##############################################################################
# Purpose: Conda-Shell designed to install and run ESMValTool and ESMValCore #
#          in the develop mode.                                              #
# Contact: Ramiro Checa-Garcia                                               #
#          contact: r.checagarcia@posteo.net                                 #
# Info:    This kind of script is a function in the language Nix that is     #
#          used to create packages over NixOS or Nix environments. It is     #
#          based on the nix derivation of the conda-shell adapted to work    #
#          for EMSValTool.                                                   #
# TODO:    - Work in a ldconfig-wrapper to deal with ctypes problem with py  #
#                                                                            #
#                                                                            #
# Changes:                                                                   #
#          v0.9: 15-October-2019. Contributors: R. Checa-Garcia.             #
#                Initial working version                                     #
#          v1.0: 25-October-2019. Contributors: R. Checa-Garcia.             #
#                Added the inline documentation                              #
##############################################################################


# This is an anonymous function with the syntax { function arguments   }:
# the main arguments are the key dependences and specific sets.
#
{ lib, stdenv, fetchurl, runCommand , makeWrapper
, buildFHSUserEnv, libselinux, libarchive, libGL
, xorg, pkgs

# Conda will install its packages and environments under this directory
#
, installationPath ? "~/.conda-esmval"

# Conda will manage most pkgs itself, but expects a few to be on the system.
# it is indicated by condaDeps first, and then by extraPkgs for those pkgs
# that are not essential but needed at some point for a python lib installed.
#
, condaDeps ? [ stdenv.cc xorg.libSM xorg.libICE xorg.libX11 xorg.libXau 
                xorg.libXi xorg.libXrender libselinux libGL ]

# Any extra nixpkgs you'd like available in the FHS env for Conda to use
# Here it is added specific stuff for ESMValTool, useful for climate
# data analysis or user dependences.

, extraPkgs ? [ pkgs.julia        # this is a requirement of ESMValCore 
                pkgs.R            # (idem)
                pkgs.openssl      # need by several libraries well to have
                pkgs.geos         # (idem)
                pkgs.hdf4         # (idem)
                pkgs.hdf5         # (idem)
                pkgs.nco pkgs.cdo # Good to have in the shell to use them.
                pkgs.fish         # Here it is just my favourite shell
              ]
}:

# How to use this package?
#
# (1) First-time setup: 
#     this nixpkg downloads the conda installer and provides a FHS
#     env in which it can run. On first use, the user will need to 
#     install conda to the installPath using the installer:
#     > esmval-shell
#     > conda-install
#
# (2) Under normal usage, simply call `esmval-shell` to activate the
#     FHS env, and then use conda commands as normal:
#     > esmval-shell
#     > conda install cartopy # for example
#
# (3) Install ESMValTool and ESMValCore. The conda installation might
#     not work in your system depending on what additional extra Unix
#     packages related with R are needed. So I recommend here to install
#     in develop mode.
#     For example if we download the ESMValCore and we are in its
#     directory then:
#
#     > conda env create --name esmval --file environment.yml
#     > source activate esmval  # not conda activate!
#     > pip install -e '.[develop]'
#
#     and similar for ESMValTool.
#
# (4) Download the ESMValCore and ESMValTool from github, on what will
#     be your working folder for ESMVal and perform the installation
#     indicated CONTRIBUTIONS.md to have a developer version working.
#
# (5) If it is possible that your geos package is not finding all the
#     dependences glibc etc... due to how nix manages the dynamic link
#     to libraries. In general it is enough with indicate to geos that
#     they can be found at /usr/lib/
#     Work in a ldconfig-wrapper is added to the TODO list.


let
  version = "4.6.14";
  src = fetchurl {
      url = "https://repo.continuum.io/miniconda/Miniconda3-${version}-Linux-x86_64.sh";
      sha256 = "1gn43z1y5zw4yv93q1qajwbmmqs83wx5ls5x4i4llaciba4j6sqd";
  };

  conda = runCommand "conda-install" { buildInputs = [ makeWrapper ]; }
    ''
      mkdir -p $out/bin
      cp ${src} $out/bin/miniconda-installer.sh
      chmod +x $out/bin/miniconda-installer.sh

      makeWrapper                            \
        $out/bin/miniconda-installer.sh      \
        $out/bin/conda-install               \
        --add-flags "-p ${installationPath}" \
        --add-flags "-b"
    '';

in
  buildFHSUserEnv {
    name = "esmval-shell";
    targetPkgs = pkgs: (builtins.concatLists [ [ conda ] condaDeps extraPkgs]);
    profile = ''
      # Add conda to PATH -------------------------------------------
      export PATH=${installationPath}/bin:$PATH
      # Paths for gcc if compiling some C sources with pip ----------
      export NIX_CFLAGS_COMPILE="-I${installationPath}/include"
      export NIX_CFLAGS_LINK="-L${installationPath}lib"
      # Some other required environment variables -------------------
      export FONTCONFIG_FILE=/etc/fonts/fonts.conf
      export QTCOMPOSE=${xorg.libX11}/share/X11/locale
      export LIBARCHIVE=${libarchive.lib}/lib/libarchive.so
      # Nice bash shell prompt --------------------------------------
      export PS1="\[\033[38;5;172m\]$(tput bold)\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;34m\]$(tput bold)\h\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;6m\][\[$(tput sgr0)\]\[\033[38;5;120m\]\w\[$(tput sgr0)\]\[\033[38;5;6m\]]:\[$(tput sgr0)\]\[\033[38;5;15m\]> \[$(tput sgr0)\]"
    '';

# Here it is kept as maintainers the authors of the general conda-shell
# that here has been adapted to work for ESMValCore/Tool.

    meta = {
      description = "Conda is a package manager for Python";
      homepage = https://conda.io/;
      platforms = lib.platforms.linux;
      license = lib.licenses.bsd3;
      maintainers = with lib.maintainers; [ jluttine bhipple ];
    };
  }

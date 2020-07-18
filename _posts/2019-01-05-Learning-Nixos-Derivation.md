---
layout: page
sidebar: right
subheadline: Tips
title: "Aprendiendo NixOS: Creando una derivación"
excerpt: "Paso a Paso "
breadcrumb: true
tags: [nixos, linux, functional-languages]
categories:
    - computing-blog
header:
    title: Aprendiendo NixOS
    pattern: pattern_jquery-dark-grey-tile.png
---

Este es un ejemplo de como añadir una derivación propia de un paquete Python no presente
en NixOS 

## Codigo de la derivación

Esta seria la derivación para el paquete Python **regionmask**, que hemos guardado
en un archivo *regionmask.nix*

{% highlight %}
{ lib, buildPythonPackage, fetchFromGitHub
, numpy, matplotlib, shapely, six, rasterio, cartopy
, geopandas, affine, xarray
}:

 buildPythonPackage rec {
  pname = "regionmask";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "mathause";
    repo = "regionmask";
    url =  "https://github.com/mathause/regionmask/archive/v0.5.0.zip";
    rev =  "v${version}";
    sha256 =  "14gxlb2w94pqrlvvxgczmknrncc5w2h8bdyli9lxd9ni93ag2ra3";
    #fetchSubmodules = false;
  };

  doCheck = false;
  propagatedBuildInputs = [ numpy affine matplotlib shapely six rasterio cartopy geopandas xarray ];

  meta = with lib; {
    description = "Python package to create regionmasks";
    license = licenses.bsd3;
    homepage = "https://regionmask.readthedocs.io/en/latest/";
    # maintainers = with maintainers; [ rchg ];
  };
}
{% endhighlight %}

## Añadir a configuration.nix

En mi caso tengo un archivo con los paquetes python llamado **python.nix*, que ahora será:
pkgs: with pkgs; 

{% highlight %}
let     
  regionmask      = pkgs.callPackage ./regionmask.nix {
    buildPythonPackage = python3Packages.buildPythonPackage;
    numpy      = python37Packages.numpy;
    matplotlib = python37Packages.matplotlib;
    shapely    = python37Packages.shapely;
    six        = python37Packages.six;
    rasterio   = python37Packages.rasterio;
    cartopy    = python37Packages.cartopy;
    geopandas  = python37Packages.geopandas;
    affine     = python37Packages.affine;
    xarray     = python37Packages.xarray;
                    };

in
[ 
    ...
    pyyaml
    regionmask
    reportlab
    ...
]
{% endhighlight %}

Mientras que configuration.nix tiene:

{% highlight %}

{ config, pkgs, lib, ... }:


let 
    mypython       = import ./python.nix pkgs;

in

{
environment.systemPackages =  ... ++ mypthon + ...

}
{% endhighlight %}


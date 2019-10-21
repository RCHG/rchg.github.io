---
layout: page
sidebar: right
subheadline: Tips
title: "NixOS: installing ESMValTool"
excerpt: "Step by Step "
teaser: "Notes to understand NixOS, Nix and nixpkgs."
breadcrumb: true
tags: [nixos, linux, functional-languages]
categories:
    - computing-blog
header:
    title: NixOS, installing ESMValTool
    pattern: pattern_jquery-dark-grey-tile.png
---




## Main dependencies

The main dependency that we will use is to install the **conda-shell** for NixOS. There are several ways in my
case I have chosen to install it as part of the systemPackages so I have a line in `/etc/nixos/configuration.nix` that is:

`environment.systemPackages = import ./applications.nix pkgs;`

which has all main packages I want to be installed and the `application.nix` looks like:


{% highlight bash %}
pkgs: with pkgs; [


    conda
    
    
    ];
{% endhighlight %}

   
where I have obiously other packages rather than only conda. Note that **conda-shell** is used typing `conda-shell` rather than conda in any terminal. Usually, when you change your  configuration at `/etc/nixos/`
you will install the new state of the system with:

`nixos-rebuild switch --upgrade --show-trace`

## Installing synda

Here I indicate how to install the **synda** that is used to download datasets from typical scientific databases for climate/meterology/ocean studies

{% highlight bash %}
bash$ conda-shell
conda-shell> conda create --name synda python=2.7 
conda-shell> source activate synda
conda-shell> conda install -c IPSL synda          
{% endhighlight %}

now we have to set few things outside of conda-shell. They are related with indication of the path where our synda configuation will be stored. For that we have to add to our shell (I will suppose it is the bash shell something like `export ST_HOME=my-synda-directory-full-path`. For this step I have added to the `/etc/nixos/configuration.nix` the new piece of code (where the path I indicated is a particular choice):

{% highlight bash %}
programs.bash.shellInit =
     ''
     export ST_HOME=/home/my-user-name/synda/
     '';
{% endhighlight %}

probably after this you will have to use again `nixos-rebuild switch --upgrade --show-trace`.

So after if we could open a new terminal, and there the conda-shell and,

{% highlight bash %}
conda-shell> source activate synda
conda-shell> synda -h
{% endhighlight %}

this last command will detect the setting of the **ST_HOME** and activate the configuration for this directory. You can inspect it with `ls /home/my-user-name/synda/`

If you now use:

{% highlight bash %}
conda-shell> synda check-env
{% endhighlight %}

and fill the requested information of your OPENID the it is very easy for example:

{% highlight bash %}
conda-shell> synda search activity_id=CMIP experiment_id=historical  variable=ptp
{% endhighlight %}

will give you a list of datasets compatible with the searching parameters:


{% highlight bash %}
new  CMIP6.CMIP.NOAA-GFDL.GFDL-ESM4.historical.r1i1p1f1.AERmon.ptp.gr1.v20180701
new  CMIP6.CMIP.NOAA-GFDL.GFDL-ESM4.historical.r1i1p1f1.AERmon.ptp.gr1.v20190726
new  CMIP6.CMIP.CNRM-CERFACS.CNRM-CM6-1.historical.r1i1p1f2.AERmon.ptp.gr.v20180917
new  CMIP6.CMIP.CNRM-CERFACS.CNRM-CM6-1.historical.r2i1p1f2.AERmon.ptp.gr.v20181126
new  CMIP6.CMIP.CNRM-CERFACS.CNRM-CM6-1.historical.r5i1p1f2.AERmon.ptp.gr.v20190125
...
{% endhighlight %}

you can download with install or get options of synda commandline tool. 

## 








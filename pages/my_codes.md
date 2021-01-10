---
layout: page-fullwidth
title: "Computer Software"
subheadline: "Overview of selfmade software tools and libraries"
permalink: "/research/my-codes/"
header:
    title: R. Checa-Garcia webpage | Software 
    pattern: pattern_jquery-dark-grey-tile.png
breadcrumb: true
---
<div class="row">
<div class="medium-4 medium-push-8 columns" markdown="1">


<div class="panel radius" markdown="1">

## Table of Contents
{:.no_toc }
*  TOC
{:toc}
</div>
<div class="panel radius" markdown="1">

  {% include alert info=' <a href="/research/overview/">Research Overview</a>' %}

  {% include alert info=' <a href="/research/resources/">Resources & Links</a>' %}
  
</div>
</div><!-- /.medium-4.columns -->

<div class="medium-8 medium-pull-4 columns" markdown="1">


This is not an exhaustive description of the codes that I have developed but those that currently I maintain more often. 
{:.notice}

### Open Source Sites/Repositories


- [github](https:/github.com/RCHG/): This is currently my main repository for open source codes.
- [bitbucket](https://bitbucket.org/rchecagarcia/) I collaborate in two projects under github.
- [sourceforge](https://sourceforge.net/u/rchecagarcia/profile) I barely use now for my own projects but still it is there.
{:.smallquote}

### Earth Sciences Software

#### Pieces of code

- [pyozone](https://github.com/RCHG/pyozone): It is a piece of code that allows some python calculations. More information is also avaiable at [zenodo](https://zenodo.org/record/1118950)
- [Mie-Scattering](https://rchg.github.io//science-blog/Mie-Scattering/) Part of this code has been refactored and integrated in FunFAN
{:.smallquote}
#### FunFAN

The main idea of [FunFAN](https://github.com/RCHG/FunFAN) project is to have a set of modules and functions used for aerosols studies that can be easely incorporated in different kind of projects.The [documentation](https://funfan.readthedocs.io/en/latest/) is online in readthedocs. It is registered in [Zenodo](https://zenodo.org/record/3672001) so you can cite it as [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3672001.svg)](https://doi.org/10.5281/zenodo.3672001).
{:.smallblock}

- Language: Python
- Info: Several functions has been used in mineral dust aerosol studies.
{:.smallquote}

#### pyIPSLtools

[pyIPSLtools](https://github.com/RCHG/pyIPSLtool) is a python software to prepate specific climate diagnostics for IPSL model. It also perform additional opertations to test the CF-compilant of the diagnostics (netcdf files) and typical test to ascertain the main properties of the climate simulations. It is registered in [Zenodo](https://zenodo.org/record/41347471) so you can cite it: [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4134747.svg)](https://doi.org/10.5281/zenodo.4134747). This tool has been used to provide diagnostics of IPSL climate model for the projects CRESCENDO, AEROCOM and specific collaborations with Jasper Kok. It is open and modular, in principle with few work it could be adapted to other models.
{:.smallblock}

- Languages: Python, cdo and nco
{:.smallquote}

#### SOCRATES-RF

[SOCRATES-RF](http://www.met.reading.ac.uk/~vr912734/SOCRATESRF/index.html) is a software suite based on SOCRATES but designed to have a different user interface and focused on the estimation of radiative forcing by offline methodologies. Currently it is able to estimate the radiative forcing by fixed dynamical heating method by adjusting the temperatures on the stratosphere. This software has been used for publications regarding the radiative forcing of Ozone in the troposphere and the stratosphere.
{:.smallblock}

- Languages: Fortran (main tool), Python (post-processing and prepare inputs)
{:.smallquote}

### Statistical Physics

#### MaxEnt

It is a code programmed to estimate a probability density function according to a set of constrains that the pdf should fulfill, typically in the form of pdf-moments.
{:.smallblock}

<small markdown="1">[Up to table of contents](#toc)</small>
{: .text-right }



</div><!-- /.medium-8.columns -->
</div><!-- /.row -->



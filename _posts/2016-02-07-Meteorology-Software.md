---
layout: page
sidebar: right
subheadline: Tips
title: "Meteorology Software"
excerpt: "Software for Meteorology, Climate and Atmospheric Sciences..."
teaser: "Computer Tools for Meteorology, Climate and Atmospheric Sciences..."
breadcrumb: true
tags: [Linux, Debian]
categories:
    - computing-blog
header:
    title: R. Checa-Garcia webpage |  Meteorology Software
    pattern: pattern_jquery-dark-grey-tile.png
---



<section id="table-of-contents" class="toc">
<div class="panel radius" markdown="1">
#### Table of Contents
{:.no_toc }
*  TOC
{:toc}
</div>
</section><!-- /#table-of-contents -->


#### Manipulation of Climate Files

- [cdo](https://code.zmaw.de/projects/cdo) Climate Data Operators is a collection of commands to manipulate output of climate models on several formats like GRIB or netCDF.
- [nco](http://nco.sourceforge.net/) NetCDF Command Operators is a collection of commands to perform typical operations on netCDF output files from climate models (or numerical weather prediction models).
- [cdat](http://sourceforge.net/projects/cdat/) CDAT is a collection of Python modules for the analysis and visualization of atmospheric science data. (Please check also: [badc](https://badc.nerc.ac.uk/help/software/cdat/) and [esg.llnl]( http://esg.llnl.gov/cdat))
- [cmor](http://www-pcmdi.llnl.gov/software-portal/cmor/documentation) It is the so called "Climate Model Output Rewriter" (CMOR, pronounced "Seymour"). Instead of a collection of Python modules it is collection of FORTRAN 90 functions. The main idea is to produce **CF-compliant netCDF files** that fulfill the requirements of many of the climate community's standard model experiments. These experiments are collectively referred to as MIP's and include, for example, AMIP, CMIP, CFMIP, PMIP, APE, and IPCC scenario runs. The output resulting from CMOR is "self-describing" and facilitates analysis of results across models. 
- [DB-All.e](http://www.arpa.emr.it/dettaglio_documento.asp?id=514&idlivello=64) DB-All.e can import observations from various sources into a unique, high-level, physically-based data model (lon, lat, time, level, parameter, etc.), where they can be manipulated at will and exported back to BUFR or CREX messages.

:.smallquote}

#### Visualization Tools

- [GrADS](https://code.zmaw.de/projects/cdo)
- [Ferret](http://nco.sourceforge.net/)
- [ncview](http://meteora.ucsd.edu/~pierce/ncview_home_page.html)
- [ncl](http://www.ncl.ucar.edu/overview.shtml)
- [IRIS](http://scitools.org.uk/iris/) A python library for Meteorology and Climatology. Iris provides a community-driven Python library for analysing and visualising meteorological and oceanographic data sets. It reads and writes (CF-)netCDF, GRIB, and PP files. It can be used to create graphs and maps via integration with matplotlib and cartopy.
{:.smallquote}

#### Libraries

- [Magics++](https://software.ecmwf.int/wiki/display/MAGP/Magics)
- [Libgrib-api-tools ](https://software.ecmwf.int/wiki/display/GRIB/Home) Library to encode and decode GRIB files.
- [Zygrib](http://www.zygrib.org/)
{:.smallquote}


<small markdown="1">[Up to table of contents](#toc)</small>
{: .text-right }


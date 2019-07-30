---
layout: page
sidebar: right
subheadline: Notebook
title: "Meteorology/Climatology related software"
excerpt: "Software for Meteorology, Climate and Atmospheric Sciences..."
teaser: "Computer Tools for Meteorology, Climate and Atmospheric Sciences..."
breadcrumb: true
tags: [linux, debian, software, meteorology]
categories:
    - computing-blog
header:
    title: Meteorology related Software
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

- [cdo](https://code.zmaw.de/projects/cdo) Climate Data Operators is a collection of commands to manipulate output of climate models on several formats like GRIB or netCDF. It is very useful for daily tasks and quick analysis of the netcdf outputs of climate models. For instance, 'cdo sinfon namefile.nc' will give you a broad view of the netcdf fields as an alternative to ncdump. But also it is possible to perform operations with variables, interpolations, re-gridding to give few examples. Finally note that it is possible to use it within Python with a wrapper avaiable online.
- [nco](http://nco.sourceforge.net/) NetCDF Command Operators is a collection of commands to perform typical operations on netCDF output files from climate models (or numerical weather prediction models). It is very useful like cdo for daily tasks but it is not considered as a specific tool for climate/meteorological community and it can be used for any application. It is a very good complement to cdo to actually perform many analysis of netcdf files in a quick way. Like cdo there is also a Python wrapper.
- [cdat](http://sourceforge.net/projects/cdat/) CDAT is a collection of Python modules for the analysis and visualization of atmospheric science data. Please check also: [badc](https://badc.nerc.ac.uk/help/software/cdat/) or the webpage [esg.llnl]( http://esg.llnl.gov/cdat).
- [cmor](http://www-pcmdi.llnl.gov/software-portal/cmor/documentation) It is the so called "Climate Model Output Rewriter" (CMOR, pronounced "Seymour"). Instead of a collection of Python modules it is collection of FORTRAN 90 functions. The main idea is to produce **CF-compliant netCDF files** that fulfill the requirements of many of the climate community's standard model experiments. These experiments are collectively referred to as MIP's and include, for example, AMIP, CMIP, CFMIP, PMIP, APE, and IPCC scenario runs. The output resulting from CMOR is "self-describing" and facilitates analysis of results across models. 
- [DB-All.e](http://www.arpa.emr.it/dettaglio_documento.asp?id=514&idlivello=64) DB-All.e can import observations from various sources into a unique, high-level, physically-based data model (lon, lat, time, level, parameter, etc.), where they can be manipulated at will and exported back to BUFR or CREX messages.
{:.smallquote}

#### Visualization Tools

- [GrADS](http://cola.gmu.edu/grads/) It is a tool to visualize datasets. It is very flexible as GrADS supports many data file formats, including binary (stream or sequential), GRIB (version 1 and 2), NetCDF, HDF (version 4 and 5), and BUFR (for station data). Users might be also interested on check the set to complementary tools: *opengrads*
- [Ferret](http://www.ferret.noaa.gov/Ferret/) It is also a widely used tool for plotting and visualizing climate datasets. It also has a python wrapper. More information can be found in their NOAA webpage. 
- [ncview](http://meteora.ucsd.edu/~pierce/ncview_home_page.html) Traditional simple, fast and easy viewer of netcdf files. While is not suited for high quality plots still is very useful for quick analysis.
- [ncl](http://www.ncl.ucar.edu/overview.shtml) It is a script language specifically designed by NCAR/UCAR for plotting climate and meteorological datasets. It has also additional libraries to interacts with python. 
- [IRIS](http://scitools.org.uk/iris/) A python library for Meteorology and Climatology. Iris provides a community-driven Python library for analysing and visualising meteorological and oceanographic data sets. It reads and writes (CF-)netCDF, GRIB, and PP files. It can be used to create graphs and maps via integration with matplotlib and cartopy. This library relies on the idea of a cube that represents the climate variables under analysis, it is a concept similar to named-arrays used by xarray but with xarray aimes to apply to a broader context. 
- [matplotlib](http://matplotlib.org) Althought it is not specific of atmospheric sciences, it is broadly used due to its versatily.
- [cartopy](https://scitools.org.uk/cartopy/docs/latest/) Based on matplotlib, it is a library to plot geographical maps, and it is close related with IRIS (it is created also by MetOffice of UK) although it is not dependent on IRIS library.
- [ESMValTool](https://www.esmvaltool.org/) A tool whose focus is to perform standard cross-comparisions between models and also with observations. Althought based on Python it has an interface to use methods from ncl and R language.
{:.smallquote}

#### Libraries

- [xarray](http://xarray.pydata.org/en/stable/) Very useful library to process the netcdf files commonly used on climate sciences. It is a library under development but currently it is very usable. Relies in the idea of create *named-arrays* directly derived from the netcdf files in such way that the data-analysis is much more easy. Shared ideas with Pandas.
- [Magics++](https://software.ecmwf.int/wiki/display/MAGP/Magics)
- [Libgrib-api-tools ](https://software.ecmwf.int/wiki/display/GRIB/Home) Library to encode and decode GRIB files.
- [Zygrib](http://www.zygrib.org/)
{:.smallquote}

<small markdown="1">[Up to table of contents](#toc)</small>
{: .text-right }


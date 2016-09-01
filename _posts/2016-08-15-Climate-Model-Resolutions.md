---
layout: page
sidebar: right
subheadline: Tips
title: "Climate Model Resolutions"
excerpt: "Note on the typical resolutions of CM."
teaser: "Notes for Meteorology, Climate and Atmospheric Sciences..."
breadcrumb: true
tags: [Climate Models]
categories:
    - science-blog
header:
    title: R. Checa-Garcia webpage |  Meteorology and Climatology
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

[^1]: *Atmospheric Modelling, Data Assimilaton and Predictability*, **Eugenia Kalnay*, Cambridge University Press.

## Climate Model Resolutions

The numerical formulation of the equations included on the current climate models is a subject of research. The climate model resolution indicates information on this discretization process both in time and space. The two main discretization methods are the finite difference method to formulate the differential equations and the spectral method which allows analyitical expressions for the spaces derivatives. Here is specified several typical resolutions of both Spectral and Finite differences methods.

### Spectral Model Grid

The spectral models uses a different methodology for space discretization based on spectral expansion (it can be considered a Galerkin approach) 

More information can be found [ECMWF](http://www.ecmwf.int/newsevents/training/rcourse_notes/NUMERICAL_METHODS/NUMERICAL_METHODS/Numerical_methods7.html) and in the referece [^1]

In general the main advantage of spectral models is that space derivatives can be calculated analytically instead of numerically. Also in general the pole problem is not present. However the main disadvantages are the difficulties to include directly typical space grid physical processed (althought it can be done with a transformation method). It is mainly designed for global models and not limited-area models. 


#### Typical Model Spectral Resolutions

|Truncation	| lat x lon	| km at Eq	|deg at Eq | In ICCP Reports |
|-----------|-----------|-----------|----------|-----------------|
| T21	      |32x64	    |625	      |5.625     | FAR             |
| T42	      |64x128	    |310      	|2.8125    | SAR             |
| T62	      |94x192	    |210	      |1.875     |                 |
| T63	      |96x192	    |210	      |1.875     | TAR             |
| T85	      |128x256	  |155        |1.4       |                 |
| T106	    |160x320	  |125	      |1.125     | AR4             |
| T255	    |256x512	  |60	        |0.703125  |                 |
| T382	    |576x1152	  |38       	|0.313     |                 |
| T799	    |800x1600	  |25 	      |0.225     |                 |


<figure class="half">
<a
href="http://eo.ucar.edu/staff/rrussell/climate/modeling/images/ipcc_ar4_wg1_ch1_fig_1_4_big.gif"><img src="http://eo.ucar.edu/staff/rrussell/climate/modeling/images/ipcc_ar4_wg1_ch1_fig_1_4_big.gif"></a>
	<figcaption><a title="Illustration of Spatial Resolutions IPCC">Illustration of Spatial Resolutions IPPC. Credits: Image courtesy of the IPCC (AR4 WG 1 Chapter 1 page 113 Fig. 1.4).
 </a></figcaption>
</figure>

<small markdown="1">[Up to table of contents](#toc)</small>
{: .text-right }


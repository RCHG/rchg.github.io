---
layout: page
sidebar: right
subheadline: Notebook
title:  "Online Coupled Models"
teaser: "Short introduction to Online Coupled Models."
breadcrumb: true
tags:
    - [NWPM, Earth-Modeling, Atmospheric-Physics, ESM]
categories:
    - science-blog
header:
    title: Online Coupled Models
    pattern: pattern_jquery-dark-grey-tile.png
---


> Post under construction: In this post I am writing step by step the topics I am learning about Online Coupled Models. 


**Definition**: By Online Coupled Models (OCM) I understand a numerical weather prediction model (NWPM) -or a climate model, global or regional- that includes also a parameterization with the gases chemistry and/or an aerosols physics-chemistry (if both are included they has to be also linked with a gas-phase module) [^1]. The term online is included because there is an update of the NWPM due to the parameterizations. An offline chemistry transport model means a chemistry model whose transport and interaction are conditioned by the meteorological fields (but it is unidirectional). Note: The concept of online coupled model may be applied also to ocean-atmosphere coupling, here I am not commenting about that case.
{:.smallblock}

[^1]: Baklanov, A. et al. (2014): Online coupled regional meteorology chemistry models in Europe: current status and prospects, *Atmos. Chem. Phys.*, 14, 317-398, [doi-link](http://dx.doi.org/10.5194/acp-14-317-2014).
[^2]: Ban, N., J. Schmidli, and C. Schär (2014), Evaluation of the convection-resolving regional climate modeling approach in decade-long simulations, *J. Geophys. Res. Atmos.*, 119, 7889–7907, [doi-link](http://dx.doi.org/10.1002/2014JD021478).
[^3]: Kristina Lundgren, Direct Radiative Effects of Sea Salt on the Regional Scale, *KIT Scientific Publishing 2012*, ISSN 0179-5619, ISBN 978-3-86644-773-8. [pdf-link](http://www.imk-tro.kit.edu/english/3140_5642.php).
[^4]: Marshall, J., C. Hill, L. Perelman, and A. Adcroft (1997), Hydrostatic, quasi-hydrostatic, and nonhydrostatic ocean modeling, J. Geophys. Res., 102(C3), 5733–5752, [doi-link](http://dx.doi.org/10.1029/96JC02776). [pdf-link](http://www-paoc.mit.edu/paoc/papers/hydrostatic.pdf).


#### Spatial-temporal Resolutions

Few years ago most of the NWPM were **hydrostatic**. An approximation that constrained the spatial resolution to values larger than (around) 15-20 km. However recently most of the NWPM (global climate models usually have larger spatial resolutions) are actually **non-hydrostatic**[^4]. However smaller spatial resolution also means improve the physical parameterizations and physical descriptions (and also increase the temporal resolution), a classical example is the convection. When the scale is highly improved some authors speak about **Cloud-Resolving-Models** or **Convection-Resolving-Models(CRM)**[^2]. The aerosols and chemistry can be included on several model scales, but I understand that higher resolution will means be careful about the quality of the parametrization and its relations with cloud micro-physics and precipitation. 

<figure class="half">
<a
href="http://www.dwd.de/bvbw/generator/DWDWWW/Content/Oeffentlichkeit/FE/Bilder/ASFU__NM__Phys__Par__skalentrennung__en__580,property=default.jpg"><img src="http://www.dwd.de/bvbw/generator/DWDWWW/Content/Oeffentlichkeit/FE/Bilder/ASFU__NM__Phys__Par__skalentrennung__en__580,property=default.jpg"></a>
<a
href="http://www.clm-community.eu/images/13_Picture1_1403507274.jpg"><img src="http://www.clm-community.eu/images/13_Picture1_1403507274.jpg"></a>
	<figcaption><a title="Illustration of Spatial Resolutions">Illustration of Spatial Resolutions (sources:DWD and www.clm-community.eu)</a></figcaption>
</figure>

#### Objectives

There are advantages of the online coupled is that they may use to study the role of aerosols on the global radiative forcing [^3]. Also the aerosols are the source of Cloud-Condensation-Nucleus (CCN) that plays a central role on the cloud micro-physics. 

#### General framework

> Section under construction.


#### Balance equations

It is quite interesting that the parameterizations of several physical processes are described with **balance equations**. The first step is define several categories: like aerosols types or like drops sizes... The physical process are the interpreted as effective transferences from a category to another one. For instance, the breakup of a rain drop in two others will be represented by an increase the concentration of one category and decrease on another. This kind of processed can written as **balance equations**. That in a warm cloud micro-physics scheme would imply total water vapor mass conservation.

Describe the aerosols dynamics is quite complex due to the several physical processes involved: cloud micro-physics, chemistry, precipitation etc... But the dynamic processed between aerosols is usually modeled by balance equations like (k represents here a mode-category),

$$
\partial_{t}N_{k}={\overbrace{T(N_{k})}^{Turbulent\,Transp.}}+{\overbrace{A(N_{k})}^{Advection \, Transp.}}+{\overbrace{v_{s}\partial_{z}(N_{k})}^{Sedimentation}}-{\overbrace{C\sum_{l}a_{k,l}}^{Balance\,between: k, l}}
$$


##### References and Notes


---
layout: page
sidebar: right
subheadline: Notebook
title:  "Land Surface Modelling"
teaser: "Describing vegetation in climate models"
breadcrumb: true
tags: [Land-Surface-Model, Atmospheric-Physics]
categories:
    - science-blog
header:
    title: R. Checa-Garcia webpage | Land Surface Modelling I
    pattern: pattern_jquery-dark-grey-tile.png
---

> Post under construction
[^1]: I recommend to check the following course: http://www2.geog.ucl.ac.uk/~plewis/geogg124/intro.html in case you are interested on learn about this topic.


### Land Surface Schemes in Climate Models

Land Surface Schemes as the interaction between the Earth Surface and the Atmosphere is an intense field of research nowdays. This is because the role of on the boundary layer of the atmosphere but also because we aim to evaluate the climate change impacts on ecosystems, and possible feedbacks between land-surface managament (like is the case of agriculture, forest management etc) and other Earth Subsystems.

The main amounts to be estimated are the energy and mass fluxes. For instance the energy budget or balance equation between the atmosphere and the land is given by,

$$Q_{S}(1-a)-Q_{Lu}+Q_{Ld}-Q_{H}-Q_{E}-Q_{G}=0$$

where,

- $$Q_{S}$$ is the incoming solar energy and $$a$$ is the surface effective albedo
- $$Q_{Lu}$$ is the longwave upwelling radiation
- $$Q_{Ld}$$ is the longwave downwelling radiation
- $$Q_{H}$$ is the rate of heat transfer from the ground to the atmosphere (per area unit)
- $$Q_{E}$$ is the latent heat flux (derived from the moisture transfer per unit of area from ground to the atmosphere)
- $$Q_{G}$$ is the netto ground heat flux from the most outer surface layer to other deeper surface layers.

Beyond this simple formulation the estimation of each term can be challening depending on earth surface type (and atmospheric conditions). 


### Modelling Vegetation [^1]

Vegetation might be understand as a kind of land surface with very simple general parameters or ideally is considered a system between a bare soil and the boundarly atmospheric layer. This is one of the most interestings improvement of current Earth Systems Models as the vegetation plays an important role on the carbon and water cycles (also with a key interaction with the solar radiation). 

#### Canopy?

Canopy is the part of the vegetation above the bare soil (this is only one part of a plant) so it is the main part to be modelled. It interact with water from soil, precipitation and air moisture. It also intereact with radiation, and with the gases on the atmosphere: in particular $$CO_{2}$$. The canopy has a 3D-structure that modulates all these interactions but not all the models actually implement the full vertical structure given its complexity. It is more common to use parameters that aims to describe indirectly the canopy structure (in those aspect relevant for the described interactions). Most of the parameters are directly related with Vegetation Index derived from remote sensing measurements, like the classical NDVI (normalized difference vegetation index) or the more accurate EVI (enhanced vegetation index) which is able to differenciate canopies properties not differenciated with NDVI. While the LAI (Leaf area index) defined by the ration between leaf area and ground area is used in photosyntetic primary production like,

$$P=P_{max}(1-e^{-cLAI})$$

and in general those parameters not easily measured are estimated with allometric relationships like $$Y=\beta X^{\alpha}$$ where $$X$$ is measurable and Y is estimated. For example the metabolic activity might be estimated from the volumen of the tree.

The photosynthesis is a critical aspect of the modelling because its role on greenhouse gases studies and the important feedback with soil moisture. The photosynthesis gives the necessary energy for the metabolic processes by maximizing the absorption of $CO_{2}$ and minimize the amount of water spent in the process. 

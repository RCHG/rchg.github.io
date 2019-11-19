---
layout: page
sidebar: right
subheadline: Notebook
title:  "Inverse Modelling"
teaser: "Introduction to Inverse Modelling applied to Atmospheric Science"
breadcrumb: true
tags: [radiative-theory, atmospheric-physics, inverse-modelling]
categories:
    - science-blog
header:
    title: Inverse Modelling
    pattern: pattern_jquery-dark-grey-tile.png
---


### Initial concepts

We consider that a physical system is described by a set of variables named state variables and grouped 
in a state vector, **x** however those variables are not directly observables or are difficult to measure 
and indirect methods are used to assess the state of the system. These other variables are grouped in 
the observation vector **y**. The relation between both is given by the forward model **F** by

$$
\mathbf{y}=\mathbf{F}(\mathbf{x},\mathbf{b})+\mathbf{\epsilon}
$$

where **b** is named parameter vector, and the $$\mathbf{\epsilon}$$ is named observational error due to 
uncertainties in the observations, the forward model and model parameters.

The inversion modelling give us methods to estimate the values of **x** given the values of **y** and our
forward model. 

In general we design the foward model according to state vector and observation vector, in the
case of remote sensing of the atmosphere, we rely on the radiative transfer theory and the model **F** will
be close related with the radiation (our observations) that arrives to a sensor. The inverse modelling
however can be applied to estimate surface-fluxes given concentratons or used in data assimilation.


 

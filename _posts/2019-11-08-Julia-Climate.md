---
layout: page
sidebar: right
subheadline: Notebook
title:  "Julia y modelos de clima"
teaser: "Experiencias programando con Julia"
breadcrumb: true
tags:
    - [scientific-computing, Julia]
categories:
    - julia-blog
header:
    title: Julia y Clima
    pattern: pattern_jquery-dark-grey-tile.png
---


Dado que me dedico profesionalmente a la fisica de la atmosfera, 
una de las herramientas principales con la que he de trabajar son
librerias para el analisis de datos climatologicos o meteorologicos.
En principio para esto uso, en particular, la libreria xarray (antes
usaba la libreria netCDF4 pero xarray facilita muchas tareas). Algo
similar a xarray, aunque mas especifico es Iris, la libreria creada
por Met-Office.

## xarray and iris

- La libreria xarray proporciona un modo de manejar arrays multidimensionales,
de alguna manera encapsula la informacion tipica de un archivo netcdf
en unas estructuras llamadas Dataset y DataArrays. DataQrray seria lo mas similar
a un archivo netcdf con una sola variable y varias dimensiones. Dataset
puede contener varias DataArrays. En ambos casos se almacena metadata y atributos.

- La libreria iris se construye alrededor de un objeto llamado cube que es
similar a un DataArray. Dado que iris esta creado especificamente para 
el tratamiento de datos de modelos de clima, esta libreria se ocupa tambien
de tener metodos concretos para segurar CF-Compilant, hacer interpolaciones etc.

Also similar a xarray seria AxisArrays.jl al menos en el sentido de que su
estructura principal es similar a un DataArray. Otras alternativas son NamedArrays.jl

Lo mas similar a iris-cube seria la estructura ClimateGrid presente en la libreria
ClimateTools.jl (que en ultima instancia usa AxisArrays). Dado que ClimateTools
es especifica, como lo es iris, esta estructura incorpora CF-Compilant y busca
tener funcionalidades y metodos similares a iris-cube.

## ClimateTools.jl

Esta libreria



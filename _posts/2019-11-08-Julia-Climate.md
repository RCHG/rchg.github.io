---
layout: page
sidebar: right
subheadline: Notebook
title:  "Julia: librerias para geociencias comparadas con Python"
teaser: "Experiencias programando con Julia"
breadcrumb: true
tags:
    - [Scientific Computing, Julia]
categories:
    - julia-blog
header:
    title: Julia y Geociencias
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


# ¿Qué librerias hay en Python?

Dado que me dedico profesionalmente a la física de la atmósfera, 
una de las herramientas principales con la que he de trabajar son
librerias para el análisis de datos climatológicos o meteorológicos.
En Python la libreria que más uso para esto **xarray** (antes
usaba la libreria netCDF4 pero xarray facilita muchas tareas). Algo
similar a xarray, aunque más específico es **iris**, la libreria creada
por Met-Office. 

## xarray and iris

- La libreria **xarray** proporciona un modo rápido y cómodo de manejar arrays multidimensionales.
Para aquellos que trabajamos con archivos netcdf, xarray encapsula la información típica de un archivo netcdf
en unas estructuras de datos llamadas *dataset* y *dataArrays*. DataQrray seria lo mas similar
a un archivo netcdf con una sola variable y varias dimensiones. Dataset
puede contener varias DataArrays. En ambos casos se almacena metadata y atributos. No hay una 
estructura general que encapsule un archivo netcdf con varios grupos por lo que habría que leer
cada grupo del archivo orginal como un Dataset diferente.

- La libreria **iris** se construye alrededor de un objeto llamado *cube* que es
similar a un DataArray. Una diferencia importante es que si bien los objetos de xarray pueden tener cualesquiera
dimensiones en el caso de cube se espera que sean coordenadas geográficas (latitud y longitud), coordenada vertical y una
coordenada temporal. Dado que iris está creado especificamente para 
el tratamiento de datos de modelos de clima, esta librería se ocupa también
de tener métodos concretos para segurar CF-Compilant, hacer interpolaciones etc.

- Para visualización utilizo principalmente **cartopy** y **matplotlib**. Ambas xarray e iris tienen métodos para hacer más sencilla
la visualización de sus objetos con estas librerias pero en cualquier caso conviene aprenderlas de modo independiente.

# ¿Qué librerias hay en Julia?

Si bien *xarray* es una libreria consolidad en Python, en este momento no hay una alternativa consolidada en Julia sino
muchas opciones y propuestas en busca de una herramienta apropiada: **AxisArrays.jl**, **NamedArrays.jl**, **GeoArrays.jl** etc.

Lo más similar a *iris-cube* seria la estructura ClimateGrid presente en la libreria
**ClimateTools.jl** (que en última instancia usa AxisArrays). Dado que ClimateTools
es específica, como lo es iris, esta estructura incorpora CF-Compilant y busca
tener funcionalidades y metodos similares a iris-cube.

Para la visualización hay opciones pero nada en este momento al nivel de *cartopy*. Eso no es un mayor problema dado que con **PyPlots.jl**
es posible utilizar *matplotlib* y *cartopy* con **PyCall**. Hay una tentativa de libreria en Julia con **GeoMakie.jl**, pero aun esta en desarrollo y no es 
muy funcional. ClimateTools.jl utiliza matplotlib via PyCall para la representación gráfica.




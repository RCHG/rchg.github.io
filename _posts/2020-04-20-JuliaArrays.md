---
layout: page
sidebar: right
subheadline: Notebook
title:  "Arrays en Julia"
teaser: "Experiencias programando con Julia"
breadcrumb: true
tags:
    - [scientific-computing, Julia]
categories:
    - julia-blog
header:
    title: Arrays en Julia
    pattern: pattern_jquery-dark-grey-tile.png
---

**Resumen**
Introducción a los arrays en Julia para computación científica.
{:.smallblock}

<div class="panel radius" markdown="1">
#### Tabla de Contenidos
{:.no_toc }
*  TOC
{:toc}
</div>

Uno de los aspectos que intentan estar más cuidados en Julia son los arrays ya que constituyen un bloque esencial de la computación científica. Además dado que la libreria *standard* incluye una parte de algebra lineal, más proximo a como sucede en MatLab o incluso en Fortran. No ocurre lo mismo en otros lenguajes como Python, Haskell o C donde es necesario optar por una libreria adicional (en Python esta consolidada numpy como standard pero no forma parte del Python *oficial*).

Por otra parte, si bien es cierto que los arrays son centrales para lenguajes como Julia, en su caso no deja por ello de integrarse bien en el sistema de tipos del lenguaje a traves de [AbtractArrays](https://docs.julialang.org/en/v1/base/arrays/#Core.AbstractArray). 

## Definición

Un array es una colleción de elementos en una estructura multidimensional. Formalmente, esta estructura tiene forma de *grid*, lo que permite acceder a los elementos por indices que refieren a cada una de las dimensiones del array. En Julia estos elementos pueden tener formalmente cualquier tipo (o tipo `any`). Para propositos de calculo computacional lo normal es tipo float, pero estructuralmente la forma es similar. De hecho si definimos en Julia un tipo mediante `struct`, podemos construir un array de este tipo si lo deseasemos.

## Como construir arrays
```
A = ones(Float64, (2,2))
```
crea un array de floats en un grid 2x2, con valores 1, es decir,
```
2×2 Array{Float64,2}
1.0   1.0
1.0   1.0
```
Donde `Array{Float64,2}` significa 2 dimensiones (dos indices) y 2x2 es el tamaño concreto del grid.
```
> ones(Int64, (2,3))
2×3 Array{Int64,2}
1.0   1.0   1.0
1.0   1.0   1.0
```
Es posible definir tambien arrays con la sintaxis [ ... ],

```
> [[0,1]  [2,3]  [4,5]]
2×3 Array{Int64,2}:
 0  2  4
 1  3  5
```

Donde Julia ha inferido el tipo como Int64. Notar que en Python una lista (cuya sintaxis es [...]) y un array numpy son dos cosas diferentes. En Julia, la sintaxis [...] define un array. Por su puesto en Julia hay otros tipos que representan colecciones de datos como `sets` o `dictionaries` entre otros llamados en general [collections](https://docs.julialang.org/en/v1/base/collections/), pero estas estructuras de datos no se refieren a una red/grid multidimensional de valores.






<small markdown="1">[Volver a la tabla de contenidos](#toc)</small>
{: .text-right }

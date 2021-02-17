---
layout: page
sidebar: right
subheadline: Notebook
title:  "Arrays en Julia"
teaser: "Experiencias programando con Julia"
breadcrumb: true
tags:
    - [Scientific Computing, Julia]
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

Uno de los aspectos que intentan estar más cuidados en Julia son los arrays ya que constituyen un bloque esencial de la computación científica. Además dado que la libreria *standard* incluye una parte de algebra lineal, más proximo a como sucede en MatLab o incluso en Fortran. No ocurre lo mismo en otros lenguajes como Python, Haskell o C donde es necesario optar por una librería adicional (en Python esta consolidada numpy como standard pero no forma parte del Python *oficial*).

Además dado que los arrays son centrales para lenguajes como Julia, estos se integran de modo natural en el sistema de tipos del lenguaje a traves de [AbstractArrays](https://docs.julialang.org/en/v1/base/arrays/#Core.AbstractArray). Veamos  más información y ejemplos sobre los arrays en Julia.

## Definición

Un array es una colleción de elementos en una estructura multidimensional. Formalmente, esta estructura tiene forma de *grid*, lo que permite acceder a los elementos por indices que refieren a cada una de las dimensiones del array. En Julia estos elementos pueden tener formalmente cualquier tipo (o tipo `any`). Para propositos de cálculo computacional lo normal es tipo *float*, pero estructuralmente la forma es similar. De hecho si definimos en Julia un tipo mediante `struct`, podemos construir un array de este tipo si lo deseasemos.

## Como construir arrays

{% highlight Julia %}
A = ones(Float64, (2,2))
{% endhighlight %}

crea un array de floats en un grid 2x2, con valores 1, es decir,
{% highlight Julia %}
2×2 Array{Float64,2}
1.0   1.0
1.0   1.0
{% endhighlight %}

Donde `Array{Float64,2}` significa 2 dimensiones (dos indices) y 2x2 es el tamaño concreto del grid.

{% highlight Julia %}
> ones(Int64, (2,3))
2×3 Array{Int64,2}
1   1   1
1   1   1
{% endhighlight %}

Es posible definir tambien arrays con la sintaxis [ ... ],

{% highlight Julia %}

> [[0,1]  [2,3]  [4,5]]
2×3 Array{Int64,2}:
 0  2  4
 1  3  5
 
{% endhighlight %}

Donde Julia ha inferido el tipo como Int64. Notar que en Python una lista (cuya sintaxis es [...]) y un array numpy son dos cosas diferentes. En Julia, la sintaxis [...] define un array. Por su puesto en Julia hay otros tipos que representan colecciones de datos como `sets` o `dictionaries` entre otros llamados en general [collections](https://docs.julialang.org/en/v1/base/collections/), pero estas estructuras de datos no se refieren a una red/grid multidimensional de valores.

## De archivos de texto a arrays

Esto es sencillo gracias a parte de la libreria standard llamada DelimitedFiles. Si por ejemplo tengo un archivo de datos llamado datos.txt

{% highlight Julia %}
1.0 2.0 2.1
1.1 2.0 2.6
1.5 3.0 0.0
110 0.1 9.9
{% endhighlight %}

Podemos tener un array directamente con:
{% highlight Julia %}

using DelimitedFiles

data = DelimitedFiles.readdlm("datos.txt")

{% endhighlight %}

## Creando un array 1...10

Este ejercicio es interesante para entender el funcionamiento de los arrays en Julia

{% highlight Julia %}
A = [1:10]
{% endhighlight %}
produces in Julia v1.5:
{% highlight Julia %}
1-element Array{UnitRange{Int64},1}:
 1:10
{% endhighlight %}
{% highlight Julia %}
A = [1:3 ;]
{% endhighlight %}
produces in Julia v1.5:
{% highlight Julia %}
3-element Array{Int64,1}:
  1
  2
  3
{% endhighlight %}
Which is the same than 'collect(1:3)'

<small markdown="1">[Volver a la tabla de contenidos](#toc)</small>
{: .text-right }

---
layout: page
sidebar: right
subheadline: Notebook
title:  "Librerias en Julia"
teaser: "Experiencias programando con Julia"
breadcrumb: true
tags:
    - [scientific-computing, Julia]
categories:
    - julia-blog
header:
    title: Librerias en Julia
    pattern: pattern_jquery-dark-grey-tile.png
---

**Resumen**
Lista con Librerias para Julia para computacion cientifica.
{:.smallblock}

<div class="panel radius" markdown="1">
#### Tabla de Contenidos
{:.no_toc }
*  TOC
{:toc}
</div>

## Entiendiendo Pkgs.jl 

Existe una lista de paquetes para Julia que esta creciendo continuamente, y se manejan de modo sencillo gracias a Pkgs.jl
La manera basica de uso se centra en su uso en REPL, es decir, entramos en `> Julia` y escribimos `]`:

{% highlight bash %}
> julia
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.1.1 (2019-05-16)
 _/ |\__'_|_|_|\__'_|  |  
|__/                   |

julia> 

{% endhighlight %}

tras escribir `]`: tendremos algo como 


{% highlight bash %}
> julia
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.1.1 (2019-05-16)
 _/ |\__'_|_|_|\__'_|  |  
|__/                   |

(v1.1) pkg>
{% endhighlight %}

en este entorno podemos usar una serie de comandos para el manejo de *packages* como, por ejemplo:

{% highlight bash %}
(v1.1) pkg> status
(v1.1) pkg> add ClimateTools
(v1.1) pkg> rm ClimateTools
(v1.1) pkg> add https://github.com/JuliaLang/Example.jl
{% endhighlight %}

Sin embargo desde la version 1.3, Pkg.jl, posee otras funcionalidades y diseño:

- Pkg está diseñado en torno a "entornos/enviroments": conjuntos independientes de paquetes que pueden ser locales para un proyecto individual o compartidos y seleccionados por nombre. 

Por esto teniamos `(v1.1) pkg>` que nos indicaba el entorno/enviroment activado (uno especifico). Pero podemos cambiarlo:

{% highlight bash %}
(v1.1) pkg> activate mientorno
 Info: activating new environment at ~/mientorno.

(mientorno) pkg> 

(mientorno) pkg> status
    Status `~/mientorno/Project.toml`
  (empty environment)

(mientorno) pkg> 
{% endhighlight %}

vamos a usar aqui add y status:

{% highlight bash %}
(mientorno) pkg> add JSON
 Resolving package versions...
  Updating `~/mientorno/Project.toml`
  [682c06a0] + JSON v0.21.0
  Updating `~/mientorno/Manifest.toml`
  [682c06a0] + JSON v0.21.0
  [69de0a69] + Parsers v0.3.11
  [2a0f44e3] + Base64 
  [ade2ca70] + Dates 
  [8ba89e20] + Distributed 
  [b77e0a4c] + InteractiveUtils 
  [56ddb016] + Logging 
  [d6f4376e] + Markdown 
  [a63ad114] + Mmap 
  [de0858da] + Printf 
  [9a3f8284] + Random 
  [9e88b42a] + Serialization 
  [6462fe0b] + Sockets 
  [8dfed614] + Test 
  [4ec0a83e] + Unicode 

(mientorno) pkg> status
    Status `~/mientorno/Project.toml`
  [682c06a0] JSON v0.21.0

(mientorno) pkg> develop --local JSON
   Cloning git-repo `https://github.com/JuliaIO/JSON.jl.git`
  Updating git-repo `https://github.com/JuliaIO/JSON.jl.git`
 Resolving package versions...
  Updating `~/mientorno/Project.toml`
  [682c06a0] ? JSON v0.21.0 [`dev/JSON`]
  Updating `~/mientorno/Manifest.toml`
  [682c06a0] ? JSON v0.21.0 [`dev/JSON`]

{% endhighlight %}

Nos podemos preguntar donde esta todo esto archivado (seguramente en este momento en una localizacion temporal) pero si salimos de julia vemos un directorio llamando **mientorno**

{% highlight bash %}
> tree mientorno -L 3
mientorno
├── dev
│   └── JSON
│       ├── appveyor.yml
│       ├── bench
│       ├── data
│       ├── LICENSE.md
│       ├── Project.toml
│       ├── README.md
│       ├── src
│       └── test
├── Manifest.toml
└── Project.toml

6 directories, 6 files
{% endhighlight %}

Es decir se ha creado un directorio con *mientorno* donde he invocado julia, y posee los archivos *Manifest.toml* y *Project.toml*. Ademas vemos que estos archivos son los que han sido cambiados tras el comando `develop --local`, que ha creado un directorio dev/ donde esta el codigo de JSON.

La motivacion de todo esto la podemos ver en el propio manual de Pkg.jl

> El conjunto exacto de paquetes y versiones en un *enviroment* se describe en un archivo de Manifest.toml que se puede registrar en un repositorio de proyectos y rastrear en el control de versiones, lo que mejora significativamente la reproducibilidad de los proyectos. Si alguna vez ha intentado ejecutar código que no ha utilizado durante un tiempo solo para descubrir que no puede hacer que nada funcione porque ha actualizado o desinstalado algunos de los paquetes que estaba usando su proyecto, comprenderá el motivación para este enfoque. En Pkg, dado que cada proyecto mantiene su propio conjunto independiente de versiones de paquetes, nunca más tendrá este problema. Además, si revisa un proyecto en un nuevo sistema, simplemente puede materializar el entorno descrito por su archivo de manifiesto e inmediatamente estará en funcionamiento con un conjunto de dependencias bien conocido.
> (Manual Pkg.jl)


## Paquetes de Julia

La lista de librerias y paquetes en julia comienza a ser amplia, pueden encontrarse muchos de ellos en [Julia Observer](https://juliaobserver.com/). De todos modos, en el caso de Julia, la libreria estandar que viene con el propio compilador al contrario que otros compliadores/lenguages posee modulos para muchas de la tareas de modo que no nos require installar paquetes externos. Por dar algunos ejemplos: la parte de algebra lineal, unit-test, distributed comnputing, markdown, profiling, etc. 

### Libreria Estandar

Os indico algunos modulos dentro de la libreria estandar (que es distribuida con Julia junto a Base que como el nombre indica es el conjunto de funciones que constituyen el nucleo de Julia) que yo personamente he usado:

- **Dates**: Proporciona dos tipos llamados `Date` y `DateTime` que se diferencian esencialmente en la resolucion que proporciona. De modo formal estos tipos cumplen con *ISO 8601* de modo que el calendario usado es proleptic Gregorian.
- **Delimited Files**: Esta libreria es esencial si trabajas con archivos de texto organizados/separados por columnas con un caracter o conjunto de ellos conocido. 
- **Pkg**: Ya lo hemos comentado antes, y es parte de la libreria estandar.
- **Random**: Implementa el metodo de `Mersenne Twister` para generar numeros aleatorios. `rand(Float64, (n, m, p))` por ejemplo genera un array tridimensional con dimensiones (n, m, p) con valores aleatorios entre 0 y 1, es decir, numeros positivos entre 0 y 1 (incluyendo 0 pero no 1). Cuando leas la documentacion ten encuenta que aunque el modulo de numeros aleatorios es Random.Random, las funciones rand, rand!, randn, randexp estan en Base (es decir Base.rand, Base.rand! etc). 
- **Statistics**: Hay algunas functiones detro de la libreria estandar, pero en este caso es bastante limitada ya que unicamente ofrece estadisticos basicos (media, mediana, etc). Recomiendo revisar **Distributions.jl** si quieres trabajas con estadistica en Julia.
- **Unit Testing**: Creo que esta es otra libreria muy util y recomiendo aprenderla desde el principio cuando aprendas Julia.


### Paquetes de Visualización 

| Nombre 	| Propósito                | Licencia     |	Docs   | Repositorio|
| --------- | ------------------------ | ------------ | ------ | ---------- |
| Plots.jl	| Visualization wrapper    | Open-Source  | [docs](http://docs.juliaplots.org/latest/) | [github](https://github.com/JuliaPlots/Plots.jl) |
| VegaLite.jl	| Visualizacion con VegaLite    | Open-Source  | [docs](https://www.queryverse.org/VegaLite.jl/stable/) | [github](https://github.com/queryverse/VegaLite.jl) |
| Gadfly.jl	| Visualization focuses on Stats Plots    | Open-Source  | [docs](http://gadflyjl.org/stable/),  , [paper](https://doi.org/10.5281/zenodo.593105) | [github](https://github.com/GiovineItalia/Gadfly.jl) |
| Makie.jl	| Visualizacion basada en GPU   | Open-Source  | [docs](http://makie.juliaplots.org/stable/) | [github](https://github.com/JuliaPlots/Makie.jl) |

Notes:

**Plots.jl** puede usar diferentes motores (backends) para la creación de figuras como pueden ser GR or pyplots (que utiliza en última instancia matplotlib) entre otros.


## Matemáticas y estadística

| Nombre 	| Propósito                | Licencia     |	Docs   | Repositorio|
| ----------------- | ---------------------- | ------------ | -----| ---------- |
|Distributions.jl 	| Distributions Probab.  |  Open-Source  | [docs](https://juliastats.github.io/Distributions.jl/stable/) , [paper](https://arxiv.org/abs/1907.08611) | [github](https://github.com/JuliaStats/Distributions.jl) |
|SpecialFunctions.jl| Special Functions Math | Open-Source  | [docs](https://juliamath.github.io/SpecialFunctions.jl/stable/)  | [github](https://github.com/JuliaMath/SpecialFunctions.jl) |
|GSL.jl 	        | Interface to GSL Math-Lib |  Open-Source  | [docs-gsl](https://www.gnu.org/software/gsl/doc/html/index.html)  | [github](https://github.com/JuliaMath/GSL.jl) |
| Convex.jl         |Mathematical Optimization | Open-Source  | [docs](https://www.juliaopt.org/Convex.jl/stable/) , [paper](https://web.stanford.edu/~boyd/papers/pdf/convexjl.pdf)  | [github](https://github.com/JuliaOpt/Convex.jl) |

## Machine Learning

| Nombre 	| Propósito                | Licencia     |	Docs   | Repositorio|
| ----------------- | ---------------------- | ------------ | -----| ---------- |
| Flux.jl       	| [Machine Learning approach](https://julialang.org/blog/2017/12/ml&pl)       |  Open-Source  | [docs](https://fluxml.ai/Flux.jl/stable/) , [paper](https://joss.theoj.org/papers/10.21105/joss.00602) | [github](https://github.com/FluxML/Flux.jl) |
| MLJ.jl       	| [Machine Learning methods](https://github.com/alan-turing-institute/MLJModels.jl/blob/master/src/registry/Models.toml)      |  Open-Source  | [docs](hhttps://alan-turing-institute.github.io/MLJ.jl/stable/) | [github](https://github.com/alan-turing-institute/MLJ.jl) |

## Documentación

| Nombre 	| Propósito                | Licencia     |	Docs   | Repositorio|
| ----------------- | ---------------------- | ------------ | -----| ---------- |
| Documenter.jl     | Documentar codigo paquetes       |  Open-Source  | [docs](https://juliadocs.github.io/Documenter.jl/stable/)  | [github](https://github.com/JuliaDocs/Documenter.jl) |

El paquete Documenter.jl es bastante interesante, y combina bien con la forma de crear docstrings del propio lenguaje. Este paquete es similar a Sphinx desarrollado en Python con una visualizacion por defecto parecida a *ReadTheDocs*. 


<small markdown="1">[Volver a la tabla de contenidos](#toc)</small>
{: .text-right }

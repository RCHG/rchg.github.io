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

Tenemos una lista de paquetes para Julia que esta creciendo continuamente, y se manejan gracias a Pkgs.jl
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

Sin embargo desde la version 1.3, Pkg.jl, posee otras funcionalidades y diseno:

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


## Paquetes de Visualizacion 

| Name 		| Purpose                  | License      |	Docs | Repository |
| --------- | ------------------------ | ------------ | ------ | ---------- |
| Plots.jl	| Visualization wrapper    | Open-Source  | [docs](http://docs.juliaplots.org/latest/) | [github](https://github.com/JuliaPlots/Plots.jl) |

Notes:

**Plots.jl** can use several backends like GR or pyplots (that uses matplotlib) between others.


## Matematicas y estadistica

| Name 		        | Purpose                | License      |	Docs | Repository |
| ----------------- | ---------------------- | ------------ | -----| ---------- |
|Distributions.jl 	| Distributions Probab.  |  Open-Source  | [docs](https://juliastats.github.io/Distributions.jl/stable/) , [paper](https://arxiv.org/abs/1907.08611) | [github](https://github.com/JuliaStats/Distributions.jl) |
|SpecialFunctions.jl| Special Functions Math | Open-Source  | [docs](https://juliamath.github.io/SpecialFunctions.jl/stable/)  | [github](https://github.com/JuliaMath/SpecialFunctions.jl) |
|GSL.jl 	        | Interface to GSL Math-Lib |  Open-Source  | [docs-gsl](https://www.gnu.org/software/gsl/doc/html/index.html)  | [github](https://github.com/JuliaMath/GSL.jl) |
| Convex.jl         |Mathematical Optimization | Open-Source  | [docs](https://www.juliaopt.org/Convex.jl/stable/) , [paper](https://web.stanford.edu/~boyd/papers/pdf/convexjl.pdf)  | [github](https://github.com/JuliaOpt/Convex.jl) |

## Machine Learning

| Name 		        | Purpose                | License      |	Docs | Repository |
| ----------------- | ---------------------- | ------------ | -----| ---------- |
| Flux.jl       	| [Machine Learning approach](https://julialang.org/blog/2017/12/ml&pl)       |  Open-Source  | [docs](https://fluxml.ai/Flux.jl/stable/) , [paper](https://joss.theoj.org/papers/10.21105/joss.00602) | [github](https://github.com/FluxML/Flux.jl) |
| MLJ.jl       	| [Machine Learning methods](https://github.com/alan-turing-institute/MLJModels.jl/blob/master/src/registry/Models.toml)      |  Open-Source  | [docs](hhttps://alan-turing-institute.github.io/MLJ.jl/stable/) | [github](https://github.com/alan-turing-institute/MLJ.jl) |


<small markdown="1">[Volver a la tabla de contenidos](#toc)</small>
{: .text-right }





<small markdown="1">[Volver a la tabla de contenidos](#toc)</small>
{: .text-right }

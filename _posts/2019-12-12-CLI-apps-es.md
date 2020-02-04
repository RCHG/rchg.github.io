---
layout: page
sidebar: right
subheadline: Tips
title:  "Aplicaciones y utilidades CLI"
teaser: "Terminal CLI"
breadcrumb: true
tags:
    - [scientific-computing, linux]
categories:
    - computing-blog
header:
    title: CLI comandos y applicaciones
    pattern: pattern_jquery-dark-grey-tile.png
---

<div class="panel radius" markdown="1">
#### Tabla de Contenidos
{:.no_toc }
*  TOC
{:toc}
</div>


> Se recogen aplicaciones para la consola/terminal que he encontrado útiles en mi trabajo diario, y también en mi uso personal

## Motivación

En mi uso diario trabajo fundamentalmente en la terminal, tanto localmente como remotamente. Aunque lo usual es usar la terminal para scripts, poco a poco he ido desechando las típicas aplicaciones GUI y me es más cómodo el uso de aplicaciones CLI.

## Manejo de referencias bibliográficas
La aplicación más completa GNU sobre Linux/Unix es Jabref, sin embargo de cara al manejo únicamente bajo la terminal me he decantado por la utilidad pubs [pubs](https://github.com/pubs/pubs), que me parece mas practica que papis para sencillamente trabajar con referencias en bibtex y archivos pdf.

Si ya posees una colección de archivos pdf correspondientes a artículos científicos, pubs combina muy bien con papers [cli-papers](https://github.com/perrette/papers) con el siguiente esquema:

` > papers extract mypaper.pdf`

Da como salida un archivo bibtex donde por ejemplo tienes el DOI, digamos myDOI

` > pubs add -D myDOI -d mypaper.pdf`

La utilidad cli papers podría ser una buena alternativa a pubs por si sola pero no ha tenido actualizaciones del código desde hace tiempo mientas que pubs es bastante activa.

Pueden existir alternativas para extraer el DOI de un pdf, tal como pdfx (que es una applicacion un poco mas general que no intenta generar un archivo bibtext del pdf, sino que busca metadata, enlaces etc). 

Si tienes instalados *pubs* y *papers*, el siguiente script en python te permitira incluir tus pdfs de articulos directamente en pubs.

{% highlight python %}
# ===============================================
# Code to add a set of pdf files from articles
# to a given pubs based library
#
# RCHG, Jan-2020.
# ===============================================

import glob
import os

list_pdfs = glob.glob('*.pdf')

for fpdf in list_pdfs:
    commands = 'papers extract '+fpdf + ' > temp.out'
    os.system(commands)
    with open('temp.out') as fout:
        out_lines = fout.readlines()
        for lin in out_lines:
            if 'doi = ' in lin:
                pdoi = lin.split('=')[1].replace('{','').replace('}','').replace(',','').replace(' ','').replace('\n','')
                print(fpdf, pdoi)
                if len(pdoi)>10:
                    pubsadd = 'pubs add -D '+pdoi+' -d '+fpdf
                    print(pubsadd)
                    os.system(pubsadd)
                    
{% endhighlight %}

Una vez instalado pubs y dado un repositorio (hay modos de tener varios independientes tal y como aparece en la web del programa). Podemos de manera sencilla acceder a lo que necesitemos:

- Para guardar la referencia en bibtex bastaria
  `> pubs export Monks_2009 > reference.bib`
- Para copiar el pdf del paper en el directorio actual:
  `> pubs doc export Monks_2009 ./`


## Gestión del tiempo y de tareas

Para esto personalmente uso dos aplicaciones relacionadas: una para gestionar el tiempo y las tareas.

- [Timewarrior](https://timewarrior.net/) permite crear una base de datos con el tiempo que utilizas en determinadas tareas. Te permite utilizar *tags* (etiquetas) sobre las cuales puedes buscar y crear sumarios. Por mi parte utilizo dos: una en mayúsculas para el proyecto, y una en minúsculas para la tarea concreta. No se si es la mejor manera pero me es útil. Una alternativa es **watson** pero no la conozco en detalle.

- ([Taskwarrior](https://taskwarrior.org/)es un gestor de tareas, dentro del abanico de GTDs. Ofrece muchas funcionalidades y posibilidad de extensiones y de gestores visuales (que permite su uso para aquellos no habituados a la terminal). Personalmente, uso **zenkit** ya que permite compartir tareas con colaboradores, desconozco si taskwarrior puede usarse también en casos multiusuario.

## Manejo de claves

La aplicación **pass** permite almacenar claves encriptadas desde la terminal, dado que se basa en un des-encriptado seguro, en teoría es posible compartir la base de datos entre ordenadores mediante entornos como dropbox or similares. Hay documentacion extensa, muchas extensiones y utilidades [pass](https://www.passwordstore.org). Para casos con varios ordenadores hay alternativas especificas, también basadas en open-source, como **bitwarden**, pero no es una aplicación CLI.

## Como llevar los gastos/ingresos: accounting

Hay varias aplicaciones que permiten tener un historial de gastos/ingresos en la terminal. Una página de referencia podría ser [cli-accounts](https://plaintextaccounting.org/), donde se hace referencia a una familia de aplicaciones que comienzan con ledger pero que tienen muchas otras derivadas de la misma filosofía. Mi elección personal ha sido **hledger**, cuya documentación podéis encontrar en [hledger](https://hledger.org/).

<small markdown="1">[Volver a la tabla de contenidos](#toc)</small>
{: .text-right }



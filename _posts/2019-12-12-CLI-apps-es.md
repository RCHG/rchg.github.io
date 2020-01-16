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
La aplicación más completa GNU sobre Linux/Unix es Jabref, sin embargo de cara al manejo únicamente bajo la terminal me he decantado por la utilidad pubs (https://github.com/pubs/pubs), que me parece mas practica que papis para sencillamente trabajar con referencias en bibtex y archivos pdf.

Si ya posees una colección de archivos pdf correspondientes a artículos científicos, pubs combina muy bien con papers (https://github.com/perrette/papers) con el siguiente esquema:

> papers extract mypaper.pdf
Da como salida un archivo bibtex donde por ejemplo tienes el DOI, digamos myDOI

> pubs add -D myDOI -d mypaper.pdf

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


<small markdown="1">[Voler a la tabla de contenidos](#toc)</small>
{: .text-right }



</div><!-- /.medium-8.columns -->
</div><!-- /.row -->


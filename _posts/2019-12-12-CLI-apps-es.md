---
layout: page
sidebar: right
subheadline: Tips
title:  "Aplicaciones y utilidades CLI"
teaser: "Terminal CLI"
breadcrumb: true
tags:
    - [Scientific Computing, Linux, CLI, Management]
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


> Se recogen aplicaciones para la consola/terminal (CLI) que he encontrado útiles tanto en mi trabajo diario como en mi uso personal.

## Motivación

En mi trabajo diario la herramienta principal que uso es la terminal de comandos, tanto localmente como remotamente. Aunque es usual usar la terminal solo para scripts, poco a poco he ido desechando las típicas aplicaciones GUI y me es más cómodo el uso de aplicaciones CLI. Por una parte me resulta más rápido para muchas tareas, por ejemplo, de modo continuo uso LaTeX para escribir y la mayoría de las veces bajo un editor vim/nvim/emacs, la posibilidad de sumar a la terminal un programa para las referencias me hace tener un flujo de trabajo fluido, además lo usual es que requieran menos recursos y sean fáciles de instalar en cualquier computadora Unix/Linux. Dado que estoy trabajando la mayoría del tiempo en una terminal para programar, revisar simulaciones o tareas similar, es conveniente gestionar varios aspectos desde la propia shell/terminal de comandos: gestión del tiempo, claves, incluso algunos también gestionan el correo electrónico. Incluso si uno usa un entorno de escritorio tipo 'tiling windows' que se maneja esencialmente desde el teclado se incrementa nuestra productividad. En mi caso uso *xmonad* aunque tambien he usado *i3/sway*. 


## Manejo de referencias bibliográficas

La aplicación más completa GNU sobre Linux/Unix es **Jabref**, sin embargo de cara al manejo únicamente bajo la terminal me he decantado por la utilidad [pubs](https://github.com/pubs/pubs), que me parece más practica que *papis* (otra utilidad que esta ganando popularidad) para sencillamente trabajar con referencias en *bibtex* y archivos *pdf*.

Si ya posees una colección de archivos en *pdf* correspondientes a artículos científicos, pubs combina muy bien con otra utilidad llamada papers para la terminal: [cli-papers](https://github.com/perrette/papers) con el siguiente esquema:

` > papers extract mypaper.pdf`

Da como salida un archivo *bibtex* donde por ejemplo tienes el DOI, digamos myDOI

` > pubs add -D myDOI -d mypaper.pdf`

La utilidad cli *papers* podría ser una buena alternativa a pubs por si sola, pero no ha tenido actualizaciones del código desde hace tiempo mientas que pubs es bastante activa e incorpora muchas mejoras. Yo mismo he intentado mejorar [papers-rchg](https://github.com/rchg/papers) incorporando algunas funcionalidades nuevas como palabras clave (tags/keywords) o mejorar la visualización de busquedas, sin embargo *pubs* sigue siendo más completa.   

Pueden existir alternativas para extraer el DOI de un pdf, tal como pdfx (que es una applicacion un poco más general que no intenta generar un archivo bibtext del pdf, sino que busca metadata, enlaces etc). 

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

Una vez instalado pubs y dado un repositorio (hay modos de tener varios independientes, tal y como aparece en la documentación del proyecto en github). Podemos de manera sencilla acceder a lo que necesitemos:

- Para guardar la referencia en bibtex en un archivo: `> pubs export Monks_2009 > reference.bib`
- Para copiar el pdf del paper en el directorio actual: `> pubs doc export Monks_2009 ./`

Si sabemos algo del manejo de nuestra shell, podemos manejar de modo ágil nuestra base de datos de referencias bibliográficas. Por ejemplo, si queremos buscar todos los artículos con *ozone* en el título y adjudicarle un *tag* llamado ozone, que juzgamos nos puede ser útil más adelante, haríamos:

`> pubs list "title:ozone" -k | xargs -l -I $  pubs tag $ +ozone`
 
- Con `> pubs list "title:ozone" -k` pedimos la lista de *citekeys* (por eso -k) que contienen en el título la palabra *ozone*. 
- Luego pasamos esta lista a [xargs](https://en.wikipedia.org/wiki/Xargs) usando los argumentos `-l -I $` que tratan la entrada como una lista y dice que cada item sea colocado donde apareza el simbolo `$`. Luego indicamos `pubs tag $ +ozone`. Podemos usar la opcion `-p` la primera vece para verificar que estamos haciendo lo que deseamos.

`> pubs list "title:ozone" -k | xargs -l -p -I $  pubs tag $ +ozone`

Ya que nos pedirá confirmación para cada ejecución que haga *xargs* del comando deseado (pubs en este caso). En mi caso, por ejemplo, aparece:

`> pubs list "title:ozone" -k | xargs -l -p -I $  pubs tag $ +ozone`

`> pubs tag Checa_Garcia_2018 +ozone ?...` y nos pide confirmación (y/n).

En mi caso es importante el uso de keywords para clasificar las referencias por proyectos, de esta manera puedo desde una base de
datos más general obtener las referencias que corresponden o son útiles para un determinado proyecto.

### Uso de pubs para buscar referencias

En principio no hay un motor de busqueda propio e independiente dentro de pubs, pero permite busquedas dentro de google scholar mediante el comando `websearch`. Doy algunos ejemplos:

- Busqueda por autor y palabras clave:
`> pubs websearch author:Shine climate feedbacks`
- Busqueda por revista y palabras clave:
`> pubs websearch radiative forcing  source:Nature`
- Busqueda por palabras en titulo:
`> pubs websearch allintitle: radiative forcing source:Nature`

En todos los casos se abre la web de google scholar en nuestro navegador pre-determinado con los parametros indicados. Notar que se pueden combinar todos ellos: *author*, *source*, *allintitle*.

### Uso de pubs para abrir webs de enlace

Si en nuestra entrada de pubs, poseemos un enlace *url* o el doi, esto permite abrir directamente la web con la referencia:

{% highlight bash %}
> pubs url Checa_Garcia_2018
info: opening url https://doi.org/10.1002%2F2017gl076770
{% endhighlight %}

### Otras herramientas dentro de pubs

Podemos importar previous archivos bibtex mediante

`> pubs import bibpath`  que admite varias opciones extra y bibpath puede ser bibtex u otros formatos soportados

El manejo de varias bibliotecas aparece descrito en [multiple-repositories](https://github.com/pubs/pubs#multiple-pubs-repository) posibilidad muy util si queremos tener diferentes biblotecas por temas, proyectos etc.

## Gestión del tiempo y de tareas

Para esto personalmente uso dos aplicaciones relacionadas: una para gestionar el tiempo y las tareas.

- [Timewarrior](https://timewarrior.net/) permite crear una base de datos con el tiempo que utilizas en determinadas tareas. Te permite utilizar *tags* (etiquetas) sobre las cuales puedes buscar y crear sumarios. Por mi parte utilizo dos: una en mayúsculas para el proyecto, y una en minúsculas para la tarea concreta. No se si es la mejor manera pero me es útil. Una alternativa es **watson** pero no la conozco en detalle.

El modo de uso es sencillo (en este caso nos damos cuenta de haber trabajado ya 15 min antes del registro en nuestro projecto Ciencia (estamos introduciendo dos *tags*: *Mi-Projecto* y *Ciencia*).

{% highlight bash %}
> timew start 15min ago Mi-Projecto Ciencia
> Tracking Mi-Projecto Ciencia
  Started 2020-02-07T12:01:06
  Current               15:06
  Total               0:15:00
{% endhighlight %}

En caso de que estemos ya registrando una actividad nos notificara el cambio:

{% highlight bash %}
> timew start Nuevo-Projecto 
 Recorded Mi-Projecto Ciencia
  Started 2020-02-07T08:55:56
  Ended              12:01:06
  Total               3:05:10
Tracking Nuevo-Projecto
  Started 2020-02-07T12:01:06
  Current                  06
  Total               0:00:00

{% endhighlight %}


- [Taskwarrior](https://taskwarrior.org/) es un gestor de tareas, dentro del abanico de GTDs. Ofrece muchas funcionalidades y posibilidad de extensiones y de gestores visuales (que permite su uso para aquellos no habituados a la terminal). Personalmente, uso **zenkit** ya que permite compartir tareas con colaboradores, desconozco si taskwarrior puede usarse también en casos multiusuario.

**Actualización**: He usado durante un tiempo las herramientas Taskwarrior y Timewarrior pero en este momento utilizo **org-mode** en emacs (en mi caso en doom-emacs). Es una herramienta completa, potente y que sirve para multiples facetas de mi trabajo diario como manejo de proyectos, gestión de tareas o monitorizar el tiempo, y eso entre otras muchas. Como es un mundo en si mismo, recomiendo una busqueda en internet acerca de org-mode. La curva de aprendizaje puede ser mayor, pero las posibilidades que ofrece lo merece.
{:.smallblock}


## Manejo de claves

La aplicación **pass** permite almacenar claves encriptadas desde la terminal, dado que se basa en un des-encriptado seguro, en teoría es posible compartir la base de datos entre ordenadores mediante entornos como dropbox or similares. Hay documentacion extensa, muchas extensiones y utilidades [pass](https://www.passwordstore.org). Para casos con varios ordenadores hay alternativas especificas, también basadas en open-source, como **bitwarden**, pero no es una aplicación CLI.


**Actualización**: bitwarden parece que ofrece tambien una version para la terminal de comandos aunque aun no la he probado.
{:.smallblock}

## Como llevar los gastos/ingresos: accounting

Hay varias aplicaciones que permiten tener un historial de gastos/ingresos en la terminal. Una página de referencia podría ser [cli-accounts](https://plaintextaccounting.org/), donde se hace referencia a una familia de aplicaciones que comienzan con ledger pero que tienen muchas otras derivadas de la misma filosofía. Mi elección personal ha sido **hledger**, cuya documentación podéis encontrar en [hledger](https://hledger.org/).

<small markdown="1">[Volver a la tabla de contenidos](#toc)</small>
{: .text-right }



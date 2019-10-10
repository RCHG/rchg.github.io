---
layout: page
sidebar: right
subheadline: Tips
title: "Learning Nixos"
excerpt: "Step by Step "
teaser: "Notes to understand NixOS, Nix and nixpkgs."
breadcrumb: true
tags: [nixos, linux, functional-languages]
categories:
    - computing-blog
header:
    title: Learning Nixos
    pattern: pattern_jquery-dark-grey-tile.png
---

Nix
====

Nix es un *package manager* que no asume informacion externa  sobre el estado del sistema.
Es decir, que no asume que determinados recursos, ficheros etc van a estar en determinadas
localizaciones. Esto lleva a que los paquetes que instala esten contenidos en un directorio
especial llamado **/nix/store/**

Dado que cada paquete en este directorio aparece con un *hash-name* del tipo:
/nix/store/s4zia7hhqkin1di0f187b79sa2srhv6k-bash-4.2-p45/
entonces es posible tener multiples versiones del mismo paquete en este directorio en teoria
sin interferencias.

Una consecuencia es que las localizaciones tipicas: /bin,  /usr/bin, etc, no contienen los 
paquetes, es decir, no se tiene la estructura jerarquica de paquetes tipica de Linux. Pero 
ganamos que /nix/store es inmutable y en teoria reproducible. La teoria dice que asi se
ha resuelto el llamado *dependency hell*. Notar que aqui por inmutable queremos decir que
si instalamos una version nueva de un paquete, este es installado sin borrar la version
anterior (tendra otro hash) con lo que todos los paquetes que incompatibles con la version
nueva que no se re-construyan seguirian functionando. Es reproducible, porque siempre podemos
volver al estado anterior del sistema si los paquetes previos no han sido eliminados por 
el usuario.

El manejo basico de paquetes:

{% highlight bash %}
>  nix-env -i name             # instala un paquete
>  nix-env --list-generations  # ve a lista de estados del sistema (generaciones)
>  nix-env -q                  # lista los paquetes instalados que se llaman **derivations**
>  nix-env --rollback          # vuelve al estado de una generacion atras
>  nix-env -G 3                # vuelve al estado de la generacion numero 3> 
{% endhighlight %}

Para entender como se estructuran las dependencias en */nix/store* existe un comando:

{% highlight bash %}
>  nix-store -q --references `which hello`  # this will show the depedences of hello **on runtime**
>  nix-store -q --referrers `which hello`   # this will show the paquetes que dependen de hello **on runtime**
>  nix-store -q --tree `which hello`        # esto es todo el arbol de dependencias para crear hello
{% endhighlight %}

Lenguaje Nix
------------

Hasta el momento hemos visto solo nix como un comando shell que instala paquetes. En realidad, Nix es bastante mas,
es un lenguaje de programacion para gestionar todos los aspectos de la creacion y uso de derivaciones.

Asi el lenguaje nix es un leguaje de tipo funcional (solo posee expresiones, no statements), y sus variables son inmutables. 
En ingles Nix es: a pure, lazy, functional language, strongly typed, but it's not statically typed.
Esencialmente, escribimos expresiones que crean una derivacion que luego se construye con **nix-build** (un comando que lee
el codigo de la derivacion y lo interpreta para crear luego el paquete).

Podemos abrir en nuestra shell un entorno repl (como hay en Python, Haskell o Julia) que nos permite aprender a entender
la sintaxis de Nix.

Tipos basicos en Nix:
- integer
- floating point
- string
- path
- boolean
- null
- lists
- sets
- functions

Existen operadores basicos artimeticos con la sintaxis habitual para +, - etc . Division como existe el tipo path se usa '/ ' o bien la version functiona: 'builtins.div x y' que equivale a x/y (no son necesarios los parentesis). Tambien notar que 1-2 posee sentido (es -1) pero a-b seria el nombre de una variable. Si a y b son variables numericas a menos b seria 'a - b' con espacios.


 - Strings o cadenas:
   se especifican entre dos " (una de inicio otra de fin) o dos '' 
 - Lists o listas:
   pueden ser multi-tipo pero son inmutables
 - Sets o diccionarios:
   s = { foo = "bar"; a-b = "baz"; "123" = "num"; }
   asi que: > s."123" devuelve "num"
   Es posible definir sets de modo recursivo (al modo de suponer que un elemento es una funcion de una variable que
   esta dada en un elemento previo):
   { a = 3; b = a+4; }  esto da error (a no definido)
   rec { a = 3; b = a+4; } esto da { a = 3; b = 7; }
   
If-then

> if a > b then "yes" else "no"

los operadores de comparacion son:  ||, && and ! (para booleans), y !=, ==, <, >, <=, >= para otros tipos con identidad y/o relacion de orden.

Let define una variable de modo local 

> let a = "foo"; in a
 

Lazyness:

> let a = builtins.div 4 0; b = 6; in b

esto no da error ya que a nunca es evaluado (no se necesita en la expresion)













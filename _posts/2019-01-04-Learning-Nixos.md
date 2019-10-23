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

# Nix

Nix es un *package manager* que no asume información externa sobre el estado del sistema.
Es decir, que no asume que determinados recursos, ficheros etc van a estar en determinadas
localizaciones. Esto lleva a que los paquetes que instala estén contenidos en un directorio
especial llamado **/nix/store/**

Dado que cada paquete en este directorio aparece con un *hash-name* del tipo:

```
/nix/store/s4zia7hhqkin1di0f187b79sa2srhv6k-bash-4.2-p45/
```
entonces es posible tener multiples versiones del mismo paquete en este directorio en teoria
sin interferencias.

Una consecuencia es que las localizaciones típicas: /bin, /usr/bin, etc, no contienen los
paquetes, es decir, no se tiene la estructura jerárquica de paquetes típica de Linux. Pero
ganamos que */nix/store* es inmutable y en teoría reproducible. La teoría dice que así se
ha resuelto el problema llamado *dependency hell*. Notar que aquí por inmutable queremos decir que
si instalamos una versión nueva de un paquete, este es instalado sin borrar la versión
anterior (tendrá otro *hash*) con lo que todos los paquetes que sean incompatibles con la versión
nueva y que no se reconstruyan seguirían funcionando. Es reproducible, porque siempre podemos
volver al estado anterior del sistema si los paquetes previos no han sido eliminados por
el usuario.

El manejo básico de paquetes:

{% highlight bash %}
> nix-env -i name # instala un paquete
> nix-env --list-generations # ve a lista de estados del sistema (generaciones)
> nix-env -q # lista los paquetes instalados que se llaman **derivations**
> nix-env --rollback # vuelve al estado de una generación atrás
> nix-env -G 3 # vuelve al estado de la generación numero 3>
{% endhighlight %}

Para entender como se estructuran las dependencias en */nix/store* existe un comando:

{% highlight bash %}
> nix-store -q --references 'which hello' # muestra las dependencias de hello **on runtime**
> nix-store -q --referrers 'which hello' # muestra que depende de hello **on runtime**
> nix-store -q --tree 'which hello' # muestral el árbol de dependencias para crear hello
{% endhighlight %}

Podemos también usar '''nix-store''' haciendo referencia a un paquete en */nix/store* para ver su árbol de dependencias.

## Lenguaje Nix

Hasta el momento hemos visto solo nix como un comando shell que instala paquetes. En realidad, Nix es bastante más, es un lenguaje de programación para gestionar todos los aspectos de la creación y uso de derivaciones.

Así el lenguaje nix es un lenguaje de tipo funcional (solo posee expresiones, no statements), y sus variables son inmutables. En ingles Nix es: a pure, lazy, functional language, strongly typed, but it's not statically typed. Esencialmente, escribimos expresiones que crean una derivación que luego se construye con **nix-build** (un comando que lee el código de la derivación y lo interpreta para crear luego el paquete).

Podemos abrir en nuestra shell un entorno repl (como hay en Python, Haskell o Julia) que nos permite aprender a entender la sintaxis de Nix.

### Tipos basicos en Nix:

- integer
- floating point
- string
- path
- boolean
- null
- lists
- sets
- functions

Existen operadores básicos aritméticos con la sintaxis habitual para +, - etc . División como existe el tipo path se usa '/ ' o bien la versión funciona: 'builtins.div x y' que equivale a x/y (no son necesarios los paréntesis). También notar que 1-2 posee sentido (es -1) pero a-b seria el nombre de una variable. Si a y b son variables numéricas a menos b seria 'a - b' con espacios.

- *Strings o cadenas*:
  se especifican entre dos " (una de inicio otra de fin) o dos ''
- *Lists o listas*:
  pueden ser multi-tipo pero son inmutables
- *Sets o diccionarios*:
   s = { foo = "bar"; a-b = "baz"; "123" = "num"; }
   asi que: > s."123" devuelve "num"
   Es posible definir sets de modo recursivo (al modo de suponer que un elemento es una función de una    variable que esta dada en un elemento previo):
   { a = 3; b = a+4; } esto da error (a no definido)
   rec { a = 3; b = a+4; } esto da { a = 3; b = 7; }
   
### If-then y let
{% highlight bash %}
$> if a > b then "yes" else "no"
{% endhighlight %}

los operadores de comparación son: ||, && and ! (para booleans), y !=, ==, <, >, <=, >= para otros tipos con identidad y/o relación de orden.

*Let* define una variable de modo local 

{% highlight bash %}
$> let a = "foo"; in a
{% endhighlight %}
 

**Lazyness**:
{% highlight bash %}
$> let a = builtins.div 4 0; b = 6; in b
{% endhighlight %}
esto no da error ya que a nunca es evaluado (no se necesita en la expresión)

### Funciones
{% highlight bash %}
$> x: x*2
$> cuadrado x: x*2
$> suma = a: b: a + b
$> suma = a: (b: a + b)
$> suma = { a, b }: a*b
{% endhighlight %}







## Configuración en NixOS

Se localiza en '/etc/nixos/configuration.nix' y este archivo es una expresión en el lenguaje Nix. Entender este archivo y saber como configurar con el sistema necesita a su vez conocer dos aspectos:

- Como se construye la sintaxis de esta expresión en Nix
- Como funciona la configuración de un sistema Linux (nos olvidamos aquí de MacOS/Darwin)

### configuration.nix

{% highlight nix %}
{ config, pkgs, ... }: # define una función que toma al menos dos argumentos
# Y cuyo cuerpo posee una serie de expresiones
{
option definitions # expresiones que definen la configuración.
}

{% endhighlight %}









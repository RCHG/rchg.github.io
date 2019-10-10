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





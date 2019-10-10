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
------

Nix es un *package manager* que no asume informacion externa  sobre el estado del sistema.
Es decir, que no asume que determinados recursos, ficheros etc van a estar en determinadas
localizaciones. Esto lleva a que los paquetes que instala esten contenidos en un directorio
especial llamado **nix/store/**

Dado que cada paquete en este directorio aparece con un *hash-name* del tipo:
/nix/store/s4zia7hhqkin1di0f187b79sa2srhv6k-bash-4.2-p45/
entonces es posible tener multiples versiones del mismo paquete en este directorio en teoria
sin interferencias.

Una consecuencia es que las localizaciones tipicas: /bin,  /usr/bin, etc, no contienen los 
paquetes, es decir, no se tiene la estructura jerarquica de paquetes tipica de Linux.


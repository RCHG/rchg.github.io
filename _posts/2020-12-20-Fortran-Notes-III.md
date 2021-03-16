---
layout: page
sidebar: right
subheadline: Notebook
title: "Fortran 90 Notebook III"
teaser: "List of libraries, compilers and editors of Fortran. The list is mainly focused to Modern Fortran but there are some resources also useful for Fortran 77 users."
breadcrumb: true
tags: [Scientific-computing, Fortran]
categories:
    - computing-blog
header:
    title: Fortran 90/95
    pattern: pattern_jquery-dark-grey-tile.png
---

<section id="table-of-contents" class="toc">
  <header>
    <h3>Table of Contents</h3>
  </header>
<div id="drawer" markdown="1">
*  Auto generated table of contents
{:toc}
</div>
</section><!-- /#table-of-contents -->


## General information

Fortran is one of the oldest computer programming languages that is still alive. It is not a main language, but it has its niche in scientific applications. There are several blog entries that a I think useful to understand recent updates in the language itself. First in github [f3-fortran](https://github.com/j3-fortran/fortran_proposals) there is a list of proposals that are related, as far as I understood, with [LFortran](https://lfortran.org/) new compiler.  

Other important source of updates of fortran comunity is centralized in the [fortran-lang](https://github.com/fortran-lang) github group. There you have a webpage [fortran-lag.org](https://fortran-lang.org/) where you can find news and information of the related projects. From them I highlight two: the fortran-package-manager [fpm](https://github.com/fortran-lang/fpm) and the [standard-lib](https://github.com/fortran-lang/stdlib). The last one relies on few python libraries to create an interesting tool. 

For further information you can read two summaries at [resurrecting-fortran](https://ondrejcertik.com/blog/2021/03/resurrecting-fortran/) and [1st-year of fortran-lang](https://medium.com/modern-fortran/first-year-of-fortran-lang-d8796bfa0067).

## Tools

| Name 	            | Goal                        | Licence       |	Docs   | Link       |
| ----------------- | --------------------------- | ------------- | -------| ---------- |
| findent           | Beautify f90, f2003 code    |  Open-Source  | [info](https://sourceforge.net/projects/findent/)  | [sourceforge](https://sourceforge.net/projects/findent/) |
| tags (ctags)      | Syntax higlight             |  Open-Source  | [info](http://ctags.sourceforge.net/) | [sourceforge](https://sourceforge.net/projects/ctags/)                |
| f2c               | Fortran77 to C translator   |  Open-Source  | [info](https://en.wikipedia.org/wiki/F2c) | [code](http://www.netlib.org/f2c/) |
| fortran-language-server | support for editors   |  MIT          | [info](https://github.com/hansec/fortran-language-server) | [github](https://github.com/hansec/fortran-language-server) |
| fntcheck                | code checker F77      |               |       |             |
| gdb                     | gnu debugger          |  GPL          |       |             |
| fpm                     | package manager       |  MIT          | [info](https://github.com/fortran-lang/fpm/blob/master/PACKAGING.md) | [github](https://github.com/fortran-lang/fpm) |

## IDE

| Name 	            | Kind                        | Licence       |	Docs   | Link       |
| ----------------- | --------------------------- | ------------- | -------| ---------- |
| Geany             | General IDE                 |  Open-Source  |        |            |
| Code-Blocks       | Support Fortran and C  |  Open-Source  |        |            |
| Eclipse+Photran   | Fortran in Eclipse          |  Open-Source  |        |            |
| Kate              | general IDE                 |  Open-Source  |        |            |
| Atom              | general IDE (plugins)       |  Open-Source  |        |            |
| Emacs             | Two fortran modes (f77 & f90)| Open-Source  |        |            |
| Visual Studio     | general IDE (plugins)       |  Open-Source  |        |            |
| vim               | with vim-fortran plugin     |  Open-Source  |        |            |

## Compilers

| Name 	            | Kind                        | Licence       |	Docs   | Link       |
| ----------------- | --------------------------- | ------------- | -------| ---------- |
| gfortran          | GCC                         |  Open-Source  | [info](https://gcc.gnu.org/wiki/GFortran) | [web](https://gcc.gnu.org/fortran/)           |
| LFortran          | LLVM                        |  Open-Source  |        | [web](https://lfortran.org/)            |
| Flang             | LLVM                        |  Open-Source  |        | [web](https://github.com/llvm/llvm-project/tree/main/flang)           |


---
layout: page
sidebar: right
subheadline: Notebook
title: "Fortran 90 Notebook II"
teaser: "Overview"
breadcrumb: true
tags: [Scientific-computing, Fortran]
categories:
    - computing-blog
header:
    title: Fortran 90/95
    pattern: pattern_jquery-dark-grey-tile.png
author: ramiro_chg
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

> This notes were possible by reading from several sources, but the book *Introduction to Programming with Fortran* [^1] was specifically useful because its large set of examples and progressive definitions. My first approach to Fortran 90 relies on the manual Physique Numérique[^2] that I recommend to those people interested in an introduction to Computational Physics based in Fortran.

[^1]: Introduction to Programming with Fortran, *Ian Chivers and Jane Sleightholme*, Springer 2006.
[^2]: Physique Numérique, Ph. Depondt, INSP and CNRS Université Pierre et Marie Curie, 2006.

## Advanced Fortran

### Pointers

In general all the most common multi-dimensional data types are static, which means that the size has to be clearly defined before any
possible operation with the them. In Fortran as commented in my previous [Fortran Notes](https://rchg.github.io//computing-blog/Fortran-Notes/)
there are several "kind" of arrays concerning how it is determined the shape, but even with allocated arrays its shape has to be defined on execution
time. Pointers aims to be a flexible tool when the problems to be solved are more complex or not totally defined a-priori. The general idea
is that a pointer can be associated to the values of another variable, this association can be changed during runtime, but also 
the pointer can "point" to a "target" that is a sub-array for another array-variable. Alse these kind of associations give to pointers
a lot of flexibility to the programer. The pointers are not present in Fortran 77.

### Derived Types

Other tool not present in Fortran 77 are the derived types. The provide a similar functionality to the "objects" that we can find in other
languages, but it is possible just to consider them a kind of encapsulation of several data types on a single entity.  

#### Examples

{% highlight fortran %}

subroutine date_type(dtime)
implicit none
type date_time
  integer :: year
  integer :: month
  integer :: day
  integer :: hour
  integer :: minute
  real(8) :: second
end type date
type (date_time), intent(out) :: dtime

dtime%year = 2016
dtime%month = 1
dtime%day = 21
dtime%hour = 11
dtime%minute = 15
dtime%second = 20.345

end subroutine
{% endhighlight %}

In this subroutine is defined a typical date and time derived type. We can see that in the object dtime is included all the
information. We can access to the different date-time parts simply as dtime%day, dtime%time etc... but also we can potentially define
an operation like: dsum(dtime1, dtime2) that will give a new date_time derived type, or even overide the intrinsic sum '+' to deal
with date_time types.


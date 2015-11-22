---
layout: page
sidebar: right
subheadline: Notebook
title: "Fortran 90 Notebook"
teaser: "Overview"
breadcrumb: true
tags: [Scientific-computing, Fortran]
categories:
    - computing-blog
header:
    title: R. Checa-Garcia webpage |  Fortran 90
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

## Terminology

### Arrays

- **explicit-shape array**: declared with explicit values for the bounds in each dimension of the array. For this we can have **automatic arrays**, when the array is a local variable, and **adjustable array** when it is a dummy argument to a subprogram or procedure.
- **assumed-shape array**: it is a non-pointer(!) dummy argument array that takes its shape from the associated actual argument array (by actual I mean the array that is introduced or demanded by the main program when it is called the subprogram or procedure). It is interesting to combine this approach with the size() instrinc procedure that gives the actual size of an array. We then can obtain within the procedure the size of the array and use this integer value inside the subprogram. For example to allocate an intent(out) array with the correct dimensions.
- **deferred-shape array**: is an allocatable array (it has the ALLOCATABLE attribute and a specified rank but their bounds are set by allocation or argument association) or array pointer.
- **automatic array**: it is explicit-shape and *local*. It is usually in subprograms and the bounds are set when the subprogram is called

#### Examples

An example with a subprogram (a subroutine) with arguments x and n will be:

{% highlight fortran %}
subroutine example(x , n)
implicit none
integer     , intent(in)                     :: n
real        , intent(in)    , dimension(1:n) :: x
{% endhighlight %}

Here x is a dummy argument declared with specific bounds therefore it is a explicit-shape dummy array. However we could use an assumed-shape dummy array because in Fortran 90 and later versions the actual array size and the associated dummy arguments have the same rank and the same size in each dimension. In this situation a different approach will be:

{% highlight fortran %}
  program example_main

  implicit none
  integer                         :: n
  real, allocatable, dimension(:) :: a

  ! The interface part is optional and not mandatory  
  ! it is useful when we have external subprograms
  ! and we can help the compiler to a full consistence
  ! checking. It is recomended its use.

  interface
     subroutine example(x)
        implicit none
        integer                           :: m
        real   , intent(in), dimension(:) :: x
    end subroutine example
  end interface

  ! n can be read from a file for example

  read *,n
  allocate(x(1:n))

  CALL example(x)

  end example_main


  subroutine example(x)
  implicit none
  integer                                    :: n
  real        , intent(in)    , dimension(:) :: x

  n = size(x)

  {% endhighlight %}

### Procedures

They are very important for break the code in smaller problems, to don't repeat code within a program, to allow a better testing strategy.

In general the procedures communicate with the main program or other procedure by the arguments, inside the procedure they are named dummy arguments.Because Fortran is an strongly type code, we have to define the type of each argument both in the main program and in the procedures and they have to be consistent (this is for instance ensured by the definition of an interface). 

Inside the procedures, specifically in the subroutines, we have the possibility of define if the dummy argument is an input, an output or both, by the intent sentence in the type definition block at the beginning of the sentence. The internal local variables are simple not included in the list of arguments of the procedure and they are destroyed once the procedure end.

The interface block is mandatory in several cases: 

    1. A procedure with optional or keywords arguments
    2. Function returning an array or a pointer
    3. Procedure with assumed-shape dummy arguments
    4. Procedure with dummy arguments with pointer or target attribute
    5. Procedure generic (this allow overloading)
    6. Procedure defining a user operator
    7. Procedure with a user defined assignment

#### Functions

#### Subroutines

A very interesting case is when the subroutine is including a procedure as argument
this means that we have to define an interface for the function that is consistent
with the actual procedure argument

{% highlight fortran %}

subroutine my_own(a, ext_sub, b, c, d)
implicit none
real, intent(in),  dimension(:) :: a
real, intent(out), dimension(:) :: b
integer                         :: c,d

interface 
    subroutine ext_sub(a,b,c)
    implicit none
    real, intent(in),  dimension(:) :: a
    real, intent(out), dimension(:) :: b
    integer, intent(inout)          :: c
    real                            :: parm1, parm2
    end subroutine ext_sub
end interface

! now we have operations including call ext_sub(a,b,c) and using the arguments b and c 
! ..

end subroutine my_own
{% endhighlight %}


In this situation we have to include information on a main program using this
subroutine as

{% highlight fortran %}
program main
implicit none
real     :: parmx, parmy
integer  :: i,j,k
real, allocatable, dimension(:)  :: x,y,z

interface
    subroutine my_own()

    interface
        subroutine ext_sub()


        end subroutine ext_sub
    end interface
    end subroutine my_own
end interface

interface
    subroutine ext_sub1()

    end subroutine ext_sub1
end interface
interface
    subroutine ext_sub2()

    end subroutine ext_sub2()
end interface
{% endhighlight %}


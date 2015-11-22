---
layout: page
sidebar: right
subheadline: Notebook
title: "Using C procedures in a Fortran code"
teaser: "C and Fortran together"
breadcrumb: true
tags: [Scientific-computing, Fortran, C/C++]
categories:
    - computing-blog
header:
    title: R. Checa-Garcia webpage |  ISO_C_BINDING
    pattern: pattern_jquery-dark-grey-tile.png
author: ramiro_chg
---


> Here I described the inter-operability between C and Fortran

The interoperability is possible in Fortran 2003 as it incorporates an specific module called ISO_C_BINDING that ensures a correct use of the C intrinsic types.

Also we can have a interoperability of derived types:

{% highlight fortran %}
use iso_c_binding
...
    type, bind(c) :: my_own_type
        integer (c_init) :: a,b,c
        real (c_float)   :: o,p
    end type my_own_type
...
{% endhighlight %}

with the above code we can inter-operate with a typical C code:

{% highlight c %}
  typedef struct {
    int i,j,k;
    float  r,s;
  } my_c_type;
{% endhighlight %}

However we can also have a procedure inter-operations. For example in Fortran we can make,

{% highlight fortran %}
use iso_c_binding
...
  function func(a,b,c,d) bind(c, name='c_func')
...
{% endhighlight %}



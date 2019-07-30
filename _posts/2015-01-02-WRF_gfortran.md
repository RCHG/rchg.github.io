---
layout: page
sidebar: right
subheadline: Tips
title:  "Notes on WRF-gfortran-compilation"
teaser: "How to compile WRF with gfortran"
breadcrumb: true
tags:
    - [scientific-computing, fortran, WRF]
categories:
    - computing-blog
    - science-blog
header:
    title: WRF Tips
    pattern: pattern_jquery-dark-grey-tile.png
---
> Here I described a solution for a problem in the compilation of WRF with gfortran. The problem arrives because some comments are considered code. This was posted on the [WRF-Forum](http://forum.wrfforum.com/viewtopic.php?f=5&t=6086)


My diagnostic of that the problem is related with the **C preprocessor**. A possible solution is change:

{% highlight bash %}
CPP             =  /lib/cpp -C -P
{% endhighlight %}

to

{% highlight bash %}
CPP             =  /lib/cpp -P
{% endhighlight %}

I think this avoid the addition of C-style comments to the .f90 files. However *this should be changed for every makefile in the directories of WRF*. The other solution is add -cpp to the gfortran. Basically you have to change two lines:

{% highlight bash %}
FORMAT_FIXED    =  -ffixed-form -cpp
FORMAT_FREE     =  -ffree-form -ffree-line-length-none -cpp
{% endhighlight %}


Now the gfortran knows that cpp preprocessor is being used. The most easy way is generate the file configure.wrf as usual and before compile anything change manually those two lines by adding -cpp (and check before any compilation). Also is possible apply the changes on the ./configure script.s

In my case these changes were enough to compile with gfortran. Anyway, previously to do this you may try

{% highlight bash %}
gfortran -v
{% endhighlight %}

the output would be the default configuration of gfortran on your machine, and probably there isn't anything like -cpp. I guess this output may depend partially on your Linux distribution (or Unix system).

**Other users comments:**
In the forum others users replied that my solution works also for *WRFDA*. If you are using *ifort* instead *gfortran* another user of the forum commented that added *-fpp* instead *-cpp*
{:.notice}

---
layout: page
sidebar: right
subheadline: Notebook
title:  "Introduction to make"
teaser: "Survival guide to make"
breadcrumb: true
tags: [Scientific-computing, Make]
categories:
    - computing-blog
header:
    title: Make Unix Tool
    pattern: pattern_jquery-dark-grey-tile.png
author: ramiro_chg
---


<section id="table-of-contents" class="toc">
<div class="panel radius" markdown="1">
#### Table of Contents
{:.no_toc }
*  TOC
{:toc}
</div>
</section><!-- /#table-of-contents -->


### What is make?

It is a command line tool to perform automatic tasks. Usually it is used on compilation of complex codes to ensure
that all the dependencies are correcly included, but also it allows to perform other repetitive tasks efficently.

Often the kind of task we are doing in scientific computing are somehow hierarchical. So we extract some data information
from a server using a program, we run a custom made model based on that data, we obtain new output datafiles that can
be processed as an input of another program. For example a data analysis program or another code to perform additional simulations.

As we see in each step of the process we have a **target** with one or more **dependencies** that is using a **program** to
build the target from them. Make helps you to create **rules** for that. The structure is more and less standard:

{% highlight make %}
target: dependency1 dependency2 dependency3
    rule
{% endhighlight%}

### Step by Step with examples

For example, the next rule compile a Fortran code with dependences: *compute.f90 constants.f90 main.f90* and a target 
**myprogram.out**. 

{% highlight make %}
myprogram.out : compute.f90 cte.f90 main.f90
    gfortran compute.f90 cte.f90 main.f90 -o myprogram.out
{% endhighlight%}

Usually this information is stored in a file named: **Makefile** which contains all the rules. And we can compile
just writting `make`. Let's say that we want to compare results with several different *contants.f90* files

{% highlight make %}
myprogram1.out : compute.f90 cte1.f90 main.f90
    gfortran compute.f90 cte1.f90 main.f90 -o myprogram.out
    
myprogram2.out : compute.f90 cte2.f90 main.f90
    gfortran compute.f90 cte2.f90 main.f90 -o myprogram.out
{% endhighlight%}

We can invoke each rule by,
{% highlight bash %}
make myprogram1.out
{% endhighlight%}
or
{% highlight bash %}
make myprogram2.out
{% endhighlight%}

It is quite common include a clean rule as,

{% highlight make %}
clean : 
    rm -f myprogram*.out

myprogram1.out : compute.f90 cte1.f90 main.f90
    gfortran compute.f90 cte1.f90 main.f90 -o myprogram.out
    
myprogram2.out : compute.f90 cte2.f90 main.f90
    gfortran compute.f90 cte2.f90 main.f90 -o myprogram.out
{% endhighlight%}

This clean rule has no dependencies, however if **make** finds a file or directory named **clean** then nothing is done. For this
reason we include:

{% highlight make %}
.PHONY : clean
clean : 
    rm -f myprogram*.out
{% endhighlight%}

Let's say that our fortran code process some datafiles stores in a subdirectory **data** but this datafiles
have to be downloaded from a server with the more recent information, we can include a rule for that.

{% highlight make %}
.PHONY : download
download : 
    wget -O dataset.tar.gz http://mydataserver.com/nowcasting.tar.gz
prepare : dataset.tar.gz
    mv dataset.tar.gz data/
create : data/dataset.tar.gz
    tar -zxf data/dataset.tar.gz
{% endhighlight%}

With this kind of rules you have to,

{% highlight bash %}
> make download
> make prepare
> make create
{% endhighlight%}

After that you will have the file **nowcasting.tar.gz** decompresed on your directory and stored also in **data/**
as **dataset.tar.gz**. However is we don't have yet downloaded the file or prepare it for extracting then 
make doesn't know how to proceed. Basically **make** doesn't know how to build the dependency **data/dataset.tar.gz. But we can try as,

{% highlight make %}
.PHONY : download
download : 
    wget -O dataset.tar.gz http://mydataserver.com/nowcasting.tar.gz
prepare : download
    mv dataset.tar.gz data/
create : prepare
    tar -zxf data/dataset.tar.gz
{% endhighlight%}

And the commad **make create** will do all the previous rules to achieve the rule create. Note that if you type in **bash** shell **make** and tab you will see all the possible rules avaliables on the **Makefile** of your current directory, something very useful.



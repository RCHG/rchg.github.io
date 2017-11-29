---
layout: page
sidebar: right
subheadline: Tips
title:  "UNIX commands"
teaser: "Terminal Linux-Unix Tools: pr, cut, grep..."
breadcrumb: true
tags:
    - [Scientific-computing, Linux]
categories:
    - computing-blog
header:
    title: Unix Tools
    pattern: pattern_jquery-dark-grey-tile.png
---

<div class="panel radius" markdown="1">
#### Table of Contents
{:.no_toc }
*  TOC
{:toc}
</div>


> This post just collects a list of shorts tips related with UNIX terminal tools. To extract information of a file, to find specific archives, etc ...

### awk and pr

**AWK** (or **gawk**) is a quite powerful line command, here I will just comment an example of how to combine it with **pr**. The **pr** command is useful to, for example, create a file with two columns from two previous one column files (or more complex operations).

The next example is based on a very simple file **test-file.dat**

{% highlight bash %}
a  1   house   hause
b  2     day   tag
h  7   cinema  kino
u  23  chess   schach
{% endhighlight %}

You can simply try!

{% highlight bash %}
cp test-file.dat del_later
gawk '{print $1 }' del_later > COL1; more COL1
gawk '{print $2 }' del_later > COL2; more COL2
gawk '{print $3 }' del_later > COL3; more COL3
gawk '{print $2, $NF }' del_later > COL2_last; more COL2_last
gawk '{print $3, $NF }' del_later > COL3_last; more COL3_last
pr -m -t -s\ COL2_last COL3_last
{% endhighlight %}

### cut

**cut** may be used to select an specific column number

{% highlight bash %}
cut -f 
cut -c 129 file.txt > new_file.txt
{% endhighlight %}


<small markdown="1">[Up to table of contents](#toc)</small>
{: .text-right }



</div><!-- /.medium-8.columns -->
</div><!-- /.row -->


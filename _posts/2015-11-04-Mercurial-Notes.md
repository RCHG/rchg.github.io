---
layout: page
sidebar: right
subheadline: Notebook
title: "Descentralized Version Control Notes"
teaser: "Version Control Notes: Hg"
breadcrumb: true
tags: [VCS, Scientific-computing, Hg, Mercurial]
categories:
    - computing-blog
header:
    title: R. Checa-Garcia webpage | Mercurial
    pattern: pattern_jquery-dark-grey-tile.png
---

<div class="panel radius" markdown="1">
#### Table of Contents
{:.no_toc }
*  TOC
{:toc}
</div>


### Introduction to Mercurial

Here I will introduce a very basic use of Mercurial version control system (named Hg). Let's say that we are working on a document in LaTeX (a PhD dissertation, and article/paper, a report etc). First it is based on a local directory but we want to be able to track all the changes on the text (the evolution of the document). I recommend a this point to read the previous post about version control where is explained the basic terminology. So we are going to create a **repository** of Hg.

{% highlight bash %}
> mkdir /home/mrmagguu/my_document
> cd /home/mrmagguu/my_document
> hg

Mercurial Distributed SCM

basic commands:

 add           add the specified files on the next commit
 annotate      show changeset information by line for each file
 clone         make a copy of an existing repository
 commit        commit the specified files or all outstanding changes
 diff          diff repository (or selected files)
 export        dump the header and diffs for one or more changesets
 forget        forget the specified files on the next commit
 hgview
 init          create a new repository in the given directory
 log           show revision history of entire repository or files
 merge         merge another revision into working directory
 pull          pull changes from the specified source
 push          push changes to the specified destination
 qct           start qct commit tool
 remove        remove the specified files on the next commit
 serve         start stand-alone webserver
 status        show changed files in the working directory
 summary       summarize working directory state
 update        update working directory (or switch revisions)

(use "hg help" for the full list of commands or "hg -v" for details)
{% endhighlight%}

Just typing Hg we have the main commands of our hg version. In my case,
{% highlight bash %}
> hg version
Mercurial Distributed SCM (version 3.5.2)
(see http://mercurial.selenic.com for more information)

Copyright (C) 2005-2015 Matt Mackall and others
This is free software; see the source for copying conditions. There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
{% endhighlight%}

Now to create a repository in our directory we just write:

{% highlight bash %}
> hg init
{% endhighlight%}

With `ls -a` command we can certificate that there is a new directory named **.hg** that is hidden to the usual ls. Right now we have no included anything in the repository. We can do with:

{% highlight bash %}
> hg add
adding FIGURES/FIG1.jpg
adding my_draft.tex
adding natbib.sty
{% endhighlight%}

In my case the directory had two files and one folder with a figure. However we did not yet validated this changes. We can validate or **commit**

{% highlight bash %}
> hg commit -m 'Version 0.1 (initial)'
{% endhighlight%}

To see what happened:
{% highlight bash %}
> hg log
changeset:   0:187c32c11d5b
tag:         tip
user:        Mr. Magguu <mr_magguu@magguu.com>
date:        Wed Nov 04 17:36:56 2015 +0100
summary:     Version 0.1 (initial)
{% endhighlight%}

Now I forgot to include a file with the bibliography. We copy a new file: **biblio.bib** in the directory and:
{% highlight bash %}
> hg summary
parent: 0:187c32c11d5b tip
 Version 0.1 (initial)
branch: default
commit: 1 unknown (clean)
update: (current)
phases: 1 draft
{% endhighlight%}

We forgot to add the new file:

{% highlight bash %}
> hg add biblio.bib
> hg summary
parent: 0:187c32c11d5b tip
 Version 0.1 (initial)
branch: default
commit: 1 added
update: (current)
phases: 1 draft
{% endhighlight%}

Ok, and

{% highlight bash %}
> hg status
A    biblio.bib
{% endhighlight%}

Exactly like in SVN. The command hg is notificating the we have add a new file (but have not commit the addition).
{% highlight bash %}

> hg commit -m 'Version 0.1 with Biblio'
> hg status
> hg log
changeset:   1:891564a37700
tag:         tip
user:        Mr. Magguu <mr_magguu@magguu.com>
date:        Wed Nov 04 17:47:58 2015 +0100
summary:     Version 0.1 with Biblio

changeset:   0:187c32c11d5b
user:        Mr. Magguu <mr_magguu@magguu.com>
date:        Wed Nov 04 17:36:56 2015 +0100
summary:    Version 0.1 (initial)
{% endhighlight%}

We see the now how useful is mercurial to track all the changes!! Let's say that our editor saves automatically files with the symbol **~** at the end but we do not want to keep track of these files. An easy way to handle with this is by creating a simple file called **.hgignore** with the following text inside:

{% highlight bash %}
syntax: glob
*~
{% endhighlight%}

### Mercurial: next steps

If you tried the above tiny shown tutorial then probably you will be confortable with Hg. But probably also you will have a lot of questions about Hg. For instance, the username, the email, what means the code: changeset:   1:891564a37700 or other things.

Let's go step by step. At the beginning we commented that we have a working installation of Hg. We can try to verify this with:

{% highlight bash %}
> hg debuginstall
checking encoding (UTF-8)...
checking Python executable (/usr/bin/python)
checking Python version (2.7.10)
checking Python lib (/usr/lib/python2.7)...
checking installed modules (/usr/lib/python2.7/dist-packages/mercurial)...
checking templates (/usr/share/mercurial/templates)...
checking commit editor...
checking username...
no problems detected
{% endhighlight%}

This command gives us information about the installation. In my case everthing seems correct. You have detected about Python, this is because all the extensions in Mercurial are written in Python. If you type the command `hg config` you will have more information. The usual configuration file for a given user is found in **/home/user/.hgrc**. And looks like:

{% highlight bash %}
> more /home/mrmagguu/.hgrc
# Mercurial Configuration Info
[ui]
username = Mr. Magguu <mr_magguu@magguu.com>

[extensions]
graphlog = 
hgcia = 
hgk = 
hgview = 
color = 
{% endhighlight%}

Here is the very basic configuration for the user *mrmaggugg*. The activated extensions are indicated here just with the name follow by = .Therefore the information about the user is taken from this configuration file. You can edit manually but before you should check `hg help config`, but because the information given is very large you can try something like `hg help config | grep user` just to have the information with the word user of the documentation. And just to give another examples of this configuration files it has **graphlog**, **color** or **hgview**. The first introduce the command `hg glog` that is a kind of `hg log` command but with additional information about branches, master version etc. **color** just add color to the outputs shown on your terminal when you use any hg command. Concerning **hgview** you will have `hgview` command you will have a graphical frontend for Hg.

#### Text Editors and Hg

  - In case you are using **VIM**, which is one of the main tools I use every day, I may recommend the plugin  [lawrencium](http://bolt80.com/lawrencium/)   
  - **Geany** is another nice tool that might integrate a version control inside with a plugin and **gedit** has this posibility also with rabbitVCS. This utility is not specific of mercurial and you might use several control version software. Note that git has specific plugins.

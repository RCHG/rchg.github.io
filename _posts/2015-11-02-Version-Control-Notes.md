---
layout: page
sidebar: right
subheadline: Notebook
title: "Centralized Version Control"
teaser: "Version Control Notes: SVN"
breadcrumb: true
tags: [VCS, scientific-computing, SVN]
categories:
    - computing-blog
header:
    title: R. Checa-Garcia webpage |  SVN
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


### What is? 

It is a software to:

  - Provide incremental versions (or revisions) of a set of files/directories.
  - Explore the changes which resulted in each of those versions.
  - Return to any of the previous versions/revisions.

Therefore it is a kind of backup system but also is a kind of file server.

### How it works?

It is build over the concept of **repository** that is a kind of register of all the changes of a set of files. Usually the information
is stored as a hierarchy of files (like a tree file-system). Now this repository allows connections of several clients. They can read and write so the version
control system should be able to track who, and when,  make changes on the files, and give to other users the possibility to read those
changes.

### Who needs that?

All people who is working with computers and making progressive changes over files in a project. However the main advantage of the 
version control system is when several clients are working on improve/change the same project. 

When several users are working with the same set of files at the same time, the version control software should be able to allow changes
but without deleting or incorrectly mixing the changes of the users. For this there are several solutions that depend on how is designed the
version control. In those cases where we have a central repository we can allow only one person to change at one time the same file, the other
possibility is that all users create a personal copy of the central repository and commit changes. This last process is build over the
concept of merge code. This is something that many users are doing (in a not so clean way) when they make several copies of a code to test several changes but they
want to preserve the original copy. Version control gives them a more clean a beautiful method to perform all this tasks even if the are just
one single user of a given project.

### How it works?

The method might depends on the specific version control software. In the case of SVN (subversion) there is a central repository and several working copies. Every time
that a user commits changes on the code (using a SVN client) the SVN server creates a new state of the file-system tree (that is, the repository) named **revision**. Each revision has assigned one unique number (natural number). Note that in SVN each identify number refers to a full state of the file-system (not to a specific commit of a specific file). It is like
a instantaneous-photo of the full set of files. In this situation every working copy is private and only the process of commit the changes make them public (open to other users). This is the so named Central Version Control System (CVCS). Other version control systems are based on distributed or decentralized systems, examples are git and mercurial. 



 ![Typical CVCS-Source Univ. Washington. ](https://homes.cs.washington.edu/~mernst/advice/version-control-fig2.png "Typical CVCS-Source Univ. Washington. ")



### Terminology

  - **Repository**   It was already explained. In the case of for example Mercurial it is a directory in which a kind of set files are stored: the repository has the files of the project together with the history of changes of the files. 
  - **Trunk**        The trunk is the directory where all the main development is stored. The idea is that this directory may be evaluated by the developers. Usually it is the last main version under development.
  - **Tags**         The tags directory is used to store named snapshots or revisions. Because the unique numbers assigned to each revision are not descriptive of the key points of the snapshot the Tag operation allows to provide descriptive name to specific version in the repository
  - **Branches**     Branch operation is used to create another line of development. This is a very important concept when you want your development process to fork off into two different directions.
  - **Working copy** Working copy is a snapshot of the repository. The repository is shared by all the users, but people do not modify it directly. Instead each developer checks out the working copy. The working copy is a private and isolated from the rest of the project users.
  - **Commit**      Commit is the process of confirming and storing changes from working copy to central server (repository). After commit, changes are public and other users can retrieve these changes by **updating their working copy**. Commit is an atomic operation. Either the whole commit succeeds or is rolled back. Users never see half finished commit.

##  SVN: subversion

It is one of the most used version control systems. Currently it is a project of the Apache Software Foundation htts://subversion.apache.org/

In those cases where a distribuited version control is not needed then SVN is a robust version control software in particular the last versions.

### An example with svn

It is very easy to use svn (subversion) from the terminal. If you have correctly installed svn in a Linux/Unix machine you can follow this example:

First, lets imagine that you wanted to download the last version of a nice open-source code. In my case, I wanted to download and compile from the source a chess-program called scidvspc. I checked that it is a sourceforge project and then it is very easy to obtain a **working copy** from the official **repository**.

{% highlight bash %}
> mkdir /home/mrmagguu/test_svn
> cd /home/mrmagguu/test_svn
> svn checkout svn://svn.code.sf.net/p/scidvspc/code/ scidvspc-code
{% endhighlight%}

Now in your directory *test_svn* you have a new sub-directory named: *scidvspc-code* that **replicates the online repository** stored at sourceforge.net server. Let's try something:

{% highlight bash %}
> svn status 
svn: warning: W155007: '/home/mrmagguu/test_svn' is not a working copy
> pwd
/home/mrmagguu/test_svn
> cd scidvspc-code 
> svn status
{% endhighlight%}

Probably nothing is now returned, this is because simply there is nothing new to report, but as we have seen if we use the command svn in a directory that is not the working copy of a repository svn will complain. Now let's change a file. For instance in README.txt I have changed some lowercase letters to uppercase.

{% highlight bash %}
> vim README.txt
> svn status
M       README.txt
{% endhighlight%}

And, yes!, it detected that we have changed README.txt. But this change is only effective in our private working copy. Nowbody knows that some lowercase letters were changed to uppercase letters. Let's try:

{% highlight bash %}
> svn diff

Index: README.txt
===================================================================
--- README.txt	(revision 2372)
+++ README.txt	(working copy)
@@ -6,19 +6,19 @@
   Table of Contents
 
 
-  1. introduction
-  2. features
+  1. Introduction
+  2. Features
         2..1 New and Improved features
         2..2 Missing Features
 
-  3. download
-  4. installation
+  3. Download
+  4. Installation
         4..1 Linux , FreeBSD
         4..2 Windows
         4..3 Mac OS X
 
-  5. news
-  6. miscellaneous
+  5. News
+  6. Miscellaneous
      6.1 docked windows
      6.2 how to play
      6.3 todo
@@ -27,7 +27,7 @@
      6.6 thanks
      6.7 scid's history
 
-  7. changes
+  7. Changes
         7..1 Scid vs. PC 4.14
         7..2 Scid vs. PC 4.13
         7..3 Scid vs. PC 4.12
@@ -48,8 +48,8 @@
         7..18 Scid vs. PC 4.0
         7..19 Scid vs. PC 3.6.26.1
 
-  8. contact
-  9. links
+  8. Contact
+  9. Links

{% endhighlight%}

Now we begin to see the advantages of version control, we can see exactly the changes with just one command. Let's say now that we have created also new file. For instance I have created a file called: THANKS.txt with the text 'Thank you for create this nice software.'

{% highlight bash %}
> vim THANKS.txt
> svn status
M       README.txt
?       THANKS.txt
{% endhighlight%}

SVN indicate us that there is a new file in the **working copy** but its status is unclear. SVN knows that this file is not in the main central repository but don't know if we want to add it or not.

{% highlight bash %}
> svn add THANKS.txt
A       THANKS.txt
> svn status
M       README.txt
A       THANKS.txt
{% endhighlight%}

So we have **A**dded a file to the project and we have **M**odificated another file. If we would think that these changes are convinient we could commit the changes with `svn commit -m 'Added a file to say thank you'`. Then we will see something like...

{% highlight bash %}
> svn commit -m 'Added a file to say thank you and few lowercase letters...'
Sending        README.txt
Adding         THANKS.txt
Transmitting file data ..
Committed revision XYZ
{% endhighlight%}

The -m command indicates the message that we want to include as information of the new revision, while XYZ is the **revision number** (that, remember is a unique number describing a full status of the project). Usually our commits will be validated (or not) by a developer holding the project if they are useful (or useless). On the other side, as users, we can try to update our working code to the last revision, but first we can check the status of our version. In this case I will suppose that we have commit our changes to the server and now *other user* would like to have this revision:

{% highlight bash %}
> svn status -u
   + XYZ       README.txt
   +           THANKS.txt
   + (XYZ-1) .
{% endhighlight%}

The + means changed in the repository while XYZ and (XYZ-1) are the revision numbers of the last change and the previous one. If the new user think that these changes should be incorporated to her/his working copy then...

{% highlight bash %}
> svn update
U   README.txt
A   THANKS.txt
{% endhighlight%}

... and her her **working copy** is update with our changes.

### Typical working cycle with SVN

1. Update your working copy -> `svn update`
2. Changes in the code -> `svn add`, `svn delete` etc...
3. Check the status/details of our changes -> `svn status`, `svn diff`
4. (This step was not commented before). Restore to an unmodified state -> `svn revert`. 
5. Imagine that we have changes to uppercase some letters but other user replace some letters with numbers in the same. Usually the users realize of possible conflicts when the use svn update, then svn gives them a note indicating that two or more users have changed parts of the same files. To resolve the problem we have the tool -> `svn resolve` 
6. Submitt changes -> `svn commit`


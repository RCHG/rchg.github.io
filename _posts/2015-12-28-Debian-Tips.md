---
layout: page
sidebar: right
subheadline: Tips
title: "Debian Tips"
excerpt: "Debian tricks, repairs, improvements..."
teaser: "Here are indicated a long list of tips to solve typical debian/linux problems"
breadcrumb: true
tags: [Linux, Debian]
categories:
    - computing-blog
header:
    title: R. Checa-Garcia webpage |  Debian Tricks
    pattern: pattern_jquery-dark-grey-tile.png
---


My own daily use computer is a Lenovo Thinkpad T440s and I have installed only a Debian Linux distribution, in particular the *testing version*, this means that usually I have to solve by myself tipical problems that the stable distribution doesn't have. Here I am including a list of those problems that I was able to solve, maybe alone maybe with the help of several forums in internet.

<section id="table-of-contents" class="toc">
<div class="panel radius" markdown="1">
#### Table of Contents
{:.no_toc }
*  TOC
{:toc}
</div>
</section><!-- /#table-of-contents -->


### December 2015 IWLWIFI ISSUES

In Dec-2015 there were an update of the non-free package that control the intel wifi card ensembled on the Lenovo T440s, however the update broked my internet wifi conection. Here you have several steps to solve the problem:

#### Diagnosis

A first step is try to see what is happening:

{% highlight bash %}
dmesg | grep wifi
{% endhighlight %}

When this command is used we detect that Debian is trying to find a file named: **iwlwifi-7260-7.ucode** and looking on the webpage of debian concerning T440s we realize that the Network Controller,
{% highlight bash %}
Network controller [0280]: Intel Corporation Wireless 7260 [8086:08b2] (rev 83)
{% endhighlight %}

In my case the documentation about T440s is not including this information but T440p that is basically the same laptop covers all the steps for Debian installation [Debian-T440p](https://wiki.debian.org/InstallingDebianOn/Thinkpad/T440p/jessie#WiFi). Another source of information is [ThinkWiki](http://www.thinkwiki.org/wiki/ThinkWiki).

#### Checking Diagnosis

Our first guess is a problem with **iwlwifi**, so simply we check the files installed by this debian package. You can find this information on the link: [FileList-iwlwifi](https://packages.debian.org/stretch/all/firmware-iwlwifi/filelist). We can realize that the **iwlwifi-7260-7.ucode** is not in the list of files installed. We can double check this with 

{% highlight bash %}
ls /lib/firmware/*ucode
{% endhighlight %}

#### Solving the problem

Now we can check the stable equivalent package at [Stable-version-iwlwifi](https://packages.debian.org/jessie/firmware-iwlwifi) and confirm that **iwlwifi-7260-7.ucode** is there. Therefore simply download here the files on this package [firmware-nonfree_0.43.tar.gz](http://http.debian.net/debian/pool/non-free/f/firmware-nonfree/firmware-nonfree_0.43.tar.gz). Wa can extract the file named **iwlwifi-7260-7.ucode-22.1.7.0** and copy at /lib/firmware with the name **iwlwifi-7260-7.ucode**. You can simply reboot the machine and the wifi is alive again.

<small markdown="1">[Up to table of contents](#toc)</small>
{: .text-right }



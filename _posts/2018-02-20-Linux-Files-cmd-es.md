---
layout: page
sidebar: right
subheadline: Tips
title:  "Comandos Linux: discos y particiones"
teaser: ""
breadcrumb: true
tags:
    - [scientific-computing, linux]
categories:
    - computing-blog
header:
    title: Comandos Linux: discos y particiones
    pattern: pattern_jquery-dark-grey-tile.png
---

<div class="panel radius" markdown="1">
#### Table of Contents
{:.no_toc }
*  TOC
{:toc}
</div>

{% highlight bash %}
> fdisk -l

Disk /dev/sdd: 1.8 TiB, 2000398934016 bytes, 3907029168 sectors
Disk model: ST2000DX002-2DV1
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: gpt
Disk identifier: 6F8FFC86-FDC6-4121-87A6-20C68EC63B61

Device          Start        End    Sectors   Size Type
/dev/sdd1          40  524288000  524287961   250G Linux filesystem
/dev/sdd2   524288008 1048576007  524288000   250G Linux filesystem
/dev/sdd3  1048576008 2097152007 1048576000   500G Linux filesystem
/dev/sdd4  2097154048 2098202623    1048576   512M EFI System
/dev/sdd5  2098202624 3840083967 1741881344 830.6G Linux filesystem
/dev/sdd6  3840083968 3907028991   66945024  31.9G Linux swap


Disk /dev/sde: 7.5 GiB, 8000110592 bytes, 15625216 sectors
Disk model: Cruzer          
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x5a1a6a57

Device     Boot Start     End Sectors  Size Id Type
/dev/sde1  *        0 7733247 7733248  3.7G  0 Empty
/dev/sde2       23196   29051    5856  2.9M ef EFI (FAT-12/16/32)
{% endhighlight %}


{% highlight bash %}
> umount /dev/sde1
> dd bs=4M if=firmware-testing-amd64-DVD-1.iso of=/dev/sde
{% endhighlight %}






<small markdown="1">[Up to table of contents](#toc)</small>
{: .text-right }



</div><!-- /.medium-8.columns -->
</div><!-- /.row -->


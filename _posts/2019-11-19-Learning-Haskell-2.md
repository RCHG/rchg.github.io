---
layout: page
sidebar: right
subheadline: Tips
title: "Learning Haskell"
excerpt: "Step by Step "
teaser: "collection of notes and links"
breadcrumb: true
tags: [haskell, programming]
categories:
    - computing-blog
header:
    title: Learning Haskell
    pattern: pattern_jquery-dark-grey-tile.png
---

Random Notes about Haskell II
-----------------------------

{% highlight haskell %}
--
-- Copy a file in Haskell
--
import System.Directory(copyFile)

main :: IO ()
main = do 
    putStr "Enter the filename:" 
    name <- getLine 
    putStr "Enter the copy name:" 
    c_name <- getLine
    copyFile name c_name
    
{% endhighlight %}

{% highlight haskell %}
--
-- Copy a file in Haskell by read it and write it again
--

import System.Environment

main = do
      [f,g] <- getArgs
      s     <- readFile f
      writeFile g s

{% endhighlight %}


{% highlight haskell %}
--
-- Count file lenght string in Haskell
--
-- We use interact
-- interact    ::  (String -> String) -> IO ()
-- interact f = do s <- getContents
--                putStr (f s)

main    = interact count
count s = show (length s) ++ "\n"
{% endhighlight %}

{% highlight haskell %}
--
-- Count lines in file in Haskell
--
-- We use interact and lines functions
--

main = interact (count . lines)
{% endhighlight %}


## Useful packages in Haskell


- [Parse Config-Files](https://hackage.haskell.org/package/ConfigFile-1.1.4/docs/Data-ConfigFile.html)
- [Manage directories](https://hackage.haskell.org/package/directory-1.3.6.0/docs/System-Directory.html)
- [Manage paths](https://github.com/hasufell/hpath)
- [Kind of glob](https://hackage.haskell.org/package/filepattern)


<small markdown="1">[Up to table of contents](#toc)</small>
{: .text-right }


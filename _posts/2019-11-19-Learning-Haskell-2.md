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
-- Count file lines in Haskell
--
-- We use interact
-- interact    ::  (String -> String) -> IO ()
-- interact f = do s <- getContents
--                putStr (f s)

main    = interact count
count s = show (length s) ++ "\n"
    
{% endhighlight %}


<small markdown="1">[Up to table of contents](#toc)</small>
{: .text-right }


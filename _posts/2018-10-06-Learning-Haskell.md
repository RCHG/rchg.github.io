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



# Intro 

Haskell is a functional programming language. Its roots is the lambda calculus which is a mathematical-computational theory to build 
algorithms different from the traditional *Turing Machine concept*. In this context, the *functions* in a programming language are
closer to what a function is in mathematics, and in Haskell functions are *first-class elements*. Haskell is considered a *pure* functional
programing language, going further than what you might found in other language where there are *elements* from functional programming
paradigma.

The word purity in functional programming is sometimes also
used to mean what is more properly called referential transparency.
Referential transparency means that the same function, given the
same values to evaluate, will always return the same result in pure
functional programming, as they do in math. (From the introduction of the book **Haskell Programming from First Principles**)
{:.smallblock}



Random Notes about Haskell
---------------------------

**Types and Clases** 

- The first task is to understand **types** in Haskell, so it is needed to understand the concept of type and classes that 
might be different from others languages (more formal).

*type* in Haskell is a collection of values. It seems that everthing is haskell has a type, so for example, a function that
two int numbers has type, (Int, Int) -> Int . 

*class* is a collection of type that supports a common set of methods. For example, Int and Float both supports a method that
evaluate if two Ints (or two Floats) are equal. This is the Eq. Class. 

**Arrays**

Second task is to understand the specific type of array (and more advanced definitions like Repa)

- [Arrays](https://wiki.haskell.org/Arrays)
- [Vectors](https://wiki.haskell.org/Numeric_Haskell:_A_Vector_Tutorial)
- [Repa](https://wiki.haskell.org/Numeric_Haskell:_A_Repa_Tutorial)
- [General](https://guide.aelve.com/haskell/arrays-bpid18sd)

First there are many kind of arrays, in a quite complex forest of options. It seems that the kind of array *Unboxed* is the one
similar to C and more suited for numerical operations that require speed. *StorableArray* allows to interchange with C, which also is Unboxed.

It is important to think about what its an array: it is something that associate index to values. In basic arrays index has
type Int (to undestand it [Ix Class](http://hackage.haskell.org/package/base-4.11.1.0/docs/Data-Ix.html) but I think that it something complex also). The manual says for example that:

*the bounds of a 10-element, zero-origin vector with Int indices would be (0,9), 
while a 100 by 100 1-origin matrix might have the bounds ((1,1),(100,100)), In many other languages, such bounds would be
written in a form like 1:100, 1:100, but the present form fits the type system better, since each bound is of the same 
type as a general index.*
{:.smallblock}

Finally, it seems that internally the ((1,1),(100,100)) are stored in a list of index [(1,1),...,(100,100)]. So internally, the array index 1 corresponds to (1,1), the index 2 corresponds to (1,2) etc..., there is a function named range that helps with it:

{% highlight haskell %}
range ((0,0),(1,2)) => [(0,0), (0,1), (0,2), (1,0), (1,1), (1,2)] 
{% endhighlight %}

The definition of an array has type:

{% highlight haskell %}
array  :: (Ix a) => (a,a) -> [(a,b)] -> Array a b
{% endhighlight %}

like,

{% highlight haskell %}
squares =  array (1,100) [(i, i*i) | i <- [1..100]]
squares!7 => 49
bounds squares => (1,100)
{% endhighlight %}

A small piece of code [similar to](https://lotz84.github.io/haskellbyexample/ex/arrays),

{% highlight haskell %}
import Data.Array

main = do
    -- now we define an array a
    let a = array (0, 4) [(i, 0) | i <- [0..4]]
    -- and a is array (0,4) [(0,0),(1,0),(2,0),(3,0),(4,0)] 
    -- for example with:
    putStrLn $ show a
    -- now this is problematic...
    let b = array (0, 4) [(i, 0) | i <- [0..2]]
    -- but Haskell is lazy, so only when we use b then we see a problem
    -- with show b the output is
    -- "array (0,4) [(0,0),(1,1),(2,2),(3,*** Exception: (Array.!): undefined array element"
    -- the construction array (0, 4) [(i, 0) | i <- [0..4]]
    -- basically define the index from 0 to 4 (5 elements) and the second part is the one that
    -- assign for each index i a value, in this case the constant zero.
    let c = array (0, 4) [(i, i+1) | i <- [0..4]]
    -- then show c!1 is 2, c!0 is 1 and c!4 is 5
    let matrix = array ((0,0), (1, 2)) [((i, j), i + j) | i <- [0..1], j <- [0..2]]
    -- defines a matrix with structure:
    -- array ((0,0),(1,2)) [((0,0),0),((0,1),1),((0,2),2),((1,0),1),((1,1),2),((1,2),3)]
{% endhighlight %}

## Examples

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


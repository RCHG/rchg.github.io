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

Random Notes about Haskel
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

First there are many kind of arrays, in a quite complex forest of options. It seems that the kind of array *Unboxed* is the one
similar to C and more suited for numerical operations that require speed. *StorableArray* allows to interchange with C, which also is Unboxed.

It is important to think about what its an array: it is something that associate index to values. In basic arrays index has
type Int (to undestand it [Ix Class](http://hackage.haskell.org/package/base-4.11.1.0/docs/Data-Ix.html) but I think that it 
something complex also). The manual says for example that:

*the bounds of a 10-element, zero-origin vector with Int indices would be (0,9), 
while a 100 by 100 1-origin matrix might have the bounds ((1,1),(100,100)), In many other languages, such bounds would be
written in a form like 1:100, 1:100, but the present form fits the type system better, since each bound is of the same 
type as a general index.*
{:.smallblock}

Finally, it seems that internally the ((1,1),(100,100)) are stored in a list of index [(1,1),...,(100,100)]. So internally, the
array index 1 corresponds to (1,1), the index 2 corresponds to (1,2) etc..., there is a function named range that helps with it:

```
range ((0,0),(1,2)) => [(0,0), (0,1), (0,2), (1,0), (1,1), (1,2)] 
```
The definition of an array has type:
```
array  :: (Ix a) => (a,a) -> [(a,b)] -> Array a b
```
like,
```
squares =  array (1,100) [(i, i*i) | i <- [1..100]]
squares!7 => 49
bounds squares => (1,100)
```


<small markdown="1">[Up to table of contents](#toc)</small>
{: .text-right }


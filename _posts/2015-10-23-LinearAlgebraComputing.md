---
layout: page
sidebar: right
subheadline: Notebook
title: "Linear Algebra and Computing"
teaser:  "Scientific Computing and Linear Algebra"
breadcrumb: true
tags: [Math, Programming]
categories:
    - computing-blog
header:
    title: R. Checa-Garcia webpage |  Linear Algebra
    pattern: pattern_jquery-dark-grey-tile.png
author: ramiro_chg
---

<section id="table-of-contents" class="toc">
  <header>
    <h3>Table of Contents</h3>
  </header>
<div id="drawer" markdown="1">
*  Auto generated table of contents
{:toc}
</div>
</section><!-- /#table-of-contents -->


### Introduction

This post just remember several linear algebra properties that are relevant for scientific programming. 

### Reducible Matrix

**Definition:** An square matrix A is reducible if there is a matrix P (basis change) such that,

$$
PAP^{T}=\begin{bmatrix}
  B_{11} & B_{11}\\
  0  & B_{22}
\end{bmatrix}
$$

This property is very useful because the typical linear system solution $$Ay=c$$ is now more easy to resolve in terms of computing because

$$
\begin{bmatrix}
  B_{11} & B_{11}\\
  0  & B_{22}
\end{bmatrix}\begin{bmatrix}
  y_{1} \\
  y_{2}
\end{bmatrix}=\begin{bmatrix}
  c_{1}\\
  c_{2}
\end{bmatrix}
$$

The subsystem $$B_{22}y_{2}=c_{2}$$ is indepentent of the other B matrices with the logical computational improvement.

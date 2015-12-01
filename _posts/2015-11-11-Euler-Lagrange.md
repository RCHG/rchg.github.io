---
layout: page
sidebar: right
subheadline: Notebook
title:  "Euler-Lagrange Equation"
teaser: "Introduction to Variational Calculus"
breadcrumb: true
tags: [Radiative-Theory, Atmospheric-Physics]
categories:
    - science-blog
header:
    title: R. Checa-Garcia webpage | Euler-Lagrange Equation
    pattern: pattern_jquery-dark-grey-tile.png
---

> Post under construction

[^1]: Hansen, J.E., and L.D. Travis, 1974: Light scattering in planetary atmospheres. Space Sci. Rev., 16, 527-610, doi:10.1007/BF00168069.

**Previous**: The Euler-Lagrance Equations are well known from Analitic Mechanics and Minimum Action Principle, a very elegant alternative to Newton formulation of Mechanics. Here is exposed just as a mathematical tool within Calculus of Variations branch of Mathematical Analysis.
{:.smallblock}

### An important preliminar result


Given to real numbers a and b with $$a<b \in R$$ and a continous function $$g(x): [a,b]\rightarrow \mathbb{R}$$. If,

$$\int_{a}^{b}\eta(x)g(x)dx=0 \qquad \forall \eta(x)\in \mathcal{C}^{2} \,, with\,, \eta(a)=\eta(b)=0 $$

then,

$$g(x)=0 \qquad \forall x\in [a,b] $$


This lemma is what is needed to demostrate that the Euler-Lagrange Equations are the solution to this other problem:


## Theorem of Euler-Lagrange


Given a function $$f:[a,b]\rightarrow\mathbb{R}$$ twice differentiable, so $$f(x)\in \mathcal{C}^{2}$$, with prescribed boundary values $$f(a)=f_{a}$$ and  $$f(b)=f_{b}$$ and a continous function $$g(x): [a,b]\rightarrow \mathbb{R}$$. We define an integral as,

$$I[x,f] = \int_{a}^{b}g(x,f,f')dx $$

Then, if $$I[x,f]$$ have a minimum value for the function $$f$$, then the function $$f$$ satisfaces the following differential equation,

$$\frac{\partial g}{\partial f} - \frac{d}{dx}\left( \frac{\partial g}{\partial f'} \right)=0 $$


From a partical point of view the derivatives of the $$g$$ function with respect to $$f$$ and $$f'$$ are done with the usual derivation rules.
{:.notice}



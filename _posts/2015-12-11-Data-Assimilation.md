---
layout: page
sidebar: right
subheadline: Notebook
title:  "Data Assimlation Notebook"
teaser: "Introduction to Data Assimilation in NWPM"
breadcrumb: true
tags:
    - [Data Assimilation, NWPM]
categories:
    - science-blog
header:
    title: R. Checa-Garcia webpage | Data Assimilation
    pattern: pattern_jquery-dark-grey-tile.png
---

<section id="table-of-contents" class="toc">
<div class="panel radius" markdown="1">
#### Table of Contents
{:.no_toc }
*  TOC
{:toc}
</div>
</section><!-- /#table-of-contents -->

[^1]: Daley, R., Atmospheric Data Analysis, Cambridge University Press, pp. 457, 1991.
[^2]: Albert Tarantola, Inverse Problem Theory and Model Parameter Estimation. SIAM, 2005.
[^3]: Kalnay, E., Atmospheric Modeling, Data Assimilation and Predictability, Cambridge University Press, pp. 341,2003, Chap.
[^4]: Thiebaux, H.J. and Pedder, M.A. Spatial Objective Analysis with applications in atmospheric science, Academic Press1987.
[^5]: Saroja Polavarapu, Introduction to Data Assimilation (Presentation). GCC Summer School, Banff. May 22-28, 2004

### Data Assimilation?

> The ambitious and elusive goal of data
assimilation is to provide a dynamically
consistent motion picture of the
atmosphere and oceans, in three space
dimensions, with known error bars.
M. Ghil and P. Malanotte-Rizzoli (1991)

Data Assimilation goal in Atmospheric Sciences:
> "is to produce a regular,
physically consistent
four dimensional
representation of the
state of the atmosphere from a heterogeneous
array of in situ and
remote instruments which sample
imperfectly and
irregularly in space and
time.  (H. Elbern, ESA Workshop)

Methodology to achieve that:

> Data assimilation "extracts the signal from
noisy observations
(filtering), interpolates in space
and time (interpolation)
and finally reconstructs state
variables that are not
sampled by the
observation network
(completion).“ (Daley,
1991)[^1]

and also
> To produce a regular, physically consistent,
four-dimensional representation of the state of
the atmosphere from a heterogeneous array of
in-situ and remote instruments which sample
imperfectly and irregularly in space and time.
(Daley, 1991)[^1]


In weather forecasting we would like to combine information from observations (past and new) with  the state predicted by model. The ideal situation includes: model errors (discretization, incomplete description, etc...) and observation errors (calibration, sparse etc..)

### Most easy example:

Given a set of N observations of two variables (x,y) and given a model y = f (x; m, n) where m and m are  parameters of the model (real numbers). The parameters are estimated from the measurements by optimizing a designed estimator.

But the conditions in atmospheric models are much more complex and first the dimension of the system is very large, the dynamics is not linear anymore, the system is undetermined as the dimension of x and y is very different. 

### Data Analysis: tasting the problem [^5]

Data assimilation is derived from data analysis a very simple examples is when we have a scalar variable x and a single observation:

$$x_{a} = x_{b} + W(x_{o}-x_{b}) $$

where $$x_{a}$$ is the value after the analysis, $$x_{b}$$ is the value before the analysis (background), $$x_{o}$$ is the value of the single observation and $$W$$ is a weighting function to be calculated in the data analysis.

If we define the error as the value minus the true value then from the equation above we can write,

$$e_{a} = e_{b} + W(e_{o}-e_{b}) $$

Still we have to propose a value for W, we can proceed by performing an ensemble average (we are trying to understand the statistical properties on our data analysis). If our background, analysis and observation are unbiased the average of their errors is zero. But it the equation,

$$e_{a}^{2} = [e_{b} + W(e_{o}-e_{b})]^{2} $$

is useful and we can evaluate it in a large set of possible measurements and our relationship will be,

$$W = \frac{E(e_{b}^{2})}{E(e_{b})+E(e_{b}^{2})}$$

when the cross-correlation $$E(e_{b}e{o})=0$$

The situation on the case of atmospheric models is more complicated because we have a model-grid and the observations are not exactly in our grid or not necessarily and is possible that we have a kind of heterogeneous sources with different error properties. 


### Optimal Interpolation [^3] 

This point is important, we have now a situation with several fields defining the state of the system, for example the prognostic variables $$x=(\rho_{s},w,T,u,v)$$, so pressure, temperature, air moisture and wind fields. Our model has defined a grid. So we will have, let's say, n scalar variables in total (n=5m if m is the number of grid points).

We proceed as before but not we have to introduce a new concept, the **forward observational operator** which translates a given prognostic state vector into our measurements (not necessarily the variables $x=(\rho_{s},w,T,u,v)$$). 

$$x_{t} - x_{b} =  W(y_{o}-H(x_{b}))-e_{a}$$
 
Our measurements are a vector $$y_{o}$%$ with usually different dimension p than the state vector. H is the forward observational operator. The weights are then a matrix of numbers (nxp). The **observational increments** are defined by: $$d=(y_{o}-H(x_{b}))$$. The matrix W is often named gain matrix. The observational errors are defined by: $e_{o,i}=y_{o,i}-H(x_{t,i})$. Note that each measurements is done in an specific point $r_{i}$ of the space not necessarily in our model grid. Because we don't know the true values we have to move the statistical analysis by introducing the statistical properties of the errors we have (sometimes these are hypothesis). Another key definition is the error covariance matrix:

$$P_{b}=E(e_{b}e_{b}^{T})$$ (in the case of background errors). Each element of the matrix has the form $$P_{l,k}E(e_{b,j}e_{b,k})$$ and represents the statistical covariance between the errors of two prognostic variables (it may be the the temperature at two points, or the air moisture in a grid point and the wind velocity and other grind point etc...).

Now we have to deal with the forward observation operator which is usually highly non-linear. This means that it is better build our study over the **linear observation operator** defined as a pxn matrix with elements $$h_{i,j}=\partial H_{i}\partial x_{l}$$. The idea of this definition is to write now the observation increment as,

$$d=y_{o}-H(x_{b})\simeq y_{o}-H(x_{t})-h((x_{b}-x_{t})=e_{o}-he_{b}$$ 
 
With the three definitions $$P_{a},P_{b},P_{o}$$. It is assumed that $$P_{o,b}=0$$. The **optimal interpolation** minimizes the amount $$e_{a}^{T}e_{a}$$ an scalar product of two error vectors of the analysis with a weighting matrix,

$$W = P_{b}h^{T}(P_{o}+hBh^{T})^{-1}$$

all the amounts are know and the $$P_{a}=(1-Wh)P_{b}$$. A main issue here is perform numerically the inversion of a usually very big matrix.

Note here an important property of Optimal interpolation shared with other statistical interpolation schemes as 3D-Var. The method implements statistical properties of all the involved amounts. Other methodologies more empirical based simply on build an interpolation function over the grid.


### Variational approaches: 3D-Var [^3]

The optimal interpolation method can be formulated also directly as a variational problem. This means that we begin with the definition of a **cost function** that has to be minimized to obtain our analysis). In this formulation we have similar methodologies to inverse methods in remote sensing. Formally we will have an statistical problem and our goal is to maximize the a posteriori probability of the true state of the atmosphere constrained by the observations. 

$$J(x)=(x-x_{b})P_{b}^{-1}(x-x_{b})+(y_{0}-H(x))^{T}P_{o}^{-1}(y_{0}-H(x))$$

If we define the analysis increment $$\delta x_{a}=x_{a}-x_{b}$$ over the background,

$$\delta x_{a}=(P_{b}+h^{T}R^{-1}h)^{-1}h^{T}R^{-1}\delta y_{o}$$

where $$\delta y_{0}= y_{o}-H(x_{b})$$.

The equation for $$\delta x_{a}$$ defines the 3D-Var analysis problem. The optimization here was in the analysis not in the weights as the optimal interpolation. Both approaches are equivalents[^3] formally but the method is different and 3D-Var has practical advantages over OI in atmospheric models.

### Kalman Filter

Until know we didn't comment about the dynamical system itself and the only important point are the background error covariance matrix (a constant matrix). This is done with the Kalman Filter that relies on the concept of linear tangent evolution operator of our dynamical (non-linear) system. The global idea is to replace the matrix $$P_{b}$$ by a **forecast error covariance matrix$$ $$P_{f}$$. The method consist in advance one time step with the dynamical system:

$$x^{f}_{i+1}=M_{i}[x^{a}_{i}]$$

given the analysis of the last step we calculate the forecast state vector with the operator evolution M (on practical cases just means solve numerically our model in one step more). Now a key step is calculate with the linear tangent evolution operator L the evolution of the analysis error covariance matrix at time step i, so,

$$P^{f}_{i+1}=L_{i}P^{a}_{i}L^{T}_{i} + P^{q}_{i}$$

the matrix $$P^{q}$$ just account for forecasting typical errors, so if the forecast has a typical error $$e_{f,t}$$ then $$P_{q}=E(e_{f,i}e^{T}_{f,i})$$. i represents the time step. After this forecast step we perform a data analysis similar to Optimal interpolation but our background is the forecast so,

$$K_{i+1}=P^{f}_{i+1}h^{T}_{i+1}(P^{0}_{i+1}+h_{i+1}P^{f}_{i+1}h^{T}_{i+1})^{-1}$$

The Kalman Filter has very nice properties but it is very expensive in terms of computation. The reason is that in addition to the inversion of the matrix we have to calculate all the forecasting steps. The most widely used solution of this (extended) Kalman Filter is the Ensemble Kalman Filter which only demands a moderate of computational resources over 3D-Var. 

### 4D-Var

In the case 3D-Var there is an extension that aims to introduce time dependences with a cost function,

$$J(x_{t0})=(x_{t0}-x^{b}_{t0})P_{b,0}^{-1}(x_{t0}-x^{b}_{t0})+\sum_{i}(y_{0,i}-H(x,i))^{T}P_{o,i}^{-1}(y_{0,i}-H(x,i))$$

whose optimization also needs the linear tangent evolution operator 

### References





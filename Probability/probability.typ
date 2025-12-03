//imports
#import "@preview/physica:0.9.7": *
#import "prob_lib.typ": *
#import "personal_lib.typ": *

#show: note_template.with(note_title: [Probability Notes])


= Continuous Distributions <continuous>
A continuous probability distribution over a single random variable $X$ is defined by a real-valued _density function_ $f:RR -> RR$ such that:

  #list(
    [$f(x)$ is a continuous function over $RR$],
    [$f(x) >= 0$, $forall x in RR$],
    [ $integral_RR f(x) dd(x) = 1$ ],
    indent: 2.5em
  )

The expected value and 2nd moments are defined as they are with discrete distributions:
$ EE[X] = integral_(-infinity)^infinity x f(x) dd(x) \
  EE[X^2] = integral_(-infinity)^infinity x^2 f(x) dd(x) #<secmoment> $


= The Gaussian Distribution <gaussian>

The density function for a one-dimensional Gaussian distribution $X$ is written as follow:
$ f(x) = 1 / (sqrt(2 pi sigma^2)) dot e^(- 1/2 ((x- mu)/sigma)^2) #<gaussian_density> $

where $mu$ is the mean and $sigma^2$ is the variance. By using the usual definitions of $EE[X]$ and $EE[X^2]$ (@continuous), it can be readily calculated that 
$ EE[X] = mu \
  EE[X^2] = mu^2 + sigma^2 $ 

The second moment's calculation is done through a subsitution and a differentiation through the integral. 
Indeed by using the formula for the variance, we verify that $sigma^2$ is indeed the variance for the Gaussian distribution:
$ Var(X) = EE[X^2] - (EE[X])^2 = sigma^2 $ 

The Gaussian with mean $mu$ and variance $sigma^2$ is usually denoted by $Gaussian(mu,sigma^2)$. The _standard normal distribution_ is $Gaussian(0,1)$. 

#theorem[Gaussian][]
#import "@preview/physica:0.9.7": *
#import "@local/personal_lib:1.0.0": *

== Gaussian Width
The Gaussian width can be seen as a measure of geometric complexity such as volume or surface area. Roughly, it tells you on average what the support function values will be if the normal directions are sample from an isotropic Gaussian distribution. 

#definition[Gaussian Width][
  Let $S subset RR^n$ be a subset. The _Gaussian width_ is defined as
  $ w(S) = EE[sup_(s in s) ip(g,s)] quad g tilde Gaussian(0,1) $
] <def:gaussian_width>


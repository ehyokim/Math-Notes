//imports
#import "@preview/physica:0.9.7": *
#import "ee546_lib.typ": *
#import "personal_lib.typ": *

#show: note_template.with(note_title: [High dimensional Probability])


= Sub-Gaussian Random Variables 


= Concentration Inequalities


= Gaussian Matrices 


== Gaussian Concentration Inequalities
#theorem[Gaussian Concentration Inequality][
  Let $X tilde Gaussian(0,I_(n times n))$ be sampled from an unit isotropic Gaussian. Let $f: RR^m -> RR$ be an $L$-Lipschitz continuous function. For $t >= 0$. the following holds
  $ PP[|f(X) - EE[f(X)]| >= t] <= 2 exp(-t^2/2) $ 
] <thm:gauss_concen_ineq>

== Gaussian Width
The Gaussian width can be seen as a measure of geometric complexity such as volume or surface area. Roughly, it tells you on average what the support function values will be if the normal directions are sample from an isotropic Gaussian distribution. 

#definition[Gaussian Width][
  Let $S subset RR^n$ be a subset. The _Gaussian width_ is defined as
  $ w(S) = EE[sup_(s in s) ip(g,s)] "where" g tilde Gaussian(0,1) $
] <def:gaussian_width>

== Gordon's Comparison Theorem

Gordon's Comparison Theorem gives an similar analogue to the JL lemma in the sense that it describes the amount of distortion one should expect with high probability after randomly projecting a vector to a lower dimensional space:

#theorem[Gordon's Comparison Theorem][ 
  Let $G in RR^(k times d)$ be a matrix whose entries are sampled from independent unit Gaussians $Gaussian(0,1)$ and $S subset SS^(d-1)$ a closed subset of the unit sphere. For $t >= 0$, $ lambda_m - w(S) - t <= inf_(s in S)  ||G s|| <= sup_(s in S) ||G s|| <= lambda + w(S) + t $ with probability at least $1 - 2exp(-t^2/2)$
]
Here, $w(S)$ refers to the Gaussian width of $S$. See @def:gaussian_width.  

#proof[
  The main idea behind the proof will be to invoke the Gaussian concentration inquality for Lipschitz functions (@thm:gauss_concen_ineq). Let $F(G) = sup_(s in S)||G s||_2$. This is a 1-Lipschitz function:
  $ | sup_(s_1 in S) ||G_1 s_1|| - sup_(s_2 in S) ||G_2 s_2|| | & <= | sup_(s in S) ||G_1 s|| - ||G_2 s|| | \
  & <= sup_(s in S) | ||G_1 s|| - ||G_2 s|| | \
  & <= sup_(s in S) ||G_1 s - G_2 s || \ 
  & = ||G_1 - G_2||_2 <= ||G_1 - G_2||_F  $
]

Recall that the Frobenius norm of a matrix is the sum of the squared entries of its entries: 
$ ||G_1 - G_2||_F = || "vec"(G_1) - "vec"(G_2) ||_2 $
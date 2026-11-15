//imports
#import "@preview/physica:0.9.7": *
#import "@local/personal_lib:1.0.0": *

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
] <thm:gordons_thm>
Here, $w(S)$ refers to the Gaussian width of $S$. See @def:gaussian_width.  

#proof[
  The main idea behind the proof will be to invoke the Gaussian concentration inquality for Lipschitz functions (@thm:gauss_concen_ineq). Let $F_(max)(G) = sup_(s in S)||G s||_2$. This is a 1-Lipschitz function:
  $ |sup_(s_1 in S) ||G_1 s_1|| - sup_(s_2 in S) ||G_2 s_2|| | & <= | sup_(s in S) ||G_1 s|| - ||G_2 s|| | \
  & <= sup_(s in S) | ||G_1 s|| - ||G_2 s|| | \
  & <= sup_(s in S) ||G_1 s - G_2 s || \ 
  & = ||G_1 - G_2||_2 <= ||G_1 - G_2||_F  $
]

Recall that the Frobenius norm of a matrix is the sum of the squared entries of its entries: 
$ ||G_1 - G_2||_F = ||"vec"(G_1) - "vec"(G_2)||_2 $

The first inequality can be found by w.l.o.g fixing the first norm to $||G_1 s_1^*$||, the value at which the supremum is attained. Such a $s_1^*$ must exist as $S$ is compact. Now the second norm will attain a value at most the supremum of $||G_2 s_2||$ taken over $S$, resulting in a larger magnitude difference. The second inequality is simply reverse triangle inequality.

A similar argument shows that $F_(min)(G) = inf_(s in S) ||G s||$ is also 1-Lipschitz. 

In light of this finding, we invoke a one-sided version of  @thm:gauss_concen_ineq to find the exponential tail bound:
$ PP[F_(max)(G) >= EE[F_(max)] + t]] <= exp(-t^2/2) \
  PP[F_(min)(G) <= EE[F_(min)] - t]] <= exp(-t^2/2) $

Hence, it suffices to ascertain both expected values to prove the theorem. To this end, we will invoke a theorem allowing us to compare the maximum between two Gaussian processes:

#theorem[Slepian/Sudakov-Fernique inequality][
  Let ${X_u}_(u in U)$ and ${Y_u}_(u in U)$ be almost surely bounded centered Gaussian processes indexed by an non-empty compact set $U$. Suppose that for every $u_1,u_2 in U$, 
  $ EE|X_(u_1)-X_(u_2)|^2 <=EE|Y_(u_1)-Y_(u_2)|^2 $
  then
  $ EE[ sup_(u in U) X_u ] <= EE[ sup_(u in U) Y_u ] $
] <thm:slepian_ineq>

In some sense, the expected square differences between pairs of random variables in $X,Y$ can be intuively understood as a way to measure correlations between the pair. A smaller expected value means that the values of the process tend to be nore likely to be closer to one another. The theorem above says that the process with the "least correlations" will have a higher expected maximum. 

The following is an extension by Gordon:

#theorem[Gordon's Extension to @thm:slepian_ineq][
  Let ${X_(t,u)}_((t,u) in T times U)$ and ${Y_(t,u)}_((t,u) in T times U)$ be almost surely bounded centered Gaussian processes indexed by an non-empty compact sets $T,U$. Suppose $u_1,u_2 in U$ and $t_1,t_2 in T$ and 
  $ EE|X_(t_1,u_1) - X_(t_1,u_2)|^2 <= EE|Y_(t_1,u_1) - Y_(t_1,u_2)|^2 $
  Furthermore, for $t_1 eq.not t_2$ if 
  $ EE|X_(t_1,u_1) - X_(t_2,u_2)|^2 >= EE|Y_(t_1,u_1) - Y_(t_2,u_2)|^2 $
  Then 
  $ EE[ inf_(t in T) sup_(s in S) X_(t,u) ] <= EE[ inf_(t in T) sup_(s in S) Y_(t,u) ] $
]
Note that @thm:slepian_ineq can be recovered by setting $|T|=1$. We can now finish the proof of @thm:gordons_thm.
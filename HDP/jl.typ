#import "@preview/physica:0.9.7": *
#import "@local/personal_lib:1.0.0": *

== The Johnson-Lindenstrauss Lemma
The seminal Johnson-Lindenstrauss Lemma describes a remarkable property of random linear projections $Pi: RR^d -> RR^k$ whose entries are sampled independently from a scaled unit Gaussian $Gaussian(0,1)$. In particular, the result tells that preserving the pairwise distance of a finite set of points $X$ does not depend on the ambient dimension $d$. Rather, it only depends on the number of points $|X|$ and the desired distortion factor $epsilon$. 

#theorem[Johnson-Lindenstrauss Lemma][Let $x_1, dots, x_N subset RR^d$ be a finite set of points. For $epsilon > 0$, there exists a linear $epsilon$-isometry $Pi:RR^d -> RR^k$ in the sense that:
$ (1 - epsilon)||x_i - x_j||_2 <= ||Pi x_i - Pi x_j||_2 <=  (1 + epsilon)||x_i - x_j||_2 quad (forall i eq.not j) $
where $k = O(log N \/ epsilon^2)$. 
] <thm:jl_lemma>

In other words, an $epsilon$-isometry approximately preserves the pairwise Euclidean distances between all points. Such maps are called _Johnson-Lindenstrauss embeddings_. 

 The question is how do we find such a linear map? It turns out we can construct a distribution over linear projections $Pi$ which allows us to sample a Johnson-Lindenstrauss embedding with high probability.

 #theorem[Distributional JL Lemma][Let $epsilon, delta > 0$. If 
 $ k >= 4 dot frac(log(1 \/ delta), epsilon^2 \/ 2 - epsilon^2 \/ 3) $
 then there exists a distribution over linear maps $Pi: RR^d -> RR^k$ such that for every $x in RR^d$
 $ (1 - epsilon)||x||_2 <= ||Pi x||_2 <= (1+epsilon)||x||_2 $
 with probability $1- delta$.
 ] <thm:dist_jl_lemma>

 By setting $delta \/ binom(n, 2) < 1/2$ and performing a union bound over all distinct pairs, we can sample a linear map $Pi$ which satisfies the Johnson-Lindenstrauss property described in @thm:jl_lemma with probability greater than a half provided that
 $ k >= frac(8 dot log (n\/delta), epsilon^2 \/ 2 - epsilon^2 \/ 3) $
We can then amplify this probability to increase the success probability arbitrarily close to 1 with a logarithmic number of samples. 


=== Distributional JL Through $chi^2$ Tail Bound.

=== Matousěk's Proof on Sub-Gaussian Matrices
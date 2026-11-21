#import "@preview/physica:0.9.7": *
#import "@local/personal_lib:1.0.0": *

== Gordon's Theorem

Gordon's Theorem gives an similar analogue to the JL lemma in the sense that it describes the amount of norm distortion one should expect with high probability after randomly projecting a (possibly infinite) set to a lower dimensional space. The key idea is that the expected maximum and minimum distortion is controlled by the _Gaussian width_ of the set of unit directions arising from projecting all vectors contained in the set to the unit sphere. 

Recall that $ lambda_k = EE||g_k||_2 quad g_k tilde Gaussian(0, I_(k times k)) $

#theorem[Gordon's Theorem][
  Let $G$ be a random matrix whose entries are sampled according to independent unit Gaussians $Gaussian(0,1)$ and $S subset SS^(d-1)$ a closed subset of the unit sphere. It must hold that
  $ lambda_k - w(S)   <= EE[inf_(x in S) ||G x||_2 ] <=  EE[sup_(x in S) ||G x||_2 ]  <= lambda_k + w(S) $ 
] <thm:gordons_thm_v1>

#proof[
To this end, we will invoke a theorem allowing us to compare the maximum between two Gaussian processes:

#theorem[Slepian/Sudakov-Fernique inequality][
  Let ${X_u}_(u in U)$ and ${Y_u}_(u in U)$ be almost surely bounded centered Gaussian processes indexed by an non-empty compact set $U$. Suppose that for every $u_1,u_2 in U$, 
  $ EE|X_(u_1)-X_(u_2)|^2 <=EE|Y_(u_1)-Y_(u_2)|^2 $
  then
  $ EE[ sup_(u in U) X_u ] <= EE[ sup_(u in U) Y_u ] $
] <thm:slepian_ineq>

In some sense, the expected square differences between pairs of random variables in $X,Y$ can be intuively understood as a way to measure correlations between the pair. A smaller expected value means that the values of the process tend to be more likely to be closer to one another. The theorem above says that the process with the "least correlations" will have a higher expected maximum. 

The following is an extension by Gordon:

#theorem[Gordon's Extension to @thm:slepian_ineq][
  Let ${X_(t,u)}_((t,u) in T times U)$ and ${Y_(t,u)}_((t,u) in T times U)$ be almost surely bounded centered Gaussian processes indexed by an non-empty compact sets $T,U$. Suppose $u_1,u_2 in U$ and $t_1,t_2 in T$ and 
  $ EE|X_(t_1,u_1) - X_(t_1,u_2)|^2 <= EE|Y_(t_1,u_1) - Y_(t_1,u_2)|^2 $
  Furthermore, for $t_1 eq.not t_2$ if 
  $ EE|X_(t_1,u_1) - X_(t_2,u_2)|^2 >= EE|Y_(t_1,u_1) - Y_(t_2,u_2)|^2 $
  Then 
  $ EE[ inf_(t in T) sup_(s in S) X_(t,u) ] <= EE[ inf_(t in T) sup_(s in S) Y_(t,u) ] $
]

#proof[

  
]

]
Note that @thm:slepian_ineq can be recovered by setting $|T|=1$. 

A few more steps yields a powerful comparison theorem that captures many of the core themes describing the nature of Johnson-Lindenstrauss embeddings. 


#theorem[Gordon's Theorem][ 
  Let $G in RR^(k times d)$ be a matrix whose entries are sampled from independent unit Gaussians $Gaussian(0,1)$ and $S subset SS^(d-1)$ a closed subset of the unit sphere. For $t >= 0$, $ lambda_k - w(S) - t <= inf_(x in S)  ||G x||_2 <= sup_(x in S) ||G x||_2 <= lambda_k + w(S) + t $ with probability at least $1 - 2exp(-t^2/2)$
] <thm:gordons_thm_v2>

#proof[
  The main idea behind the proof will be to invoke the Gaussian concentration inquality for Lipschitz functions (@thm:gauss_concen_ineq). Let $F_(max)(G) = sup_(s in S)||G s||_2$. This is a 1-Lipschitz function:
  $ |sup_(s_1 in S) ||G_1 s_1||_2 - sup_(s_2 in S) ||G_2 s_2||_2 | & <= | sup_(s in S) ||G_1 s||_2 - ||G_2 s||_2 | \
  & <= sup_(s in S) | ||G_1 s||_2 - ||G_2 s||_2 | \
  & <= sup_(s in S) ||G_1 s - G_2 s||_2 \ 
  & = ||G_1 - G_2||_2 <= ||G_1 - G_2||_F  $


Recall that the Frobenius norm of a matrix is the sum of the squares of its entries: 
$ ||G_1 - G_2||_F = ||"vec"(G_1) - "vec"(G_2)||_2 $

The first inequality can be found by w.l.o.g fixing the first norm to $||G_1 s_1^*||_2$, the value at which the supremum is attained. Such a $s_1^*$ must exist as $S$ is compact. Now the second norm will attain a value at most the supremum of $||G_2 s_2||_2$ taken over $S$, resulting in a larger magnitude difference. The second inequality is simply reverse triangle inequality.

A similar argument shows that $F_(min)(G) = inf_(s in S) ||G s||_2$ is also 1-Lipschitz. 

In light of this finding, we invoke a one-sided version of  @thm:gauss_concen_ineq to find the exponential tail bound:
$ PP[F_(max)(G) >= EE[F_(max)] + t]] <= exp(-t^2/2) \
  PP[F_(min)(G) <= EE[F_(min)] - t]] <= exp(-t^2/2) $

From the upper and lower bounds on the expectations described in @thm:gordons_thm_v1 and simple union bound on the two inequalities above, we arrive at the desired result.
]

Notice that, we see that for non-vacuous $t >= sqrt(2 ln 2)$ @thm:gordons_thm_v2 implies that for sufficiently large $k$, for all $x in S$, the norms $||G x||_2$ concentrate around $lambda_k$. By normalizing the inequality by $lambda_k$, we see that:

$ 1 - (w(S) + t)/lambda_k <= norm(1 / lambda_k G x)_2 <= 1 + (w(S) + t) / lambda_k quad (forall x in S) $ <eq:normalized_gordon_ineq>

#corollary[Let $G in RR^(k times d)$ be a matrix whose entries are sampled from independent unit Gaussians $Gaussian(0,1)$ and $S subset SS^(d-1)$ a closed subset of the unit sphere. If $epsilon > w(S) / lambda_k$, then 
$ (1-epsilon)||x|| <= norm(1 / lambda_k G x)_2 <= (1+ epsilon)||x|| $
with probability at least $1 - 2 exp[- lambda_k^2 / 2 (epsilon - w(S) / lambda_k)^2]$]

#proof[

  To achieve the desired distortion factor, set $epsilon = (w(S) + t) / lambda_k$. Solving for $t$ and substituting it into the probability in @thm:gordons_thm_v1  and minding the constraint that $t >= 0$.
]

#remark[
  A looser bound on the success probability that explicitly links $k$ can be found through the following lower bound on $lambda_k$: 

  $ lambda_k >= k - k / (k+1) >= k^2 / 2 $

  Together, this tells us that the theorem holds with probability at least $1 - 2 exp[- k^2 / 4 (epsilon - w(S) / lambda_k)^2]$
 ]  

So why is this so important? Since $lambda_k asymp sqrt(k)$, we can conclude a useful rule of thumb by making a substitution into @thm:gordons_thm_v2:
$  sup_(x in S) abs(norm(1 / sqrt(k) G x)_2 - 1) lt.tilde (w(S) + t) / sqrt(k) $

This tells us that the maximum distortion after pushing unit vectors living in $S$ through the random linear map $ 1 / sqrt(k) G$ is controlled by Gaussian width $w(S)$. Hence, if we want distortion at most $epsilon$, it suffices to choose $k$ such that
$ k gt.tilde (w(S) + t)^2 / epsilon^2 $

If $X subset RR^d$ is a finite set of points living in $RR^d$, then we know that $w(X) lt.tilde sqrt(log|X|)$. This directly implies that by choosing a $k$ which is proportional to $(log|X|) / epsilon^2$ will ensure that the unit vectors obtained from normalizing all points in $X$ will not distort by more than $epsilon$ after pushing them through $1 / lambda_k G$. This shows that Gordon's theorem essentially implies Johnson-Lindenstrauss lemma. 


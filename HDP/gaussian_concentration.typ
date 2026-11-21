#import "@preview/physica:0.9.7": *
#import "@local/personal_lib:1.0.0": *

== Gaussian Concentration Inequalities
#theorem[Gaussian Concentration Inequality][
  Let $X tilde Gaussian(0,I_(n times n))$ be sampled from an unit isotropic Gaussian. Let $f: RR^m -> RR$ be an $L$-Lipschitz continuous function. For $t >= 0$. the following holds
  $ PP[|f(X) - EE[f(X)]| >= t] <= 2 exp(-t^2/2) $ 
] <thm:gauss_concen_ineq>


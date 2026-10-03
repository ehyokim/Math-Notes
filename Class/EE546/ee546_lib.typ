#let Var(rv) = [Var\[  #rv  \]]
#let Gaussian(mean, var) = { math.cal([N]); [(#mean, #var)] }
#let ip(x, y) = $lr(chevron.l #x, #y chevron.r)$
library(stats)
musterds <- rnorm(200)

standarderror <- function(x) {
  c <- sd(x)/sqrt(length(x))
  return(c)
}

standarderror(musterds)

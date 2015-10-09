## load 'Rcpp' package
install.packages("Rcpp")
library(Rcpp)

## try to evaluate c++ expression
evalCpp("1 + 1")


## function that returns 1 if 'x' is positive, -1 if 'x' is negative, 0 otherwise
cppFunction('int signC(int x) {
  if (x > 0) {
    return 1;
  } else if (x == 0) {
    return 0;
  } else {
    return -1;
  }
}')

signC(-10)

## speed check
sumR <- function (x){
  out <- 0
  for (i in x){  
       out[i] <- out+x[i]
       } 
       return(x)
}

test <- seq(1:10)
sumR(test)


microbenchmark(
  sum(1:1e6), # built-in `sum` function
  sumR(1:1e6), # base-R version
  sumC(1:1e6)  # rcpp version
  , times = 20L)
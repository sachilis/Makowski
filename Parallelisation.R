## load 'doParallel' package
install.packages("doParallel")
library(doParallel)

## no. of local cores
detectCores()

## create parallel socket cluster
cl <- makeCluster(3)

## register parallel backend
registerDoParallel(cl)


## The foreach syntax

## calculate square root, return list
foreach(i = 1:4) %do% sqrt(i)

## calculate sqare root, return vector
foreach(i = 1:4, .combine = "c") %do% sqrt(i)

##parallelisation

## load 'microbenchmark' package
library(microbenchmark)

## load 'ggplot2' and split 'diamonds' dataset
library(ggplot2)
ls_diamonds <- split(diamonds, f = diamonds$cut)


## speed test (this might take some time)

##bad example of parallelisation
#without doparallel
microbenchmark({
  foreach(i = ls_diamonds) %do% lm(carat ~ price, data = i)
}, times = 20L) # number of times to evaluate the expression

#with doparallel
microbenchmark({
  foreach(i = ls_diamonds) %dopar% lm(carat ~ price, data = i) # %dopar% is the command to parallelize
}, times = 20L)

##good example of parallelisation
## load 'party' package
library(party)

## without doparallel
system.time({
  
  ## conditional inference trees 
  ls_ct <- foreach(i = c("cut", "color", "carat")) %do% {
    
    # formula
    frml <- as.formula(paste(i, ".", sep = " ~ "))
    
    # classification
    ctree(frml, data = diamonds,
          controls = ctree_control(testtype = "MonteCarlo",
                                   nresample = 999,
                                   mincriterion = 0.999,
                                   maxdepth = 3))
  }
})


##with doparallel
system.time({
  
  ## conditional inference trees 
  ls_ct <- foreach(i = c("cut", "color", "carat"), 
                   .packages = c("ggplot2", "party")) %dopar% {
                     
                     # formula
                     frml <- as.formula(paste(i, ".", sep = " ~ "))
                     
                     # classification
                     ctree(frml, data = diamonds,
                           controls = ctree_control(testtype = "MonteCarlo",
                                                    nresample = 999,
                                                    mincriterion = 0.999,
                                                    maxdepth = 3))
                   }
})

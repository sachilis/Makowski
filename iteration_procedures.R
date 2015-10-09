##### applly family #####

###  lapply #### for lists designed

lst <- list(1:10, 
            "Hello", 
            mean,
            mean(1:10),
            function(x) x + 1, 
            data.frame(col1 = rnorm(10), col2 = runif(10)),
            matrix(1:9, 3, 3))
lst

result <- lapply(1:5, function(i) i)
result

fls <- list.files("results", pattern = glob2rx("*subset*.csv"),
                  full.names = TRUE)

dat_lst <- lapply(seq(fls), function(i) {
  read.csv(fls[i])
})

str(dat_lst, 1)

## split diamonds by cut
cut_lst <- split(diamonds, f = diamonds$cut)

my_result_list <- lapply(seq(cut_lst), function(i) {
  
  ## subset to color = D
  dat <- cut_lst[[i]]
  dat_d <- subset(dat, dat$color == "D")
  
  ## calculate linear model
  lm1 <- lm(price ~ carat, data = dat_d)
  
  ## create scatterplot
  scatter_ggplot <- ggplot(aes(x = carat, y = price), data = dat_d)
  g_sc <- scatter_ggplot + 
    geom_point(colour = "grey60") +
    theme_bw() +
    stat_smooth(method = "lm", se = TRUE, 
                fill = "black", colour = "black") +
    geom_text(data = NULL, 
              x = min(dat_d$carat, na.rm = TRUE) + 0.2,  
              y = max(dat_d$price, na.rm = TRUE) * 0.98, 
              label = unique(dat_d$cut))
  
  ## return both the linear model and the plot as a list
  return(list(linmod = lm1,
              plt = g_sc))
})

## set names of list for clarity
names(my_result_list) <- names(cut_lst)

str(my_result_list, 2)


###  sapply #### s from simplify. Return and object of simple structure, such as a vector or a matrix

result <- sapply(1:5, function(i) i)
result



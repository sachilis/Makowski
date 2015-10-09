install.packages("ggplot2")
library(ggplot2)
install.packages("dplyr")
library(dplyr)

diamonds <- tbl_df(diamonds)
diamonds
subset_diamonds <- diamonds[diamonds$cut %in% c("Premium","Ideal") & diamonds$color %in% c("C","D","F") & diamonds$carat > 3,]

diamonds %>%  # pipelíne operator comes from the "magrittr package"
  filter(carat > 3 &
           cut %in% c("Premium", "Ideal") &
           color %in% c("D", "E", "F")) %>%
  select(carat:clarity, price)

#data aggregation

diamonds %>% 
  group_by(color) %>%
  summarise(MIN = min(price), MEAN = mean(price), MAX = max(price)) # This is an alternative for aggregate in base R

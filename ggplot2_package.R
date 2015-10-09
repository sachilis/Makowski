##### visualization with ggplot2 ######

###  scatterplots

ggplot(aes(x = carat, y = price), data = diamonds) + 
  geom_point() +
  stat_smooth(method = "lm", se = TRUE, 
              colour = "red", fill = "grey35") + 
  facet_wrap(~ cut)


#without grey background
ggplot(aes(x = carat, y = price), data = diamonds) + 
  geom_point(colour = "grey65") +
  stat_smooth(method = "lm", se = TRUE, 
              colour = "black", fill = "grey35") +
  facet_wrap(~ cut, nrow = 2, ncol = 3) +
  labs(x = "Carat", y = "Price ($)") +
  theme_bw() # remove grey background

#without grey background and lines
ggplot(aes(x = carat, y = price), data = diamonds) + 
  geom_point(colour = "grey65") +
  stat_smooth(method = "lm", se = TRUE, 
              colour = "black", fill = "grey35") +
  facet_wrap(~ cut, nrow = 2, ncol = 3) +
  labs(x = "Carat", y = "Price ($)") +
  theme_bw() +
  theme(panel.grid = element_blank())


###  boxplots and whyskerplots

## basic frame
p <- ggplot(aes(x = color, y = price), data = diamonds)

## add boxplot
p_bw <- p + geom_boxplot()

## print
print(p_bw)

## add faceted boxplots
p_bw <- p + 
  geom_boxplot(fill = "grey90") +
  facet_wrap(~ cut) +
  theme_bw()

print(p_bw)
  

### histograms and density plots

## new basic frame
p <- ggplot(aes(x = price), data = diamonds)

## add histogram
p_hist <- p + geom_histogram()

print(p_hist)

## add densityplot
p_dens <- p +  geom_density(fill = "black", alpha = 0.5)

print(p_dens)
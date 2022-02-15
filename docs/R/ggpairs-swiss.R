#' ---
#' title: "Add regression lines in ggpairs"
#' author: "Michael Friendly"
#' date: "14 Mar 2018"
#' ---

# example from: https://www.r-bloggers.com/multiple-regression-lines-in-ggpairs/

data("swiss", package="datasets")
require(GGally)     # Extension to 'ggplot2'
require(ggplot2)    # Plots Using the Grammar of Graphics
require(dplyr)      # A Grammar of Data Manipulation

ggpairs(swiss, columns=1:5) + theme_bw()

swiss %>%
	mutate(Religeon = ifelse(Catholic < 50, "Protestant", "Catholic")) %>%
	ggpairs(columns=1:4, aes(color="Religeon"))

swiss <- swiss %>%
	mutate(Religeon = ifelse(Catholic < 50, "Protestant", "Catholic"))
	
ggpairs(swiss, columns=1:4, ggplot2::aes(color=Religeon, alpha=0.5))


#' Create a function to plot points and smooths
my_fn <- function(data, mapping, ...){
  p <- ggplot(data = data, mapping = mapping) + 
    geom_point() + 
    geom_smooth(method=loess, fill="red", color="red", ...) +
    geom_smooth(method=lm, fill="blue", color="blue", ...)
  p
}

ggpairs(swiss, columns = 1:4, 
	lower = list(continuous = my_fn(swiss, alpha=0.5)),
	upper = list(continuous = my_fn))




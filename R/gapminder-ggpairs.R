#' ---
#' title: "gapminder data: ggpairs plot"
#' author: "Michael Friendly"
#' date: "12 Apr 2018"
#' ---


library(GGally)
library(dplyr)
library(ggplot2)
library(gapminder)

gapminder %>% 
	select(-country, -year) %>% 
	ggpairs(aes(color=continent))
	
	
#' ---
#' title: "gapminder data: Summaries and boxplots by continent"
#' author: "Michael Friendly"
#' date: "19 Mar 2019"
#' ---

# original example from https://github.com/jennybc/gapminder

#' Some simple summaries of the gapminder data by continent

#' ## Load packages
if(!require(gapminder)) {install.packages("gapminder"); library(gapminder)}
library("gapminder")
library("dplyr")
library("ggplot2")

#' ## Find median life expectancy by continent, using `aggregate`
aggregate(lifeExp ~ continent, gapminder, median)

#' ## Do the same, using `dplyr`
gapminder %>%
  group_by(continent) %>%
  summarise(lifeExp = median(lifeExp))

#' ## Add a few more stats using `summarise()`
gapminder %>%
  group_by(continent) %>%
  summarise(`Q1`=quantile(lifeExp, probs=0.25),
            median=quantile(lifeExp, probs=0.5),
            Q3=quantile(lifeExp, probs=0.75),
            avg=mean(lifeExp),
            n=n())


#' ## Make boxplots but add jittered points
ggplot(gapminder, aes(x = continent, y = lifeExp)) +
  geom_boxplot(outlier.colour = "hotpink", 
               outlier.size = 2) +
  geom_jitter(position = position_jitter(width = 0.1, 
                                         height = 0), alpha = 1/4)

#' ---
#' title: "Plots of mtcars data with ggplot2"
#' author: "Michael Friendly"
#' category: "ggplot2"
#' date: "`r format(Sys.Date())`"
#' output:
#'   html_document:
#'     theme: readable
#'     code_download: true
#'   word_document: default    
#' ---

#+ echo=FALSE
knitr::opts_chunk$set(warning=FALSE, 
                      message=FALSE, 
                      R.options=list(digits=4))

#' ## Load the `mtcars` data
data(mtcars, package="datasets")
str(mtcars)

#' ## Plot with base graphics
#' This doesn't quite come out right because it is hard to coordinate the 
#' choices for point symbols and colors in the plot with those in the legend

mtcars$cyl <- as.factor(mtcars$cyl)
plot(mpg ~ hp , data=mtcars, 
	col=cyl, pch=c(4,6,8)[mtcars$cyl], cex=1.2)
legend("topright", legend=levels(mtcars$cyl),
                   pch = c(4,6,8),
                   col=levels(mtcars$cyl))

#' ## Plots with ggplot2

#' ### Basic plot: `mpg` vs. `hp`
#' Specify aesthetic mappings for `x=hp` and `y=mpg` to setup the coordinates, then
#' add points with `geom_point()`
library(ggplot2)
ggplot(mtcars, aes(x=hp, y=mpg)) +
  geom_point(size=3)


#' ### Distinguish cars by number of cylinders
#' Use color and shape as additional aesthetics. 
#' To do this,  make `cyl` a factor because ggplot now requires discrete variables to be factors.
library(dplyr)
mtcars <- mtcars |>
  mutate(cyl = as.factor(cyl))

ggplot(mtcars, aes(x=hp, y=mpg, 
                   color=cyl, 
                   shape=cyl)) +
	geom_point(size=3)

#' ### Add separate regression lines
#' `geom_smooth()` inherits the aesthetics for `color` and `shape`, so it draws a separate regression line
#' for each value of `cyl`
ggplot(mtcars, aes(x=hp, y=mpg, color=cyl, shape=cyl)) +
	geom_point(size=3) +
	geom_smooth(method="lm", aes(fill=cyl)) 

#' ### Add overall smooth
#' If I add a `geom_smooth` overriding `color`, this will be used for all the data
ggplot(mtcars, aes(x=hp, y=mpg)) +
	geom_point(size=3, aes(color=cyl, shape=cyl)) +
	geom_smooth(method="loess", color="black", se=FALSE, lwd = 2) +
	geom_smooth(method="lm", aes(color=cyl, fill=cyl)) 

#' ### Change the theme
last_plot() + theme_bw(base_size = 14)


#' ## Faceting
plt <-
ggplot(mtcars, aes(x=hp, y=mpg, color=cyl, shape=cyl)) +
	geom_point(size=3) +
	geom_smooth(method="lm", aes(fill=cyl)) 

plt + facet_wrap(~cyl)

#' ## Labeling points, change theme, 
plt2 <- ggplot(mtcars, aes(x=wt, y=mpg)) +
  geom_point(color = 'red', size=2) +
  geom_smooth(method="loess") +
  labs(y="Miles per gallon", x="Weight (1000 lbs.)") +
  theme_classic(base_size = 16)
plt2 + geom_text(aes(label = rownames(mtcars)))

library(ggrepel)
plt2 + geom_text_repel(aes(label = rownames(mtcars)))

#' ### Only label points with large residuals

mod <- loess( mpg ~ wt, data=mtcars)
resids <- residuals(mod)
mtcars$label <- ifelse(abs(resids) > 2.5, rownames(mtcars), "")

plt2 + 
	geom_text_repel(aes(label = mtcars$label)) 


#' ## What's in a ggplot object?

class(plt)

names(plt)

summary(plt)


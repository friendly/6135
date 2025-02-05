#' ---
#' title: "Plot Arbuthnot's data with ggplot2"
#' author: "Michael Friendly"
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

#' John Arbuthnot (1710) gathered data on the ratios of male to female christenings in London from 1629-1710 to 
#' carry out the first known significance test, comparing observed data to a null hypothesis. 
#' The data for these 81 years showed that in every year there were more male than female christenings.
#' Let's make a plot for him.
#'
#' ## Load the data & ggplot2
library(ggplot2) # Plots Using the Grammar of Graphics  
data(Arbuthnot, package="HistData")
head(Arbuthnot)

#' ## Basic plot: points & lines
#' I assign the initial plot to a variable, `arbuthplot`, so I can add additional graphical elements to it.
#' I also expand the Y axis limits a bit to allow for annotations.
arbuthplot <-
ggplot(Arbuthnot, aes(x=Year, y=Ratio)) +
  ylim(1, 1.20) + 
  ylab("Sex Ratio (M/F)") +
  geom_point(pch=16, size=2) +
  geom_line(color="gray") 
arbuthplot

#' ## Add smooths
#' He might have been interested in whether there was any trend over time. We can add a linear regression line
#' and loess smooth using `geom_smooth`.
arbuthplot +
  geom_smooth(method="loess", color="blue", fill="blue", alpha=0.2) +
  geom_smooth(method="lm", color="darkgreen", se=FALSE)  

#' ## Add reference line, annotations and change the theme
#' To highlight that a sex ratio = 1.0 is the null hypothesis, add a thick red line at that value.
#' Instead of a plot title outside the plot frame, you can add text annotations inside.
arbuthplot +
  geom_smooth(method="loess", color="blue", fill="blue", alpha=0.2) +
  geom_smooth(method="lm", color="darkgreen", se=FALSE) +
  geom_hline(yintercept=1, color="red", size=2) +
  annotate("text", x=1645, y=1.01, label="Males = Females", color="red", size=5) +
  annotate("text", x=1680, y=1.19, 
           label="Arbuthnot's data on the\nMale / Female Sex Ratio", size=5.5) +
  theme_bw() + 
  theme(text = element_text(size = 16))




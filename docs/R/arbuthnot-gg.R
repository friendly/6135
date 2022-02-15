#' ---
#' title: "Plot Arbuthnot's data with ggplot2"
#' author: "Michael Friendly"
#' date: "13 Sep 2018"
#' ---

#' ## Load the data & ggplot2
data(Arbuthnot, package="HistData")
library(ggplot2) # Plots Using the Grammar of Graphics  

#' ## basic plot: points & lines
#' 
arbuthplot <-
ggplot(Arbuthnot, aes(x=Year, y=Ratio)) +
  ylim(1, 1.20) + 
  ylab("Sex Ratio (M/F)") +
  geom_point(pch=16, size=2) +
  geom_line(color="gray") 
arbuthplot

#' ## add smooths
arbuthplot +
  geom_smooth(method="loess", color="blue", fill="blue", alpha=0.2) +
  geom_smooth(method="lm", color="darkgreen", se=FALSE)  

#' ## add reference line, annotations and change the theme
arbuthplot +
  geom_smooth(method="loess", color="blue", fill="blue", alpha=0.2) +
  geom_smooth(method="lm", color="darkgreen", se=FALSE) +
  geom_hline(yintercept=1, color="red", size=2) +
  annotate("text", x=1645, y=1.01, label="Males = Females", color="red", size=5) +
  annotate("text", x=1680, y=1.19, 
           label="Arbuthnot's data on the\nMale / Female Sex Ratio", size=5.5) +
  theme_bw() + 
  theme(text = element_text(size = 16))




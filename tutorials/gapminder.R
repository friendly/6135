## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_chunk$set(
  warning = FALSE,   # avoid warnings and messages in the output
  message = FALSE,
  fig.height = .8 * 5,
  fig.width = .8 * 7,
  tidy.opts=list(width.cutoff = 120),  # For code
  options(width = 120)                 # for output
  )

## ----include=FALSE-------------------------------------------------------
#What are my defaults:
unlist(knitr::opts_chunk$get(c("fig.height", "fig.width")))

## ----load-packages-------------------------------------------------------
library(ggplot2)
library(dplyr)    # data munging
library(scales)   # nicer axis scale labels

## ----install-and-load-gapminder, eval=FALSE------------------------------
## install.packages("gapminder")
## library(gapminder)

## ------------------------------------------------------------------------
if(!require(gapminder)) {install.packages("gapminder"); library(gapminder)}

## ----gapminder-str-------------------------------------------------------
str(gapminder)

## ----gapminder-print-----------------------------------------------------
gapminder

## ----gapminder-summary---------------------------------------------------
summary(gapminder)

## ----gapminder-table-----------------------------------------------------
table(gapminder$continent, gapminder$year)

## ----eval=FALSE----------------------------------------------------------
## with(gapminder, {table(continent, year)})

## ----bar-continent1------------------------------------------------------
ggplot(gapminder, aes(x=continent)) + geom_bar()

## ----bar-continent2------------------------------------------------------
ggplot(gapminder, aes(x=continent, fill=continent)) + geom_bar()

## ----bar-continent3------------------------------------------------------
ggplot(gapminder, aes(x=continent, fill=continent)) + 
	geom_bar(aes(y=..count../12)) +
	labs(y="Number of countries") +
	guides(fill=FALSE)

## ------------------------------------------------------------------------
# record a plot for future use
mybar <- last_plot()

## ----bar-continent-coord-------------------------------------------------
mybar + coord_trans(y="sqrt")
mybar + coord_flip()
mybar + coord_polar()

## ----lifeexp1------------------------------------------------------------
ggplot(data=gapminder, aes(x=lifeExp)) + 
	geom_density()

## ----lifeexp2------------------------------------------------------------
ggplot(data=gapminder, aes(x=lifeExp)) + 
	geom_density(size=1.5, fill="pink", alpha=0.3)

## ----lifeexp3------------------------------------------------------------
ggplot(data=gapminder, aes(x=lifeExp)) + 
	geom_density(size=1.5, fill="pink", alpha=0.5) +
	geom_histogram(aes(y=..density..), binwidth=4, color="black", fill="lightblue", alpha=0.5)

## ------------------------------------------------------------------------
ggplot(data=gapminder, aes(x=lifeExp, fill=continent)) +
	geom_density(alpha=0.3)

## ------------------------------------------------------------------------
gap1 <- ggplot(data=gapminder, aes(x=continent, y=lifeExp, fill=continent))

## ----boxplot-------------------------------------------------------------
gap1 +
	geom_boxplot(outlier.size=2)

## ----eval=FALSE----------------------------------------------------------
## gapminder %>%
## 	mutate(continent = reorder(continent, lifeExp, FUN=median))

## ------------------------------------------------------------------------
gapminder %>% 
	mutate(continent = reorder(continent, lifeExp, FUN=median)) %>%
	ggplot(aes(x=continent, y=lifeExp, fill=continent)) +
	geom_boxplot(outlier.size=2)

## ------------------------------------------------------------------------
ggplot(data=gapminder, aes(x=gdpPercap)) + 
	geom_density()  

## ----lifetime------------------------------------------------------------
ggplot(gapminder, aes(x=year, y=lifeExp, group=country)) +
	geom_line()

## ----life-top-sd---------------------------------------------------------
gapminder %>%
	group_by(country) %>%
	summarise(sd=sd(lifeExp), IQR=IQR(lifeExp)) %>% 
	top_n(8) %>%
	arrange(desc(sd))

## ------------------------------------------------------------------------
gapminder %>%
	group_by(continent, year) %>%
	summarise(lifeExp=median(lifeExp)) %>% head()

## ------------------------------------------------------------------------
gapminder %>%
	group_by(continent, year) %>%
	summarise(lifeExp=median(lifeExp)) %>%
	ggplot(aes(x=year, y=lifeExp, color=continent)) +
     geom_line(size=1) + 
     geom_point(size=1.5)

## ----gapyear-------------------------------------------------------------
# save in a new data set
gapminder %>%
	group_by(continent, year) %>%
	summarise(lifeExp=median(lifeExp)) -> gapyear

## ----gaplm---------------------------------------------------------------
ggplot(gapyear, aes(x=year, y=lifeExp, color=continent)) +
	geom_point(size=1.5) +
	geom_smooth(aes(fill=continent), method="lm")

## ----gap-scat1-----------------------------------------------------------
plt <- ggplot(data=gapminder,
              aes(x=gdpPercap, y=lifeExp))
plt

## ----gap-scat2-----------------------------------------------------------
plt + geom_point()

## ----gap-scat3-----------------------------------------------------------
plt + geom_point(aes(color=continent))

## ----gap-scat4-----------------------------------------------------------
plt + geom_point(aes(color=continent)) +
    geom_smooth(method="loess") 

## ----gap-scat5-----------------------------------------------------------
plt + geom_point(aes(color=continent)) +
    geom_smooth(method="loess") +
    scale_x_log10()


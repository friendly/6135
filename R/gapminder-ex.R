#' ---
#' title: "ggplot tutorial: gapminder data"
#' author: "Michael Friendly"
#' date: "29 Jan 2018"
#' ---


if(!require(gapminder)) {install.packages("gapminder"); library(gapminder)}
library(ggplot2)
library(dplyr)
library(scales)

str(gapminder)

#' how many countries in each continent
table(gapminder$continent, gapminder$year)

#' barplots
ggplot(gapminder, aes(x=continent)) + geom_bar()

ggplot(gapminder, aes(x=continent, fill=continent)) + geom_bar()

ggplot(gapminder, aes(x=continent, fill=continent)) + 
	geom_bar(aes(y=..count../12)) +
	labs(y="Number of countries") +
	guides(fill=FALSE)

# record a plot for future reference
mybar <- last_plot()

# plot on sqrt scale


# horizontal
mybar + coord_flip()
	
#' radial chart
mybar + coord_polar()


#' ## 1D plots: density plots
ggplot(data=gapminder, aes(x=lifeExp)) + 
	geom_density()

#' change line thickness
ggplot(data=gapminder, aes(x=lifeExp)) + 
	geom_density(size=1.5)

#' add a fill color, make it transparent
ggplot(data=gapminder, aes(x=lifeExp)) + 
	geom_density(size=1.5, fill="pink", alpha=0.3)

#' Add a histogram layer
ggplot(data=gapminder, aes(x=lifeExp)) + 
	geom_density(size=1.5, fill="pink", alpha=0.5) +
	geom_histogram(aes(y=..density..), binwidth=4, color="black", fill="lightblue", alpha=0.5)

# group by continent
ggplot(data=gapminder, aes(x=lifeExp, fill=continent)) +
	geom_density(alpha=0.3)

#' ## boxplots by continent
plt2 <- ggplot(data=gapminder, aes(x=continent, y=lifeExp, fill=continent)) +
	geom_boxplot(outlier.size=2)
plt2

# remove legend
plt2 + guides(fill=FALSE)

# make horizontal
plt2 + guides(fill=FALSE) + coord_flip()

# order by medians
gapminder %>% 
	mutate(continent = reorder(continent, lifeExp, FUN=median)) %>%
	ggplot(aes(x=continent, y=lifeExp, fill=continent)) +
	geom_boxplot(outlier.size=2)


# violin plots by continent	
ggplot(data=gapminder, aes(x=continent, y=lifeExp, fill=continent)) +
	geom_violin(alpha=0.5)

# what about gdpPercap?
ggplot(data=gapminder, aes(x=gdpPercap)) + 
	geom_density()  


ggplot(data=gapminder, aes(x=gdpPercap)) + 
	geom_density(aes(fill=continent), alpha=0.5)  


ggplot(data=gapminder, aes(x=gdpPercap)) + 
	geom_density(aes(fill=continent), alpha=0.5) + 
	scale_x_log10()

ggplot(data=gapminder, aes(x=continent, y=gdpPercap, fill=continent)) +
	geom_boxplot(outlier.size=2)

ggplot(data=gapminder, aes(x=continent, y=gdpPercap, fill=continent)) +
	geom_boxplot(outlier.size=2) +
	scale_y_log10()
	
#' ## 1.5D: time series plots

ggplot(gapminder, aes(x=year, y=lifeExp, group=country)) +
	geom_line()

gapminder %>%
	group_by(country) %>%
	summarise(sd=sd(lifeExp), IQR=IQR(lifeExp)) %>% 
	top_n(8) %>%
	arrange(desc(sd))

#' find median lifeExp by year and continent

gapminder %>%
	group_by(continent, year) %>%
	summarise(lifeExp=median(lifeExp)) %>% head()
	
#' can pipe this to ggplot
gapminder %>%
	group_by(continent, year) %>%
	summarise(lifeExp=median(lifeExp)) %>%
	ggplot(aes(x=year, y=lifeExp, color=continent)) +
	geom_line(size=1) + 
	geom_point(size=1.5)

#' save in a new data set
gapminder %>%
	group_by(continent, year) %>%
	summarise(lifeExp=median(lifeExp)) -> gapyear

ggplot(gapyear, aes(x=year, y=lifeExp, color=continent)) +
	geom_point(size=1.5) +
	geom_smooth(aes(fill=continent), method="lm")

	
#' ## 2D: scatterplots
plt <- ggplot(data=gapminder,
              aes(x=gdpPercap, y=lifeExp))
plt

#' add points
plt + geom_point()

#' add points, colored by continent
plt + geom_point(aes(color=continent))
 
# add a smooth
plt + geom_point(aes(color=continent)) +
    geom_smooth(method="loess") 

# plot gdp on a log scale
plt + geom_point(aes(color=continent)) +
    geom_smooth(method="loess") +
    scale_x_log10()

plt + geom_point(aes(color=continent)) +
    geom_smooth(method="loess") +
    scale_x_log10(labels=scales::comma)

# put legend inside the plot frame    
plt + geom_point(aes(color=continent)) +
    geom_smooth(method="loess") +
    scale_x_log10(labels=scales::comma) +
    theme(legend.position = c(0.8, 0.2))

# fit separate linear regressions by continent
plt + geom_point(aes(color=continent)) +
    geom_smooth(aes(color=continent, fill=continent), method="lm") +
    scale_x_log10(labels=scales::comma) +
    theme(legend.position = c(0.8, 0.2))
   
	
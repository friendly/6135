#' ---
#' title: "plotly demo"
#' author: "Michael Friendly"
#' date: "12 Feb 2022"
#' ---


# Package ----------------------
install.packages("plotly")
library(plotly)


# Example Data -----------------

data(iris)
str(iris)


# Simple scatterplot -----------------

plot_ly(
	data = iris,
	y = ~ Petal.Width,
	x = ~ Petal.Length,
	type = "scatter"
)


# Colors -----------------

plot_ly(
	data = iris,
	y = ~ Petal.Width,
	x = ~ Petal.Length,
	type = "scatter",
	color = ~ Species
)


# Colors & shapes -----------------

plot_ly(
	data = iris,
	y = ~ Petal.Width,
	x = ~ Petal.Length,
	type = "scatter",
	color = ~ Species,
	symbol = ~ Species
)

# Size -----------------

plot_ly(
	data = iris,
	y = ~ Petal.Width,
	x = ~ Petal.Length,
	type = "scatter",
	color = ~ Species,
	size = 3
)

# Transparency -----------------

plot_ly(
	data = iris,
	y = ~ Petal.Width,
	x = ~ Petal.Length,
	type = "scatter",
	color = ~ Species,
	size = ~ Petal.length,
	alpha = .3
)


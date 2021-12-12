library(ggplot2)

# set a consistent theme
theme_set(theme_bw() +
          theme(text = element_text(size = 18)))

set.seed(123435)
dsmall = diamonds[sample(nrow(diamonds),200),]
#
# Bar chart: map discrete variable to x-axis and to color; compute
# counts-by-category, and map them to bar heights

ggplot(data = dsmall, aes(x = cut, fill = cut)) +
  geom_bar(stat = "count") 

# Pie chart: set a constant radius of 1 on polar coordinates; map
# discrete variable to color; compute counts-by-category, and map
# them to angles

ggplot(data = dsmall, aes(x = factor(1), fill = cut)) +
  geom_bar(stat = "count") + coord_polar(theta = "y")

# what if we map discrete variable to color and radius instead?

ggplot(data = dsmall, aes(x = cut, fill = cut)) +
	geom_bar(stat = "count") + coord_polar(theta = "y")

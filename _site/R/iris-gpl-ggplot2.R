# Grouped scatterplot

# GPL
DATA: x = "SepalLength"
DATA: y = "SepalWidth"
DATA: z = "species"
TRANS: x = x
TRANS: y = y
ELEMENT: point(position(x*y), color(z))
COORD: rect(dim(1,2))
SCALE: linear(dim(1))
SCALE: linear(dim(2))
GUIDE: axis(dim(1), label("Sepal Length"))
GUIDE: axis(dim(2), label("Sepal Width"))

# ggplot2

library(ggplot2)
data(iris)

ggplot(iris,
       aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
       geom_point() +
       theme_bw()
  

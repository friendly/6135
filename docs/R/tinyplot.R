#' ---
#' title: tinyplot demo
#' ---

library(tinyplot)
#' ## Load the `mtcars` data
data(mtcars, package="datasets")
str(mtcars)

#' ## Plot with base R graphics
#' This doesn't quite come out right because it is hard to coordinate the 
#' choices for point symbols and colors in the plot with those in the legend

mtcars$cyl <- as.factor(mtcars$cyl)
plot(mpg ~ hp , data=mtcars, 
     col=cyl, 
     pch=c(4,6,8)[mtcars$cyl], 
     cex=1.2)
legend("topright", 
       legend=levels(mtcars$cyl),
       pch = c(4,6,8),
       col=levels(mtcars$cyl))

#' ## Basic use: determine `pch` and `col` from levels of the group variable
tinyplot(mpg ~ hp | cyl, data = mtcars,
         legend = "topright",
         pch = "by")

#' Specify symbols and colors directly
op <- par(mar = c(4,4,1,1)+.5)
tinyplot(mpg ~ hp | cyl, data = mtcars,
         legend = "topright",
         col = palette()[2:4],
         pch = 15:17)
par(op)

# Linear regression lines
tinyplot(mpg ~ hp | cyl, data = mtcars,
         type = "lm",
         legend = "topright",
         col = palette()[2:4],
         pch = 15:17)
tinyplot_add(type = "p")


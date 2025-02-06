library(tinyplot)
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

tinyplot(mpg ~ hp | cyl, data = mtcars,
         legend = "topright",
         pch = "by")

# try nlstools

#install.packages("nlstools")
library(nlstools)
library(ggplot2)
library(glue)

#library(nls2)

# set relative path for images
#path <- here()
setwd(here::here("images", "bootstrap"))


#theme_set(theme_bw(base_size=18))

nlsfit <- nls(mpg ~ k / wt + b, mtcars, 
              start = list(k = 1, b = 0))
summary(nlsfit)

con <- nlsConfRegions(nlsfit)
plot(con)

plot(nlsContourRSS(nlsfit))

## bootstrapping

nlsb <- nlsBoot(nlsfit)

names(nlsb)

plot(nlsb, type="pairs")

plot(nlsb, type="boxplot")

library(ggplot2)
library(ggdist)

library(dplyr)
library(tidyr)
library(broom)
library(modelr)
library(distributional)

setwd("C:/Users/friendly/Dropbox/Documents/6135/images/uncertainty")

p1 <-
  ggplot(mtcars, aes(x = hp, y=mpg)) +
  geom_point(aes(color=factor(cyl)), size=4, pch=16 ) + 
  theme(legend.position = c(0.85, 0.75)) + 
  labs(color = "Cylinders",
       x = "Horsepower",
       y = "Miles per gallon")
p1

p1 +
	annotate("text", x = 250, y = 34, label = "Data", size=8)
ggsave(file="mtcars-data.png", height=5, width=5)

# add error
n <- nrow(mtcars)
mtcars2 <- mtcars %>%
	mutate(ey = runif(n, 0, 2),
	       ex = runif(n, 0, 20),
	       ymin = mpg - ey,
	       ymax = mpg + ey,
	       xmin = hp - ex,
	       xmax = hp + ex)

p2 <-
  ggplot(mtcars2, aes(x = hp, y=mpg, xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax)) +
  geom_point(aes(color=factor(cyl)), size=4, pch=16 ) + 
  geom_linerange() +
  geom_errorbarh(aes(xmin = xmin, xmax = xmax)) +
  theme(legend.position = c(0.85, 0.75)) + 
  labs(color = "Cylinders",
       x = "Horsepower",
       y = "Miles per gallon")
p2 +
	annotate("text", x = 250, y = 34, label = "Observation Error", size=8)

ggsave(file="mtcars-obs-error.png", height=5, width=5)
	       
	       

p1 + 
  geom_smooth(method = lm, formula = y~poly(x,2), 
              size=2, fill="lightblue", level=.95) +
	annotate("text", x = 250, y = 34, label = "Quadratic fit", size=8)
ggsave(file="mtcars-quadratic.png", height=5, width=5)


p1 + 
  geom_smooth(method = loess, formula = y~x, 
              size=2, fill="lightblue", level=.95) +
	annotate("text", x = 250, y = 35, label = "Loess fit", size=8)
ggsave(file="mtcars-loess.png", height=5, width=5)


p1 +
  geom_smooth(method = loess, formula = y~x, 
              size=2, fill="lightblue", level=.95) +
  theme(legend.position = c(0.8, 0.8)) + 
  labs(color = "Cylinders")
#  geom_smooth(method = loess, size=2, fill="lightblue", level=.99, alpha=0.2) 
  

# Fit interaction model
m_mpg = lm(mpg ~ hp * cyl, data = mtcars)


mtcars %>%
  group_by(cyl) %>%
  data_grid(hp = seq_range(hp, n = 101)) %>%
  augment(m_mpg, newdata = ., se_fit = TRUE) %>%
  ggplot(aes(x = hp, fill = ordered(cyl), color = ordered(cyl))) +
  stat_dist_lineribbon(
    aes(dist = dist_student_t(df = df.residual(m_mpg), mu = .fitted, sigma = .se.fit)),
    alpha = 1/4
  ) +
  geom_point(aes(y = mpg), data = mtcars) +
  
  scale_fill_brewer(palette = "Set2") +
  scale_color_brewer(palette = "Dark2") +
  labs(
    color = "Cylinders",
    fill = "Cylinders",
       x = "Horsepower",
       y = "Miles per gallon"
  	) +
  theme(legend.position = c(0.8, 0.75)) +
  annotate("text", x = 250, y = 34, label = "Interaction model", size=8)
ggsave(file="mtcars-interaction.png", height=5, width=5)
 


mtcars %>%
  group_by(cyl) %>%
  data_grid(hp = seq_range(hp, n = 101)) %>%
  augment(m_mpg, newdata = ., se_fit = TRUE) %>%
  ggplot(aes(x = hp, color = ordered(cyl))) +
  stat_dist_lineribbon(aes(
    dist = dist_student_t(df = df.residual(m_mpg), mu = .fitted, sigma = .se.fit),
    fill = ordered(cyl),
    fill_ramp = stat(level)
  )) +
  geom_point(aes(y = mpg), data = mtcars) +
  
  scale_fill_brewer(palette = "Set2") +
  scale_color_brewer(palette = "Dark2") +
  labs(
    color = "cyl",
    fill = "cyl",
    y = "mpg"
  )
  
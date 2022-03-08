# show ggplot step by step

library(ggplot2)
library(here)

plt <-
ggplot(data=mtcars) +
  aes(x = hp, y= mpg)


ggsave(here("images/ggplot2", "gg-steps1.png"), height=4, width=4)

plt + geom_point(size=2)

plt + geom_point(size=2) +
  geom_smooth()


plt + geom_point(size=2) +
  geom_smooth() +
  ggtitle("Gas mileage vs. horsepower")
  
#  annotate("text", x=250, y=35, label="mtcars: gas mileage vs. horsepower")

# Illustrate theme elements

p1 <-
  ggplot(mtcars, aes(x = hp, y=mpg)) +
  geom_point(aes(color=factor(cyl)), size=3, pch=16 ) + 
  labs(color = "Cylinders",
       x = "Horsepower",
       y = "Miles per gallon") +
  ggtitle("Gas mileage vs. Horsepower")
p1
ggsave(here("images/ggplot2", "gg-themes1.png"), height=4, width=4)

# move the legend
p1 + theme(legend.position = c(0.85, 0.75)) 
ggsave(here("images/ggplot2", "gg-themes2.png"), height=4, width=4)

# change all text to serif font
p1 + theme(legend.position = c(0.85, 0.75),
           text = element_text(size=18, family = "serif"))
ggsave(here("images/ggplot2", "gg-themes3.png"), height=4, width=4)

# change background & panel colors
p1 + theme(legend.position = c(0.85, 0.75),
           text = element_text(size=18, family = "serif"),
           plot.background = element_rect(fill="green"),
           panel.background = element_rect(fill="lightyellow"))
ggsave(here("images/ggplot2", "gg-themes4.png"), height=4, width=4)


# custom theme

theme_ugly <- function (base_size = 12, base_family = "") {
  theme_gray(base_size = base_size, base_family = base_family) %+replace% 
    theme(
      axis.text = element_text(colour = "white"),
      axis.title.x = element_text(colour = "pink", size=rel(3)),
      axis.title.y = element_text(colour = "blue", angle=45),
      panel.background = element_rect(fill="green"),
      panel.grid.minor.y = element_line(size=3),
      panel.grid.major = element_line(colour = "orange"),
      plot.background = element_rect(fill="red")
    )   
}

p1 + 
  theme_ugly() +
  theme(legend.position = c(0.85, 0.75)) 

ggsave(here("images/ggplot2", "gg-themes5.png"), height=4, width=4)


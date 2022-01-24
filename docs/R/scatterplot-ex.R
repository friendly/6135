#' ---
#' title: "Scatterplot example"
#' author: "Michael Friendly"
#' date: "15 Jan 2022"
#' ---

#' ## Sequential steps to illustrate adding additional information to a basic scatterplot

library(ggplot2)
library(glue)
library(gganimate)
library(here)
library(car)     # for dataEllipse

data(mtcars)

#' ## Basic scatterplot: mpg vs. weight
#' 
p1 <-
  ggplot(mtcars, aes(y=mpg, x=wt)) +
  geom_point(size=2) +
  labs(x="Car Weight (1000 lbs)",
       y="Miles Per Gallon") +
  ggtitle("1974 Motor Trend Cars: Gas Mileage vs. Weight") +
  theme_minimal()
p1

#' ## add	linear regression line
p2 <-
  p1 + geom_smooth(method = "lm", formula = y~x, se=FALSE,
                   color="red", size=2) 
p2

#' add confidence band
p3 <-
  p2 + geom_smooth(method = "lm", formula = y~x, 
                 color="red", fill="pink", size=2) 
p3

#' annotate with coefficients
#' 
#' contruct text labels for the linear model
mod <- lm(mpg ~ wt, data=mtcars)
coefs <- coef(mod)
r = cor(mtcars$mpg, mtcars$wt)
modtxt <- glue("b0 = {round(coefs[1],1)}
                b1 = {round(coefs[2],1)}
                r  = {round(r, 2)}"
)
modtxt

mtfit <- cbind(mtcars, fit = predict(mod))

p4 <-
p2 + geom_smooth(method = "lm", formula = y~x, 
                 color="red", fill="pink", size=2) +
     annotate("text", x = 4.5, y = 30, label = modtxt, size=6) +
     geom_segment(data=mtfit, 
                  aes(y=mpg, x=wt, yend=fit, xend=wt),
                  color="gray")


#' add loess smooth
p2 + geom_smooth(method = "loess", formula = y~x, # se=FALSE,
                 color="blue", fill="lightblue", size=2) 

# add a data ellipse
ell <- car::dataEllipse(mtcars$wt, mtcars$mpg, levels=0.68, draw=FALSE)

p2 + geom_smooth(method = "loess", formula = y~x, # se=FALSE,
                 color="blue", fill="lightblue", size=2) +
     stat_ellipse(level=0.68, color="green", size=2)

# animate


anim <-
ggplot(mtcars, aes(y=mpg, x=wt)) +
  geom_point(size=3, alpha=0.5) +
  labs(x="Car Weight (1000 lbs)",
       y="Miles Per Gallon") +
  ggtitle("1974 Motor Trend Cars: Gas Mileage vs. Weight [Frame {frame}]") +
  theme_minimal(base_size = 14) +
  geom_smooth(method = "lm", formula = y~x, 
                 color="red", fill="pink", size=2) +
  geom_smooth(method = "loess", formula = y~x, # se=FALSE,
              color="blue", fill="lightblue", size=2) +
  transition_layers(layer_length = 1, transition_length = 2,
                    from_blank = FALSE) +
  enter_fade() + enter_grow()

animate(anim, nframes=20, fps = 2, start_pause = 3, end_pause = 3, rewind=FALSE)

path <- here(file.path("images", "varieties", "scattercars.gif"))
anim_save(path, anim, nframes=40, fps = 2,
          start_pause = 3, end_pause = 3, rewind=FALSE)

anim2 <-
ggplot(mtcars, aes(y=mpg, x=wt)) +
  geom_point(size=3, alpha=0.5) +
  labs(x="Car Weight (1000 lbs)",
       y="Miles Per Gallon") +
  ggtitle("1974 Motor Trend Cars: Gas Mileage vs. Weight") +
  theme_minimal(base_size = 14) +
  geom_smooth(method = "lm", formula = y~x, 
              color="red", fill="pink", size=2) +
  annotate("text", x = 4.5, y = 30, label = modtxt, size=6) +
  geom_segment(data=mtfit, 
             aes(y=mpg, x=wt, yend=fit, xend=wt)) +
  transition_layers(layer_length = 1, transition_length = 2,
                  from_blank = FALSE) +
  enter_fade() + enter_grow()

#animate(anim2, nframes=40, fps = 2, start_pause=3, end_pause=5)

path <- here(file.path("images", "varieties", "scattercars2.gif"))
anim_save(path, anim2, nframes=40, fps = 2,
          start_pause = 2, end_pause = 4, rewind=FALSE)

# combine these with imagemagik convert

# convert scattercars.gif scattercars2.gif scattercars-both.gif




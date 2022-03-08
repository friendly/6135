library(ggplot2)
library(gganimate)
library(dplyr)

ggplot(mtcars, aes(factor(cyl), mpg)) + 
  geom_boxplot()  
  
# animate this over changes in gear

ggplot(mtcars, aes(factor(cyl), mpg)) + 
  geom_boxplot() + 
  # Here comes the gganimate code
  transition_states(gear) +
  enter_fade() + 
  exit_shrink() 

anim_save(here::here("images", "ggplot2", "gganim-mtcars.gif"))

# fancier version
ggplot(mtcars, aes(factor(cyl), mpg)) + 
  geom_boxplot() + 
  # Here comes the gganimate code
  transition_states(
    gear,
    transition_length = 2,
    state_length = 1
  ) +
  enter_fade() + 
  exit_shrink() +
  ease_aes('sine-in-out')


options(gganimate.nframes = 50)

ggplot(mtcars, aes(mpg, disp)) +
  geom_point(aes(color = gear, shape=as.factor(cyl)), size=5) +
  transition_states(gear, transition_length = 2, state_length = 1) +
  enter_fade() +
  exit_fade()

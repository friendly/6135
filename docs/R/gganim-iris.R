# animate iris over species

library(ggplot2)
library(gganimate)

ggplot(iris, aes(Sepal.Width, Petal.Width)) +
  geom_point(size=3) +
  labs(title = "{closest_state}") +
  transition_states(Species, transition_length = 3, state_length = 1) 

library(forcats)
library(dplyr)
library(ggplot2)

# generate  some categorical data
set.seed(42)
N <- 200
survey <- data.frame(
  marital = sample(c("never", "separated", "divorced", "widowed", "married"), 
                   N, replace = TRUE,
                   prob = c(3, 1, 2, 1, 5)),
  party = sample(c("PC", "NDP", "Lib", "Green"), 
                 N, replace = TRUE,
                  prob = c(.35, .2, .4, .05)),
  age = rnorm(N, mean=30, sd=5)
)

str(survey)
# make factors
survey <- survey |>
  mutate(marital = factor(marital),
         party = factor(party))
str(survey)

old <- theme_set(theme_bw(base_size = 16),
          legend.position = "none")

# default: Alpha order
ggplot(survey, aes(x= party, fill = party)) +
  geom_bar() + coord_flip() + 
  theme(legend.position="none")


# reorder by frequency
survey |>
  mutate(party = fct_infreq(party)) |>
  ggplot(aes(x= party, fill = party)) +
  geom_bar() + coord_flip() + 
  theme(legend.position="none")

# reorder by right - left
survey |>
  mutate(party = fct_relevel(party, c("PC", "Lib", "NDP", "Green"))) |>
  ggplot(aes(x= party, fill = party)) +
  geom_bar() + coord_flip() + 
  theme(legend.position="none")

# reorder by median age
survey |>
  mutate(party = fct_relevel(party, age)) |>
  ggplot(aes(x= party, fill = party)) +
  geom_bar() + coord_flip() + 
  theme(legend.position="none")

ggplot(survey, aes(x= marital, fill=marital)) +
  geom_bar() + coord_flip() + 
  theme(legend.position="none")

# show in frequency order: fct_infreq()
ggplot(survey, aes(x=fct_infreq(marital), fill=marital)) +
  geom_bar() + coord_flip() + 
  theme(legend.position="none")

# relevel by marital stage
survey |>
  mutate(marital = fct_relevel(marital, c("never", "separated", "divorced", "widowed", "married"))) |>
  ggplot(aes(x=marital, fill = marital)) +
  geom_bar() + coord_flip() + 
  theme(legend.position="none")


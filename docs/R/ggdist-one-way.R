#' ---
#' title: Showing uncertainty in one-way ANOVA
#' ---

# From: https://mjskay.github.io/ggdist/articles/freq-uncertainty-vis.html

library(dplyr)
library(tidyr)
library(ggdist)
library(ggplot2)
library(broom)
library(distributional)

theme_set(theme_ggdist(base_size = 16))

set.seed(5)
n <- 10
ngrps <- 5
ABC <-
  tibble(
    grp = rep(c("A","B","C","D","E"), n),
    response = rnorm(n * ngrps, c(0,1,2,1,-1), 0.5)
  )

# fit ANOVA model

ABC.mod = lm(response ~ grp, data = ABC)

# Get the estimates and standard errors easily by using broom::tidy():

tidy(ABC.mod)

# Show distributions of the model terms, which frequentist theory says are
# distributed as t, with mu=

ABC.mod |>
  tidy() |>
  ggplot(aes(y = term)) +
  stat_halfeye(
    aes(xdist = dist_student_t(df = df.residual(ABC.mod), 
                               mu = estimate, 
                               sigma = std.error))
  )

# Add confidence intervals

ABC.mod |>
  tidy() |>
  ggplot(aes(y = term)) +
  stat_halfeye(
    aes(xdist = dist_student_t(df = df.residual(ABC.mod), 
                               mu = estimate, 
                               sigma = std.error)),
    alpha = 0.5,
    interval_size_range = c(1, 3),
    color = "red"
  ) +
  xlab("Response")

# show observations

ABC |>
  expand(grp) |>
  augment(ABC.mod, newdata = ., se_fit = TRUE) |>
  ggplot(aes(y = grp)) +
  stat_halfeye(
    aes(xdist = dist_student_t(df = df.residual(ABC.mod), mu = .fitted, sigma = .se.fit)),
    scale = .5
  ) +
  # we'll add the data back in too (scale = .5 above adjusts the halfeye height so
  # that the data fit in as well)
  geom_point(aes(x = response), data = ABC, 
             pch = 16, size = 2, color = "blue",
             position = position_nudge(y = -.15))


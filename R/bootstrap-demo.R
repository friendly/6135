#' ---
#' title: "Bootstrap demonstration"
#' author: "Michael Friendly"
#' date: "05 Mar 2022"
#' ---


library(ggplot2)
library(gganimate)
library(ungevis)       # devtools::install_github("wilkelab/ungeviz")

# randomly generate dataset
set.seed(12345)
x <- rnorm(15)
df <- data.frame(x, y = x + 0.5*rnorm(15))

# bootstrapper object
bsr <- bootstrapper(10)

ggplot(df, aes(x, y)) +
  geom_point(shape = 21, size = 6, fill = "white") +
  geom_text(label = "0", hjust = 0.5, vjust = 0.5, size = 10/.pt) +
  geom_point(data = bsr, aes(group = .row),
             shape = 21, size = 6, fill = "#0072B2") +
  geom_text(data = bsr, aes(label = .copies, group = .row),
            hjust = 0.5, vjust = 0.5, size = 10/.pt, color = "white") +
  geom_smooth(data = bsr, aes(group = .draw), method = "lm",
              se = FALSE, color = "#0072B2") +
  transition_states(.draw, 1, 2) +
  enter_fade() + 
  exit_fade()

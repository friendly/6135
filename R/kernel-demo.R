# https://albert-rapp.de/post/visualize-kernel-density-estimation/

library(animation)
library(ggplot2)
library(dplyr)
library(tidyr)
library(purrr)

compute_density <- function(x_0, h, K = dnorm) {
  xx <- seq(-6, 6, 0.001) * h
  tibble(
    x = xx,
    density = K((x - x_0) / h) / h
  )
}

set.seed(123)
# For the sake of demonstration we use a 
# small uniformly distributed sample here
x_sample <- runif(5, -5, 5)
h <- 1
SCALE = 0.4

tib <- tibble(
  k = seq_along(x_sample),
  density = map(x_sample, compute_density, h = h)
) %>%
  unnest(density)

draw_axis <- function(x_sample, tib, scale=1) {
  labs <- glue::glue("$x_{seq_along(x_sample)}$")
  labs <- latex2exp::TeX(labs)
  p <- ggplot(data = NULL, aes(x = x_sample)) +
    theme_minimal() +
    theme(
      axis.line.x = element_line(),
      panel.grid = element_blank(),
      axis.ticks = element_line(size = 1),
      axis.text = element_text(size = 14)
    ) +
    scale_x_continuous(
      limits = c(min(tib$x), max(tib$x)),
      breaks = sort(x_sample),
      minor_breaks = NULL,
      labels = labs
    ) +
    scale_y_continuous(
      breaks = NULL, 
      limits = c(0, scale*max(tib$density) + 0.025)
    ) +
    labs(x = element_blank())
  p
}


p <- draw_axis(x_sample, tib, scale=SCALE)
p

draw_kernel <- function(p, tib, scale=1) {
  p <- p +
    geom_line(data = tib, aes(x, scale*density, group = k), size = 1) +
    geom_segment(
      aes(
        x = x_sample,
        xend = x_sample,
        y = 0,
        yend = scale*dnorm(0)
      ),
      linetype = 2
    ) +
    labs(y = element_blank())
  p
}
draw_kernel(p, tib, scale=SCALE)


plot_until_x0 <- function(tib, x0, scale=1) {
  labs <- glue::glue("$x_{seq_along(x_sample)}$")
  labs <- latex2exp::TeX(labs)
  tib_x0 <- tib %>%
    filter(x <= x0) %>%
    group_by(x) %>%
    summarise(est = mean(density), .groups = "drop")
  
  
  anim_col <- 'firebrick3'
  g <- ggplot() +
    geom_rect(
      data = filter(tib, x == x0),
      aes(
        xmin = x - .5, ymin = 0,
        xmax = x + .5, ymax = scale * dnorm(0)),
      fill = adjustcolor(anim_col, alpha.f=0.1)
    ) +
    geom_segment(aes(x=x0, y=0,
                     xend=x0,
                     yend=scale * dnorm(0) ), 
                 col = anim_col,
                 size = 1.5) +
    geom_line(
      data = tib,
      aes(x, scale*density, group = k),
      alpha = 0.5,
      size = 1
    ) +
    geom_point(
      data = filter(tib, x == x0),
      aes(x, scale*density),
      #col = anim_col,
      alpha = 0.75,
      size = 3
    ) +
#    geom_vline(xintercept = x0, col = anim_col, alpha = 0.5) +
    geom_point(
      data = slice_tail(tib_x0, n = 1),
      aes(x, est),
      col = anim_col,
      size = 3
    ) +
    geom_line(
      data = tib_x0,
      aes(x, est),
      col = anim_col,
      size = 1.5
    ) +
    theme_classic() +
    theme(
      axis.line.x = element_line(),
      axis.line.y = element_blank(),
      panel.grid = element_blank(),
      axis.ticks = element_line(size = 1),
      axis.text = element_text(size = 14)
    ) +
    scale_x_continuous(
      limits = c(min(tib$x), max(tib$x)),
      breaks = sort(x_sample),
      minor_breaks = NULL,
      labels = labs
    ) +
    scale_y_continuous(
      breaks = NULL, 
      limits = c(0, max(tib$density) + 0.025)
    ) +
    labs(x = element_blank(), y = element_blank())
  
  print(g)
  
}

x0 <- (0)
plot_until_x0(tib, x0, scale=SCALE)


final_plot <- function(tib) {
  labs <- glue::glue("$x_{seq_along(x_sample)}$")
  labs <- latex2exp::TeX(labs)
  tib_x0 <- tib %>%
    group_by(x) %>%
    summarise(est = mean(density), .groups = "drop")
  
  
  anim_col <- 'firebrick3'
  g <- tib_x0 %>%
    ggplot() +
    geom_line(
      aes(x, est),
      col = anim_col,
      size = 2
    ) +
    theme_classic() +
    theme(
      axis.line.x = element_line(),
      axis.line.y = element_blank(),
      panel.grid = element_blank(),
      axis.ticks = element_line(size = 1),
      axis.text = element_text(size = 14)
    ) +
    scale_x_continuous(
      limits = c(min(tib$x), max(tib$x)),
      breaks = sort(x_sample),
      minor_breaks = NULL,
      labels = labs
    ) +
    scale_y_continuous(
      breaks = NULL, 
      limits = c(0, max(tib$density) + 0.025)
    ) +
    labs(x = element_blank(), y = element_blank())
  
  print(g)
}
final_plot(tib)

gif <- function(x_sample, tib, scale=1) {
  p <- draw_axis(x_sample, tib)
  map(1:3, ~print(p))
  p <- draw_kernel(p, tib, scale=scale)
  map(1:5, ~print(p))
  map(seq(min(tib$x), max(tib$x), 0.5), ~plot_until_x0(tib, ., scale=scale))
  map(1:15, ~final_plot(tib))
}

#gif(x_sample, tib, SCALE)

saveGIF(gif(x_sample, tib, SCALE),
        interval = 0.4, # animation speed
        ani.width = 720,
#        ani.height = 405,
        ani.height = 300,
        movie.name = "kernelAnimation3.gif")



### use this for gapminder$lifeExp

gapminder_2002 <- gapminder %>%
  filter(year == 2002)

set.seed(123)
# For the sake of demonstration we use a 
# small uniformly distributed sample here
x_sample <- runif(5, -5, 5)
h <- 1

x_sample <- sample_n(gapminder_2002, 10)$lifeExp
h <- 2



tib <- tibble(
  k = seq_along(x_sample),
  density = map(x_sample, compute_density, h = h)
) %>%
  unnest(density)

draw_kernel <- function(p, tib) {
  p <- p +
    geom_line(data = tib, aes(x, density, group = k), size = 1) +
    # geom_segment(
    #   aes(
    #     x = x_sample,
    #     xend = x_sample,
    #     y = 0,
    #     yend = dnorm(0)
    #   ),
    #   linetype = 2
    # ) +
    # labs(y = element_blank())
  p
}


ph <-
  ggplot(gapminder_2002,
         aes(x = lifeExp)) +
  geom_density(fill="pink", alpha = 0.5, size=1.1) + 
  geom_rug()

draw_kernel(ph, tib)

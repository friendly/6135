library(qqplotr)
library(ggplot2)
library(dplyr)

set.seed(41)
N=60
dat <- data.frame(value = rt(n=N, df = 6))
dat <- rbind(dat, data.frame(value = c(3, 3.5, 4)))
dat$id <- 1:nrow(dat)

# base R
res <- qqnorm(dat$value, 
              ylim = c(-4, 4),
              pch = 19, cex.lab = 1.5,
              main = "qqnorm()")
qqline(dat$value, col = "steelblue", lwd = 2)

lbl <- res |> as.data.frame() |>
  mutate(id = row_number()) |>
  arrange(y) |>
  slice(c(1:2, N+1:3))
text(lbl[, 1:2], labels = lbl[,3], pos =2, xpd = TRUE)




gg <- ggplot(data = dat, mapping = aes(sample = value)) +
  stat_qq_band(conf = .68, fill = scales::alpha("red", .2)) +
  stat_qq_band(conf = .95, fill = "lightpink") +
  stat_qq_line() +
  stat_qq_point() +
  geom_text(data = lbl, aes(x = x, y = y, sample = y,
                            label = id)
            ) +
  labs(x = "Theoretical Quantiles", y = "Sample Quantiles") +
  theme_bw(base_size = 15)
gg


# another way: https://stackoverflow.com/questions/14958814/how-can-i-label-the-points-of-a-quantile-quantile-plot-composed-with-ggplot2

ggplot_build(gg)$data[[4]] |> str()

df.new <- ggplot_build(gg)$data[[4]]
df.new$name <- dat$id[order(df.new$x)]
head(df.new)


# cqplots

library(heplots)


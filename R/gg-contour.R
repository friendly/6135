# contour plots

library(ggplot2)
library(here)

folder <- here(file.path("images", "ggplot2"))
setwd(folder)

# # Basic plot: density pre-computed
# ggplot(faithfuld, aes(waiting, eruptions, z = density)) +
#   geom_contour(size=1.2) +
#   labs(x = "Waiting time", y = "Eruption time")
# 
# # vary binwidth
# ggplot(faithfuld, aes(waiting, eruptions, z = density)) +
#   geom_contour(size=1.2, binwidth = .002) +
#  labs(x = "Waiting time", y = "Eruption time")



# Or compute from raw data
p <- ggplot(faithful, aes(waiting, eruptions)) 

p + geom_density_2d(size=1.2) +
    labs(x = "Waiting time", y = "Eruption time") +
    theme_bw()
ggsave("gg-contour1.png", height=4, width = 4)

p + geom_density_2d(size=1) +
  geom_point() +
  labs(x = "Waiting time", y = "Eruption time") +
  theme_bw(base_size = 16)
ggsave("gg-contour1a.png", height=4, width = 4)



ggplot(faithful, aes(waiting, eruptions)) +
  geom_density_2d_filled(show.legend = FALSE) +
  labs(x = "Waiting time", y = "Eruption time") +
  theme_bw()

p + geom_density_2d_filled(show.legend = FALSE) +
    labs(x = "Waiting time", y = "Eruption time") +
    theme_bw()

ggsave("gg-contour2.png", height=4, width = 4)

# or hex bins
ggplot(faithful, aes(waiting, eruptions)) +
  geom_hex(bins=30, color="gray") +
  scale_fill_viridis_c(direction = -1) +
  labs(x = "Waiting time", y = "Eruption time") +
  theme_bw()
ggsave("gg-contour3.png", height=4, width = 4)

p + geom_hex(bins=30, color="gray", show.legend = FALSE) +
  scale_fill_viridis_c(direction = -1) +
  labs(x = "Waiting time", y = "Eruption time") +
  theme_bw()


install.packages("ggalt")
library(ggalt)

m <- ggplot(faithful, aes(x = eruptions, y = waiting)) +
  geom_point() +
  xlim(0.5, 6) +
  ylim(40, 110)

m + geom_bkde2d(bandwidth=c(0.5, 4))

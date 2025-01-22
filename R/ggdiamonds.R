library(ggplot2)
ggdiamonds = ggplot(diamonds, aes(x, depth)) +
  stat_density_2d(aes(fill = stat(nlevel)), geom = "polygon", n = 200, bins = 50,contour = TRUE) +
  facet_wrap(clarity~.) +
  scale_fill_viridis_c(option = "A")

ggdiamonds

ggsave("ggdiamonds.png")
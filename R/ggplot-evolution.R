#' ---
#' title: Evolution of a ggplot
#' ---

## packages
library(tidyverse)
library(ggsci)
library(showtext)

## load fonts
font_add_google("Poppins", "Poppins")
font_add_google("Roboto Mono", "Roboto Mono")
showtext_auto()

## get data
devtools::source_gist("https://gist.github.com/Z3tt/301bb0c7e3565111770121af2bd60c11")

## tile map as legend
map_regions <-
  df_ratios %>%
  mutate(region = fct_reorder(region, -student_ratio_region)) %>%
  ggplot(aes(x = x, y = y, fill = region, color = region)) +
  geom_tile(color = "white") +
  scale_y_reverse() +
  scale_fill_uchicago(guide = "none") +
  coord_equal() +
  theme_light() +
  theme(
    line = element_blank(),
    panel.background = element_rect(fill = "transparent"),
    plot.background = element_rect(fill = "transparent",
                                   color = "transparent"),
    panel.border = element_rect(color = "transparent"),
    strip.background = element_rect(color = "gray20"),
    axis.text = element_blank(),
    plot.margin = margin(0, 0, 0, 0)
  ) +
  labs(x = NULL, y = NULL)

## calculate worldwide average
world_avg <-
  df_ratios %>%
  summarize(avg = mean(student_ratio, na.rm = TRUE)) %>%
  pull(avg)

## coordinates for arrows
arrows <-
  tibble(
    x1 = c(6, 3.65, 1.8, 1.8, 1.8),
    x2 = c(5.6, 4, 2.18, 2.76, 0.9),
    y1 = c(world_avg + 6, 10.5, 9, 9, 77),
    y2 = c(world_avg + 0.1, 18.4, 14.16, 12, 83.42)
  )

## final plot
## set seed to fix position of jittered points
set.seed(2019)

## final plot
df_ratios %>%
  mutate(region = fct_reorder(region, -student_ratio_region)) %>%
  ggplot(aes(x = region, y = student_ratio, color = region)) +
  geom_segment(
    aes(x = region, xend = region,
        y = world_avg, yend = student_ratio_region),
    size = 0.8
  ) +
  geom_hline(aes(yintercept = world_avg), color = "gray70", size = 0.6) +
  stat_summary(fun = mean, geom = "point", size = 5) +
  geom_jitter(size = 2, alpha = 0.25, width = 0.2) +
  coord_flip() +
  annotate(
    "text", x = 6.3, y = 35, family = "Poppins",
    size = 2.7, color = "gray20",
    label = glue::glue("Worldwide average:\n{round(world_avg, 1)} students per teacher")
  ) +
  annotate(
    "text", x = 3.5, y = 10, family = "Poppins",
    size = 2.7, color = "gray20",
    label = "Continental average"
  ) +
  annotate(
    "text", x = 1.7, y = 11, family = "Poppins",
    size = 2.7, color = "gray20",
    label = "Countries per continent"
  ) +
  annotate(
    "text", x = 1.9, y = 64, family = "Poppins",
    size = 2.7, color = "gray20",
    label = "The Central African Republic has by far\nthe most students per teacher"
  ) +
  geom_curve(
    data = arrows, aes(x = x1, xend = x2,
                       y = y1, yend = y2),
    arrow = arrow(length = unit(0.08, "inch")), size = 0.5,
    color = "gray20", curvature = -0.3#
  ) +
  annotation_custom(
    ggplotGrob(map_regions),
    xmin = 2.5, xmax = 7.5, ymin = 52, ymax = 82
  ) +
  scale_y_continuous(
    limits = c(1, NA), expand = c(0.02, 0.02),
    breaks = c(1, seq(20, 80, by = 20))
  ) +
  scale_color_uchicago() +
  labs(
    x = NULL, y = "Student to teacher ratio",
    caption = 'Data: UNESCO Institute for Statistics'
  ) +
  theme_light(base_size = 18, base_family = "Poppins") +
  theme(
    legend.position = "none",
    axis.title = element_text(size = 12),
    axis.text.x = element_text(family = "Roboto Mono", size = 10),
    plot.caption = element_text(size = 9, color = "gray50"),
    panel.grid = element_blank()
  )
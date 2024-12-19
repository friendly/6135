#===============================================================================
# 2024-12-12 -- blog
# Rotate the damn plot
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#===============================================================================

# The original plot
# https://www.linkedin.com/feed/update/urn:li:activity:7271909125997924353/


library(tidyverse)

# Points digitized manually using
# https://web.eecs.utk.edu/~dcostine/personal/PowerDeviceLib/DigiTest/index.html
digi <- read_csv(
    "https://gist.githubusercontent.com/ikashnitsky/8cc26eab8165b0b79f67da761aa66a1e/raw/8d44c9e6ddea51de3cbb0fdb742fb75a62a307fd/data.csv",
    col_names = c("x", "happiness")
)

# get all combinations of the categories and attach the digitized data
df <- crossing(
    country = c("United Kingdom", "Estonia", "Denmark", "Netherlands", "Czech Republic", "Finland", "Austria") |> as_factor(),
    group = c("18-29", "30-39", "40-49", "50-59", "Total")
) |>
    mutate(happiness = digi |> pull(happiness))

# recreate the plot

df |>
    ggplot(aes(x = country, y = happiness, fill = group))+
    geom_col(position = position_dodge()) +
    labs(
        x = NULL,
        y = NULL,
        fill = NULL
    ) +
    coord_cartesian(ylim = c(6, NA), expand = 0)+
    scale_fill_manual(values = c("#2f74cc", "#ff7502", "#a3d384", "#ffbc00", "#908d90"))+
    theme_minimal()+
    theme(
        legend.position = "bottom",
        panel.grid.minor = element_blank()
    )

# custom theming
# devtools::source_gist("653e1040a07364ae82b1bb312501a184")
# sysfonts::font_add_google("Atkinson Hyperlegible", family = "ah")
# theme_set(theme_ik(base_family = "ah"))


# Create the plot
df |>
    ggplot(aes(y = country, x = happiness, color = group))+
    geom_point(size = 2) +
    labs(
        title = "How happy are you with your home?",
        subtitle = "Happiness scores from Generations and Gender Programme surveys\non a scale of 0 to 10",
        x = NULL,
        y = NULL,
        color = "Age group"
    ) +
    scale_color_manual(values = c("#2f74cc", "#ff7502", "#a3d384", "#ffbc00", "#908d90"))+
    theme(
        legend.position = "bottom",
        panel.grid.minor.x = element_blank()
    )+
    scale_x_continuous(position = "top")

# join the points by group
df |>
  ggplot(aes(y = country, x = happiness, color = group, group = group))+
  geom_point(size = 2) +
  geom_line() +
  labs(
    title = "How happy are you with your home?",
    subtitle = "Happiness scores from Generations and Gender Programme surveys\non a scale of 0 to 10",
    x = NULL,
    y = NULL,
    color = "Age group"
  ) +
  scale_color_manual(values = c("#2f74cc", "#ff7502", "#a3d384", "#ffbc00", "#908d90"))+
  theme(
    legend.position = "bottom",
    panel.grid.minor.x = element_blank()
  )+
  scale_x_continuous(position = "top")

library(twoway)
library(tidyr)

happy.mod <- lm(happiness ~ country + group, data=df)
anova(happy.mod)

# Tukey test: see https://rpubs.com/wgalvord/335035

#anova(lm(happiness ~ country * group, data=df))


happy.tab <- df %>% 
  pivot_wider(names_from = group, values_from = happiness) |>
  as.data.frame()

happy.mat <- as.matrix(happy.tab[, -1])
rownames(happy.mat) <- happy.tab[, 1]
happy.mat

happy.tway <- twoway(happy.mat, 
                     responseName = "happiness",
                     method = "mean") |> 
  print(digits = 4)

plot(happy.tway)

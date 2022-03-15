
# broom & dplyr: https://cran.r-project.org/web/packages/broom/vignettes/broom_and_dplyr.html
# -- nest -> map -> unnest

regressions <- mtcars %>%
  nest(data = -am) %>% 
  mutate(
    fit = map(data, ~ lm(wt ~ mpg + qsec + gear, data = .x)),
    tidied = map(fit, tidy),
    glanced = map(fit, glance),
    augmented = map(fit, augment)
  )

regressions %>% 
  unnest(tidied)

regressions %>% 
  unnest(glanced)

regressions %>% 
  unnest(augmented)

#' ---
#' title: "Bootstrap demonstration"
#' author: "Michael Friendly"
#' date: "05 Mar 2022"
#' ---


library(ggplot2)
library(dplyr)
library(gganimate)
if (!require(ungeviz)) devtools::install_github("wilkelab/ungeviz")
library(ungeviz)       

# create a function to generate 3 bootstrap samples of its argument
bs <- bootstrapper(3)
(draws <- bs(data.frame(letter = LETTERS[1:4])))

setwd(here::here("images", "bootstrap"))

theme_set(theme_bw(base_size=18))

ggplot(draws, aes(x=.draw, y=letter)) +
  geom_tile(fill="pink", alpha=0.3) +
  geom_text(aes(label=.copies), size=6)

ggsave("letter-draws.png", w = 4, h=4)

# do again with more draws & letters
bs2 <- bootstrapper(5)
(draws2 <- bs2(data.frame(letter = LETTERS[1:5])))
ggplot(draws2, aes(x=.draw, y=letter)) +
  geom_tile(fill="pink", alpha=0.3) +
  geom_text(aes(label=.copies), size=6)

ggsave("letter-draws2.png", w = 4, h=4)


# randomly generate dataset
set.seed(12345)
x <- rnorm(15)
df <- data.frame(x, y = x + 0.5*rnorm(15))

# bootstrapper object
bsr <- bootstrapper(10)

anim <-
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

anim_save("boot-reg-demo.gif", anim, nframes=20, fps = 3,
          start_pause = 3, end_pause = 3, rewind=FALSE)



# mtcars data

library(glue)
bsr <- bootstrapper(25)
anim <-
ggplot(data = mtcars, aes(wt, mpg)) +
  geom_smooth(method = "lm", formula = y~x, color = gray(.5)) +
  geom_point(size = 3, alpha = 0.3) +
  # `.row` is a generated column providing a unique row number for all rows
  geom_point(data = bsr, aes(group = .row), size = 4, color="red") +
  geom_smooth(data = bsr, method = "lm", formula = y~x, 
              fullrange = TRUE, se = FALSE, color = "red") +
  # geom_text(data=bsr, aes(x = 4.5, y= 30, 
  #                         label=paste("Draw:", round(.draw))
  #                         ), size=8
  #           ) +
  ggtitle("Draw {closest_state}") +
# animation
  theme_bw(base_size=16) +
  labs(x = "Weight", y = "Miles per Gallon") + 
  transition_states(.draw, 1, state_length = 2 ) + 
  enter_fade() + exit_fade()
  
animate(anim, nframes = 25, fps = 3, start_pause = 3, end_pause = 3)

anim_save("boot-reg-mtcars.gif", anim, nframes=20, fps = 3,
          start_pause = 3, end_pause = 3, rewind=FALSE)

  

#  smooth draws
plt <-
ggplot(mtcars, aes(hp, mpg)) + 
  geom_point(size = 2) +
  stat_smooth_draws(times = 20, aes(group = stat(.draw))) + 
  theme_bw() 

plt +
  transition_states(stat(.draw), 1, 2) +
  enter_fade() + exit_fade()


# try to fit models
library(dplyr)
library(broom)
library(ungeviz)
bsr <- bootstrapper(25)
models <- bsr(mtcars) %>%
  group_by(.draw) %>%
  summarise(b0 = coef(lm(mpg ~ hp, data = .))[1],
            b1 = coef(lm(mpg ~ hp, data = .))[2]) %>%
  ungroup()


  # mutate(mod = lm(mpg ~ hp, data = .),
  #        coef_info = coef(mod))

models %>% select(mod) %>% glance()

boot_models <-
  boots %>% 
  mutate(model = map(splits, fit_nls_on_bootstrap),
         coef_info = map(model, tidy))





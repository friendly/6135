#' ---
#' title: "gapminder data: Using broom for tidy model visualization"
#' author: "Michael Friendly"
#' date: "03 Apr 2018"
#' ---

#' ## load packages
library(dplyr)
library(ggplot2)
library(gapminder)
library(broom)
library(effects)

library(here)
setwd(here("images", "ggplot2"))

#' ## fit a main effects model for life expectancy
gapmod <- lm(lifeExp ~ year + pop + log(gdpPercap) + continent, data=gapminder)
summary(gapmod)

#' ## A more compact & tidy summary
glance(gapmod)

#' tidy() gives the model term statistics
tidy(gapmod)

#' ## plot the predicted effects for the model terms
plot(allEffects(gapmod))

#' #' ## now, separate models for continents
#' models <- gapminder %>%
#' 	filter(continent != "Oceania") %>%
#' 	group_by(continent) %>%
#' 	do(mod = lm(lifeExp ~ year + pop + log(gdpPercap), 
#' 	            data=.)
#' 	  )
#' 
#' #' what is our models object?
#' models
#' 
#' #' ## view model summary statistics
#' models %>% glance(mod)

#' #' ## plot R^2 values
#' 
#' models %>%
#' 	glance(mod) %>%
#' 	ggplot(aes(r.squared, reorder(continent, r.squared))) +
#' 		geom_point(size=4) +
#' 		geom_segment(aes(xend = 0, yend = ..y..)) +
#' 		ylab("Continent") 
#' 
#' #' same, but connect points with lines
#' gg <- 
#'   models %>%
#'   glance(mod) %>%
#'   mutate(group = 1) %>% 
#'   ggplot(aes(r.squared, reorder(continent, r.squared), group = group) ) +
#'   geom_line() + 
#'   geom_point(size=4) +
#'   ylab("Continent") 
#' gg
		 

#' #' ## get coefficients for each model		
#' models %>% tidy(mod)
#' 
#' # extract coefficients for year
#' models %>% tidy(mod) %>%
#' 	filter(term=="year")
#' 
#' #' ## plot t statistics 
#' 
#' models %>% tidy(mod) %>%
#' 	filter(term != "(Intercept)") %>% 
#' 	mutate(term=factor(term, levels=c("log(gdpPercap)", "year", "pop"))) %>%
#' 	ggplot(aes(x=term, y=statistic, color=continent, group=continent)) + 
#' 		geom_point(size=5, alpha=0.5) +
#' 		geom_line(size=1.5) +
#' 		geom_hline(yintercept=c(-2, 0, 2), 
#' 		           color = c("red", "black", "red")) +
#' 		ylab("t statistic") +
#' 		theme_minimal() + theme(legend.position=c(0.9, 0.8))
#' 

## -------------------- try nest - map - unnest --------------

models <- gapminder %>%
  filter(continent != "Oceania") %>%
  nest(data = -continent) %>%
  mutate(
    fit = map(data, ~ lm(lifeExp ~ year + pop + log(gdpPercap), data = .x)),
    tidied = map(fit, tidy),
    glanced = map(fit, glance),
    augmented = map(fit, augment)
  )


models %>% 
  select(continent, tidied) %>%
  unnest(tidied)

models %>% 
  unnest(glanced)

# just select one component
#' model coefficients
models %>% 
  select(continent, glanced) %>%
  unnest(glanced)


models %>% 
  select(continent, augmented) %>%
  unnest(augmented)

	
#' ## plot R^2 values

models %>%
  select(continent, glanced) %>%
  unnest(glanced) %>%
  ggplot(aes(r.squared, reorder(continent, r.squared))) +
  geom_point(size=5) +
  geom_segment(aes(xend = 0, yend = ..y..), size = 2) +
  ylab("Continent") 

ggsave("gapminder-rsquared.png", height = 4, width = 2 * 4)


#' same, but connect points with lines
models %>%
  select(continent, glanced) %>%
  unnest(glanced) %>%
  mutate(group = 1) %>% 
  ggplot(aes(r.squared, reorder(continent, r.squared), group = group) ) +
  geom_line() + 
  geom_point(size=4) +
  geom_segment(aes(xend = 0, yend = ..y..)) +
  ylab("Continent") 


#' ## get coefficients for each model		
models %>% 
  select(continent, tidied) %>%
  unnest(tidied)

# extract coefficients for year
models %>% 
  select(continent, tidied) %>%
  unnest(tidied) %>%
  filter(term=="year")

#' ## plot t statistics 

models %>%  select(continent, tidied) %>% unnest(tidied) %>%
  filter(term != "(Intercept)") %>% 
  mutate(term=factor(term, levels=c("log(gdpPercap)", "year", "pop"))) %>%
  ggplot(aes(x=term, y=statistic, color=continent, group=continent)) + 
  geom_point(size=5, alpha=0.5) +
  geom_line(size=1.5) +
  geom_hline(yintercept=c(-2, 0, 2), 
             color = c("red", "black", "red"),
             size = 1.1) +
  ylab("t statistic") +
  theme_minimal(base_size = 18) + theme(legend.position=c(0.9, 0.8))
ggsave("gapminder-tstats2.png", height = 4, width = 4 * 1.7)

#' ## plot fitted values
models %>%  select(continent, augmented) %>% unnest(augmented) %>%
  ggplot(aes(x=`log(gdpPercap)`, y=.fitted, color=continent, fill=continent)) + 
  geom_point(size = 0.7, alpha=0.6) +
  geom_smooth(method = "lm", formula = y~x, alpha=0.5) +
  ylab("Fitted Life Expectancy") +
  theme(legend.position=c(0.18, 0.78))

ggsave("gapminder-fitted.png", height = 4.5, width = 5)




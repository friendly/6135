library(gapminder)
library(ggplot2)
library(gganimate)
library(dplyr)
library(here)

options(gganimate.nframes = 25)

path <- here(file.path("images", "ggplot2"))

anim <-
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, 
                      size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 15)) +
  scale_x_log10(labels = scales::comma) +
  theme_bw() + 
  theme(legend.position = "none",
        plot.title = element_text(size = 25),
        axis.title = element_text(size = 20 )) +

  # Here comes the gganimate specific bits
#  geom_text(aes(x=4000, y=40, label=round(year)), colour="lightgrey", alpha=0.5, size = 40) +
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  ease_aes('linear')

animate(anim, nframes=55, fps = 3, start_pause = 3, end_pause = 3, rewind=FALSE)
filename <- file.path(path, "gap-bubble1.gif") 
anim_save(filename, anim, nframes=55, fps = 3,
          start_pause = 3, end_pause = 3, rewind=FALSE)



#######################
# from: https://www.ddrive.no/post/gganimate-your-hex/

library(gapminder)
library(tidyverse)
library(ggrepel)
library(hrbrthemes)

lbl_countries <- c("Congo, Dem. Rep.", "China", "Japan", "United States", "South Africa")
gapminder2007 <- gapminder %>% filter(year==2007) 

gapminder2007 %>% 
  ggplot(aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  annotate("text", x=4000, y=65, label="2007", size=50, colour="lightgrey", alpha=0.5)+
  geom_point(alpha = 0.7, show.legend = FALSE) +
  geom_label_repel(data=filter(gapminder2007, country %in% lbl_countries), 
                   aes(gdpPercap, lifeExp, label=country), inherit.aes = FALSE)+
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10(minor_breaks=rep(1:9, 21)*(10^rep(-10:10, each=9))) +
#  theme_bw(grid_col = "grey90", axis_title_just = 'm')+
  labs( x = 'GDP per capita', y = 'life expectancy')

#########################
# Animate density plot

# https://stackoverflow.com/questions/61276499/r-gganimate-with-geom-density

p <- gapminder::gapminder %>% 
  ggplot(aes(lifeExp, fill = factor(year))) + 
  geom_density(alpha=.2) + 
  xlab("Life Expectancy") + 
  ylab("Kernal density") +
  guides(fill = guide_legend(title = "Year"))

p + 
  transition_time(year) + 
  ease_aes('linear')

path <- here(file.path("images", "ggplot2"))
ggsave(file.path(path, "gap-density.png"), plot=p, height = 4, width = 4 )

anim <-
  p + 
  transition_time(year) + 
  ease_aes('linear')

animate(anim, nframes=20, fps = 4, start_pause = 3, end_pause = 3, rewind=FALSE)

anim_save(file.path(path, "gap-density-gganim-1.gif" ), anim, nframes=20, fps = 3,
          start_pause = 3, end_pause = 3, rewind=FALSE)

# save individual frames
animate(anim, nframes = 20, device = "png",
        renderer = file_renderer("C:/temp/gganimate", prefix = "gganim_gap", overwrite = TRUE))


### or, ggridges

ggplot(chic, aes(x = temp, y = factor(year), fill = year)) +
  geom_density_ridges(alpha = .8, color = "white",
                      scale = 2.5, rel_min_height = .01) +
  labs(x = "Temperature (°F)", y = "Year") +
  guides(fill = FALSE) +
  theme_ridges()

library(ggridges)

gapminder::gapminder %>% 
  ggplot(aes(lifeExp, y = factor(year), fill=year)) + 
  geom_density_ridges(alpha = .6, color = "white",
                      scale = 2.5, rel_min_height = .01) +
  
  xlab("Life Expectancy") + 
  ylab("Year") +
  guides(fill = "none") +
  theme_ridges()

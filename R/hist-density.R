
# Histograms & Density curves

library(gapminder)
library(ggplot2)
library(patchwork)
library(dplyr)

library(here)
setwd(here("images", "uncertainty"))

theme_set(theme_gray(base_size=16))


gapminder_2002 <- gapminder %>%
  filter(year == 2002)

ggplot(gapminder_2002,
       aes(x = lifeExp)) +
  geom_histogram()

ggsave("histogram0.png", width=5, height=5)

# vary binwidth
p0 <- ggplot(gapminder_2002,
             aes(x = lifeExp)) 

  
p1 <- p0 +
  geom_histogram(binwidth = 0.5) +
  ggtitle("binwidth = 0.5")
p1

p2 <- p0 +
  geom_histogram(binwidth = 25) +
  ggtitle("binwidth = 25")
p2

p3 <- p0 +
  geom_histogram(binwidth = 2) +
  ggtitle("binwidth = 2")
p3



p1 + p3 + p2
ggsave("hist-dens1.png", width=9, height=3.5)

# make prettier
p4 <- p0 + geom_histogram(binwidth = 5, color="white") 
p4 <- p4 + ggtitle('color = "white"')

# change boundaries
p5 <- p0 + geom_histogram(binwidth = 5, color="white", boundary=50) 
p5 <- p5 + ggtitle('boundary = 50')

p4 + p5
ggsave("hist-dens2.png", width=8, height=4)

#' ## density plots
#' 

# illustrate kernel densities (animation)

ph <-
ggplot(gapminder_2002,
       aes(x = lifeExp)) +
  geom_density(fill="pink", alpha = 0.5, size=1.1) + 
  geom_rug()


set.seed(42)
xs <- sample_n(gapminder_2002, 10)$lifeExp
h <- 2


for(xi in seq_along(xs)) {
  ph <- ph + geom_function(fun=function(x) 5*dnorm(x, mean=xi, sd=h), 
                           color="red")
}
ph

ph + geom_function(dnorm(mean=45, sd=2), color="red")

dnorms <- stat_function(fun = dmean)

p6 <- p0 + geom_density(fill="pink", alpha = 0.5, size=1.1)
p6
ggsave("hist-dens3.png", width=5, height=5)

p6t <- p6 + ggtitle('bw = "nrd0" (default: 4.1)')

p7 <- p0 + geom_density(fill="pink", alpha = 0.5, size=1.1, bw = 1) +
  ggtitle("bw = 1")

p8 <- p0 + geom_density(fill="pink", alpha = 0.5, size=1.1, bw = 8) +
  ggtitle("bw = 8")

p7 + p6t + p8
ggsave("hist-dens4.png", width=9, height=3.5)


# what is the default?
bw.nrd0(gapminder_2002$lifeExp)
# [1] 4.101823

# comparative densities
gap_2002c <-
  gapminder_2002 %>%
  filter(continent != "Oceania")

ggplot(gap_2002c,
       aes(x = lifeExp,
           fill = continent)) +
  geom_density(alpha = 0.5) +
  theme(legend.position = c(.2, .7))

ggsave("hist-dens5.png", width=5, height=5)

ggplot(gap_2002c,
       aes(x = lifeExp,
           fill = continent)) +
  geom_density(alpha = 0.5) +
  facet_wrap(~ continent) +
  theme(legend.position = "none")

ggsave("hist-dens6.png", width=5, height=5)



library(ggridges)

gap_2002c <-
  gapminder_2002 %>%
  filter(continent != "Oceania")

ggplot(gap_2002c,
       aes(x=lifeExp, y=continent, fill=continent)) +
  geom_density_ridges(
    alpha = 0.5,
    jittered_points=TRUE) +
  theme(legend.position = "none")

ggsave("hist-dens7.png", width=5, height=5)

  

library(ggdist)

ggplot(gapminder_2002,
       aes(x = lifeExp)) +
  geom_dotsinterval(fill="pink") +
  stat_halfeye(alpha = .5, size=20)


ggplot(gap_2002c,
       aes(x=lifeExp, y=continent, fill=continent)) +
  stat_halfeye(alpha=0.5, size = 10) +
#  stat_interval() +
  theme(legend.position = "none")

# boxplots

ggplot(gap_2002c,
       aes(x=lifeExp, y=continent, fill=continent)) +
  geom_boxplot(alpha = 0.2) +
  theme(legend.position = "none")
ggsave("hist-box1.png", width=5, height=5)

ggplot(gap_2002c,
       aes(x=lifeExp, y=continent, fill=continent)) +
  geom_boxplot(alpha = 0.2) +
  geom_point(aes(color = continent), size = 3, position = position_jitter(height=0.1)) +
  theme(legend.position = "none")

ggsave("hist-box2.png", width=5, height=5)




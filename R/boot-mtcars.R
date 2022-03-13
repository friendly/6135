
# Bootstrap resampling and tidy regression models
# From: https://www.tidymodels.org/learn/statistics/bootstrap/

library(tidymodels)
library(ggplot2)
library(glue)

#library(nls2)

# set relative path for images
#path <- here()
setwd(here::here("images", "bootstrap"))


theme_set(theme_bw(base_size=18))

plt <-
ggplot(mtcars, aes(x=wt, y=mpg)) + 
    geom_point(size=2) +
    labs(x = "Weight", y = "Miles per gallon")
plt
ggsave("boot-mtcars1.png", height = 5, width = 5)

plt +
  geom_smooth(method = "loess", formula = y~x, 
              color="blue", fill="blue", alpha=0.2) 
  # geom_smooth(method = "lm",    formula = y~x, 
  #             color="red", se = FALSE ) 
ggsave("boot-mtcars2a.png", height = 5, width = 5)


#   
nlsfit <- nls(mpg ~ k / wt + b, mtcars, start = list(k = 1, b = 0))
summary(nlsfit)
#> 
#> Formula: mpg ~ k/wt + b
#> 
#> Parameters:
#>   Estimate Std. Error t value Pr(>|t|)    
#> k    45.83       4.25   10.79  7.6e-12 ***
#> b     4.39       1.54    2.85   0.0077 ** 
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 2.77 on 30 degrees of freedom
#> 
#> Number of iterations to convergence: 1 
#> Achieved convergence tolerance: 2.88e-08

#' Plot predicted curve

coeflab <- paste("Coefficients:\n",
                  "k =", round(coef(nlsfit)[1], 1), "\n",
                  "b =", round(coef(nlsfit)[2], 1))
plt +
    geom_line(aes(y = predict(nlsfit)), lwd=2, color="red") +
    annotate("text", x=5, y = 30, label= coeflab, size=5) 
ggsave("boot-mtcars3a.png", height = 5, width = 5)


#' ## Sidebar: Graphing parametric curves

df <- expand_grid(b = -1:4, k = seq(40,60,10))

nlfun <- function(x, b, k) {k / x + b}


#basic plot, fixed parameter a = b=0, k=50
p = ggplot(data.frame(x = c(1,6)), aes(x))
p + stat_function(fun=function(x) { nlfun(x, 0, 50) } )

# parametric plotting
nlfun.parametric = function(b,k){
  function(x) {nlfun(x, b, k)}  
}

# define a parametric stat_function for plotting
fun.plot.parametric = function(b, k) {
  stat_function(fun=nlfun.parametric(b, k)) 
  }

# one parameter b=seq(0, 8, 2)
bvals <- seq(0, 8, by = 2)
fun.plot.family=sapply(bvals, 
                       function(b){b=b; fun.plot.parametric(b, 50)})

pltb = ggplot(data.frame(x = c(1, 6)), aes(x))
for(curve in fun.plot.family) { pltb = pltb + curve}
pltb

curlab <- data.frame(x=6, b = bvals, y = nlfun(6, bvals, 50))

pltb + geom_text(data = curlab, aes(x=x, y=y, label=b), size = 4, hjust=-.5) +
  annotate("text", x=6, y=20, label="b", size = 6 )
ggsave("nlsfun-b.png", height = 5, width = 5)

#--------------
# one parameter k=seq(0, 8, 2)
kvals <- seq(30, 60, by = 10)
fun.plot.family=sapply(kvals, 
                       function(k){k=k; fun.plot.parametric(4, k)})

pltk = ggplot(data.frame(x = c(1, 6)), aes(x))
for(curve in fun.plot.family) { pltk = pltk + curve}
pltk

curlab <- data.frame(x=1, k = kvals, y = nlfun(1, 4, kvals))

pltk + geom_text(data = curlab, aes(x=x, y=y, label=k), size = 4, hjust=.5) +
  annotate("text", x=1, y=25, label="k", size = 6 )
ggsave("nlsfun-k.png", height = 5, width = 5)


# or,

parm <- list( list(0, 30), list(0, 40), list(0, 50) )
ggplot(data.frame(x = 1:6), aes(x)) + 
  Map(function(params, name){stat_function(mapping = aes_(color = name), 
                                           fun = nlfun, args = params)}, 
      params = parm, 
      name = paste('k', seq_along(parm))) +
  theme(legend.position = c(.8, .8))

  
aa <- list(list(0.2, 0.1), list(0.7, 0.05), list(0.45, 0.2))
ggplot(data.frame(x = 0:1), aes(x)) + 
  Map(function(params, name){stat_function(mapping = aes_(color = name), 
                                           fun = dnorm, args = params)}, 
      params = aa, 
      name = paste('Group', seq_along(aa)))





#' ## bootstrap
library(rsample)

# We can use the bootstraps() function in the rsample package to sample bootstrap replications. First, we construct 2000 bootstrap replicates of the data, each of which has been randomly sampled with replacement. The resulting object is an rset, which is a data frame with a column of rsplit objects.

set.seed(27)
boots <- bootstraps(mtcars, times = 500)
boots

# Let?s create a helper function to fit an nls() model on each bootstrap sample, and then use purrr::map() to apply this function to all the bootstrap samples at once. Similarly, we create a column of tidy coefficient information by unnesting.

fit_nls_on_bootstrap <- function(split) {
    nls(mpg ~ k / wt + b, analysis(split), start = list(k = 1, b = 0))
}


boot_models <-
  boots %>% 
  mutate(model = map(splits, fit_nls_on_bootstrap),
         coef_info = map(model, tidy))

# The unnested coefficient information contains a summary of each replication combined in a single data frame:
boot_coefs <- 
  boot_models %>% 
  unnest(coef_info)

#We can then calculate confidence intervals (using what is called the percentile method):

pct_intervals <- int_pctl(boot_models, coef_info)


# distribution of coefficients
ggplot(boot_coefs, aes(estimate)) +
  geom_histogram(aes(y = ..density..), 
                 bins = 30, fill="pink", color="gray") +
  geom_density(size = 1.2) +
  facet_wrap( ~ term, scales = "free") +
  geom_vline(aes(xintercept = .estimate), data = pct_intervals, col = "blue", size=1) +
  geom_vline(aes(xintercept = .lower),    data = pct_intervals, col = "blue") +
  geom_vline(aes(xintercept = .upper),    data = pct_intervals, col = "blue")

ggsave("boot-mtcars-coef.png", height = 5, width = 7)

#' ## fancy scatterplot of coefs

#' Steps:
#' 1. coefs -> wide to plot k ~ b
#' 2. find means & se of b & k
#' 3. ellipse: stat_ellipse
#' 4. errorbar & errorbarh

#' 1
boot_coefs_wide <- boot_coefs %>% 
  select(id, term, estimate) %>%
  tidyr::pivot_wider(
    names_from = term, 
    values_from=estimate) 
boot_coefs_wide


#' 2. get means and se

mean_se <- boot_coefs_wide %>%
  summarise(
    sk = sd(k), 
    sb = sd(b),
    k = mean(k),
    b = mean(b)
    )
print(mean_se, digits=4)

#' Plot
plt_bk <-
boot_coefs_wide %>%
  ggplot(aes(b, k)) +
    stat_ellipse(level = .95,
                 geom = "polygon", alpha = 0.15,
                 fill = "blue", color = "blue", size=1) +
    geom_point(color = "red", size=2, alpha=0.4) 

plt_bk2 <-
plt_bk +
    geom_errorbar(data = mean_se,
               aes(ymin = k - sk, 
                   ymax = k + sk, x = b), width=0.4, size=2) + 
    geom_errorbarh(data = mean_se,
               aes(xmin = b - sb, 
                   xmax = b + sb, y = k), size=2) + 
    geom_errorbar(data = mean_se,
               aes(ymin = k - 2*sk, 
                   ymax = k + 2*sk, x = b), width=0.6, size=1, color=gray(.5)) + 
    geom_errorbarh(data = mean_se,
               aes(xmin = b - 2*sb, 
                   xmax = b + 2*sb, y = k), size=1, color = gray(.5)) 
plt_bk2  
ggsave("boot-mtcars-coef2.png", height = 5, width = 5)

# animate this?

library(gganimate)
anim <-
plt_bk2 +
  transition_layers(from_blank=FALSE) +
  enter_fade() + exit_fade()

animate(anim, nframes=40, fps = 3,
        start_pause = 3, end_pause = 3, rewind=FALSE)

anim_save("boot-mtcars-coef.gif", anim, nframes=40, fps = 3,
          start_pause = 3, end_pause = 3, rewind=FALSE)

  


# We can use augment() to visualize the uncertainty in the fitted curve. 
# Since there are so many bootstrap samples, we’ll only show a sample of the model fits in our visualization:
  
boot_aug <- 
  boot_models %>% 
  sample_n(200) %>% 
  mutate(augmented = map(model, augment)) %>% 
  unnest(augmented)

ggplot(boot_aug, aes(wt, mpg)) +
  geom_line(aes(y = .fitted, group = id), alpha = .1, col = "blue") +
  geom_line(data=mtcars, aes(x = wt, y = predict(nlsfit)), lwd=1.2, color="red") +
  geom_point() +
  labs(x = "Weight", y = "Miles per gallon")


ggsave("boot-mtcars-fits.png", height = 5, width = 5)

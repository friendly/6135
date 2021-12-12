# chonch pies vs. granola bars

dat <- read.csv(textConnection("
species,choice,count
shark,pie,45
shark,bar,4
shark,diver,1
turtle,pie,3
turtle,bar,47
turtle,diver,0
"))

# reorder choice factor levels
dat$choice <- factor(dat$choice, levels=c("pie", "bar", "diver"))

library(ggplot2)

p1 <-
ggplot(dat, aes(x=choice, y=count, group=species)) +
	geom_line(aes(color=species), size=1.5) +
	geom_point(aes(color=species, shape=species), size=3) +
	scale_y_sqrt() +
	theme_bw() +
	theme(legend.position=c(.8, .8),
	      legend.text = element_text(size = 18),
	      legend.title = element_text(size = 18),
	      axis.title = element_text(size = 16),
	      axis.text = element_text(size = 14),
	      ) +
	 ylab("count (sqrt scale)")

p2 <-	
ggplot(dat, aes(x=choice, y=count, group=species)) +
	geom_col(aes(color=species, fill=species), position=position_dodge()) +
	scale_y_sqrt(breaks=c(1, 2,5, seq(10,50,10))) +
	theme_bw() +
	theme(legend.position=c(.8, .8),
	      legend.text = element_text(size = 18),
	      legend.title = element_text(size = 18),
	      axis.title = element_text(size = 16),
	      axis.text = element_text(size = 14),
	      ) +
	 ylab("count (sqrt scale)")

p3 <-	
ggplot(dat, aes(x=species, y=count, group=choice)) +
	geom_col(aes(color=choice, fill=choice), position=position_dodge()) +
	scale_y_sqrt(breaks=c(1,2,5, seq(10,50,10))) +
	theme_bw() +
	theme(legend.position=c(.9, .8),
	      legend.text = element_text(size = 18),
	      legend.title = element_text(size = 18),
	      axis.title = element_text(size = 16),
	      axis.text = element_text(size = 14),
	      ) +
	 ylab("count (sqrt scale)")

p2 + coord_polar() +
		theme(legend.position=c(.9, .2))

p3 + coord_polar() +
		theme(legend.position=c(.9, .2))
		
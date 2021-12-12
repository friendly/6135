library(dplyr)
library(ggplot2)
library(lattice)

nasafile <- 'http://eosweb.larc.nasa.gov/sse/global/text/global_radiation'
nasa <- read.table(file=nasafile, skip=13, header=TRUE)

bwplot(Ann ~ cut(Lat, pretty(Lat, 20)),
 data=nasa, subset=(abs(Lat)<60),
 xlab='Latitude', ylab='Solar radiation G(0) (kWh/m²)')

nasa %>%
	filter(abs(Lat) < 60) %>%
	mutate(Latf = cut(Lat, pretty(Lat, n=10))) %>%
	ggplot(aes(x=Latf, y=Ann)) +
		geom_violin(fill="pink", alpha=0.3) +
		labs(x="Latitude", y="Solar radiation G(0) (kWh/m²)")


nasa_long <- nasa %>%
	select(-Ann) %>%
	gather(month, solar, Jan:Dec, factor_key=TRUE) %>%
	filter( abs(Lat) < 60 ) %>%
	mutate( Lat_f = cut(Lat, pretty(Lat, 12)))

str(nasa_long)

ggplot(nasa_long, aes(x=Lat_f, y=solar)) +
	geom_violin(fill="pink") + 
#	geom_smooth(method="lm", color="blue" ) +
	facet_wrap(~ month) +
	theme_bw() +
	theme(axis.text.x = element_text(angle = 70, hjust = 1))

ggplot(nasa_long, aes(x=Lat, y=solar)) +
#	geom_violin(fill="pink") + 
	geom_smooth(color="blue", method="loess") +
	facet_wrap(~ month) +
	theme_bw()
#	 +
#	theme(axis.text.x = element_text(angle = 90, hjust = 1))


#' Build a model

library(mgcv)
nasa.gam <- gam(solar ~ Lon + month + s(Lat), data=nasa_long)
summary(nasa.gam)

# plot the effects
#plot(nasa.gam, shade=TRUE, shade.col="lightblue", all.terms=TRUE, pages=1)
plot(nasa.gam, shade=TRUE, shade.col="lightblue", cex.lab=1.25)
termplot(nasa.gam, terms="month", se=TRUE, lwd.term=3, lwd.se=2, cex.lab=1.25)
termplot(nasa.gam, terms="Lon", se=TRUE, lwd.term=3, lwd.se=2, cex.lab=1.25)

# what does effects do here?

library(effects)
nasa.eff <- allEffects(nasa.gam)

plot(nasa.eff)


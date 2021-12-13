data(Draft1970, package="vcdExtra")

plot(Rank ~ Day, data=Draft1970,
	ylab="Draft Priority", xlab="Birthday (day of year)")
#with(Draft1970, lines(lowess(Day, Rank), col="red", lwd=2))
with(Draft1970, lines(loess.smooth(Day, Rank, span=1/2), col="red", lwd=3))

abline(lm(Rank ~ Day, data=Draft1970), col="blue")
 
# boxplots
plot(Rank ~ Month, data=Draft1970, col="bisque", 
	ylab="Draft Priority", xlab="Birth month", cex.lab=1.25)
with(Draft1970, points(jitter(as.numeric(Month)), Rank, cex=0.6, pch=16, col="blue"))


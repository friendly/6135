library(car)
data(Prestige)

source("c:/Dropbox/R/functions/scatterplotMatrix.R")

scatterplotMatrix(~ prestige + women + education + income, data=Prestige,
	diagonal="boxplot", col=c("red", "blue", "black"), 
	lwd=2, pch=16)
	

scatterplotMatrix(~ prestige + women + education + income, data=Prestige,
	diagonal="density", col=c("red", "blue", "black"), 
	ellipse=TRUE, levels=0.68, smooth=FALSE, fill=TRUE,
	lwd=2, pch=16)

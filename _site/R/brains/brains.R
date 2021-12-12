folder <- file.path(dropbox_folder(), "Documents", "6135", "R", "brains")
setwd(folder)

brains.dat <- file.path(folder, "brain-size.csv")
brains <- read.csv(brains.dat, stringsAsFactors=FALSE)
brains$class <- factor(brains$class)

library(png)

sizes <- t(sapply(brains$img, function(x) dim(readPNG(x))))
brains$height <- sizes[,1]
brains$width  <- sizes[,2]
brains



op <- par(mar=c(5,5,1,1)+.1)
plot(neurons ~ brain_weight, data=brains,
	xlab="Brain weight (g)", ylab="Neurons (billions)",
	cex.lab=1.4)
pp <- c(4,4,1,1,2)
off <- c(3,3,2,3,4)
col <- ifelse(brains$class=="primate", "blue", "red")
with(brains, text(brain_weight, neurons, gsub(" ", "\n", brains$species), col=col, pos=pp, offset=off))
par(op)

op <- par(mar=c(5,5,1,1)+.1)
plot(neurons ~ brain_weight, data=brains,
	xlab="Brain weight (g)", ylab="Neurons (billions)",
	cex.lab=1.4, log="xy")
pp <- c(4,4,1,1,2)
off <- c(3,3,2,3,4)
col <- ifelse(brains$class=="primate", "blue", "red")
with(brains, text(brain_weight, neurons, gsub(" ", "\n", brains$species), col=col, pos=pp, offset=off))
par(op)



library(ggimage)
library(ggplot2)

ggplot(brains, aes(x=brain_weight, y=neurons)) +
	geom_text(aes(label=species), color=col, hjust="inward") +
	geom_image(aes(image=img)) + theme_bw()


ggplot(brains, aes(x=brain_weight, y=neurons)) +
	geom_text(aes(label=species), color=col, hjust="inward") +
	geom_image(aes(image=img), by="height") + scale_size_identity()




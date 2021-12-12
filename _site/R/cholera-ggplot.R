library(ggplot2)

data(Cholera, package="HistData")

str(Cholera)

#' make a basic scatterplot
plt <- ggplot(Cholera, aes(x=elevation, y=cholera_drate)) +
	geom_point() 


#' Farr's law: data from his Figure
law <- data.frame(
	elev <- c(0, 10, 30, 50, 70, 90, 100, 350),
	mort <- c(174, 99, 53, 34, 27, 22, 20, 6)
	)

#' Add Farr's law to the plot
plt + geom_point(size=2) +
	geom_line(data=law, aes(x=elev, y=mort), col="blue", size=1.5)

#' Add a smoothed curve

plt + geom_point(size=2) +
	geom_line(data=law, aes(x=elev, y=mort), col="blue", size=1.5) +
	geom_smooth(color="red", se=FALSE)

#' Identify the unusual points
ids <- c(2, 5, 38)

plt + geom_point(size=2) +
	geom_line(data=law, aes(x=elev, y=mort), col="blue", size=1.5) +
	geom_smooth(color="red", se=FALSE) +
	geom_text(data=Cholera[ids,], aes(label=district), vjust=-1)




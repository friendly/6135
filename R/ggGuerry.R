#' ---
#' title: "Guerry's data on crime and literacy"
#' author: "Michael Friendly"
#' category: "ggplot2"
#' date: "`r format(Sys.Date())`"
#' output:
#'   html_document:
#'     theme: readable
#'     code_download: true
#'   word_document: default    
#' ---

#+ echo=FALSE
knitr::opts_chunk$set(warning=FALSE, 
                      message=FALSE, 
                      R.options=list(digits=4),
                      fig.width = 5,
                      fig.height = 5)

#' This example shows the development of plots of Andre-Michel Guerry's (1831) data on crime and literacy in France

#' ## Load packages
library(ggplot2)
library(ggrepel)

#' ## Load the data
data(Guerry, package="Guerry")
head(Guerry[, 1:9])


#' ## Start with basic scatterplot 
ggplot(aes(x=Literacy, y=Crime_pers/1000), data=Guerry) +
  geom_point(size=2) 
# ggsave("guerry-crime1.png", width=5, height=5)

#' ## Add data ellipses
#' Data ellipses give a visual assessment of the correlation between variables
ggplot(aes(x=Literacy, y=Crime_pers/1000), data=Guerry) +
  geom_point(size=2) +
  stat_ellipse(level=0.68, color="blue", size=1.2) +  
  stat_ellipse(level=0.95, color="gray", size=1, linetype=2) 
# ggsave("guerry-crime2.png", width=5, height=5)
  
#' ## Add smooths

ggplot(aes(x=Literacy, y=Crime_pers/1000), data=Guerry) +
  geom_point(size=2) +
  stat_ellipse(level=0.68, color="blue", size=1.2) +  
  stat_ellipse(level=0.95, color="gray", size=1, linetype=2) + 
  geom_smooth(method="lm", formula=y~x, fill="lightblue") +
  geom_smooth(method="loess", formula=y~x, color="red", se=FALSE) 
# ggsave("guerry-crime3.png", width=5, height=5)

#' ## Do some styling  
gplot <- last_plot()
gplot + theme_bw(base_size = 18) 

#' ## Put the steps together
ggplot(aes(x=Literacy, y=Crime_pers/1000), data=Guerry) +
  geom_point(size=2) +
  stat_ellipse(level=0.68, color="blue", size=1.2) +  
  stat_ellipse(level=0.95, color="gray", size=1, linetype=2) + 
  geom_smooth(method="lm", formula=y~x, fill="lightblue") +
  geom_smooth(method="loess", formula=y~x, color="red", se=FALSE) +
  theme_bw() + theme(text = element_text(size=18))
# ggsave("guerry-crime4.png", width=5, height=5)



#' ## Use Mahalanobis Dsq to label unusual points
gdf <- Guerry[, c("Literacy", "Crime_pers", "Department")]
gdf$dsq <- heplots::Mahalanobis(gdf[, 1:2])

ggplot(aes(x=Literacy, y=Crime_pers/1000), data=Guerry) +
  geom_point(size=2) +
  stat_ellipse(level=0.68, color="blue", size=1.2) +  
  stat_ellipse(level=0.95, color="gray", size=1, linetype=2) + 
  geom_smooth(method="lm", formula=y~x, fill="lightblue") +
  geom_smooth(method="loess", formula=y~x, color="red", se=FALSE) +
	geom_label_repel(aes(label=Department), data = gdf[gdf$dsq > 4.6,]) +
  theme_bw() + theme(text = element_text(size=18))
# ggsave("guerry-crime5.png", width=5, height=5)

gplot + 
     theme_bw() + 
     theme(text = element_text(size=18)) +        
	   geom_label_repel(aes(label=Department), data = gdf[gdf$dsq > 4.6,])


#' ## Do the same for property crime

gdf <- Guerry[, c("Literacy", "Crime_prop", "Department")]
gdf$dsq <- heplots::Mahalanobis(gdf[, 1:2])

ggplot(aes(x=Literacy, y=Crime_prop/1000), data=Guerry) +
  geom_point(size=2) +
  stat_ellipse(level=0.68, color="blue", size=1.2) +  
  stat_ellipse(level=0.95, color="gray", size=1, linetype=2) + 
  geom_smooth(method="lm", formula=y~x, fill="lightblue") +
  geom_smooth(method="loess", formula=y~x, color="red", se=FALSE) +
	geom_label_repel(aes(label=Department), data = gdf[gdf$dsq > 4.6,]) +
  theme_bw() + theme(text = element_text(size=18))

# ggsave("guerry-crime-prop.png", width=5, height=5)



# Guerry: Literacy vs Crime
library(ggplot2)
data(Guerry, package="Guerry")


#gplot <-

# start with basic scatterplot 
ggplot(aes(x=Literacy, y=Crime_pers/1000), data=Guerry) +
  geom_point(size=2) 
ggsave("guerry-crime1.png", width=5, height=5)

# add data ellipses
ggplot(aes(x=Literacy, y=Crime_pers/1000), data=Guerry) +
  geom_point(size=2) +
  stat_ellipse(level=0.68, color="blue", size=1.2) +  
  stat_ellipse(level=0.95, color="gray", size=1, linetype=2) 
ggsave("guerry-crime2.png", width=5, height=5)
  
# add smooths

ggplot(aes(x=Literacy, y=Crime_pers/1000), data=Guerry) +
  geom_point(size=2) +
  stat_ellipse(level=0.68, color="blue", size=1.2) +  
  stat_ellipse(level=0.95, color="gray", size=1, linetype=2) + 
  geom_smooth(method="lm", formula=y~x, fill="lightblue") +
  geom_smooth(method="loess", formula=y~x, color="red", se=FALSE) 
ggsave("guerry-crime3.png", width=5, height=5)

# do some styling  
gplot <- last_plot()
gplot + theme_bw() + 
        theme(text = element_text(size=18))


ggplot(aes(x=Literacy, y=Crime_pers/1000), data=Guerry) +
  geom_point(size=2) +
  stat_ellipse(level=0.68, color="blue", size=1.2) +  
  stat_ellipse(level=0.95, color="gray", size=1, linetype=2) + 
  geom_smooth(method="lm", formula=y~x, fill="lightblue") +
  geom_smooth(method="loess", formula=y~x, color="red", se=FALSE) +
  theme_bw() + theme(text = element_text(size=18))
ggsave("guerry-crime4.png", width=5, height=5)



library(ggrepel)
# use Mahalanobis Dsq to label unusual points
gdf <- Guerry[, c("Literacy", "Crime_pers", "Department")]
gdf$dsq <- mahalanobis(gdf[,1:2], colMeans(gdf[,1:2]), cov(gdf[,1:2]))

ggplot(aes(x=Literacy, y=Crime_pers/1000), data=Guerry) +
  geom_point(size=2) +
  stat_ellipse(level=0.68, color="blue", size=1.2) +  
  stat_ellipse(level=0.95, color="gray", size=1, linetype=2) + 
  geom_smooth(method="lm", formula=y~x, fill="lightblue") +
  geom_smooth(method="loess", formula=y~x, color="red", se=FALSE) +
	geom_label_repel(aes(label=Department), data = gdf[gdf$dsq > 4.6,]) +
  theme_bw() + theme(text = element_text(size=18))
ggsave("guerry-crime5.png", width=5, height=5)

gplot + 
     theme_bw() + 
     theme(text = element_text(size=18)) +        
	   geom_label_repel(aes(label=Department), data = gdf[gdf$dsq > 4.6,])


# same for property crime

gdf <- Guerry[, c("Literacy", "Crime_prop", "Department")]
gdf$dsq <- mahalanobis(gdf[,1:2], colMeans(gdf[,1:2]), cov(gdf[,1:2]))

ggplot(aes(x=Literacy, y=Crime_prop/1000), data=Guerry) +
  geom_point(size=2) +
  stat_ellipse(level=0.68, color="blue", size=1.2) +  
  stat_ellipse(level=0.95, color="gray", size=1, linetype=2) + 
  geom_smooth(method="lm", formula=y~x, fill="lightblue") +
  geom_smooth(method="loess", formula=y~x, color="red", se=FALSE) +
	geom_label_repel(aes(label=Department), data = gdf[gdf$dsq > 4.6,]) +
  theme_bw() + theme(text = element_text(size=18))

ggsave("guerry-crime-prop.png", width=5, height=5)



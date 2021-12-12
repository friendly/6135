ggplot(Minard.troops, aes(long, lat)) +
	geom_path() +
	geom_point(aes(size=survivors))

ggplot(Minard.troops, aes(long, lat)) +
	geom_path() +
	geom_point(aes(size=survivors, color=direction))


plot_troops +	
	geom_point(data = Minard.cities) +
  geom_text(data = Minard.cities, aes(label = city), vjust = 1.5) 

library(ggrepel)
plot_troops +	
	geom_point(data = Minard.cities) +
	geom_text_repel(data = Minard.cities, aes(label = city))
	
Minard.temp <- Minard.temp %>%
	mutate(label = paste0(temp, "°, ", date))

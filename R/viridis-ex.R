library(ggplot2)
library(viridis)

set.seed(12347)
df <- data.frame(x = rnorm(10000), y = rnorm(10000))
g <- ggplot(df, aes(x = x, y = y)) +
  geom_hex(bins=40) + coord_fixed() +
  theme_bw()
g
  
g + scale_fill_viridis()

# heat colors
g + scale_fill_gradient(high="red", low="yellow")


ggplot(df, aes(x = x, y = y)) +
  geom_hex(bins=40) + coord_fixed() +
  scale_fill_viridis() + theme_bw()
  
ggplot(df, aes(x = x, y = y)) +
  geom_hex(bins=40) + coord_fixed() +
  scale_fill_gradient(high="red", low="yellow") + theme_bw()
  

g <- ggplot(df, aes(x = x, y = y)) +
  geom_hex(bins=40) + coord_fixed() +
  theme_bw()
g



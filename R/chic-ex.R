# from : https://www.cedricscherer.com/2019/08/05/a-ggplot2-tutorial-for-beautiful-plotting-in-r/
# National Morbidity and Mortality Air Pollution Study (NMMAPS)

chic <- readr::read_csv("https://raw.githubusercontent.com/z3tt/ggplot-courses/master/data/chicago-nmmaps.csv")
tibble::glimpse(chic)

# contour plots

# basic
ggplot(chic, aes(temp, o3)) +
  geom_density_2d() +
  labs(x = "Temperature (°F)", x = "Ozone Level")

ggplot(chic, aes(temp, o3)) +
  geom_density_2d_filled(show.legend = FALSE) +
  coord_cartesian(expand = FALSE) +
  labs(x = "Temperature (°F)", x = "Ozone Level")

g + geom_tile(aes(fill = Dewpoint)) +
    scale_fill_viridis_c(option = "inferno")
    

# binned contour plots
ggplot(chic, aes(temp, o3)) +
  geom_hex() +
  scale_fill_distiller(palette = "YlOrRd", direction = 1) +
  labs(x = "Temperature (°F)", y = "Ozone Level")

ggplot(chic, aes(temp, o3, fill = ..density..)) +
  geom_bin2d(bins = 15, color = "grey") +
  scale_fill_distiller(palette = "YlOrRd", direction = 1) +
  labs(x = "Temperature (°F)", y = "Ozone Level")

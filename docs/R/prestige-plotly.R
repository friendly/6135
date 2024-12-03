library(plotly)

data(Prestige, package = "carData")

fig <- plot_ly(
  data = Prestige, 
  x = ~education, 
  y = ~income, 
  z = ~prestige,
#  color = ~women # colors = c('#BF382A', '#0C4B8E'),
  marker = list(color = ~type, 
                colors = c("red", "blue", "darkgreen")),
#                colorscale = c('#FFE1A1', '#683531'), showscale = TRUE)
  text = ~paste(rownames(Prestige), 
                '<br>Prestige:', prestige, 
                '<br>Educ:', education,
                '<br>Inc:', income)
  )


fig |> 
  add_markers() |>
  layout(scene = list(xaxis = list(title = 'Education'),
                      yaxis = list(title = 'Income'),
                      zaxis = list(title = 'Prestige')))


marker = list(symbol = 'circle', sizemode = 'diameter'), sizes = c(5, 150),

text = ~paste(rownames(Prestige), 
              '<br>Prestige:', prestige, 
              '<br>Educ:', education,
              '<br>Inc:', income))

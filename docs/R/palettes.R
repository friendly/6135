(pal <-palette())
pie(rep(1, length(pal)), labels = sprintf("%d (%s)", seq_along(pal), pal),  col = pal)

pal <- rainbow(8)
pie(rep(1, length(pal)), labels = sprintf("%d (%s)", seq_along(pal), pal),  col = pal)

palette(rainbow(8))
pie(rep(1, length(pal)), labels = sprintf("%d (%s)", seq_along(pal), pal),  col = pal)





# Color palettes in R

(pal <-palette())
  
pie(rep(1, length(pal)), labels = sprintf("%d (%s)", seq_along(pal), pal), 
    col = pal)

n <- 12
pie(rep(1, n), col=rainbow(n))


pie(rep(1, n), col=heat.colors(n))

pie(rep(1, n), col=terrain.colors(n))

pie(rep(1, n), col=topo.colors(n))

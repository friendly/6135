# sine illustion

op <-par(mar=c(4,4,1,1)+.5)
x <- seq(0, 5 * pi, length.out = 100)
w <- 0.5
plot(x, sin(x), ylim = c(-1, 1 + w), type = "n")
segments(x0 = x, y0 = sin(x), y1 = sin(x) + w, lwd = 3)


plot(x, sin(x), ylim = c(-1, 1 + w), type = "n")
lines(x, sin(x), col="blue", lwd=3)
lines(x, sin(x)+w, col="blue", lwd=3)

xx <- c(x, rev(x))
yy <- c(sin(x), rev(sin(x)+w))
polygon(xx, yy, col="pink")

plot(x, rep(w, 100), ylim=c(0.3, 0.7), type="l", lwd=3, ylab="Difference")

par(op)
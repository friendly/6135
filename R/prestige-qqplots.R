library(car)
library(qqtest)
library(qqplotr)

data(Prestige, package="carData")

# Plots of income

## histogram with density
ggplot(Prestige, aes(x=income)) + 
 geom_histogram(aes(y=..density..), colour="black", fill="skyblue", alpha=0.8) +
 geom_density(alpha=.2, fill="red") +  # "#FF6666"
 theme(axis.ticks.y = element_blank(),
       axis.text.y=element_blank()) +
 labs(y="Frequency")


qqPlot(~income, data=Prestige, envelope=FALSE, grid=FALSE, pch=16)

# theoretical conf band
qqPlot(~income, data=Prestige, 
       envelope=list(col="lightblue", alpha=0.5,
                     level = .95,
                     simulate = FALSE), 
       grid=FALSE, pch=16)

# try qqplotr

ggplot(data = Prestige, aes(sample = income)) +
 stat_qq_band(conf = .95, fill="lightblue", alpha=0.5) +
 stat_qq_line(color="blue") +
 stat_qq_point() +
 labs(x = "Normal Quantiles", y = "Income Quantiles") +
  theme_bw(base_size = 14)

# detrended 
ggplot(data = Prestige, aes(sample = prestige)) +
 stat_qq_band(conf = .95, fill="lightblue", alpha=0.5, detrend=TRUE) +
 stat_qq_line(color="blue", detrend=TRUE) +
 stat_qq_point(size=2, detrend=TRUE) +
 labs(x = "Normal Quantiles", y = "Detrended Prestige Quantiles") + 
 theme_bw(base_size = 14)



# Plots of prestige

ggplot(Prestige, aes(x=prestige)) + 
 geom_histogram(aes(y=..density..), colour="black", fill="skyblue", alpha=0.8) +
 geom_density(alpha=.2, fill="red") +  # "#FF6666"
 theme(axis.ticks.y = element_blank(),
       axis.text.y=element_blank()) +
 labs(y="Frequency")
 
#qqPlot(~prestige, data=Prestige, envelope=FALSE, grid=FALSE, pch=16)
 
qqPlot(~prestige, data=Prestige, 
       envelope=list(col="lightblue", alpha=0.5), grid=FALSE, pch=16, id=FALSE)

qqtest(Prestige$prestige, main="Prestige$prestige")

# Normal Q-Q plot of Normal data
gg <- ggplot(data = Prestige, aes(sample = prestige)) +
 stat_qq_band(fill="lightblue", alpha=0.5) +
 stat_qq_line(color="blue") +
 stat_qq_point()
gg + labs(x = "Theoretical Quantiles", y = "Sample Quantiles")





# residuals from lm()
# residuals from lm()
qqPlot(lm(prestige ~ income + education + type, data=Duncan), 
       envelope=list(col="lightblue", alpha=0.5), pch=16,
				ylab="Studentized Residuals")

qqPlot(lm(prestige ~ income + education + type, data=Duncan),
       envelope=.99)


qqtest(Prestige$income, main="Prestige$income")


# cqplot

library(heplots)
cqplot(Prestige[, 1:4], id.n = 2)

cqplot(Prestige[, 1:4], id.n = 2, detrend = TRUE, ylim = c(-4, 20))


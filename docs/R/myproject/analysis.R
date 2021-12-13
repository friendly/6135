# analysis
load("data/mydata.RData")

# do the analysis
plot(mydata)

# fit models
mymod.1 <- lm(y ~ X1 + X2 + X3, data=mydata)

# plot models, extract model summaries
plot(mymod.1)
sumary(mymod.1)

dotplot(variety ~ yield | site, data = barley, groups = year,
        key = simpleKey(levels(barley$year), space = "top", columns=2), 
        pch=c(15, 16),
        xlab = "Barley Yield (bushels/acre) ",
        aspect=0.5, layout = c(2,3), ylab=NULL)
       
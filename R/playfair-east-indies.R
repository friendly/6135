#' ---
#' title: "Playfair Balance of Trade Data"
#' author: "Michael Friendly"
#' date: "13 Sep 2018"
#' ---

#' ## Load the data & ggplot2

#' NB: you may have to install the GDAdata package
if (!require("GDAdata")) install.packages("GDAdata")
data(EastIndiesTrade,package="GDAdata")
library(ggplot2)

#' ## Plot two lines, for Exports & Imports
c1 <- ggplot(EastIndiesTrade, aes(x=Year, y=Exports)) + 
           ylim(0,2000) + 
           geom_line(colour="black", size=2) + 
           geom_line(aes(x=Year, y=Imports), colour="red", size=2)  
print(c1)


#' ## Fill the area between curves and change the Y label
c1 <- c1 +
         geom_ribbon(aes(ymin=Exports, ymax=Imports), fill="pink",alpha=0.5) + 
         ylab("Exports and Imports (millions of pounds)") 
print(c1)


#' ## Add text annotations, change the theme
c1 <- c1 +
         annotate("text", x = 1710, y = 0, label = "Exports", size=4) +
         annotate("text", x = 1770, y = 1620, label = "Imports", color="red", size=4) +
         annotate("text", x = 1732, y = 1950, label = "Balance of Trade to the East Indies", color="black", size=5) +             
         theme_bw()
print(c1)

#' ## Plot trade deficit directly
c2 <- ggplot(EastIndiesTrade, aes(x=Year,
           y=Exports-Imports)) + geom_line(colour="red", size=2) +
           ylab("Balance = Exports - Imports") +
           geom_ribbon(aes(ymin=Exports-Imports, ymax=0), fill="pink",alpha=0.5) + 
           annotate("text", x = 1710, y = -30, label = "Our Deficit", color="black", size=5) +             
           theme_bw()

#' ## Combine the two plots into one
#+ fig.width=10
library(gridExtra)
grid.arrange(c1, c2, nrow=1)



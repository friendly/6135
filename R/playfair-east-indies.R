#' ---
#' title: "Playfair Balance of Trade Data"
#' author: "Michael Friendly"
#' date: "`r format(Sys.Date())`"
#' output:
#'   html_document:
#'     theme: readable
#'     code_download: true
#'   word_document: default    
#' ---

#+ echo=FALSE
knitr::opts_chunk$set(warning=FALSE, 
                      message=FALSE, 
                      R.options=list(digits=4))

#' Playfair's (1801) [_Commercial and Political Atlas_](https://archive.org/details/PLAYFAIRWilliam1801TheCommercialandPoliticalAtlas)
#' introduced the idea of line graphs for time series data. He used these to talk about the balance of trade England had
#' with other countries. Let's try to reproduce one of these, for trade with the East Indies, with `ggplot`.
#' 
#+ echo=FALSE, out.width="50%"
#knitr::include_graphics("https://github.com/friendly/6135/blob/master/images/Playfair_Exports_Imports_East_Indies-600px.jpg")
knitr::include_graphics("../images/Playfair_Exports_Imports_East_Indies-600px.jpg")
#' 
#' ## Load the data & ggplot2
#' The data are contained in `GDAdata::EastIndiesTrade`. You may have to install the `GDAdata` package.
library(ggplot2)
if (!require("GDAdata")) install.packages("GDAdata")
data(EastIndiesTrade,package="GDAdata")
head(EastIndiesTrade)

#' ## Plot two lines, for Exports & Imports
#' Playfair plotted Exports and Imports against Year with separate lines for each. The data are in a wide format, so
#' to do this, I change the Y mapping for the second `geom_line()`.
c1 <- ggplot(EastIndiesTrade, aes(x=Year, y=Exports)) + 
           ylim(0,2000) + 
           geom_line(colour="black", linewidth=2) + 
           geom_line(aes(x=Year, y=Imports), colour="red", linewidth=2)  
print(c1)


#' ## Fill the area between curves and change the Y label
#' `geom_ribbon()` is designed for this. It takes `ymin` and `ymax` aesthetics, here mapped to `Exports` and `Imports`.
#' Note the use of `+` to add to an existing ggplot object.
c1 <- c1 +
         geom_ribbon(aes(ymin=Exports, ymax=Imports), fill="pink",alpha=0.5) + 
         ylab("Exports and Imports (millions of pounds)") 
print(c1)


#' ## Add text annotations, change the theme
#' `annotate("text")` takes `x` and `y` coordinates in the units of the plot.
c1 <- c1 +
         annotate("text", x = 1710, y = 0, label = "Exports", size=4) +
         annotate("text", x = 1770, y = 1620, label = "Imports", color="red", size=4) +
         annotate("text", x = 1732, y = 1950, label = "Balance of Trade to the East Indies", color="black", size=5) +             
         theme_bw(base_size = 14)
print(c1)

#' ## Plot trade deficit directly
#' In the mapping, simply use `y=Exports-Imports`
c2 <- ggplot(EastIndiesTrade, 
             aes(x=Year, y=Exports-Imports)) + 
    geom_line(colour="red", size=2) +
    ylab("Balance = Exports - Imports") +
    geom_ribbon(aes(ymin=Exports-Imports, ymax=0), fill="pink",alpha=0.5) + 
    annotate("text", x = 1710, y = -30, label = "Our Deficit", color="black", size=5) +             
    theme_bw(base_size = 14)

#' ## Combine the two plots into one
#' `ggplot` uses `grid` graphics under the hood, so plots can be combined using `gridExtra::grid.arrange()`.
#+ fig.width=10
library(gridExtra)
grid.arrange(c1, c2, nrow=1)

#' ## Easier & more general with `patchwork`
#' The [`patchwork`](https://patchwork.data-imaginist.com/) package makes it "ridiculously simple to combine separate ggplots into the same graphic"
#+ fig.width=10
library(patchwork)
c1 + c2

#' ## Going further
#' I didn't exactly reproduce Playfair's chart. To do so more completely, I would:
#' 
#' * Find fonts that were closer to those he used for the plot title at the top, reading: "CHART of EXPORTS and IMPORTS ..." and for the caption,
#'   reading "The Bottom Line is Divided ...". The
#'   [`showtext`](https://cran.rstudio.com/web/packages/showtext/vignettes/introduction.html)
#'   package makes them available in R.
#' * Where I simply labeled the curves "Imports" and "Exports", I could use the [`geomtextpath`](https://allancameron.github.io/geomtextpath/) 
#'   package to write longer labels following the curves.
#' * Move the internal title inside the two curves as Playfair did, but make it read "Balance Against England"
#' * Position the Y axis at the right, and try to mimic his markings.
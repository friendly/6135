# Effect ordering for correlation matrices

library(corrgram)

vars2 <- c("Assists","Atbat","Errors","Hits","Homer","logSal",
           "Putouts","RBI","Runs","Walks","Years")

corrgram(baseball[vars2], order=FALSE, main="Baseball data alphabetic order",
         lower.panel=panel.shade, upper.panel=panel.pie)

corrgram(baseball[vars2], order=TRUE, main="Baseball data PC2/PC1 order",
         lower.panel=panel.shade, upper.panel=panel.pie)

library(ggbiplot)

bb <- corrgram::baseball[,vars2]
bb <- bb[complete.cases(bb),]
baseball.pca <- prcomp(bb, scale. = TRUE)
ggbiplot(baseball.pca, scale=0.5, alpha=0.7, varname.size=6) + theme_bw()

# heatmep

library(gplots)
library(RColorBrewer)

bb.std <- scale(as.matrix(bb))
my_palette <- colorRampPalette(c("red", "white", "blue"))(n = 299)
heatmap.2(bb.std,
	col=my_palette)



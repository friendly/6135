old <- theme_set( theme_gray() +
          theme(text = element_text(size = 18)))
theme_set(old)

cd("C:/Dropbox/Documents/6135/images/ggplot")

data(Arbuthnot, package="HistData")

library(ggplot2)
ggplot(Arbuthnot, aes(x=Year, y=Ratio)) +
    ylim(1, 1.20) + 
    ylab("Sex Ratio (M/F)") +
    geom_point(pch=16, size=2) +
    geom_line(color="gray") +
    geom_smooth(method="loess", color="blue", fill="blue", alpha=0.2) +
    geom_smooth(method="lm", color="darkgreen", se=FALSE) + 
    geom_hline(yintercept=1, color="red", size=2) +
    annotate("text", x=1645, y=1.01, label="Males = Females", color="red", size=5) +
    annotate("text", x=1680, y=1.19, 
             label="Arbuthnot's data on the\nMale / Female Sex Ratio", size=5.5) +
    theme_bw() + theme(text = element_text(size = 16))

ggsave("artuthnot-5.png", height=3.5, width=4.9)


arbuth +
    geom_hline(yintercept=1, color="red", size=2) +
    annotate("text", x=1645, y=1.01, label="Males = Females", color="red", size=5) +
    annotate("text", x=1680, y=1.19, 
             label="Arbuthnot's data on the\nMale / Female Sex Ratio", size=5.5) +
    theme_bw() + theme(text = element_text(size = 16))

# African Countries by GDP
# from: https://www.one.org/us/2014/05/20/12-data-visualizations-that-illustrate-povertys-biggest-challenges/

countries <- read.csv(textConnection('
country, GDP
South Africa, 284.4
Egypt, 188.4
Nigeria, 173
Algeria, 140.6
Morocco, 91.4
Angola, 75.5
Libya, 62.3
Tunesia, 39.6
Kenya, 29.4
Ethiopia, 28.5
Ghana, 26.2
Cameroon, 22.2
'
))

library(dplyr)
countries.sorted <-
countries %>% arrange(country)

with(countries.sorted, 
	pie(GDP, labels=sprintf("%s (%3.1f)",country,GDP), 
	    col=rainbow(12),
	    main="African Countries by GDP")
	)

with(countries, 
	dotchart(rev(GDP), labels=rev(country),
	pch=16, pt.cex=1.4, cex.lab=1.25, xlab="GDP",
	main="African Countries by GDP"))

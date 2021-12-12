library(htmltools)


thumbnail <- function(title, img, href, caption = TRUE) {
  div(class = "col-sm-4",
      a(class = "thumbnail", title = title, href = href,
        img(src = img),
        div(class = ifelse(caption, "caption", ""),
          ifelse(caption, title, "")
        )
      )
  )
}

```{r, echo=FALSE}
thumbnail("Apple", "images/apple.png", "https://en.wikipedia.org/wiki/Apple")
thumbnail("Grape", "images/grape.png", "https://en.wikipedia.org/wiki/Grape")
thumbnail("Peach", "images/peach.png", "https://en.wikipedia.org/wiki/Peach")
```

# table tags
tab <- function (...)
tags$table(...)
td <- function (...) 
	tags$td(...)
tr <- function (...) 
	tags$tr(...)

# an <a> tag with href as the text to be displayed
aself <- function (href, ...)
	a(href, href=href, ...)
	

# thumnail figure with href in a table column
#tabfig <- function(name, img, href, width) {
#		td(
#      a(class = "thumbnail", title = name, href = href,
#        img(src = img, width=width)
#       )
#    )
#}
tabtxt <- function(text, ...) {
		td(text, ...)
}

tabfig <- function(name, img, href, ...) {
		td(
      a(class = "thumbnail", title = name, href = href,
        img(src = img, ...)
       )
    )
}



tr(
	tabfig("R-Graphics", "images/books/R-Graphics.jpg", "https://www.stat.auckland.ac.nz/~paul/RG2e/", width="100px"),
	tabtxt("Paul Murrell, *R Graphics*, 2nd Ed.",br(),
	        "R code for figures:", a("https://www.stat.auckland.ac.nz/~paul/RG2e/", href="https://www.stat.auckland.ac.nz/~paul/RG2e/")
	       )
	)
	

<table cellspacing="10px">
<tr>
<td><img src="images/books/R-Graphics.jpg" width="80px"></td>
<td>Paul Murrell, *R Graphics*, 2nd Ed.<br/>
R code for figures: <a href="https://www.stat.auckland.ac.nz/~paul/RG2e/">https://www.stat.auckland.ac.nz/~paul/RG2e/</a>
</td>
</tr>


FlowingData - Nathan Yaus blog, http://flowingdata.com.  A large number of blog posts illustrating data visualization methods with tutorials on how do do these with R and other software.

Junk Charts - Kaiser Fung, http://junkcharts.typepad.com/. Fung discusses a variety of data displays
and discusses how they can be improved.

Data Stories - A podcast on data visualization with Enrico Bertini and Moritz Stefaner, http://datastori.es/
Interviews with over 100 graphic designers & developers.

Kantar Information is Beautiful Awards - Celebrate excellence and beauty in data visualizations,infographics, interactives & information art. 
https://www.informationisbeautifulawards.com

width <- "180px"
tab(cellspacing="12px", cellpadding="8px", width="600px",
	tr(
		tabfig("FlowingData", "images/blogs/flowingdata.png", "http://flowingdata.com/", width=width),
		tabtxt("Nathan Yau,", aself("flowingdata.com/"),
		       "A large number of blog posts illustrating data visualization methods with tutorials on how do do these with R and other software.")
		),
	
	tr(
		tabfig("Junk Charts", "images/blogs/junkcharts.png", "http://junkcharts.typepad.com/", width=width),
		tabtxt("Kaiser Fung,", aself("http://junkcharts.typepad.com/"),
		       "Fung discusses a variety of data displays and how they can be improved.")
		),
	
	tr(
		tabfig("Data Stories", "images/blogs/datastories.png", "http://datastori.es/", width=width),
		tabtxt("A podcast on data visualization with Enrico Bertini and Moritz Stefaner,",
		       aself("http://datastori.es/"), 
		       "Interviews with over 100 graphic designers & developers.")
		),
	
	tr(
		tabfig("Kantar", "images/blogs/kantar.png", "https://www.informationisbeautifulawards.com", width=width),
		tabtxt("Kantar Information is Beautiful Awards ",
		       aself("https://www.informationisbeautifulawards.com"), 
		       "Celebrate excellence and beauty in data visualizations,infographics, interactives & information art. ")
		)
)


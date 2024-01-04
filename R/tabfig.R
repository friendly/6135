library(htmltools)
library(glue)

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

# thumnail figure with href in a table column / row
tabfig <- function(name, img, href, ...) {
  td(
    a(class = "thumbnail", title = name, href = href,
      img(src = img, ...)
    )
  )
}
tabtxt <- function(text, ...) {
  td(text, ...)
}

TabFigText <- function(author, name,
                       img, website, title, desc, extra,
                       width = "160px", ...) {
  Fig <- tabfig(name = author, img = img, href = website, width = width, ...)

  link <- a(href=website, desc)
  text <-  c(name, title, link)
  if(!missing(extra)) text <- c(text, "br()", extra) 
  Txt <- tabtxt(text, ...)

  cat(paste(Fig, collapse = "\n"),
      paste(Txt, collapse = "\n"))
}

if(FALSE) {
  width <- "160px"
  tabfig("Wainer", "images/books/Wainer-graphic-discovery.png",
         "https://press.princeton.edu/titles/7820.html", width=width)
  tabtxt("Howard Wainer,",  a("Graphic discovery: a trout in the milk and other visual adventures",
                              href="https://press.princeton.edu/titles/7820.html"),
         ". A collection of essays on the history of graphics and other topics.")
  
  TabFigText(
    author = "Wainer",
    name = "Howard Wainer",
    img = "images/books/Wainer-graphic-discovery.png",
    title = "Graphic discovery: a trout in the milk and other visual adventures",
    website = "https://press.princeton.edu/titles/7820.html",
    desc = "A collection of essays on the history of graphics and other topics."
  )
  
  tr(
    tabfig("Ware", "images/books/ware.jpg", 
           "https://www.elsevier.com/books/information-visualization/ware/978-0-12-381464-7", width=width),
    tabtxt("Colin Ware,",  a("Information Visualization, 3rd Ed.",
                             href="https://www.elsevier.com/books/information-visualization/ware/978-0-12-381464-7"),
           ". What perceptual science has to say about data visualization, from a bottom-up perspective.", br(),
           "Course notes at", aself("http://ccom.unh.edu/vislab/VisCourse/index.html"))
  )
  
  tr(
    TabFigText(
      author = "Ware",
      name = "Colin Ware",
      img = "images/books/ware.jpg",
      title = "Information Visualization, 3rd Ed.",
      website = "https://www.elsevier.com/books/information-visualization/ware/978-0-12-381464-7",
      desc = "What perceptual science has to say about data visualization, from a bottom-up perspective.", 
      extra = paste("Course notes at", aself("http://ccom.unh.edu/vislab/VisCourse/index.html")))
    )
    
  
}
# DataExplorer demo

## Dataset
if(!require("palmerpenguins")) install.packages("palmerpenguins")

str(penguins)


## Install package if necessary
if(!require("DataExplorer")) install.packages("DataExplorer")
library(DataExplorer)   ## Create report

create_report(penguins, 
              output_file="penguins.html",
              report_title = "Penguins: Data Overview")

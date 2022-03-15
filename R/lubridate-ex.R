library(lubridate)
# parse dates in various formats
ymd("20210604")
mdy("06-04-2021")
dmy("04/06/2021")

# extract date components
minard_bday <- ymd("1781-03-27")
year(minard_bday)
month.name[month(minard_bday)]

# date arithmetic
year(today()) - year(minard_bday)

library(rio)
#install_formats()
library("rio")

x <- import("mtcars.csv")
#y <- import("mtcars.rds")
#z <- import("mtcars.dta")

mt <- head(subset(mtcars,mtcars$gear != 4 ))

#FILE EXPORT------------------------------------------------------
export(mt, "mtcars_gearnon4.dta")

# export to sheets of an Excel workbook
export(list(mtcars = mtcars, iris = iris), "multi.xlsx")
# export to an .Rdata file
## as a named list
export(list(mtcars = mtcars, iris = iris), "multi.rdata")

## as a character vector
export(c("mtcars", "iris"), "multi.rdata")

#FILE CONVERSION-----------------------------------------------------
# create file to convert
export(mtcars, "mtcars.dta")

# convert Stata to SPSS
convert("mtcars.dta", "mtcars.sav")

# create an ambiguous file
fwf <- tempfile(fileext = ".fwf")
cat(file = fwf, "123456", "987654", sep = "\n")

# see two ways to read in the file
identical(import(fwf, widths = c(1,2,3)), import(fwf, widths = c(1,-2,3)))

# convert to CSV
convert(fwf, "fwf.csv", in_opts = list(widths = c(1,2,3)))
import("fwf.csv") # check conversion

#command line

#Rscript -e "rio::convert('mtcars.dta', 'mtcars.csv')"
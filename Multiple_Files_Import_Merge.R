library(plyr)
library(readr)

#setwd("~/Desktop")
mydir = "C:/Users/345513/Documents/T"
myfiles = list.files(path=mydir, pattern="*.csv", full.names=TRUE)
#myfiles
#class(myfiles)

dat_csv = ldply(myfiles, read_csv) 
#read tab delimited files
## dat_txt = ldply(myfiles, read.table, sep = "\t", fill=TRUE, header = TRUE)
#read single file seperately
#read_csv(myfiles[1])
dat_csv


library(readxl)

files <- list.files(path = "~/Dropbox/Data/multiple_files", pattern = "*.xlsx", full.names = T)

tbl <- sapply(files, read_excel, simplify=FALSE) %>% 
  bind_rows(.id = "id")

# merge two data frames by ID and Country-Horizontally
#total <- merge(data frameA,data frameB,by=c("ID","Country"))

#--Vertically
#total <- rbind(data frameA, data frameB)
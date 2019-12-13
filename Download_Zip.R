#Data info: http://www3.norc.org/GSS+Website/Download/SPSS+Format/
download.file("http://files.grouplens.org/datasets/movielens/ml-latest-small.zip", destfile="ml-latest-small.zip")
unzip("ml-latest-small.zip")
GSS <- read.csv("ml-latest-small\\movies.csv")


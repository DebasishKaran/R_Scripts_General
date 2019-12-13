
#--------------------------------Linear Regression -------------------------------------
setwd("D:\\Machine_Learning\\")

###Linear Regression Sample
library(dplyr)
library(ggplot2)
##Loading Data
mmix<-read.csv("MMix.csv",header=TRUE,stringsAsFactors=FALSE)

##Checking Data Characteristics
dim(mmix)
str(mmix)
head(mmix)
tail(mmix)
table(mmix$Website.Campaign)

summary(mmix)
summary(mmix$NewVolSales)

x <- boxplot(mmix$NewVolSales,col="lightgreen")
out <- x$out

#To get list of outliers
#Outlier treatment
x$out
index<-mmix$NewVolSales %in% x$out
sum(index)
length(index)
non_outlier<-mmix[-index,]
dim(non_outlier)

#checking missing values
colSums(is.na(mmix))
summary(mmix)

#Treating missing values
mmix$NewVolSales[is.na(mmix$NewVolSales)]<-mean(mmix$NewVolSales,na.rm=TRUE)
summary(mmix$Base.Price)

library(ggplot2)

##Univariate Analysis
#Viz
qplot(mmix$NewVolSales)
hist(mmix$NewVolSales)
hist(mmix$Base.Price)

##Bivariate analysis 

#Viz
with(mmix,qplot(NewVolSales,Base.Price))
with(mmix,qplot(NewVolSales,InStore))
qplot(mmix$NewVolSales,mmix$Radio)

#Correlations
cor(mmix$NewVolSales,mmix$Base.Price)
with(mmix,cor(NewVolSales,Radio))
with(mmix,cor(NewVolSales,InStore))
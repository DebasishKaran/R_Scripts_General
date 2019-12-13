#Data info: http://www3.norc.org/GSS+Website/Download/SPSS+Format/
download.file("http://publicdata.norc.org/GSS/DOCUMENTS/OTHR/2012_spss.zip", destfile="2012_spss.zip")
unzip("2012_spss.zip")
GSS <- foreign::read.spss("GSS2012.sav", to.data.frame=TRUE)

#Variable info: http://www3.norc.org/GSS+Website/Browse+GSS+Variables/Mnemonic+Index/
library(mgcv)
mydata <- na.omit(GSS[c("age", "tvhours", "marital")])
tv_model <- gam(tvhours ~ s(age, by=marital), data = mydata)

newdata <- data.frame(
  age = c(24, 54, 32, 75),
  marital = c("MARRIED", "DIVORCED", "WIDOWED", "NEVER MARRIED")
)

predict(tv_model, data = newdata)

library(ggplot2)
qplot(age, predict(tv_model), color=marital, geom="line", data=newdata) +
  ggtitle("gam(tvhours ~ s(age, by=marital))") +
  ylab("Average hours of TV per day")
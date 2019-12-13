X_Org <- data.frame(bad=1:3, fine=rnorm(3),worse=rnorm(3))

M <- data.frame(
  map = c('worse=best','semi-medium=', 'bad=good','medium=')
)

library(splitstackshape)
M<- cSplit(M, 1:ncol(M), sep="=", stripWhite=TRUE, type.convert=FALSE)
#M
df <- X_Org;
#colnames(dataframe)[which(names(dataframe) == "columnName")] <- "newColumnName"

#GCode  <- c('worse','bad')
#GenderName <- c('best','good')

GCode <- M$map_1
GenderName <- na.omit(M$map_2)

#MyLookupTable <- na.omit(data.frame(GCode,GenderName))

#colnames(df)[which(colnames(df) %in% c("bad","worst") )] <- c("good","best")

colnames(df)[which(colnames(df) %in% GCode )] <- GenderName
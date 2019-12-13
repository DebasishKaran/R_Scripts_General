mydata <- data.frame(
  ID=c(1,1,2,6),
  Time=c(1,2,3,5),
  X1=c(2,1,3,1),
  X2=c('a','b','d','c'),
  X3=c(3,3,2,1)
)

library(reshape)
md <- melt(mydata, id=c("ID", "Time"))
md

casted = cast( md, ID+Time~variable )
print(casted)

library(varhandle)
#nms <- names(mydata)

#class(mydata)

i <- sapply(casted, is.factor)
casted[i] <- lapply(casted[i], unfactor)


#casted$X3 <- unfactor(casted$X3)
#y <- unfactor(y)

class(casted$X1)
class(casted$X2)
class(mydata$X1)
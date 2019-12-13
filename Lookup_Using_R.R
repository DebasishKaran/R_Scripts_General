Name <- c("John", "David", "Angela", "Harry", "Christine")
GenderCode <- c(1,1,2,1,2)

MyData <- data.frame (Name,GenderCode)

# Created your lookup table
# Your lookup table has the codesand the actual value which you would want to use
GCode  <- c(1,2)
GenderName <- c("Male","Female")

MyLookupTable <- data.frame(GCode,GenderName)

# Perform alookup and add a new column in your datatable which will have the values pulled in from your lookup table
MyData$GenderName = MyLookupTable[match(MyData$GenderCode, MyLookupTable$GCode), "GenderName"] 

View(MyData)
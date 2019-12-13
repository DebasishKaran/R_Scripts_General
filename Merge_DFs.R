require(data.table)

# I imagine you have your data in data.frames.

temp <- data.frame(x1 = c(1:4), x2 = c("INDIA", "INDIA", "US", "US"))

PortfolioIndices <- data.frame(Country = c("INDIA", "US", "UK"),
                               Index = c("CNX50", "SP500", "FTSE100"),
                               CCY = c("INR", "USD", "GBP"))                           

# Coerce your data to data.table objects (they are still data.frames) and use the J() 
# function    

temp <- as.data.table(temp)
PortfolioIndices <- as.data.table(PortfolioIndices)
setkey(temp, x2)
setkey(PortfolioIndices, Country)

PortfolioIndices[temp, list(x1,Index,CCY),]
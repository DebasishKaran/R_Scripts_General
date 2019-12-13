#install.packages("RMySQL")
library(RMySQL)


mydb = dbConnect(MySQL(), user='root', password='root', dbname='setupsmart', host='localhost')
#list of the tables in our connection
print(dbListTables(mydb))
#list of the field for table in our connection
dbListFields(mydb, 'analytes')
#create tables in the database using R dataframes.
#dbWriteTable(mydb, name='table_name', value=data.frame.name)
#retrieve data from the database we need to save a results set object.
rs = dbSendQuery(mydb, "select * from phases")

data = fetch(rs, n=-1)

class(data)




#------------------------------------
library(dplyr)

library(RMySQL)

my_storms = storms
my_storms$DateTime = paste0(storms$year, "-",storms$month, "-",storms$day, " ", storms$hour,":00:00")
my_storms = my_storms %>% select(name, DateTime, lat, long, status, category, wind, pressure)

mydb = dbConnect(MySQL(), 
                 dbname = "storms",
                 host = "127.0.0.1",
                 port = 3306,
                 user = "root",
                 password = "mypassword")


dbWriteTable(mydb,'storms', 
             my_storms, 
             row.names = FALSE,
             overwrite = TRUE)


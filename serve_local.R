library(plumber)

r = plumb(dir = "api")
#r <- plumb("plumber.R") 
#p$run(port = 8000)
r$run(port = 8000)

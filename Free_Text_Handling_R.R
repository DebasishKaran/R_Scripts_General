library(splitstackshape)
df <- data.frame(V1 = c("aa bb", "cc", "dd ee", "ff gg", "hh", "ii"),
                 V2 = c("11 12", "14", "13 14", "11 14", "13", "15"))




df_mod <- cSplit(df, 'V1', sep=" ", type.convert=FALSE)

#default is type.convert= TRUE, which would convert to numeric
df_mod_both <- cSplit(df, 1:ncol(df), sep=" ", stripWhite=TRUE, type.convert=FALSE)
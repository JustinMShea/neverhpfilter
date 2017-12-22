GDPC1_filter <- yth_filter(log(GDPC1), h = 40, p = 4)

main <- "Log of Real GDP (GDPC1)"
plot(GDPC1_filter[,1:2], subset = "1992/", grid.col = "white", legend.loc = "topleft", main = main)

main <- paste(names(GDPC1_filter[,3]), "and", names(GDPC1_filter[,4]), "series", sep = " ")
plot(GDPC1_filter[,3:4], subset = "1982/", grid.col = "white", legend.loc = "topleft", main = main)


SP500_filter <- yth_filter(GSPC$GSPC.Close, h = 10, p = 5)
SP500_filter <- yth_filter(GSPC$GSPC.Close, h = 40, p = 20)

main <- "Log of SP500 (^GSPC)"
plot(SP500_filter[,1:2], subset = "2017/", grid.col = "white", legend.loc = "topleft", main = main)
plot(SP500_filter[,3:4], subset = "2017-06/", grid.col = "white", legend.loc = "topleft", main = main)



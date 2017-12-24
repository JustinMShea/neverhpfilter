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


# Test table
gdp_filtered <- yth_filter(GDPC1)

sd(coredata(gdp_filtered$GDPC1.cycle["/2016-1"]), na.rm=TRUE)


# USREC datra

qtr_recc <- to.quarterly(USREC["1947-1/2017-3"], OHLC=FALSE)
qtr_recc2 <- qtr_rec[qtr_rec$USREC==1,]
qtr_recc2

# another try

start <- index(USREC[which(diff(USREC$USREC)==1)])
end   <- index(USREC[which(diff(USREC$USREC)==-1)-1])
Recessions <- paste(format(start,"%Y-%m"),format(end[-1],"%Y-%m"),sep="/")


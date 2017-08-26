
# Real GDP
Real_Gross_Domestic_Product <- "https://research.stlouisfed.org/fred2/data/GDPC96.txt"
RGDP <- as.xts(read.zoo(Real_Gross_Domestic_Product, skip = 12, index.column = 1,
                        header = TRUE, format = "%Y-%m-%d", FUN = as.yearqtr))



### Employment Rate ###
Total_nonfarm_Payrolls   <- "https://fred.stlouisfed.org/data/PAYEMS.txt"
Employment_Establishment <- as.xts(read.zoo(Total_nonfarm_Payrolls , sep = "", skip = 42, index.column = 1,
                                            header = TRUE, format = "%Y-%m-%d", FUN = as.yearmon))

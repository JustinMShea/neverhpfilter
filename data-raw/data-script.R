
library(xts)
# Real GDP
Real_Gross_Domestic_Product <- "https://research.stlouisfed.org/fred2/data/GDPC96.txt"
GDPC96 <- as.xts(read.zoo(Real_Gross_Domestic_Product, skip = 12, index.column = 1,
                        header = TRUE, format = "%Y-%m-%d", FUN = as.yearqtr))



### Employment Rate ###
Total_nonfarm_Payrolls   <- "https://fred.stlouisfed.org/data/PAYEMS.txt"
PAYEMS <- as.xts(read.zoo(Total_nonfarm_Payrolls , sep = "", skip = 42, index.column = 1,
                                            header = TRUE, format = "%Y-%m-%d", FUN = as.yearmon))


###################################################################
# compression data sets to xz level 9 .Rdata files #
###################################################################

dir.create("data")

dataset_list <- c("RGDP", "Employment_Establishment")

for (i in dataset_list) {
  
  save(list = i, file = paste0("data/", i, ".RData"), compress = "xz", compression_level = 9)
  
}

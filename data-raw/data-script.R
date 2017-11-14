
library(xts)
# Real GDP
Real_Gross_Domestic_Product <- "https://research.stlouisfed.org/fred2/data/GDPC1.txt"
GDPC1 <- as.xts(read.zoo(Real_Gross_Domestic_Product, skip = 17, index.column = 1,
                        header = TRUE, format = "%Y-%m-%d", FUN = as.yearqtr))
colnames(GDPC1) <- "GDPC1"


### Employment Rate ###
Total_nonfarm_Payrolls   <- "https://fred.stlouisfed.org/data/PAYEMS.txt"
PAYEMS <- as.xts(read.zoo(Total_nonfarm_Payrolls , sep = "", skip = 42, index.column = 1,
                                            header = TRUE, format = "%Y-%m-%d", FUN = as.yearmon))
colnames(PAYEMS) <- "PAYEMS"

###################################################################
# compression data sets to xz level 9 .Rdata files #
###################################################################

dir.create("data")

dataset_list <- c("PAYEMS", "GDPC1")

for (i in dataset_list) {
  
  save(list = i, file = paste0("data/", i, ".RData"), compress = "xz", compression_level = 9)
  
}


library(xts)
# Real GDP
Real_Gross_Domestic_Product <- "https://research.stlouisfed.org/fred2/data/GDPC1.txt"
GDPC1 <- as.xts(read.zoo(Real_Gross_Domestic_Product, skip = 17, index.column = 1,
                        header = TRUE, format = "%Y-%m-%d", FUN = as.yearqtr))
colnames(GDPC1) <- "GDPC1"


# Employment Rate
Total_nonfarm_Payrolls   <- "https://fred.stlouisfed.org/data/PAYEMS.txt"
PAYEMS <- as.xts(read.zoo(Total_nonfarm_Payrolls , sep = "", skip = 42, index.column = 1,
                                            header = TRUE, format = "%Y-%m-%d", FUN = as.yearmon))
colnames(PAYEMS) <- "PAYEMS"

# US Recessions

Recession_Indicators <- "https://fred.stlouisfed.org/data/USREC.txt"
USREC <- as.xts(read.zoo(Recession_Indicators , sep = "", skip = 69, index.column = 1,
                                   header = TRUE, format = "%Y-%m-%d", FUN = as.yearmon))
colnames(USREC) <- "USREC"

# Hamilton Table 2

Hamilton_table_2 <- read.table(paste0(getwd(),"/data-raw/Hamilton-table-2.txt"),
                               skip=1, row.names=1, stringsAsFactors=FALSE,
                               col.names = c("cycle.sd", "gdp.cycle.sd.cor",
                                             "random.sd", "gdp.random.sd.cor",
                                             "Sample"))
# transform date sample column into xts compatible syntax.
Hamilton_table_2$Sample <- gsub("-","/", Hamilton_table_2$Sample)
Hamilton_table_2$Sample <- gsub(":", "-", Hamilton_table_2$Sample)

###################################################################
# compression data sets to xz level 9 .Rdata files #
###################################################################

dir.create("data")

dataset_list <- c("PAYEMS", "GDPC1", "USREC")

for (i in dataset_list) {

  save(list = i, file = paste0("data/", i, ".RData"), compress = "xz", compression_level = 9)

}

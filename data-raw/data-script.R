
# Hamilton Table 2
Hamilton_table_2 <- read.table(paste0(getwd(),"/data-raw/Hamilton-table-2.txt"),
                               skip=1, row.names=1, stringsAsFactors=FALSE,
                               col.names = c("cycle.sd", "gdp.cor",
                                             "random.sd", "gdp.rand.cor",
                                             "Sample"))

# transform date sample column into xts compatible syntax.
Hamilton_table_2$Sample <- gsub("-","/", Hamilton_table_2$Sample)
Hamilton_table_2$Sample <- gsub(":", "-", Hamilton_table_2$Sample)


library(xts)
# Real GDP
GDPC1 <- as.xts(read.zoo("https://research.stlouisfed.org/fred2/data/GDPC1.txt", 
                         skip = 17, index.column = 1, header = TRUE, 
                         format = "%Y-%m-%d", FUN = as.yearqtr))

colnames(GDPC1) <- "GDPC1"


# Employment Rate
PAYEMS <- as.xts(read.zoo("https://fred.stlouisfed.org/data/PAYEMS.txt", 
                          sep = "", skip = 42, index.column = 1, header = TRUE, 
                          format = "%Y-%m-%d", FUN = as.yearmon))

colnames(PAYEMS) <- "PAYEMS"


# US Recessions
USREC <- as.xts(read.zoo("https://fred.stlouisfed.org/data/USREC.txt", 
                         sep = "", skip = 69, index.column = 1, header = TRUE, 
                         format = "%Y-%m-%d", FUN = as.yearmon))

colnames(USREC) <- "USREC"


# Real Gross Private Domestic Investment
GPDIC1 <- as.xts(read.zoo("https://fred.stlouisfed.org/data/GPDIC1.txt", skip = 13, index.column = 1,
                          header = TRUE, format = "%Y-%m-%d", FUN = as.yearqtr))

colnames(GPDIC1) <- "GPDIC1"

# Real Personal Consumption Expenditures
PCECC96 <- as.xts(read.zoo("https://fred.stlouisfed.org/data/PCECC96.txt", skip = 13, index.column = 1,
                        header = TRUE, format = "%Y-%m-%d", FUN = as.yearqtr))

colnames(PCECC96) <- "PCECC96"

# Real Exports of Goods and Services
EXPGSC1 <- as.xts(read.zoo("https://fred.stlouisfed.org/data/EXPGSC1.txt", skip = 13, index.column = 1,
                             header = TRUE, format = "%Y-%m-%d", FUN = as.yearqtr))

colnames(EXPGSC1) <- "EXPGSC1"

# Real imports of goods and services
IMPGSC1 <- as.xts(read.zoo("https://fred.stlouisfed.org/data/IMPGSC1.txt", skip = 13, index.column = 1,
                             header = TRUE, format = "%Y-%m-%d", FUN = as.yearqtr))

colnames(IMPGSC1) <- "IMPGSC1"

# Real Government Consumption Expenditures and Gross Investment
GCEC1 <- as.xts(read.zoo("https://fred.stlouisfed.org/data/GCEC1.txt", skip = 13, index.column = 1,
                            header = TRUE, format = "%Y-%m-%d", FUN = as.yearqtr))

colnames(GCEC1) <- "GCEC1"

# Civilian Unemployment Rate
UNRATENSA <- as.xts(read.zoo("https://fred.stlouisfed.org/data/UNRATENSA.txt",
                             skip = 24, index.column = 1, header = TRUE,
                             format = "%Y-%m-%d", FUN = as.yearmon))

colnames(UNRATENSA ) <- "UNRATENSA"

# Gross Domestic Product: Implicit Price Deflator
GDPDEF <- as.xts(read.zoo("https://fred.stlouisfed.org/data/GDPDEF.txt", skip = 15,
                          index.column = 1, header = TRUE, format = "%Y-%m-%d",
                          FUN = as.yearqtr))

colnames(GDPDEF) <- "GDPDEF"

# 10-Year Treasury Constant Maturity Rate
GS10 <- as.xts(read.zoo("https://fred.stlouisfed.org/data/GS10.txt", skip = 14,
                          index.column = 1, header = TRUE, format = "%Y-%m-%d",
                          FUN = as.yearmon))

colnames(GS10) <- "GS10"

# Effective Federal Funds Rate
FEDFUNDS <- as.xts(read.zoo("https://fred.stlouisfed.org/data/FEDFUNDS.txt", skip = 60,
                        index.column = 1, header = TRUE, format = "%Y-%m-%d",
                        FUN = as.yearmon))
colnames(FEDFUNDS ) <- "FEDFUNDS"

# Monthly S&P 500 Case Schiller data to 1871
ie_data <- paste0(getwd(),"/data-raw/ie_data.xls")
download.file(url = "http://www.econ.yale.edu/~shiller/data/ie_data.xls", 
              destfile = ie_data, mode="wb")

library(readxl)
SP <- read_xls(ie_data, sheet = 4, skip = 7)

# Rm 6th col 'Fraction' is a repeat of Date 
  # 10th col 'Real Total Return Price'
  # 12th col 'Real TR Scaled Earnings'
  # 13th col  stay column of NAs
  # 14th col 'Cyclically Adjusted Total Return Price Earnings Ratio (TR P/E10 or TR CAPE)
  # 16th col  stray column of NAs
SP <- SP[,c(-6, -10, -12, -14, -15, -16)]

names(SP) <- c("Date", "SP500", "Dividend", "Earnings", "CPI", "GS10",
"Real_SP500", "Real_Dividend", "Real_Earnings", "CAPE")
  
  # CAPE imported as Character vector, fix
    SP$CAPE <- as.numeric(SP$CAPE)

  # clean up non-standard Date format. Example 2018.1, for January 2018.
  SP$Date <- as.character(SP$Date)
  SP$Date <- gsub("\\.", "-", SP$Date)
  SP$Date <- gsub("-1$", "-10", SP$Date)

  # conver to xts
  SP500 <- as.xts(SP[-NROW(SP),-1], order.by = as.yearmon(SP$Date[-NROW(SP)], "%Y-%m"))

  # remove extra data objects before saving data to files.
  rm(SP, ie_data)

  
  ###################################################
 # compression data sets to xz level 9 .Rdata files #
####################################################

dir.create("data")

dataset_list <- ls()

for (i in dataset_list) {

  save(list = i, file = paste0("data/", i, ".RData"), compress = "xz", compression_level = 9)

}

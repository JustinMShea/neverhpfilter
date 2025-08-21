
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
library(quantmod)
# Real GDP
getSymbols("GDPC1", src = "FRED")
# Employment Rate
getSymbols("PAYEMS", src = "FRED")
# US Recessions
getSymbols("USREC", src = "FRED")
# Real Gross Private Domestic Investment
getSymbols("GPDIC1", src = "FRED")
# Real Personal Consumption Expenditures
getSymbols("PCECC96", src = "FRED")
# Real Exports of Goods and Services
getSymbols("EXPGSC1", src = "FRED")
# Real imports of goods and services
getSymbols("IMPGSC1", src = "FRED")
# Real Government Consumption Expenditures and Gross Investment
getSymbols("GCEC1", src = "FRED")
# Civilian Unemployment Rate
getSymbols("UNRATENSA", src = "FRED")
# Recession Indicators Series
getSymbols("USREC", src = "FRED")
# Gross Domestic Product: Implicit Price Deflator
getSymbols("GDPDEF", src = "FRED")
# 10-Year Treasury Constant Maturity Rate
getSymbols("GS10", src = "FRED")
# Effective Federal Funds Rate
getSymbols("FEDFUNDS", src = "FRED")

# Monthly S&P 500 Case Schiller data to 1871
ie_data <- paste0(getwd(),"/data-raw/ie_data.xls")
download.file(url = "http://www.econ.yale.edu/~shiller/data/ie_data.xls",
              destfile = ie_data, mode = "wb")

library(readxl)
SP <- read_xls(ie_data, sheet = 5, skip = 7)

# Rm 6th col 'Fraction' is a repeat of Date
  # 14th col  stray column of NAs
  # 16th col  stray column of NAs
  # 20th col  '10 Year Annualized Stock Real Return'
  # 21st col  '10 Year Annualized Bonds Real Returns'
  # 22nd col  '10 Year Excess Annualized Real Return'
SP <- SP[,c(-6, -14, -16, -20, -21, -22)]

names(SP) <- c("Date", "SP500", "Dividend", "Earnings", "CPI", "GS10",
"Real_SP500", "Real_Dividend", "Real_SP500_TR", "Real_Earnings", "Real_Earnings_TR",
"CAPE", "CAPE_TR","CAPE_Yield","Bond_TR","Real_Bond_TR")

  # CAPE imported as Character vector, fix
    SP$CAPE <- as.numeric(SP$CAPE)
    SP$CAPE_TR <- as.numeric(SP$CAPE_TR)

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

dataset_list <- ls()

for (i in dataset_list) {

  save(list = i, file = paste0("data/", i, ".RData"),
       compress = "xz",
       compression_level = 9)

  print(
    rbind(head(get(i), 1), tail(get(i), 1)
          )
    )

  }

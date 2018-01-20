#' Real Gross Private Domestic Investment
#'
#' \code{GDPIC1} Real Gross Private Domestic Investment
#'
#'@section Notes:
#' BEA Account Code: A006RX
#' 
#' A Guide to the National  Income and Product Accounts of the United States (NIPA) 
#' - (http://www.bea.gov/national/pdf/nipaguid.pdf)
#'
#' @docType data
#'
#' @usage data(GDPIC1)
#'
#' @format An \code{\link{xts}} object of Real Exports of Goods and Services.
#'  \itemize{
#'  \item\strong{Release:} {Gross Domestic Product}
#'  \item\strong{Seasonal Adjustment:} {Seasonally Adjusted Annual Rate} 
#'  \item\strong{Frequency:} {Quarterly}
#'  \item\strong{Units:} {Billions of Chained 2009 Dollars}
#'  \item\strong{Date Range:} {1947-01-01 to 2017-07-01}
#'  \item\strong{Last Updated} {2017-12-21 7:51 AM CST}
#' }
#'
#' @source U.S. Bureau of Economic Analysis \url{https://fred.stlouisfed.org/data/GDPIC1.txt}
#'
#' @examples
#' data(GDPIC1)
#' tail(GDPIC1)
#' plot(GDPIC1, grid.col = "white", col="blue")
"GDPIC1"
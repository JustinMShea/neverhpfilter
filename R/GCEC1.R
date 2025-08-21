#' Real Government Consumption Expenditures and Gross Investment
#'
#' \code{GCEC1} Real Government Consumption Expenditures and Gross Investment
#'
#'@section Notes:
#' BEA Account Code: A822RX
#'
#' A Guide to the National Income and Product Accounts of the United States (NIPA)
#' - (http://www.bea.gov/national/pdf/nipaguid.pdf)
#'
#' @docType data
#'
#' @usage data(GCEC1)
#'
#' @format An \code{\link[xts]{xts}} object containing observations of Real Exports of Goods and Services.
#'  \itemize{
#'  \item\strong{Release:} Gross Domestic Product
#'  \item\strong{Seasonal Adjustment:} Seasonally Adjusted Annual Rate
#'  \item\strong{Frequency:} Quarterly
#'  \item\strong{Units:} Billions of Chained 2012 Dollars
#'  \item\strong{Date Range:} 1947-01-01 to 2021-07-01
#'  \item\strong{Last Updated} 2021-12-22 7:53 AM CST
#' }
#'
#' @source U.S. Bureau of Economic Analysis \url{https://fred.stlouisfed.org/data/GCEC1}
#'
#' @examples
#' data(GCEC1)
#' tail(GCEC1)
#' plot(GCEC1, grid.col = "white", col="blue")
"GCEC1"

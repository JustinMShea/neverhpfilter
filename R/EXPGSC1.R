#' Real Exports of Goods and Services
#'
#' \code{EXPGSC1} Real Exports of Goods and Services
#'
#'@section Notes:
#' BEA Account Code: A020RX
#' 
#' A Guide to the National Income and Product Accounts of the United States (NIPA) 
#' - (http://www.bea.gov/national/pdf/nipaguid.pdf)
#'
#' @docType data
#'
#' @usage data(EXPGSC1)
#'
#' @format An \code{\link{xts}} object of Real Exports of Goods and Services.
#'  \itemize{
#'  \item\strong{Release:} {Gross Domestic Product}
#'  \item\strong{Seasonal Adjustment:} {Seasonally Adjusted Annual Rate} 
#'  \item\strong{Frequency:} {Quarterly}
#'  \item\strong{Units:} {Billions of Chained 2012 Dollars}
#'  \item\strong{Date Range:} {1947-01-01 to 2021-07-01}
#'  \item\strong{Last Updated} {2021-12-22 7:53 AM CST}
#' }
#'
#' @source U.S. Bureau of Economic Analysis \url{https://fred.stlouisfed.org/data/EXPGSC1.txt}
#'
#' @examples
#' data(EXPGSC1)
#' tail(EXPGSC1)
#' plot(EXPGSC1,grid.col = "white", col="blue")
"EXPGSC1"
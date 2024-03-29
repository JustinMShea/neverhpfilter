#'  Real imports of goods and services
#'
#' \code{IMPGSC1} Real imports of goods and services
#'
#' @section Notes:
#' BEA Account Code: A021RX
#' 
#' A Guide to the National Income and Product Accounts of the United States (NIPA) 
#' - (http://www.bea.gov/national/pdf/nipaguid.pdf)
#'
#' @docType data
#'
#' @usage data(IMPGSC1)
#'
#' @format An \code{\link{xts}} object of Real imports of goods and services.
#'  \itemize{
#'  \item\strong{Release:} {Gross Domestic Product}
#'  \item\strong{Seasonal Adjustment:} {Seasonally Adjusted Annual Rate} 
#'  \item\strong{Frequency:} {Quarterly}
#'  \item\strong{Units:} {Billions of Chained 2012 Dollars}
#'  \item\strong{Date Range:} {1947-01-01 to 2021-07-01}
#'  \item\strong{Last Updated} {2021-12-22 7:53 AM CST}
#' }
#'
#' @source U.S. Bureau of Economic Analysis \url{https://fred.stlouisfed.org/data/IMPGSC1.txt}
#'
#' @examples
#' data(IMPGSC1)
#' tail(IMPGSC1)
#' plot(IMPGSC1,grid.col = "white", col="blue")
"IMPGSC1"
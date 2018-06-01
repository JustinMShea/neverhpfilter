#'  Real Personal Consumption Expenditures
#'
#' \code{PCECC96} Real Personal Consumption Expenditures
#'
#' @section Notes:
#' BEA Account Code: DPCERX
#' 
#' A Guide to the National Income and Product Accounts of the United States (NIPA) 
#' - (http://www.bea.gov/national/pdf/nipaguid.pdf)
#'
#' @docType data
#'
#' @usage data(PCECC96)
#'
#' @format An \code{\link{xts}} object of Real Personal Consumption Expenditures.
#'  \itemize{
#'  \item\strong{Release:} {Gross Domestic Product}
#'  \item\strong{Seasonal Adjustment:} {Seasonally Adjusted Annual Rate} 
#'  \item\strong{Frequency:} {Quarterly}
#'  \item\strong{Units:} {Billions of Chained 2009 Dollars}
#'  \item\strong{Date Range:} {1947-01-01 to 2018-01-01}
#'  \item\strong{Last Updated} {2018-05-30 7:52 AM CDT}
#' }
#'
#' @source U.S. Bureau of Economic Analysis \url{https://fred.stlouisfed.org/data/PCECC96.txt}
#'
#' @examples
#' data(PCECC96)
#' tail(PCECC96)
#' plot(PCECC96,grid.col = "white", col="blue")
"PCECC96"
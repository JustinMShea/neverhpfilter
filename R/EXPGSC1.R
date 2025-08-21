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
#' @format An \code{\link[xts]{xts}} object of Real Exports of Goods and Services.
#'  \itemize{
#'  \item\strong{Release:} Gross Domestic Product
#'  \item\strong{Seasonal Adjustment:} Seasonally Adjusted Annual Rate
#'  \item\strong{Frequency:} Quarterly
#'  \item\strong{Units:} Billions of Chained 2017 Dollars
#'  \item\strong{Date Range:} 1947-01-01 to 2025-04-01
#' }
#'
#' @source U.S. Bureau of Economic Analysis \url{https://fred.stlouisfed.org/data/EXPGSC1}
#'
#' @examples
#' data(EXPGSC1)
#' tail(EXPGSC1)
#' plot(EXPGSC1,grid.col = "white", col="blue")
"EXPGSC1"

#' Real Personal Consumption Expenditures
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
#' @format An \code{\link[xts]{xts}} object containing quarterly observations of
#' Real Personal Consumption Expenditures.
#' \describe{
#'   \item{**Release:**}{Gross Domestic Product}
#'   \item{**Seasonal Adjustment:**}{Seasonally Adjusted Annual Rate}
#'   \item{**Frequency:**}{Quarterly}
#'   \item{**Units:**}{Billions of Chained 2012 Dollars}
#'   \item{**Date Range:**}{1947-01-01 to 2021-07-01}
#'   \item{**Last Updated:**}{2021-12-22 7:52 AM CST}
#' }
#'
#' @source U.S. Bureau of Economic Analysis \url{https://fred.stlouisfed.org/data/PCECC96.txt}
#'
#' @examples
#' data(PCECC96)
#' tail(PCECC96)
#' plot(PCECC96, grid.col = "white", col = "blue")
"PCECC96"

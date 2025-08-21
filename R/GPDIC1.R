#' Real Gross Private Domestic Investment
#'
#' \code{GPDIC1} Real Gross Private Domestic Investment
#'
#' @section Notes:
#' BEA Account Code: A006RX
#'
#' A Guide to the National Income and Product Accounts of the United States (NIPA)
#' - (http://www.bea.gov/national/pdf/nipaguid.pdf)
#'
#' @docType data
#'
#' @usage data(GPDIC1)
#'
#' @format An \code{\link[xts]{xts}} object containing quarterly observations of
#' Real Gross Private Domestic Investment.
#' \describe{
#'   \item{**Release:**}{Gross Domestic Product}
#'   \item{**Seasonal Adjustment:**}{Seasonally Adjusted Annual Rate}
#'   \item{**Frequency:**}{Quarterly}
#'   \item{**Units:**}{Billions of Chained 2012 Dollars}
#'   \item{**Date Range:**}{1947-01-01 to 2021-07-01}
#'   \item{**Last Updated:**}{2021-12-22 7:53 AM CST}
#' }
#'
#' @source U.S. Bureau of Economic Analysis \url{https://fred.stlouisfed.org/data/GPDIC1.txt}
#'
#' @examples
#' data(GPDIC1)
#' tail(GPDIC1)
#' plot(GPDIC1, grid.col = "white", col = "blue")
"GPDIC1"

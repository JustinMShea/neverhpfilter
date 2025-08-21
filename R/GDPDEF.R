#' Gross Domestic Product: Implicit Price Deflator
#'
#' \code{GDPDEF} Gross Domestic Product: Implicit Price Deflator
#'
#' @section Notes:
#' BEA Account Code: A191RD
#'
#' The number of decimal places reported varies over time.
#' A Guide to the National Income and Product Accounts of the United States (NIPA)
#' - (http://www.bea.gov/national/pdf/nipaguid.pdf)
#'
#' @docType data
#'
#' @usage data(GDPDEF)
#'
#' @format An \code{\link[xts]{xts}} object containing quarterly observations of the
#' Gross Domestic Product: Implicit Price Deflator.
#' \describe{
#'   \item{**Release:**}{Gross Domestic Product}
#'   \item{**Seasonal Adjustment:**}{Seasonally Adjusted Annual Rate}
#'   \item{**Frequency:**}{Quarterly}
#'   \item{**Units:**}{Index 2012 = 100}
#'   \item{**Date Range:**}{1947-01-01 to 2021-07-01}
#'   \item{**Last Updated:**}{2021-11-24 7:55 AM CST}
#' }
#'
#' @source U.S. Bureau of Economic Analysis \url{https://fred.stlouisfed.org/data/GDPDEF.txt}
#'
#' @examples
#' data(GDPDEF)
#' head(GDPDEF)
#' tail(GDPDEF)
#' plot(GDPDEF, col = "blue")
"GDPDEF"

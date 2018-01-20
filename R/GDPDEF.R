#' Gross Domestic Product: Implicit Price Deflator
#'
#' \code{GDPDEF} Gross Domestic Product: Implicit Price Deflator
#'
#'@section Notes:
#' BEA Account Code: A191RD
#' 
#' The number of decimal places reported varies over time. A Guide to the National 
#' Income and Product Accounts of the United States (NIPA) - (http://www.bea.gov/national/pdf/nipaguid.pdf)
#'
#' @docType data
#'
#' @usage data(GDPDEF)
#'
#' @format An \code{\link{xts}} object containing observations of Real Exports of Goods and Services.
#'  \itemize{
#'  \item\strong{Release:} {Gross Domestic Product}
#'  \item\strong{Seasonal Adjustment:} {Seasonally Adjusted Annual Rate} 
#'  \item\strong{Frequency:} {Quarterly}
#'  \item\strong{Units:} {Index 2009 = 100}
#'  \item\strong{Date Range:} {1947-01-01 to 2017-07-01}
#'  \item\strong{Last Updated} {2017-12-21 7:51 AM CST}
#' }
#'
#' @source U.S. Bureau of Economic Analysis \url{https://fred.stlouisfed.org/data/GDPDEF.txt}
#'
#' @examples
#' data(GDPDEF)
#' tail(GDPDEF)
#' plot(GDPDEF, grid.col = "white", col="blue")
"GDPDEF"
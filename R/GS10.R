#' 10-Year Treasury Constant Maturity Rate
#'
#' \code{GS10} 10-Year Treasury Constant Maturity Rate
#'
#' @section Notes:
#'  Averages of business days. 
#'  
#'  For further information regarding treasury
#'  constant maturity data, please refer to http://www.federalreserve.gov/releases/h15/current/h15.pdf and
#'  http://www.treasury.gov/resource-center/data-chart-center/interest-rates/Pages/yieldmethod.aspx.
#'
#'
#' @docType data
#'
#' @usage data(GS10)
#'
#' @format An \code{\link{xts}} object containing observations of the 10-Year Treasury Constant Maturity Rate.
#'  \itemize{
#'  \item\strong{Release:} {H.15 Selected Interest Rates}
#'  \item\strong{Seasonal Adjustment:} {Not Seasonally Adjusted}
#'  \item\strong{Frequency:} {Monthly}
#'  \item\strong{Units:} {Percent}
#'  \item\strong{Date Range:} {1953-04-01 to 2021-04-01}
#'  \item\strong{Last Updated} {2021-05-03 3:23 PM CDT}
#' }
#'
#' @source Board of Governors of the Federal Reserve System (US) 
#' \url{https://fred.stlouisfed.org/data/GS10.txt}
#'
#' @examples
#' data(GS10)
#' tail(GS10)
#' plot(GS10, grid.col = "white", col="green")
"GS10"

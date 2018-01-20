#' Gross Domestic Product
#'
#' \code{GDPC1} Real Gross Domestic Product
#'
#'@section Notes:
#' Real gross domestic product is the inflation adjusted value of the goods and
#' services produced by labor and property located in the United States.
#'
#' For more information see the Guide to the National Income and Product Accounts
#' of the United States (NIPA) - \url{http://www.bea.gov/national/pdf/nipaguid.pdf}.
#'
#' BEA Account Code: A191RX
#'
#'
#' @docType data
#'
#' @usage data(GDPC1)
#'
#' @format An \code{\link{xts}} object of Real Gross Domestic Product.
#'  \itemize{
#'  \item\strong{Release:} {Gross Domestic Product}
#'  \item\strong{Seasonal Adjustment:} {Seasonally Adjusted Annual Rate} 
#'  \item\strong{Frequency:} {Quarterly}
#'  \item\strong{Units:} {Billions of Chained 2009 Dollars}
#'  \item\strong{Date Range:} {1947-01-01 to 2017-07-01}
#'  \item\strong{Last Updated} {2017-12-21 7:51 AM CST}
#' }
#'
#' @source U.S. Bureau of Economic Analysis \url{https://fred.stlouisfed.org/data/GDPC1.txt}
#'
#' @examples
#' data(GDPC1)
#' tail(GDPC1)
#' plot(GDPC1, grid.col = "white", col="blue")
"GDPC1"



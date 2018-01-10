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
#'
#' @docType data
#'
#' @usage data(GDPC1)
#'
#' @format An \code{\link{xts}} object containing quarterly observations of Real Gross Domestic Product.
#'  \itemize{
#'  \item\strong{GDPC1} {Seasonally Adjusted Annual Rate, in Billions of Chained 2009 Dollars.}
#' }
#'
#' @source U.S. Bureau of Economic Analysis \url{https://fred.stlouisfed.org/data/GDPC1.txt}
#'
#' @examples
#' data(GDPC1)
#' tail(GDPC1)
#' plot(GDPC1,grid.col = "white", col="blue")
"GDPC1"



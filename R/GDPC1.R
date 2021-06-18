#' Gross Domestic Product
#'
#' \code{GDPC1} Real Gross Domestic Product
#'
#'@section Notes:
#' Real gross domestic product is the inflation adjusted value of the goods and
#' services produced by labor and property located in the United States.
#'
#' For more information see the Guide to the National Income and Product Accounts
#' of the United States (NIPA) - \url{https://www.bea.gov/resources/methodologies/nipa-handbook}.
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
#'  \item\strong{Units:} {Billions of Chained 2012 Dollars}
#'  \item\strong{Date Range:} {1947-01-01 to 2021-01-01}
#'  \item\strong{Last Updated} {2021-04-29 7:52 AM CDT}
#' }
#'
#' @source U.S. Bureau of Economic Analysis \url{https://fred.stlouisfed.org/data/GDPC1.txt}
#'
#' @examples
#' data(GDPC1)
#' log_RGDP <- 100*log(GDPC1)
#' 
#' gdp_cycle <- yth_filter(log_RGDP, h = 8, p = 4, output = c("cycle", "random"), family = gaussian)
#' 
#' main <- "Log of Real GDP cycle and random walk"
#' plot(gdp_cycle, grid.col = "white", legend.loc = "topright", main = main)
"GDPC1"



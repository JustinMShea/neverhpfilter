#' Real Gross Private Domestic Investment
#'
#' \code{GPDIC1} Real Gross Private Domestic Investment
#'
#'@section Notes:
#' BEA Account Code: A006RX
#' 
#' A Guide to the National  Income and Product Accounts of the United States (NIPA) 
#' - (http://www.bea.gov/national/pdf/nipaguid.pdf)
#'
#' @docType data
#'
#' @usage data(GPDIC1)
#'
#' @format An \code{\link{xts}} object of Real Exports of Goods and Services.
#'  \itemize{
#'  \item\strong{Release:} {Gross Domestic Product}
#'  \item\strong{Seasonal Adjustment:} {Seasonally Adjusted Annual Rate} 
#'  \item\strong{Frequency:} {Quarterly}
#'  \item\strong{Units:} {Billions of Chained 2012 Dollars}
#'  \item\strong{Date Range:} {1947-01-01 to 2021-07-01}
#'  \item\strong{Last Updated} {2021-12-22 7:53 AM CST}
#' }
#'
#' @source U.S. Bureau of Economic Analysis \url{https://fred.stlouisfed.org/data/GPDIC1.txt}
#'
#' @examples
#' data(GPDIC1)
#' 
#' tail(GPDIC1)
#' 
#' plot(GPDIC1, grid.col = "white", col="blue")
"GPDIC1"
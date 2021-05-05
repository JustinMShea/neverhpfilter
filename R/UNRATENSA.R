#' Civilian Unemployment Rate
#'
#' \code{UNRATENSA} Civilian Unemployment Rate
#'
#' @section Notes:
#' The unemployment rate represents the number of unemployed as a
#' percentage of the labor force. Labor force data are restricted to
#' people 16 years of age and older, who currently reside in 1 of the 50
#' states or the District of Columbia, who do not reside in institutions
#' (e.g., penal and mental facilities, homes for the aged), and who are
#' not on active duty in the Armed Forces.
#' 
#' This rate is also defined as the U-3 measure of labor underutilization.
#' 
#' The series comes from the 'Current Population Survey (Household Survey)'
#' 
#' The source code is: LNU04000000
#'
#' @docType data
#'
#' @usage data(UNRATENSA)
#'
#' @format An \code{\link{xts}} object of the Civilian Unemployment Rate.
#'  \itemize{
#'  \item\strong{Release:} {Employment Situation}
#'  \item\strong{Seasonal Adjustment:} {Not Seasonally Adjusted}
#'  \item\strong{Frequency:} {Monthly}
#'  \item\strong{Units:} {Percent}
#'  \item\strong{Date Range:} {1948-01-01 to 2021-03-01}
#'  \item\strong{Last Updated} {2021-04-02 7:44 AM CDT}
#' }
#'
#' @source U.S. Bureau of Labor Statistics \url{https://fred.stlouisfed.org/data/UNRATENSA.txt}
#'
#' @examples
#' data(UNRATENSA)
#' tail(UNRATENSA)
#' plot(UNRATENSA, grid.col = "white", col="green")
"UNRATENSA"

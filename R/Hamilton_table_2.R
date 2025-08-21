#' Hamilton_table_2
#'
#' Standard deviation of cyclical component and correlation with cyclical
#' component of GDP for assorted macroeconomic series.
#'
#' @section Notes:
#' Filtered series were based on the full sample available for that variable,
#' while correlations were calculated using the subsample of overlapping values
#' for the two indicators. Note that the regression residuals lose the first 11
#' observations and the random-walk calculations lose the first 8 observations.
#'
#' @docType data
#'
#' @usage data("Hamilton_table_2")
#'
#' @format A \code{data.frame} containing 13 economic time series observations
#' of 5 variables:
#' \describe{
#'   \item{**cycle.sd:**}{Standard deviation of the cycle component,
#'   computed with function \code{yth_filter(x, output = "cycle")}.}
#'   \item{**gdp.cor:**}{Correlation of \code{cycle.sd} with the cycle.sd of
#'   \code{100 * log(RealGDP)}.}
#'   \item{**random.sd:**}{Standard deviation of a random walk, computed by
#'   rolling differencing the series by period \code{h}, the same \code{h} passed
#'   to \code{yth_filter(x, output = "cycle")} to compute \code{cycle.sd}.}
#'   \item{**gdp.rand.cor:**}{Correlation of \code{random.sd} with the random.sd
#'   of \code{100 * log(RealGDP)}.}
#' }
#'
#' @source Hamilton, James D. (2018). *Why You Should Never Use the Hodrick-Prescott Filter*,
#' pg. 40. \url{http://econweb.ucsd.edu/~jhamilto/hp.pdf}
#'
#' @examples
#' print(Hamilton_table_2)
"Hamilton_table_2"

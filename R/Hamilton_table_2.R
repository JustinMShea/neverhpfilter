#' Hamilton_table_2
#'
#' Standard deviation of cyclical component and correlation with cyclical
#' component of GDP for assorted macroeconomic series.
#'
#'@section Notes:
#' Filtered series were based on the full sample available for that variable,
#' while correlations were calculated using the subsample of overlapping values
#' for the two indicators. Note that the regression residuals lose the first 11
#' observations and the random-walk calculations lose the first 8 observations.
#'
#'
#' @docType data
#'
#' @usage data("Hamilton_table_2")
#'
#' @format A data.frame containing 13 economic time series observations of 5 variables.
#'  \itemize{
#'  \item\strong{cycle.sd} {Standard deviation  of the cycle component, computed with function `yth_cycle`}
#'  \item\strong{gdp.cor} {Correlation of `cycle.sd` with the cycle.sd of 100 * log(RealGDP)}
#'  \item\strong{random.sd} {Standard deviation of a Random-walk, computed by a rolling differencing the series by period `h`, the same passed to `yth_cycle` to compute `cycle.sd`.}
#'  \item\strong{gdp.rand.cor} {Correlation of `random.sd` with the random.sd of 100 * log(RealGDP).}
#'  }
#'
#' @source "Why You Should Never Use the Hodrick-Prescott Filter", pg. 40 \url{http://econweb.ucsd.edu/~jhamilto/hp.pdf}
#'
#' @examples  print(Hamilton_table_2)
"Hamilton_table_2"



#' Hamilton Filtered ar(x) quarterly xts object.
#'
#' \code{HL_filter_ar} returns an xts object containing the original series,
#'                  the difference between t+h and t, the fitted (trend) values, as well
#'                  as the residual (cyclical) component.
#'
#'@param x An xts object of quarterly periodicity.
#'
#'@param h The look ahead parameter indicating the length of the first lag. Default to h = 8, or 8 quarters.
#'
#'@param p The number of lagged AR terms. Default is p = 4, to reflect 4 quarters of an annual time series.
#'
#'@references James D. Hamilton. Why You Should Never Use the Hodrick-Prescott Filter.
#'            NBER Working Paper No. 23429, Issued in May 2017.
#'
#'@examples
#'\dontrun{
#' HL_filter(PAYEMS, h = 8)
#'}
#'
HL_filter_ar <- function(x, h = 8, p = 4, ...) {
  
  if (!requireNamespace("xts", quietly = TRUE)) {
   stop("xts package dependent. Please install it.",
         call. = FALSE)
  }
  
  # Transform data
  DF <- merge(x,
              xts::lag.xts(x, k = h, na.pad = TRUE),
              xts::lag.xts(x, k = h+1, na.pad = TRUE),
              xts::lag.xts(x, k = h+2, na.pad = TRUE),
              xts::lag.xts(x, k = h+3, na.pad = TRUE))
  colnames(DF) <- c("x_h", "x", "x_1", "x_2", "x_3")
  DF
  # linear model data
  stats::ar.ols(DF$x_h, aic = FALSE, order.max = p, n.ahead = 8)
  
  # convert fitted and residuals to xts objects
  #HL_fit <- xts::as.xts(unname(HL_Filter$fitted.values),
  #                      order.by = zoo::as.yearqtr(names(HL_Filter$fitted.values)))
  
  #HL_resid <- xts::as.xts(unname(HL_Filter$residuals),
  #                        order.by = zoo::as.yearqtr(names(HL_Filter$residuals)))
  
  # merge together relevant components
  #merge(DF$x_h, DF$x_h-DF$x, HL_fit, HL_resid)
  
}


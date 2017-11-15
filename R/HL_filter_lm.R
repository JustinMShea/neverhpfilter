#' Hamilton Filtered quarterly time series Linear Model
#' 
#' For time series of quarterly periodicity, Hamilton's solution can be described as an \eqn{AR(4)} process, 
#' additionally lagged by \eqn{h} periods. \deqn{y_{t+h} = \beta_0 + \beta_1 y_t + \beta_2 y_{t-1} +\beta_3 y_{t-2} + \beta_4 y_{t-3} + v_{t+h}}
#' \deqn{\hat{v}_{t+h} = y_{t+h} + \hat{\beta}_0 + \hat{\beta}_1 y_t + \hat{\beta}_2 y_{t-1} + \hat{\beta}_3 y_{t-2} + \hat{\beta}_4 y_{t-3}}
#'
#'\value{
#' \strong\code{HL_filter_lm} returns a linear model of class "formula", like the output created by `stats::lm`.
#'}
#'
#'@param x An xts object of quarterly periodicity.
#'
#'@param h The look ahead parameter indicating the length of the AR(4) lag. Default to h = 8, or 8 quarters.
#'
#'@param ... see "lm"
#'
#'@inheritParams stats::lm see "lm"
#'
#'@references James D. Hamilton. Why You Should Never Use the Hodrick-Prescott Filter.
#'            NBER Working Paper No. 23429, Issued in May 2017.
#'
#'@examples
#' HL_filter_lm(GDPC1, h = 8)
#' 
#'@export
HL_filter_lm <- function(x, h = 8, ...) {

  #      if (!requireNamespace("xts", quietly = TRUE)) {
   #             stop("Pkg xts needed for this function to work. Please install it.",
    #                 call. = FALSE)
     #   }

  DF <- merge(xts::lag.xts(x, k = -h, na.pad = TRUE),
                           x,
              xts::lag.xts(x, k = 1, na.pad = TRUE),
              xts::lag.xts(x, k = 2, na.pad = TRUE),
              xts::lag.xts(x, k = 3, na.pad = TRUE))
  
  colnames(DF) <- c("x_h", "x", "x_1", "x_2", "x_3")

  HL_Filter <- stats::lm(x_h ~ x + x_1 + x_2 + x_3, data = DF)

  HL_Filter

}

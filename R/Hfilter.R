#' Hamilton Filtered quarterly time series
#' 
#' For time series of quarterly periodicity, Hamilton's solution can be described as an \eqn{AR(4)} process, 
#' additionally lagged by \eqn{h} periods. \deqn{y_{t+h} = \beta_0 + \beta_1 y_t + \beta_2 y_{t-1} +\beta_3 y_{t-2} + \beta_4 y_{t-3} + v_{t+h}}
#' \deqn{\hat{v}_{t+h} = y_{t+h} + \hat{\beta}_0 + \hat{\beta}_1 y_t + \hat{\beta}_2 y_{t-1} + \hat{\beta}_3 y_{t-2} + \hat{\beta}_4 y_{t-3}}
#'
#'
#' @return \code{Hfilter} returns an xts object containing the original series,
#'                   the fitted (trend) values, the residual (cycle) component,
#'                   and the difference between \eqn{y_{t+h}} and \eqn{y_t}.
#'                   
#'
#'@param x An xts object of quarterly periodicity.
#'
#'@param h The look ahead parameter indicating the length of the AR(4) lag. Default to h = 8, or 8 quarters.
#'
#'@param ... see function "stats::lm"
#'
#'@inheritParams stats::lm see "lm"
#'
#'@references James D. Hamilton. Why You Should Never Use the Hodrick-Prescott Filter.
#'            NBER Working Paper No. 23429, Issued in May 2017.
#'
#'@examples
#'GDPC1_Hfilter <- Hfilter(GDPC1, h = 8)
#'plot(GDPC1_Hfilter)
#'
#'@export
Hfilter <- function(x, h = 8, ...) {

                if (!requireNamespace("xts", quietly = TRUE)) {
                        stop("xts package dependent. Please load.",
                             call. = FALSE)
                }

        # Transform data
             extensible <- merge(x,
                    xts::lag.xts(x, k = h, na.pad = TRUE),
                    xts::lag.xts(x, k = h+1, na.pad = TRUE),
                    xts::lag.xts(x, k = h+2, na.pad = TRUE),
                    xts::lag.xts(x, k = h+3, na.pad = TRUE))
        colnames(extensible) <- c("y_h", "x", "x_1", "x_2", "x_3")

        # linear model data
        alt_Filter <- stats::lm(y_h ~ x + x_1 + x_2 + x_3, data = extensible)

        # convert fitted and residuals to xts objects
        trend <- xts::as.xts(unname(alt_Filter$fitted.values),
                         order.by = zoo::as.yearqtr(names(alt_Filter$fitted.values)))

        cycle <- xts::as.xts(unname(alt_Filter$residuals),
                           order.by = zoo::as.yearqtr(names(alt_Filter$residuals)))

        # merge together relevant components
        output <- merge(extensible$y_h, trend, cycle, extensible$y_h - extensible$x)
        
        colnames(output) <- c("y_h","trend", "cycle", "y_h-x")
        
        output

}


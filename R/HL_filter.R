#' Hamilton Filtered quarterly xts object.
#'
#' \code{HL_filter} returns an xts object containing the original series,
#'                  the difference between t+h and t, the fitted (trend) values, as well
#'                  as the residual (cyclical) component.
#'
#'@param x An xts object of quarterly periodicity.
#'
#'@param h The look ahead parameter indicating the length of the AR(4) lag. Default to h = 8, or 8 quarters.
#'
#'@references James D. Hamilton. Why You Should Never Use the Hodrick-Prescott Filter.
#'            NBER Working Paper No. 23429, Issued in May 2017.
#'
#'@examples
#'\dontrun{
#' HL_filter(PAYEMS, h = 8)
#'}
#'@export
HL_filter <- function(x, h = 8, ...) {

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
        colnames(extensible) <- c("x_h", "x", "x_1", "x_2", "x_3")

        # linear model data
        alt_Filter <- stats::lm(x_h ~ x + x_1 + x_2 + x_3, data = extensible)

        # convert fitted and residuals to xts objects
        fit <- xts::as.xts(unname(alt_Filter$fitted.values),
                         order.by = zoo::as.yearqtr(names(alt_Filter$fitted.values)))

        resid <- xts::as.xts(unname(alt_Filter$residuals),
                           order.by = zoo::as.yearqtr(names(alt_Filter$residuals)))

        # merge together relevant components
        merge(extensible$x_h, h = (extensible$x_h - extensible$x), fit, resid)

}


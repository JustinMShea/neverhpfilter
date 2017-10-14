#' Linear Model Hamilton Filtered quarterly xts object.
#'
#' \code{HL_filter_lm} returns a hamilton filtered linear model of class "formula"
#'
#'@param x An xts object of quarterly periodicity.
#'
#'@param h The look ahead parameter indicating the length of the AR(4) lag. Default to h = 8, or 8 quarters.
#'
#'@param ... see "lm"
#'
#' @inheritParams lm Inherits arguements from "stats::lm"
#'
#'@examples
#'\dontrun{
#' HL_filter_lm(GDPC96, h = 8)
#'}
HL_filter_lm <- function(x, h = 8, ...) {

        if (!requireNamespace("pkg", quietly = TRUE)) {
                stop("Pkg xts needed for this function to work. Please install it.",
                     call. = FALSE)
        }

  DF <- merge(xts::lag.xts(x, k = -h, na.pad = TRUE),
                           x,
              xts::lag.xts(x, k = 1, na.pad = TRUE),
              xts::lag.xts(x, k = 2, na.pad = TRUE),
              xts::lag.xts(x, k = 3, na.pad = TRUE))

  colnames(DF) <- c("x_h", "x", "x_1", "x_2", "x_3")

  HL_Filter <- stats::lm(x_h ~ x + x_1 + x_2 + x_3, data = DF)

  HL_Filter

}

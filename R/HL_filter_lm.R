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
#'@references James D. Hamilton. Why You Should Never Use the Hodrick-Prescott Filter.
#'            NBER Working Paper No. 23429, Issued in May 2017.
#'
#'@examples
#'\dontrun{
#' HL_filter_lm(GDPC1, h = 8)
#'}
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

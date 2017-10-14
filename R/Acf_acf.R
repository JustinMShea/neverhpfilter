#' Autocorrelation wrapper function to `apply` over xts
#'
#'@param x Vector of ordered observations.
#'
#'
Acf_acf <- function(x) {
        y <- forecast::Acf(x, plot = FALSE)[["acf"]]
        y
}

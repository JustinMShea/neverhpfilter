#' Hodrick-Prescott filter of a time series
#'
#'\code{hpfilter()} This function implements the Hodrick-Prescott for estimating
#'                  cyclical and trend component of a time series. The function
#'                  computes cyclical and trend components of the time series
#'                  using a frequency cut-off or smoothness parameter.
#'
#'@param x A regular time series.
#'
#'@param lambda The smoothing parameter (lambda) of the Hodrick-Prescott filter
#'
#'@references R.J. Hodrick and E.C. Prescott. Postwar US business cycles: an empirical investigation. Journal of Money, Credit, and Banking, 29(1):1-16, 1997.
#'
#'@examples
#'\dontrun{
#' hp_PAYEMS <- hpfilter(PAYEMS, lambda = 1600)
#'}
hpfilter <- function(x, lambda = 1600){

        eye <- diag(length(x))
        result <- solve(eye + lambda*crossprod(diff(eye, lag=1, d=2)), x)

        return(result)
}

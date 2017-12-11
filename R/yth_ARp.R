#' An alternative to the Hodrick-Prescott Filter
#'
#' For time series of quarterly periodicity, Hamilton suggests an \eqn{AR(4)} process,
#' additionally lagged by \eqn{h} periods. \deqn{y_{t+h} = \beta_0 + \beta_1 y_t + \beta_2 y_{t-1} + \beta_3 y_{t-2} + \beta_4 y_{t-3} + v_{t+h}}
#' \deqn{\hat{v}_{t+h} = y_{t+h} - \hat{\beta}_0 + \hat{\beta}_1 y_t + \hat{\beta}_2 y_{t-1} + \hat{\beta}_3 y_{t-2} + \hat{\beta}_4 y_{t-3}}
#'
#'@return \code{yth_ARp} returns a linear model of class "formula", identical to the output created by `stats::lm`.
#'
#'@param x An xts object.
#'
#'@param h The look ahead parameter. Default to h = 8, or 8 quarters for two years.
#'
#'@param p Idicating the number of lags. Default to p = 4, or 4 quarters for one year.
#'
#'@param ... see "lm"
#'
#'@inheritParams stats::lm see "lm"
#'
#'@references James D. Hamilton. "Why You Should Never Use the Hodrick-Prescott Filter".
#'            NBER Working Paper No. 23429, Issued in May 2017.
#'
#'@examples
#' yth_AR(GDPC1, h = 8)
#'
#'@export
yth_ARp <- function(x, h = 8, p = 4, ...) {

        if(!"xts" %in% class(x)) {

        stop("This function requires an xts object.")

        } else {

        yth <- lag(x, k = c(-h, 0:(p-1)), na.pad = TRUE)

        lagnames <- c(paste0("yt",h), paste0('Xt_',0:(p-1)))
        colnames(yth) <- lagnames

        stats::lm(get(lagnames[1]) ~ ., data = yth)
        }
}

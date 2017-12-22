#' A better Hodrick-Prescott Filter
#'
#' For time series of quarterly periodicity, Hamilton suggests an \eqn{AR(4)} process,
#' regressed against a look ahead of \eqn{h} periods. \deqn{y_{t+h} = \beta_0 + \beta_1 y_t + \beta_2 y_{t-1} + \beta_3 y_{t-2} + \beta_4 y_{t-3} + v_{t+h}}
#' \deqn{\hat{v}_{t+h} = y_{t+h} - \hat{\beta}_0 + \hat{\beta}_1 y_t + \hat{\beta}_2 y_{t-1} + \hat{\beta}_3 y_{t-2} + \hat{\beta}_4 y_{t-3}}
#'
#'@return \code{yt_ar} returns a linear model estimed by ordinary least squares of class "formula".
#'
#'@param x An univariate xts series of zoo index class, such as "Date", "yearmon", or "yearqtr".
#'
#'@param h The look ahead parameter. Default to h = 8, or 8 quarters for two years of look ahead data.
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
#' yt_ar(GDPC1, h = 8, p = 4)
#'
#'@export
yt_ar <- function(x, h = 8, p = 4, ...) {

               if(!"xts" %in% class(x)) {

stop(paste("Arguement 'x' be an object of type xts.", class(x), "is not an xts object"))

        } else if(h %% 1 != 0) {

stop(paste("Argument 'h' must be a whole number.", h, "is not a whole number."))

        } else if(p %% 1 != 0) {

stop(paste("Argument 'p' must be a whole number.", p, "is not a whole number."))

        } else {


                 data  <- lag(x, k = c(0, h:(h+p-1)), na.pad = TRUE)

           data_names  <- c(paste0("yt",h), paste0('Xt_',0:(p-1)))

        colnames(data) <- data_names

               formula <- paste0(c(paste0(paste0("yt",h)," ~ Xt_0"), paste0('+ Xt_',1:(p-1))), collapse = " ")

                          stats::lm(formula, data = data)

                }
}

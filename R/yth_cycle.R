#' Estimates cyclical component
#'
#' \code{yth_cycle} returns the cyclical component of Hamilton's alternative to the HP-Filter.
#'
#' For time series of quarterly periodicity, Hamilton suggests parameters of
#'  h = 8 and p = 4, or an \eqn{AR(4)} process, additionally lagged by \eqn{8}
#'  lookahead periods. Econometricians may explore variations of h. However, p is designed to correspond with the seasonality of a given periodicity and should be matched accordingly.
#'  \deqn{y_{t+h} = \beta_0 + \beta_1 y_t + \beta_2 y_{t-1} + \beta_3 y_{t-2} + \beta_4 y_{t-3} + v_{t+h}}
#'  \deqn{\hat{v}_{t+h} = y_{t+h} - \hat{\beta}_0 + \hat{\beta}_1 y_t + \hat{\beta}_2 y_{t-1} + \hat{\beta}_3 y_{t-2} + \hat{\beta}_4 y_{t-3}}
#'  Which can be rewritten as:
#'  \deqn{y_{t} = \beta_0 + \beta_1 y_{t-8} + \beta_2 y_{t-9} + \beta_3 y_{t-10} + \beta_4 y_{t-11} + v_{t}}
#'  \deqn{\hat{v}_{t} = y_{t} - \hat{\beta}_0 + \hat{\beta}_1 y_{t-8} + \hat{\beta}_2 y_{t-9} + \hat{\beta}_3 y_{t-10} + \hat{\beta}_4 y_{t-11}}
#' This function estimates \eqn{\hat{v}_{t}}.
#'
#' @return This function returns an xts object of the cyclical component, or the residual of the \code{\link{yth_glm}} model, \eqn{\hat{v}_{t}}.
#'
#' @param x A univariate xts series of zoo index class, such as \code{Date, yearmon},
#'  or \code{yearqtr}.
#'
#' @param h An \code{integer}, defining the lookahead period.
#'  Defaults to \code{h = 8}, suggested by Hamilton. The default assumes
#'  economic data of quarterly periodicity with a lookahead period of 2 years.
#'  This function is not limited by the default parameter, , and Econometricians may
#'  change it as required.
#'
#' @param p An \code{integer}, indicating the number of lags. A Default of \code{p = 4},
#'  suggested by Hamilton, assumes data is of quarterly periodicity. If data is
#'  of monthly periodicity, one may choose \code{p = 12} or aggregate the series
#'  to quarterly periodicity and maintain the default. Econometricians should
#'  use this parameter to accomodate the Seasonality of their data.
#'
#' @param ... other arguments passed to the function \code{\link[stats]{glm}}
#'
#' @inheritParams glm
#'
#' @seealso \code{\link{yth_glm}}
#'
#' @importFrom stats lag
#' @importFrom xts as.xts
#' @import zoo
#'
#' @references James D. Hamilton. \href{http://econweb.ucsd.edu/~jhamilto/hp.pdf}{Why You Should Never Use the Hodrick-Prescott Filter}.
#'            NBER Working Paper No. 23429, Issued in May 2017.
#'
#' @examples
#' data(GDPC1)
#' l_GDPC1 <- 100*log(GDPC1)
#'
#' GDPC1_cycle <- yth_cycle(l_GDPC1, h = 8, p = 4)
#'
#' main <- "Cyclical component of 100*log(Real GDP)"
#'
#' plot(GDPC1_cycle, grid.col = "white", legend.loc = "topright", main = main)
#'
#'
#' @export
yth_cycle <- function(x, h = 8, p = 4, ...) {

  if(!"xts" %in% class(x)) {

    stop(paste("Argument 'x' must be an object of type xts.", class(x), " is not an xts object"))

  } else if(h %% 1 != 0) {

    stop(paste("Argument 'h' must be a whole number.", h, "is not a whole number."))

  } else if(p %% 1 != 0) {

    stop(paste("Argument 'p' must be a whole number.", p, "is not a whole number."))

  } else {

                # run yth_ar(p) model and store results
                data <- lag(x, k = c(0, h:(h+p-1)), na.pad = TRUE)
                lagnames <- c(paste0("yt",h), paste0('Xt_',0:(p-1)))
                colnames(data) <- lagnames
                formula <- paste0(c(paste0(paste0("yt",h)," ~ Xt_0"), paste0('+ Xt_',1:(p-1))), collapse = " ")
                neverHP <- stats::glm(formula, data = data, ...)

                # cycle xts object
                cycle <- xts::as.xts(unname(neverHP$residuals),
                                     order.by = get(paste0("as.",class(index(x))))(names(neverHP$residuals)))

                cycle
        }
}

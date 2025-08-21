#' Fits Hamilton's alternative model
#'
#' \code{yth_glm} fits a generalized linear model suggested by James D. Hamilton
#' as a better alternative to the Hodrick-Prescott Filter.
#'
#' For time series of quarterly periodicity, Hamilton suggests parameters of
#' h = 8 and p = 4, or an \eqn{AR(4)} process, additionally lagged by \eqn{8}
#' lookahead periods. Econometricians may explore variations of h. However, p is
#' designed to correspond with the seasonality of a given periodicity and should
#' be matched accordingly.
#'
#' @return \code{yth_glm} returns a generalized linear model object of class
#' \code{\link[stats]{glm}}, which inherits from \code{\link[stats]{lm}}.
#'
#' @param x A univariate \code{\link[xts]{xts}} object of any
#'   \code{\link[zoo]{zoo}} index class, such as \code{\link[base]{Date}},
#'   \code{\link[zoo]{yearmon}}, or \code{\link[zoo]{yearqtr}}.
#'   For converting objects of type \code{timeSeries}, \code{ts}, \code{irts},
#'   \code{fts}, \code{matrix}, \code{data.frame}, or \code{\link[zoo]{zoo}}
#'   to \code{\link[xts]{xts}}, please see \code{\link[xts]{as.xts}}.
#'
#' @param h An \code{integer}, defining the lookahead period. Defaults to
#'   \code{h = 8}, suggested by Hamilton. The default assumes economic data of
#'   quarterly periodicity with a lookahead period of 2 years. This function is
#'   not limited by the default parameter, and econometricians may change it as required.
#'
#' @param p An \code{integer}, indicating the number of lags. A default of
#'   \code{p = 4}, suggested by Hamilton, assumes data is of quarterly periodicity.
#'   If data is monthly, one may choose \code{p = 12} or aggregate the series
#'   to quarterly and maintain the default. Econometricians should use this
#'   parameter to accommodate the seasonality of their data.
#'
#' @param ... Additional arguments passed to \code{\link[stats]{glm}}.
#'
#' @seealso \code{\link[stats]{glm}}, \code{\link[stats]{lm}}
#'
#' @importFrom stats lag
#' @importFrom xts lag.xts
#'
#' @references
#' James D. Hamilton.
#' \href{http://econweb.ucsd.edu/~jhamilto/hp.pdf}{Why You Should Never Use the Hodrick-Prescott Filter}.
#' NBER Working Paper No. 23429, Issued in May 2017.
#'
#'@examples
#' data(GDPC1)
#'
#' gdp_model <- yth_glm(GDPC1, h = 8, p = 4, family = gaussian)
#'
#' summary(gdp_model)
#'
#' plot(gdp_model)
#'
#'@export
yth_glm <- function(x, h = 8, p = 4, ...) {

           if(!"xts" %in% class(x)) {

              stop(paste("Argument 'x' must be an object of type xts.", class(x),
                         "is not an xts object"))

    } else if(h %% 1 != 0) {

              stop(paste("Argument 'h' must be a whole number.", h,
                         "is not a whole number."))

    } else if(p %% 1 != 0) {

              stop(paste("Argument 'p' must be a whole number.", p,
                         "is not a whole number."))

    } else {

            # create matrix of lagged variables specified by h and p
            data  <- lag(x, k = c(0, h:(h+p-1)), na.pad = TRUE)
            # create lagged variable names
            colnames(data)  <- c(paste0("yt",h), paste0('xt_',0:(p-1)))
            # create formula to pass to glm
            formula <- paste0(c(paste0(paste0("yt",h)," ~ xt_0"), paste0('+ xt_',1:(p-1))), collapse = " ")

            stats::glm(formula, data = data, ...)

        }
}


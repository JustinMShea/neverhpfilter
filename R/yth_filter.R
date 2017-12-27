#' Filtered xts object
#'
#' \code{yth_filter} returns a zoo indexed original, trend, cycle, and "random walk" series.
#'
#' For time series of quarterly periodicity, Hamilton suggests parameters of
#'  h = 8 and p = 4, or an \eqn{AR(4)} process, additionally lagged by \eqn{8} lookahead periods.
#'  Exploring parameters of h should be undertaken by Economists with reason to do so.
#'  However, p merely corresponds with the seasonality of a given periodicity and should be matched accordingly.
#'  For example, p = 4 for data of quarterly periodicity and p = 12 for data of monthly.
#'  \deqn{y_{t+h} = \beta_0 + \beta_1 y_t + \beta_2 y_{t-1} + \beta_3 y_{t-2} + \beta_4 y_{t-3} + v_{t+h}}
#'  \deqn{\hat{v}_{t+h} = y_{t+h} - \hat{\beta}_0 + \hat{\beta}_1 y_t + \hat{\beta}_2 y_{t-1} + \hat{\beta}_3 y_{t-2} + \hat{\beta}_4 y_{t-3}}
#'  Which can be rewritten as:
#'  \deqn{y_{t} = \beta_0 + \beta_1 y_{t-8} + \beta_2 y_{t-9} + \beta_3 y_{t-10} + \beta_4 y_{t-11} + v_{t}}
#'  \deqn{\hat{v}_{t} = y_{t} - \hat{\beta}_0 + \hat{\beta}_1 y_{t-8} + \hat{\beta}_2 y_{t-9} + \hat{\beta}_3 y_{t-10} + \hat{\beta}_4 y_{t-11}}
#'
#' @return \code{yth_filter} returns an xts object containing four time series.
#'  They include the original series, model fitted values (trend component), model residuals (cycle component),
#'  and a "random walk" series represented by differencing \eqn{y_{t+h}} and \eqn{y_t}.
#'
#' @param x A univariate xts series of zoo index class, such as \code{Date, yearmon},
#'  or \code{yearqtr}.
#'
#' @param h An \code{integer}, defining the lookahead period.
#'  Defaults to \code{h = 8}, suggested by Hamilton. The default assumes
#'  economic data of quarterly periodicity with a lookahead period of 2 years.
#'  This function is not limited by the default parameter, and Economists may
#'  change it as desired.
#'
#' @param p An \code{integer}, indicating the number of lags. A Default of \code{p = 4},
#'  suggested by Hamilton, assumes data is of quarterly periodicity. If data is
#'  of monthly periodicity, one may choose \code{p = 12} or aggregate the series
#'  to quarterly periodicity and maintain the default. This function is not limited by
#'  the default parameter, and Economists may consider changing it to accomodate
#'  the seasonal structure of their data.
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
#'
#'@examples
#'data(GDPC1)
#'GDP_filtered <- yth_filter(100*log(GDPC1), h = 8, p = 4)
#'plot(GDP_filtered)
#'
#'@export
yth_filter <- function(x, h = 8, p = 4, ...) {

         if(!"xts" %in% class(x)) {

    stop(paste("Argument 'x' be an object of type xts.", class(x), "is not an xts object"))

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

        #fitted and residuals into trend and cycle xts objects
        trend <- xts::as.xts(unname(neverHP$fitted.values),
                             order.by = get(paste0("as.",class(index(x))))(names(neverHP$fitted.values)))

        cycle <- xts::as.xts(unname(neverHP$residuals),
                             order.by = get(paste0("as.",class(index(x))))(names(neverHP$residuals)))

        # merge together relevant components and name accordingly
                  output <- merge(data[,1], trend, cycle, data[,1] - data[,2])
                  x_name <- names(x)
            output_names <- c(x_name, paste0(x_name,".", c("trend", "cycle", paste0(lagnames[1],"-",lagnames[2]))))
        colnames(output) <- output_names

        output

        }
}

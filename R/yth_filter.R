#' Filtered xts object
#'
#' \code{yth_filter} returns an \code{\link{xts}} object containing user defined
#'  combinations of the original, trend, cycle, and random walk series.
#'
#' For time series of quarterly periodicity, Hamilton suggests parameters of
#'  h = 8 and p = 4, or an \eqn{AR(4)} process, additionally lagged by \eqn{8}
#'  lookahead periods. Econometricians may explore variations of h. However, p 
#'  is designed to correspond with the seasonality of a given periodicity and 
#'  should be matched accordingly.
#'  \deqn{y_{t+h} = \beta_0 + \beta_1 y_t + \beta_2 y_{t-1} + \beta_3 y_{t-2} + \beta_4 y_{t-3} + v_{t+h}}
#'  \deqn{\hat{v}_{t+h} = y_{t+h} - \hat{\beta}_0 + \hat{\beta}_1 y_t + \hat{\beta}_2 y_{t-1} + \hat{\beta}_3 y_{t-2} + \hat{\beta}_4 y_{t-3}}
#'  Which can be rewritten as:
#'  \deqn{y_{t} = \beta_0 + \beta_1 y_{t-8} + \beta_2 y_{t-9} + \beta_3 y_{t-10} + \beta_4 y_{t-11} + v_{t}}
#'  \deqn{\hat{v}_{t} = y_{t} - \hat{\beta}_0 + \hat{\beta}_1 y_{t-8} + \hat{\beta}_2 y_{t-9} + \hat{\beta}_3 y_{t-10} + \hat{\beta}_4 y_{t-11}}
#'
#' @return If the default parameter of output = "All" is used, the function returns 
#'  an \code{\link{xts}} object containing the original time series (x), 
#'  \code{\link{yth_glm}} model \code{\link{fitted.values}},  \code{\link{yth_glm}} model 
#'  \code{\link{residuals}}, and a random walk series defined by differencing 
#'  \eqn{y_{t+h}} and \eqn{y_t}. Other output choices lead to various combinations 
#'  of these time series.
#'
#' @param x A univariate \code{\link{xts}} object of any \code{\link{zoo}} index class,
#'  such as \code{\link{Date}}, \code{\link{yearmon}}, or \code{\link{yearqtr}}.
#'  For converting objects of type \code{timeSeries, ts, irts, fts, matrix, data.frame}
#'  or \code{zoo} to \code{\link{xts}}, please read \code{\link{as.xts}}.
#'
#' @param h An \code{\link{integer}}, defining the lookahead period.
#'  Defaults to \code{h = 8}. The default assumes economic data of quarterly 
#'  periodicity with a lookahead period of 2 years. This function is not limited 
#'  by the default parameter, and Econometricians may change it as required.
#'
#' @param p An \code{\link{integer}}, indicating the number of lags. A Default of 
#'  \code{p = 4}, assumes data is of quarterly periodicity. If data is of monthly 
#'  periodicity, one may choose \code{p = 12} or aggregate the series to quarterly 
#'  periodicity and maintain the default. Econometricians should use this parameter 
#'  to accommodate the Seasonality of their data.
#'  
#' @param output A character vector determining the output of this function. 
#'  Defaults to \code{output = "all"}, which returns the original time series 
#'  (\code{x}), \code{\link{fitted.values}} (\code{"trend"}), \code{\link{residuals}}
#'  (\code{"cycle"}), and a random walk series defined by differencing \eqn{y_{t+h}} 
#'  and \eqn{y_t} (\code{"random"}). Arguments \code{"trend"}, \code{"cycle"}, and 
#'  \code{"random"} extract their corresponding univariate series. \code{"yth_trend"} 
#'  returns both the original series \code{x} and the \code{"trend"} component.
#'  \code{"yth_cycle"} will return both the \code{"cycle"} and \code{"random"} 
#'  components.
#'
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
#' @examples
#' data(GDPC1)
#' log_GDP <- 100*log(GDPC1)
#'
#' GDP_filtered <- yth_filter(log_GDP, h = 8, p = 4)
#' tail(GDP_filtered, 8)
#'
#' GDP_yth_cycle <- yth_filter(log_GDP, h = 8, p = 4, output = "yth_cycle")
#' main <- "Cyclical and random component of 100*log(Real GDP)"
#' plot(GDP_yth_cycle, grid.col = "white", legend.loc = "topright", main = main)
#'
#' @export
yth_filter <- function(x, h = 8, p = 4, output = "all", ...) {
  
  if(!output %in% c("all","trend", "cycle", "random", "yth_trend", "yth_cycle")) {
  
        stop(paste("Argument 'output' must be a character vector of 'all', 'trend',
                   'cycle', 'random', 'yth_trend', or 'yth_cycle'"))
  
      } else {

      neverHP <- yth_glm(x = x , h = h, p = p, ...)

        #fitted and residuals into trend and cycle xts objects
        trend <- xts::as.xts(unname(neverHP$fitted.values),
                             order.by = get(paste0("as.",class(index(x))))(names(neverHP$fitted.values)))

        cycle <- xts::as.xts(unname(neverHP$residuals),
                             order.by = get(paste0("as.",class(index(x))))(names(neverHP$residuals)))

        random  <- lag(x, k = h, na.pad = TRUE)
        # merge together relevant components and name accordingly
                filtered <- merge(x, trend, cycle, x-random)
            output_names <- c(names(x), paste0(names(x),".", c("trend", "cycle", "random")))
      colnames(filtered) <- output_names

        # Choose output
               if (output == "all") {
          
                   return(filtered)
        
        } else if (output == c("yth_trend")) {
          
                   return(filtered[,1:2])
          
        } else if (output == "trend") {
          
                   return(filtered[,2])
          
        } else if (output == "cycle") {
          
                   return(filtered[,3])
          
        } else if (output == "yth_cycle") {
          
                   return(filtered[,3:4])
          
        } else if (output == "random") {
          
                   return(filtered[,4])
        }
    }
}

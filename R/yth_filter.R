#' Filtered xts object
#'
#' \code{yth_filter} returns an \code{\link[xts]{xts}} object containing
#' user-defined combinations of the original, trend, cycle, and random walk series.
#'
#' For time series of quarterly periodicity, Hamilton suggests parameters of
#' h = 8 and p = 4, or an \eqn{AR(4)} process, additionally lagged by \eqn{8}
#' lookahead periods. Econometricians may explore variations of h. However, p
#' is designed to correspond with the seasonality of a given periodicity and
#' should be matched accordingly.
#'
#' @return An \code{\link[xts]{xts}} object defined by the \code{output} parameter.
#'
#' @param x A univariate \code{\link[xts]{xts}} object of any
#'   \code{\link[zoo]{zoo}} index class, such as \code{\link[base]{Date}},
#'   \code{\link[zoo]{yearmon}}, or \code{\link[zoo]{yearqtr}}.
#'   For converting objects of type \code{timeSeries}, \code{ts}, \code{irts},
#'   \code{fts}, \code{matrix}, \code{data.frame}, or \code{\link[zoo]{zoo}},
#'   please see \code{\link[xts]{as.xts}}.
#'
#' @param h An \code{integer}, defining the lookahead period.
#'   Defaults to \code{h = 8}. The default assumes economic data of quarterly
#'   periodicity with a lookahead period of 2 years.
#'
#' @param p An \code{integer}, indicating the number of lags. Defaults to
#'   \code{p = 4}, assuming quarterly data. For monthly data, one may choose
#'   \code{p = 12} or aggregate to quarterly. Use this parameter to match
#'   the seasonality of your data.
#'
#' @param output A \code{character} vector. Defaults to
#'   \code{output = c("x","trend","cycle","random")}, which returns the original
#'   series (\code{"x"}), the fitted values from \code{\link{yth_glm}} (\code{"trend"}),
#'   the residuals from \code{\link{yth_glm}} (\code{"cycle"}), and a random walk
#'   defined by differencing \eqn{y_{t+h}} and \eqn{y_t} (\code{"random"}).
#'   Any subset of these components can be returned.
#'
#' @param ... Other arguments passed to \code{\link[stats]{glm}}.
#'
#' @seealso \code{\link{yth_glm}}
#'
#' @importFrom xts as.xts
#' @import zoo
#'
#' @references James D. Hamilton.
#' \href{http://econweb.ucsd.edu/~jhamilto/hp.pdf}{Why You Should Never Use the Hodrick-Prescott Filter}.
#' NBER Working Paper No. 23429, Issued in May 2017.
#'
#'
#' @examples
#' data(GDPC1)
#'
#' gdp_filter <- yth_filter(100*log(GDPC1), h = 8, p = 4)
#'
#' head(gdp_filter, 15)
#'
#' #---------------------------------------------------------------------------#
#'
#' data(PAYEMS)
#'
#' log_Employment <- 100*log(xts::to.quarterly(PAYEMS["1947/2016-6"], OHLC = FALSE))
#'
#' employ_trend <- yth_filter(log_Employment, h = 8, p = 4, output = c("x", "trend"))
#'
#' plot(employ_trend, grid.col = "white", legend.loc = "topleft",
#'          main = "Log of Employment and trend")
#'
#' #----------------------------------------------------------------------------#
#'
#' quarterly_data <- 100*log(merge(GDPC1, PCECC96, GPDIC1, EXPGSC1, IMPGSC1, GCEC1, GDPDEF))
#'
#' cycle <- do.call(merge, lapply(quarterly_data, yth_filter, output = "cycle"))
#' random <- do.call(merge, lapply(quarterly_data, yth_filter, output = "random"))
#'
#' cycle.sd <- t(data.frame(lapply(cycle, sd, na.rm = TRUE)))
#' GDP.cor <- t(data.frame(lapply(cycle, cor, cycle[,1], use = "complete.obs")))
#' random.sd <- t(data.frame(lapply(random, sd, na.rm = TRUE)))
#' random.cor <- t(data.frame(lapply(random, cor, random[,1], use = "complete.obs")))
#'
#' my_table_2 <- round(data.frame(cbind(cycle.sd, GDP.cor, random.sd, random.cor)), 2)
#' names(my_table_2) <- names(Hamilton_table_2)[1:4]
#'
#' my_table_2
#' @export
yth_filter <- function(x, h = 8, p = 4, output = c("x", "trend", "cycle", "random"), ...) {

  # Test output paramter and halt function if it doesn't match
  output_args <- c("x","trend", "cycle", "random")

  if(length(output) != sum(grepl(paste(output_args, collapse = "|"), output))) {

    stop(paste0("Incorrect argument '",
                output[!grepl(paste(output_args, collapse = "|"), output)],
                "' present in 'output' argument. Must be a character vector
                   containing `x`, 'trend', 'cycle', or 'random'."))

  } else if( is.null(colnames(x)) ) {

    warning("Your xts object doesn't have a dimnames attribute, aka names(your_xts) is NULL, which would've produced an error.
    Thus it has been given the name 'y' within the scope, and for the output, of this function.")

    colnames(x) <- ifelse( is.null(colnames(x)), "y", colnames(x) )

  } else if(p == 1) {

    stop(paste0("Argument 'p=1' does not capture time series seasonality, as
                intended by this methodlogy."))

  }
  # After test passes, run the yth_function
  neverHP <- yth_glm(x = x , h = h, p = p, ...)

  # Begin extracting and transforming model series.
  # If univariate output is specified, return individual series.
  trend <- xts::as.xts(unname(neverHP$fitted.values),
                       order.by = get(paste0("as.",class(index(x))))(names(neverHP$fitted.values)))
  names(trend) <- paste0(names(x),".trend")

  if (any(length(output) == 1 & output == "trend")) {return(trend)}

  cycle <- xts::as.xts(unname(neverHP$residuals),
                       order.by = get(paste0("as.",class(index(x))))(names(neverHP$residuals)))
  names(cycle) <- paste0(names(x),".cycle")

  if (any(length(output) == 1 & output == "cycle")) {return(cycle)}

  random <- x-lag(x, k = h, na.pad = TRUE)
  names(random) <- paste0(names(x),".random")

  if (any(length(output) == 1 & output == "random")) {return(random)}


  # If multivariate output is specified, merge/extract specified series.
  all <- merge(x, trend, cycle, random)
  names(all) <- c(names(x), paste0(names(x),".",
                                   c("trend", "cycle", "random"))
  )

  if (any(output == "x")) {

    index <- grep(paste(output, collapse = "|"), names(all))

    return(all[,c(1, index)])

  } else {

    index <- grep(paste(output, collapse = "|"), names(all))

    return(all[,c(index)])

  }

}

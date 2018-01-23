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
#' @return An \code{\link{xts}} object defined by the \code{output} parameter.
#'
#' @param x A univariate \code{\link{xts}} object of any \code{\link{zoo}} index class,
#'  such as \code{\link{Date}}, \code{\link{yearmon}}, or \code{\link{yearqtr}}.
#'  For converting objects of type \code{timeSeries, ts, irts, fts, matrix, data.frame}
#'  or \code{zoo}, please read \code{\link{as.xts}}.
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
#' @param output A \code{\link{character}} vector. Defaults to \code{output = c("x","trend", "cycle", "random")}, which returns the original time series 
#'  (\code{x}), yth_glm \code{\link{fitted.values}} (\code{"trend"}), yth_glm \code{\link{residuals}}
#'  (\code{"cycle"}), and a random walk series defined by differencing \eqn{y_{t+h}} 
#'  and \eqn{y_t} (\code{"random"}). Arguments \code{"x"}, \code{"trend"}, \code{"cycle"}, and 
#'  \code{"random"} extract their corresponding univariate series and can be merged in any combination.
#'  For example \code{c("x", "trend")} returns both the original series "x" and the "trend" components. 
#'  \code{c("cycle", "random")} will return both the "cycle" and "random" components.
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
#' 
#' gdp_filter <- yth_filter(100*log(GDPC1), h = 8, p = 4)
#' 
#' knitr::kable(head(gdp_filter, 15), align = 'l')
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
#'
#' knitr::kable(my_table_2, align = 'l')
#' @export
yth_filter <- function(x, h = 8, p = 4, output = c("x", "trend", "cycle", "random"), ...) {
        
     # Test output paramter and halt function if it doesn't match
           output_args <- c("x","trend", "cycle", "random")
           
     if(length(output) != sum(grepl(paste(output_args, collapse = "|"), output))) {
  
       stop(paste0("Incorrect argument '", 
                  output[!grepl(paste(output_args, collapse = "|"), output)], 
                  "' present in 'output' argument. Must be a character vector 
                   containing `x`, 'trend', 'cycle', or 'random'."))
         
     } else {     
               # After test passes, run the yth_function
               neverHP <- yth_glm(x = x , h = h, p = p, ...) 
  
     }
           
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
                   names(all) <- c(names(x), paste0(names(x),".", c("trend", "cycle", "random")))
        
         if (any(output == "x")) {
 
                 index <- grep(paste(output, collapse = "|"), names(all))
                 
                 return(all[,c(1, index)])
          
         } else {
      
                 index <- grep(paste(output, collapse = "|"), names(all))
                 
                 return(all[,c(index)])   
         
        }         
 
}
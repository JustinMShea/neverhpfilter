#' yth_filter
#'
#' Filtered time series xts object
#'
#' For a time series of say, quarterly periodicity, Hamilton's solution can be described as an \eqn{AR(4)} process,
#' additionally lagged by \eqn{h} periods. \deqn{y_{t+h} = \beta_0 + \beta_1 y_t + \beta_2 y_{t-1} +\beta_3 y_{t-2} + \beta_4 y_{t-3} + v_{t+h}}
#' \deqn{\hat{v}_{t+h} = y_{t+h} + \hat{\beta}_0 + \hat{\beta}_1 y_t + \hat{\beta}_2 y_{t-1} + \hat{\beta}_3 y_{t-2} + \hat{\beta}_4 y_{t-3}}
#'
#'
#' @return \code{yth_filter} returns an xts object containing the original series,
#'                   the fitted (trend) values, the residual (cycle) component,
#'                   and a "random walk" series represented by the difference between \eqn{y_{t+h}} and \eqn{y_t}
#'
#'@param x An xts object.
#'
#'@param h The look ahead parameter. Default to h = 8, or 8 quarters for two years.
#'
#'@param p Idicating the number of lags. Default to p = 4, or 4 quarters for one year.
#'
#'@param ... see "glm"
#'
#'@inheritParams stats::glm see "glm"
#'
#' @importFrom stats lag
#' @importFrom xts as.xts
#' @import zoo
#'
#'@references James D. Hamilton. Why You Should Never Use the Hodrick-Prescott Filter.
#'            NBER Working Paper No. 23429, Issued in May 2017.
#'
#'@examples
#'GDPC1_filtered <- yth_filter(GDPC1, h = 8, p = 4)
#'plot(GDPC1_filtered)
#'
#'@export
yth_filter <- function(x, h = 8, p = 4, ...) {

         if(!"xts" %in% class(x)) {
    
    stop(paste("Arguement 'x' be an object of type xts.", class(x), "is not an xts object"))
    
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

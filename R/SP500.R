#' U.S. Stock Markets and CAPE Ratio
#'
#' \code{SP500} Robert Shiller's data set for U.S. Stock Markets 1871–2021 and CAPE Ratio.
#'
#' @section Notes from Shiller:
#' This data set consists of monthly stock price, dividends, and earnings data and
#' the consumer price index (to allow conversion to real values), all starting
#' January 1871. The price, dividend, and earnings series are from the same sources
#' as described in Chapter 26 of my earlier book (Market Volatility, Cambridge,
#' MA: MIT Press, 1989), although now I use monthly data, rather than annual data.
#'
#' Monthly dividend and earnings data are computed from the S&P four-quarter totals
#' for the quarter since 1926, with linear interpolation to monthly figures. Dividend
#' and earnings data before 1926 are from Cowles and associates (Common Stock Indexes,
#' 2nd ed., Bloomington, Ind.: Principia Press, 1939), interpolated from annual data.
#' Stock price data are monthly averages of daily closing prices.
#'
#' The CPI-U (Consumer Price Index–All Urban Consumers) published by the U.S. Bureau
#' of Labor Statistics begins in 1913; for years before 1913, Shiller spliced
#' Warren and Pearson's price index by multiplying it by the ratio of the indexes
#' in January 1913. December 1999 and January 2000 values for the CPI-U are extrapolated.
#' See George F. Warren and Frank A. Pearson, *Gold and Prices* (New York: John Wiley
#' and Sons, 1935). Data are from their Table 1, pp. 11–14.
#'
#' @docType data
#'
#' @usage data(SP500)
#'
#' @format An \code{\link[xts]{xts}} object containing observations of U.S. Stock Markets
#' 1871–Present and CAPE Ratio.
#' \describe{
#'   \item{**Frequency:**}{Monthly}
#'   \item{**Date Range:**}{1871-01 to 2023-09}
#'   \item{**SP500:**}{Nominal prices of the S&P composite index, April 2021 observation is 04/05 close}
#'   \item{**Dividends:**}{Nominal dividends}
#'   \item{**Earnings:**}{Nominal earnings, S&P 500 estimated}
#'   \item{**CPI:**}{Shiller's Consumer Price Index data used for transformation to real prices}
#'   \item{**GS10:**}{Shiller's Long-term interest rate, 10-Year Treasury Constant Maturity Rate, April 2021 observation is 04/05 close}
#'   \item{**Real_SP500:**}{Real prices of the S&P 500 composite index}
#'   \item{**Real_Dividends:**}{Real dividends}
#'   \item{**Real_SP500_TR:**}{Real total return price of the S&P 500 composite index}
#'   \item{**Real_Earnings:**}{Real earnings}
#'   \item{**Real_Earnings_TR:**}{Real total return scaled earnings}
#'   \item{**CAPE:**}{Cyclically Adjusted Price Earnings Ratio (P/E10 or CAPE)}
#'   \item{**CAPE_TR:**}{Cyclically Adjusted Total Return Price Earnings Ratio (P/E10_TR or CAPE_TR)}
#'   \item{**CAPE_Yield:**}{Excess CAPE Yield}
#'   \item{**Bond_TR:**}{Total bond returns}
#'   \item{**Real_Bond_TR:**}{Real total bond returns}
#' }
#'
#' @source Shiller, Robert J. *Irrational Exuberance*, Princeton University Press 2000,
#' Broadway Books 2001, 2nd ed. 2005, 3rd ed. 2015.
#' \url{http://www.econ.yale.edu/~shiller/data.htm}
#'
#' Download .xls file directly from here: \url{http://www.econ.yale.edu/~shiller/data/ie_data.xls}
#'
#' @examples
#' data(SP500)
#'
#' SP500_qtr <- xts::to.quarterly(SP500$SP500, OHLC = FALSE)
#' log_SP500 <- 100*log(SP500_qtr)
#'
#' SP500_trend <- yth_filter(log_SP500, h = 8, p = 4,
#'                           output = c("x", "trend"), family = gaussian)
#'
#' main <- "Log of SP500 and trend"
#' plot(SP500_trend, grid.col = "white", legend.loc = "topleft", main = main)
#'
#' SP500_cycle <- yth_filter(log_SP500["1900/"], h = 8, p = 4,
#'                           output = c("cycle", "random"), family = gaussian)
#'
#' main <- "Log of SP500 cycle and random walk"
#' plot(SP500_cycle, grid.col = "white", legend.loc = "topright", main = main)
"SP500"

# Hamilton Filter
library(xts)
HLfilter.lm <- function(x) {

        DF <- merge(lag.xts(x, k = -8, na.pad = TRUE),
                    x,
                    lag.xts(x, k = 1, na.pad = TRUE),
                    lag.xts(x, k = 2, na.pad = TRUE),
                    lag.xts(x, k = 3, na.pad = TRUE))

        colnames(DF) <- c("x8", "x", "x_1", "x_2", "x_3")

        HL_filter <- lm(x8 ~ x + x_1 + x_2 + x_3, data = DF)

        HL_filter

}

HLfilter <- function(x) {

        DF <- merge(x,
                    lag.xts(x, k = 8, na.pad = TRUE),
                    lag.xts(x, k = 9, na.pad = TRUE),
                    lag.xts(x, k = 10, na.pad = TRUE),
                    lag.xts(x, k = 11, na.pad = TRUE))

        colnames(DF) <- c("x", "x_8", "x_9", "x_10", "x_11")

        HL_filter <- lm(x ~ x_8 + x_9 + x_10 + x_11, data = DF)


        HL_fit <- as.xts(unname(HL_filter$fitted.values),
                         order.by = as.yearqtr(names(HL_filter$fitted.values)))

        HL_resid <- as.xts(unname(HL_filter$residuals),
                           order.by = as.yearqtr(names(HL_filter$residuals)))


        merge(DF$x, DF$x-DF$x_8, HL_fit, HL_resid)

}


# Hamilton Filter
library(xts)
HLfilter.lm <- function(x, h = 8) {

        DF <- merge(lag.xts(x, k = -h, na.pad = TRUE),
                    x,
                    lag.xts(x, k = 1, na.pad = TRUE),
                    lag.xts(x, k = 2, na.pad = TRUE),
                    lag.xts(x, k = 3, na.pad = TRUE))

        colnames(DF) <- c("x_h", "x", "x_1", "x_2", "x_3")

        HL_filter <- lm(x_h ~ x + x_1 + x_2 + x_3, data = DF)

        HL_filter

}

HLfilter <- function(x, h = 8) {

        DF <- merge(x,
                    lag.xts(x, k = h, na.pad = TRUE),
                    lag.xts(x, k = h+1, na.pad = TRUE),
                    lag.xts(x, k = h+2, na.pad = TRUE),
                    lag.xts(x, k = h+3, na.pad = TRUE))

        colnames(DF) <- c("x_h", "x", "x_1", "x_2", "x_3")

        HL_filter <- lm(x_h ~ x + x_1 + x_2 + x_3, data = DF)


        HL_fit <- as.xts(unname(HL_filter$fitted.values),
                         order.by = as.yearqtr(names(HL_filter$fitted.values)))

        HL_resid <- as.xts(unname(HL_filter$residuals),
                           order.by = as.yearqtr(names(HL_filter$residuals)))


        merge(DF$x_h, DF$x_h-DF$x, HL_fit, HL_resid)

}


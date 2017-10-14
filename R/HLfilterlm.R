# Hamilton Filter
library(xts)

HLfilter.lm <- function(x, h = 8) {

        if (!requireNamespace("pkg", quietly = TRUE)) {
                stop("Pkg xts needed for this function to work. Please install it.",
                     call. = FALSE)
        }

  DF <- merge(lag.xts(x, k = -h, na.pad = TRUE),
              x,
              lag.xts(x, k = 1, na.pad = TRUE),
              lag.xts(x, k = 2, na.pad = TRUE),
              lag.xts(x, k = 3, na.pad = TRUE))

  colnames(DF) <- c("x_h", "x", "x_1", "x_2", "x_3")

  HL_filter <- lm(x_h ~ x + x_1 + x_2 + x_3, data = DF)

  HL_filter

}

library(testthat)

GDPC1_trend <- yth_trend(GDPC1, h = 8, p = 4)

test_that("The yth_trend output is of class 'xts'",
          {
            expect_is(GDPC1_trend, "xts")
          }
          
)
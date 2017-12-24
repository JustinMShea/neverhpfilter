library(testthat)

GDPC1_filter <- yth_filter(GDPC1, h = 8, p = 4)

test_that("The yth_filter output is of class 'xts'",
          {
            expect_is(GDPC1_filter, "xts")
          }
          
)
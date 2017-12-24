library(testthat)

GDPC1_cycle <- yth_cycle(GDPC1, h = 8, p = 4)

test_that("The yth_cycle output is of class 'xts'",
          {
            expect_is(GDPC1_cycle, "xts")
          }
          
)
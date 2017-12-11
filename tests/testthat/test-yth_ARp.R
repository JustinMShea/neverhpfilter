library(testthat)

hlm_model <- yth_ARp(GDPC1, h = 8)

test_that("The hlm model is of class 'lm'",
          {
                  expect_is(hlm_model, "lm")
          }

)

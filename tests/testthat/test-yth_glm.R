library(testthat)

GDPC1_model <- yth_glm(GDPC1, h = 8, p = 4)

test_that("The hlm model is of class 'glm'",
          {
                  expect_is(GDPC1_model, "glm")
          }

)


GDPC1_model <- yth_glm(GDPC1, h = 8, p = 4)

expect_equivalent(class(GDPC1_model)[1], "glm", info = "The yth_glm model is of class 'glm'")
expect_equivalent(length(names(GDPC1_model$data)), 5, info = "yth_glm data object contains vars")

library(xts)

# --- Happy path: valid xts input ---
set.seed(123)
x <- xts(rnorm(50), order.by = as.Date("2000-01-01") + 0:49)

model <- yth_glm(x, h = 8, p = 4, family = gaussian)

expect_inherits(model, "glm")
expect_inherits(model, "lm")
expect_true("coefficients" %in% names(model))

# --- Error: x is not xts ---
bad_x <- rnorm(10)
expect_error(yth_glm(bad_x), pattern = "must be an object of type xts")

# --- Error: h is not integer ---
x_small <- xts(rnorm(20), order.by = as.Date("2000-01-01") + 0:19)
expect_error(yth_glm(x_small, h = 2.5), pattern = "must be a whole number")

# --- Error: p is not integer ---
expect_error(yth_glm(x_small, p = 3.7), pattern = "must be a whole number")



GDPC1_model <- yth_glm(GDPC1, h = 8, p = 4)

expect_equivalent(class(GDPC1_model)[1], "glm", info = "The yth_glm model is of class 'glm'")

expect_equivalent(length(names(GDPC1_model$data)), 5, info = "yth_glm data object contains vars")

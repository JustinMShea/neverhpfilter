

GDPC1_filter <- yth_filter(GDPC1, h = 8, p = 4)

expect_equivalent(class(GDPC1_filter)[1], "xts", info = "The yth_filter output is of class 'xts'")

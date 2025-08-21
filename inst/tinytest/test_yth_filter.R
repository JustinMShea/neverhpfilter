
GDPC1_filter <- yth_filter(GDPC1, h = 8, p = 4)
expect_equivalent(class(GDPC1_filter)[1], "xts", info = "The yth_filter output is of class 'xts'")

library(xts)

set.seed(123)
x <- xts(rnorm(50), order.by = as.Date("2000-01-01") + 0:49)
colnames(x) <- "series"

# --- 1. Happy path: all outputs ---
out <- yth_filter(x, h = 8, p = 4)
expect_inherits(out, "xts")
expect_true(all(c("series", "series.trend", "series.cycle", "series.random") %in% colnames(out)))

# --- 2. Error: invalid output argument ---
expect_error(yth_filter(x, output = "bogus"), pattern = "Incorrect argument")

# --- 3. Warning: no colnames ---
x_nameless <- xts(rnorm(30), order.by = as.Date("2000-01-01") + 0:29)
expect_warning(out2 <- yth_filter(x_nameless, h = 8, p = 4))
expect_true("y" %in% colnames(out2))

# --- 4. Error: p = 1 ---
expect_error(yth_filter(x, h = 8, p = 1), pattern = "p=1")

# --- 5. Only trend ---
trend_only <- yth_filter(x, h = 8, p = 4, output = "trend")
expect_inherits(trend_only, "xts")
expect_true(grepl("trend", colnames(trend_only)))

# --- 6. Only cycle ---
cycle_only <- yth_filter(x, h = 8, p = 4, output = "cycle")
expect_inherits(cycle_only, "xts")
expect_true(grepl("cycle", colnames(cycle_only)))

# --- 7. Only random ---
random_only <- yth_filter(x, h = 8, p = 4, output = "random")
expect_inherits(random_only, "xts")
expect_true(grepl("random", colnames(random_only)))

# --- 8. Subset: x and trend ---
subset_out <- yth_filter(x, h = 8, p = 4, output = c("x","trend"))
expect_inherits(subset_out, "xts")
expect_true(all(c("series", "series.trend") %in% colnames(subset_out)))


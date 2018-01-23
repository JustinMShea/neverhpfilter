---
title: "NEWS"
output: github_document
---

# neverhpfilter 0.2-0

Functions consolidated into just two functions. `yth_glm` remains unchanged, while
`yth_filter` has been given an output parameter to specify the return of specific series. This feature eliminates the need for `yth_filter` and `yth_trend`, which are helpful when apply the function to multiple data sets.

Nine additional data sets have been added to replicate most all of Hamilton's table 2.

The "Reproducing Hamilton" vignette has been expanded and content has been edited
for clarity.


# neverhpfilter 0.1-0

First complete version. Has four functions `yth_glm`, `yth_filter`, `yth_cycle`, and 
`yth_trend`. Three data sets are included to reproduce part of Hamilton's work.
They are `GDPC1`, `PAYEMS`, and `Hamilton_table_2`. A vignette titled "Reproducing Hamilton" illustrated the work and shows users how to implement functions.


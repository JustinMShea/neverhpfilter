---
title: "NEWS"
output: github_document
---

# neverhpfilter 0.3-0

Bug fix, see [issue-1 here](https://github.com/JustinMShea/neverhpfilter/issues/1)

Updated data from original package, guess I'll conisder that a feature enhancement. 

# neverhpfilter 0.2-0

Consolidated into two functions. `yth_glm` remains unchanged, while
`yth_filter` has been given an `output` arguement to specify the return of specific series. This feature eliminates the need for `yth_cycle` and `yth_trend`, which were helpful when applying the function to multiple data sets.
Done so at the strong suggestion of `CRAN`.

Additional data sets have been added to replicate most all of Hamilton's table 2.

The "Reproducing Hamilton" vignette has been expanded and content has been edited
for clarity.


# neverhpfilter 0.1-0

First complete version. Has four functions `yth_glm`, `yth_filter`, `yth_cycle`, and 
`yth_trend`. Three data sets are included to reproduce part of Hamilton's work.
They are `GDPC1`, `PAYEMS`, and `Hamilton_table_2`. A vignette titled "Reproducing Hamilton" illustrated the work and shows users how to implement functions.


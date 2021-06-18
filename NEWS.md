---
title: "NEWS"
output: github_document
---

# neverhpfilter 0.4-0

Submitted 3.3 to CRAN and received a NOTE concerning documentation files for the `GDPCI` data set, referencing the Guide to the National Income and Product Accounts of the United States (NIPA). Updated source from http://www.bea.gov/national/pdf/nipaguid.pdf to https://www.bea.gov/resources/methodologies/nipa-handbook

# neverhpfilter 0.3-3

The `knitr` maintainer decided to remove `rmarkdown` as a dependency, so the vignette build now fails. It must be added, or else CRAN will remove the package by `2021-05-14`.

Updated all data sets.

`SP500` data includes more variables from Robert Schiller's data set for U.S. Stock Markets 1871-2021.

# neverhpfilter 0.3-2

Update data for `FEDFUNDS`, `GS10`, `PAYEMS`, `UNRATENSA`, and `SP500`.

# neverhpfilter 0.3-1

Content edits and cleanup of vignettes. 

These included, removing the redundant call to `library(xts)` as it has been
moved to `Depends` instead of merely `Suggests`, as documented in 0.3-0 below.
Thus, calling `neverhpfilter` includes it.

While the vignette builder uses the `knitr` package, I was also loading the 
`knitr` package to access the `kable` function for tables. Testing was going 
fine, but then `knitr` inexplicably began throwing a variety of differing errors 
across Linux and Windows builds. This appears to be due to Suggested packages it 
couldn't import, so removing calls to `knitr` in the vignette was an easy place 
to begin reducing the area of an unknown attack surface. In the modern era, 
regardless of the original error, any opportunity to reduce dependencies seems 
the most sensible approach as ever increasing dependency sprawl has bestowed 
upon R package maintainers a constant, exponentially growing, attack surface.

The decision to remove `knitr::kable` from vignettes was also an aesthetic one. 
In my experience, tables remain an important device for graphic displays of 
information. While knitr's html format appears clean at first, closer inspection 
reveals the undesirable trait of fitting tables to full page width regardless of 
the number of columns to display. On deeper reflection, I view this as a bug, as 
it produces the undesirable side effect of too much white space for the reader's 
eye to traverse when comparing numbers across columns.

Printing the raw output of an `xts` or `data.frame` objects keeps columns compact,
allowing for clearer visual comparison. The raw output also better communicates
to our reader the table was created as a result of some computational process. 
Plus, in an increasingly sophisticated digital world of Ux, these raw outputs 
look increasingly, unique, computationally cool, and clean. They serve as a 
reminder of the objective and scientific nature we strive for in our endeavors.


# neverhpfilter 0.3-0

Feature, updated data through January 2020.

New vignette `Getting started` reworks and replaces `Additional examples`.

Increased R version dependency to (>= 3.5.0) for the `.Rdata` files.

Moved from `testtthat` to `tinytest`, and wrote additional function unit tests 
and data unit tests.

Moved `xts` and `zoo` from imports to depends. Now `xts` (>= 0.11-0) and `zoo` (>= 1.8-0)

Bug fix, see [issue-1 here.](https://github.com/JustinMShea/neverhpfilter/issues/1)


# neverhpfilter 0.2-1

Updated data from original to roughly Q2 2019.

# neverhpfilter 0.2-0

Consolidated into two functions. `yth_glm` remains unchanged, while
`yth_filter` has been given an `output` argument to specify the return of specific series. This feature eliminates the need for `yth_cycle` and `yth_trend`, which were helpful when applying the function to multiple data sets. Done so at the strong suggestion of `CRAN`, and has ultimatly proven a good idea.

Additional data sets have been added to replicate most all of Hamilton's table 2.

The "Reproducing Hamilton" vignette has been expanded and content has been edited
for clarity.


# neverhpfilter 0.1-0

First complete version. Has four functions `yth_glm`, `yth_filter`, `yth_cycle`, and 
`yth_trend`. Three data sets are included to reproduce part of Hamilton's work.
They are `GDPC1`, `PAYEMS`, and `Hamilton_table_2`. A vignette titled "Reproducing Hamilton" illustrated the work and shows users how to implement functions.


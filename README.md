# neverhpfilter Package

  <!-- badges: start -->
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/neverhpfilter)](https://cran.r-project.org/package=neverhpfilter) 
[![codecov.io](https://codecov.io/gh/JustinMShea/neverhpfilter/graph/badge.svg)](https://codecov.io/github/JustinMShea/neverhpfilter?branch=master)
[![R-CMD-check](https://github.com/JustinMShea/neverhpfilter/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/JustinMShea/neverhpfilter/actions/workflows/R-CMD-check.yaml)
  <!-- badges: end -->

## Introduction

  In the working paper titled "Why You Should Never Use the **H**odrick-**P**rescott Filter", James D. Hamilton proposes a new alternative to economic time series filtering. The **`neverhpfilter`** package provides functions and data for reproducing his solution. [Hamilton (2017) <doi:10.3386/w23429>](https://www.nber.org/papers/w23429)

Hamilton's abstract offers an excellent introduction:

  > (1) The HP filter produces series with spurious dynamic relations that have no basis in the underlying data-generating process. (2) Filtered values at the end of the sample are very different from those in the middle, and are also characterized by spurious dynamics. (3) A statistical formalization of the problem typically produces values for the smoothing parameter vastly at odds with common practice, e.g., a value for $\lambda$ far below 1600 for quarterly data. (4) There's a better alternative. A regression of the variable at date $t + h$ on the four most recent values as of date $t$ offers a robust approach to detrending that achieves all the objectives sought by users of the HP filter with none of its drawbacks.


  
## Getting Started


Install from CRAN on R version >= 3.5.0.

```{r}
install.packages("neverhpfilter")
```

Or install from the Github master branch on R version >= 3.5.0.

```{r}
devtools::install_github("JustinMShea/neverhpfilter")
```

Load the package

```{r}
library(neverhpfilter)
```

## Package Documentation

The package consists of 2 estimation `functions`, 12 economic `xts` objects, an `xts` object containing Robert Shiller's U.S. Stock Markets and CAPE Ratio data from 1871 to Present, and a `data.frame` containing the original filter estimates found on table 2 of [Hamilton (2017) <doi:10.3386/w23429>](https://www.nber.org/papers/w23429)

Documentation for each can be found here:

 * [yth_glm](https://justinmshea.github.io/neverhpfilter/reference/yth_glm.html)

 * [yth_filter](https://justinmshea.github.io/neverhpfilter/reference/yth_filter.html)
 
 * [U.S. Stock Markets and CAPE Ratio 1871-Present](https://justinmshea.github.io/neverhpfilter/reference/SP500.html)
 
 * [Effective Federal Funds Rate](https://justinmshea.github.io/neverhpfilter/reference/FEDFUNDS.html)
 
 * [10-Year Treasury Constant Maturity Rate](https://justinmshea.github.io/neverhpfilter/reference/GS10.html)
 
 * [Gross Domestic Product](https://justinmshea.github.io/neverhpfilter/reference/GDPC1.html)
 
 * [Gross Domestic Product: Implicit Price Deflator](https://justinmshea.github.io/neverhpfilter/reference/GDPDEF.html)
 
 * [Real Gross Private Domestic Investment](https://justinmshea.github.io/neverhpfilter/reference/GPDIC1.html)
 
 * [Real Government Consumption Expenditures and Gross Investment](https://justinmshea.github.io/neverhpfilter/reference/GCEC1.html)

 * [Real Exports of Goods and Services](https://justinmshea.github.io/neverhpfilter/reference/EXPGSC1.html)
 
 * [Real Imports of goods and services](https://justinmshea.github.io/neverhpfilter/reference/IMPGSC1.html) 
 
 * [Employment Situation](https://justinmshea.github.io/neverhpfilter/reference/PAYEMS.html)
 
 * [Civilian Unemployment Rate](https://justinmshea.github.io/neverhpfilter/reference/UNRATENSA.html)

 * [Real Personal Consumption Expenditures](https://justinmshea.github.io/neverhpfilter/reference/PCECC96.html)
 
 * [Hamilton's table 2 estimates](https://justinmshea.github.io/neverhpfilter/reference/Hamilton_table_2.html)
 
 
 Finally, a vignette recreating the estimates of the original work can be found in [Reproducing Hamilton.](https://justinmshea.github.io/neverhpfilter/articles/Reproducing-Hamilton.html)




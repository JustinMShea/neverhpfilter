# neverhpfilter Package

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/neverhpfilter)](https://cran.r-project.org/package=neverhpfilter) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/JustinMShea/neverhpfilter?branch=master&svg=true)](https://ci.appveyor.com/project/JustinMShea/neverhpfilter) [![Travis-CI Build Status](https://travis-ci.org/JustinMShea/neverhpfilter.svg?branch=master)](https://travis-ci.org/JustinMShea/neverhpfilter) [![codecov.io](https://codecov.io/gh/JustinMShea/neverhpfilter/graph/badge.svg)](https://codecov.io/github/JustinMShea/neverhpfilter?branch=master)


## Introduction

  In the working paper titled "Why You Should Never Use the **H**odrick-**P**rescott Filter", James D. Hamilton proposes an interesting new alternative to economic time series filtering. The **`neverhpfilter`** package provides functions for implementing his solution. [Hamilton (2017) <doi:10.3386/w23429>](https://www.nber.org/papers/w23429)

Hamilton's abstract offers an excellent introduction:

  > (1) The HP filter produces series with spurious dynamic relations that have no basis in the underlying data-generating process. (2) Filtered values at the end of the sample are very different from those in the middle, and are also characterized by spurious dynamics. (3) A statistical formalization of the problem typically produces values for the smoothing parameter vastly at odds with common practice, e.g., a value for $\lambda$ far below 1600 for quarterly data. (4) There's a better alternative. A regression of the variable at date $t + h$ on the four most recent values as of date $t$ offers a robust approach to detrending that achieves all the objectives sought by users of the HP filter with none of its drawbacks.


  
## Getting Started


Install from the Github master branch on R version >= 3.4.0.

```{r}
devtools::install_github("JustinMShea/neverhpfilter")
```

Load the package

```{r}
library(neverhpfilter)
```

Read the vignette [Reproducing Hamilton.](https://justinmshea.github.io/neverhpfilter/articles/Reproducing-Hamilton.html)


## Package Documentation

The package consists of 2 core functions documented here:

 * [yth_glm](https://justinmshea.github.io/neverhpfilter/reference/yth_glm.html)

 * [yth_filter](https://justinmshea.github.io/neverhpfilter/reference/yth_filter.html)


# neverhpfilter Package

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/JustinMShea/neverhpfilter?branch=master&svg=true)](https://ci.appveyor.com/project/JustinMShea/neverhpfilter) [![Travis-CI Build Status](https://travis-ci.org/JustinMShea/neverhpfilter.svg?branch=master)](https://travis-ci.org/JustinMShea/neverhpfilter) [![Coverage Status](https://img.shields.io/codecov/c/github/JustinMShea/neverhpfilter/master.svg)](https://codecov.io/github/JustinMShea/neverhpfilter?branch=master)

## Introduction

In his working paper titled "Why You Should Never Use the 
  Hodrick-Prescott Filter", James D. Hamilton proposes an alternative approach to 
  economic time series filtering. The `neverhpfilter` package implements his approach.
  By fitting a Generalized Linear Model of the `y` variable at date `t+h` on `p` 
  lagged values of a time series, all the objectives sought by users of the 
  Hodrick-Prescott filter are met, with none of its drawbacks. [Hamilton (2017) 
  <doi:10.3386/w23429>](https://www.nber.org/papers/w23429)
  
## Getting Started

Install from the Github master branch on R version >= 3.4.0.

```{r}
devtools::install_github("JustinMShea/neverhpfilter")

library(neverhpfilter)
```

Read the vignette [Reproducing Hamilton.](https://justinmshea.github.io/neverhpfilter/articles/Reproducing-Hamilton.html)


## Package Documentation

The package consists of 4 core functions, clearly documented here:

 * [yth_glm](https://justinmshea.github.io/neverhpfilter/reference/yth_glm.html)

 * [yth_trend](https://justinmshea.github.io/neverhpfilter/reference/yth_trend.html)

 * [yth_cycle](https://justinmshea.github.io/neverhpfilter/reference/yth_cycle.html)

 * [yth_filter](https://justinmshea.github.io/neverhpfilter/reference/yth_filter.html)


# neverhpfilter Package

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/JustinMShea/neverHPfilter?branch=master&svg=true)](https://ci.appveyor.com/project/JustinMShea/neverHPfilter) [![Travis-CI Build Status](https://travis-ci.org/JustinMShea/neverHPfilter.svg?branch=master)](https://travis-ci.org/JustinMShea/neverHPfilter)

In their working paper titled "Why You Should Never Use the Hodrick-Prescott Filter", James D. Hamilton and his trusty research assistant Daniel Leff, propose a more robust approach to economic time series filtering. By regressing the y variable at date T+h on the four most recent lagged values as of date t, all the objectives sought by users of the Hodrick-Prescott Filter are met, with none of its drawbacks. [Hamilton (2017) <doi:10.3386/w23429>.](https://www.nber.org/papers/w23429)

Install from the Github master branch on R version >= 3.4.0.

```{r}
devtools::install_github("JustinMShea/neverhpfilter")
```

Load the library and check out the documentation:
```{r}
library(neverhpfilter)

?HL_filter

?HL_filter_lm
```

Load the [`vignettes`]() to build the research project and view the results.

```{r}
vignette("Reproducing-Hamilton")
```

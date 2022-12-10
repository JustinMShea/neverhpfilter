<!--
  %\VignetteIndexEntry{Reproducing Hamilton}  
  %\VignetteEngine{simplermarkdown::mdweave_to_html}
  %\VignetteEncoding{UTF-8}
-->

---
title: "Reproducing Hamilton"
author: "Justin M Shea"
---


  In the working paper titled "Why You Should Never Use the **H**odrick-**P**rescott Filter", James D. Hamilton proposes an interesting new alternative to economic time series filtering. The **`neverhpfilter`** package provides functions for implementing his solution.
[Hamilton (2017) <doi:10.3386/w23429>](https://www.nber.org/papers/w23429)


Hamilton's abstract offers an excellent introduction to the problem and alternative solution:


  > 
  (1) The HP filter produces series with spurious dynamic relations that have no basis in the underlying data-generating process.  
  (2) Filtered values at the end of the sample are very different from those in the middle, and are also characterized by spurious dynamics.  
  (3) A statistical formalization of the problem typically produces values for the smoothing parameter vastly at odds with common practice, e.g., a value for $\lambda$ far below 1600 for quarterly data.  
  (4) There's a better alternative. A regression of the variable at date $t + h$ on the four most recent values as of date $t$ offers a robust approach to detrending that achieves all the objectives sought by users of the HP filter with none of its drawbacks.


Using quarterly economic data, Hamilton suggests a linear model on a 
univariate time series shifted a**h**ead by **h** periods, regressed against 
a series of variables constructed from varying lags of the series by some number of **p**eriods, **p**. A modified auto-regressive $AR(p)$ model, dependent on a $t+h$ look-ahead, if you will. This is expressed more specifically by:

$$y_{t+8} = \beta_0 + \beta_1 y_t + \beta_2 y_{t-1} +\beta_3 y_{t-2} + \beta_4 y_{t-3} + v_{t+8}$$
$$\hat{v}_{t+8} = y_{t+8} + \hat{\beta}_0 + \hat{\beta}_1 y_t + \hat{\beta}_2 y_{t-1} + \hat{\beta}_3 y_{t-2} + \hat{\beta}_4 y_{t-3}$$

Which can be rewritten as:

$$y_{t} = \beta_0 + \beta_1 y_{t-8} + \beta_2 y_{t-9} + \beta_3 y_{t-10} + \beta_4 y_{t-11} + v_{t}$$

$$\hat{v}_{t} = y_{t} - \hat{\beta}_0 + \hat{\beta}_1 y_{t-8} + \hat{\beta}_2 y_{t-9} + \hat{\beta}_3 y_{t-10} + \hat{\beta}_4 y_{t-11}$$



## Implementation

First, lets run the `yth_filter` on Real GDP using the default settings suggested by Hamilton of an $h = 8$ look-ahead period (2 years) and $p = 4$ lags (1 year). The output is displayed below containing the original series, trend, cycle, and random components. 

The random component is simply the difference between the original series and its $h$ look ahead, which is why it leads 8 `NA` observations. Due to the $h$ and $p$ parameters, trend and cycle components lead with 11 `NA` observations.


```{r, message = FALSE, warning = FALSE}
library(neverhpfilter)
```

```{r, message = FALSE, warning = FALSE}
data(GDPC1)

gdp_filter <- yth_filter(100*log(GDPC1), h = 8, p = 4)

head(data.frame(Date=index(gdp_filter), coredata(gdp_filter)), 15)
```

## Comparing our estimates with Hamilton's

In this next section, I reproduce a few of Hamilton's tables and graphs, to make
sure the functions approximately match his results.

In the Appendix, Employment (All Employees: Total Non-farm series) is plotted in the form of $100 * log($`PAYEMS`$)$ and superimposed with it's random walk representation. (Hamilton 44). There are many good reasons to use `xts` when handling time series data. Two of them are illustrated below in efficiently transforming monthly series `to.quarterly` and in `plot`ing the results of `yth_filter`.

```{r, message = FALSE, warning = FALSE}
data(PAYEMS)
log_Employment <- 100*log(xts::to.quarterly(PAYEMS["1947/2016-6"], OHLC = FALSE))

employ_trend <- yth_filter(log_Employment, h = 8, p = 4, output = c("x", "trend"), family = gaussian)

plot.xts(employ_trend, grid.col = "white", legend.loc = "topleft", main = "Log of Employment and trend")
```

When filtering time series, the cycle component is of great interest. Here, it is graphed alongside
a random walk representation (Hamilton 44).

```{r, warning = FALSE}
employ_cycle <- yth_filter(log_Employment, h = 8, p = 4, output = c("cycle", "random"), family = gaussian)

plot.xts(employ_cycle, grid.col = "white", legend.loc = "topright", main="Log of Employment cycle and random")
abline(h=0)
```

Turning the page, we find a similar graph of the cyclical component of $100 * log$ of GDP, Exports, Consumption, Imports, Investment, and Government (Hamilton 45). 

Below I `merge` these data into one `xts` object and write a function wrapper around `yth_filter` and `plot`, which is then `lapply`'d over each series, producing a plot for each one.

```{r, message=FALSE, warning=FALSE}
fig6_data <- 100*log(merge(GDPC1, EXPGSC1, PCECC96, IMPGSC1, GPDIC1, GCEC1)["1947/2016-3"])

fig6_wrapper <- function(x, ...) {
               cycle <-  yth_filter(x, h = 8, p = 4, output = c("cycle", "random"), family = gaussian)
               plot.xts(cycle, grid.col = "white", lwd=1, main = names(x))
}
```

```{r, warning=FALSE, message=FALSE, eval=FALSE}
par(mfrow=c(3,2))
lapply(fig6_data, fig6_wrapper)
```

```{r, echo=FALSE,results='hide',fig.keep='all'}
par(mfrow=c(3,2))
lapply(fig6_data, fig6_wrapper)
```

When striving to recreate a statistical method found in a journal or paper, one can perform surprisingly well by thoroughly digesting the relevant sections and "eyeballing" graphs included in the original author's work.

Better still, is finding a table presenting said author's estimates, which one 
can use to directly compare with their own. Fortunately for us, Hamilton's 
Appendix displays such a table which I use here to test against functions 
contained in **`neverhpfilter`**.

His results are displayed below in table 2 (Hamilton 40), which I've stored as a `data.frame` in this package.

```{r, eval=FALSE}
data("Hamilton_table_2")
?Hamilton_table_2
```

```{r}
Hamilton_table_2[-NROW(Hamilton_table_2),]
```


I'll replicate the table above, combining base R functions with estimates of the `yth_filter` function.

The first step is to combine our economic time series into an object that allows 
for convenient iteration of computations across all data of interest. First, 
`merge` all series of quarterly frequency. These are `GDPC1, PCECC96, GPDIC1, EXPGSC1, IMPGSC1, GCEC1, GDPDEF`. At this point, subset observations by the precise date 
range used by Hamilton. At some point, all series which are measured in prices 
need to be given the $100*log$ treatment, so do this now.

```{r, warning = FALSE, message = FALSE}
quarterly_data <- 100*log(merge(GDPC1, PCECC96, GPDIC1, EXPGSC1, IMPGSC1, GCEC1, GDPDEF)["1947/2016-3"])
```

Some economic time series we wish to compare are measured in monthly periodicity, 
so we need to lower their frequency `to.quarterly`. `merge` monthly series and 
$100*log$ those expressed in prices. Leave data measured in percentages be.
Then, functionally iterate over every series and transform them `to.quarterly`.
Finally, all series are combined into one `xts` object, I call `quarterly_data`.

```{r, warning = FALSE, message = FALSE}
monthly_data <- merge(100*log(PAYEMS), 100*log(SP500$SP500)["1950/"], UNRATENSA, GS10, FEDFUNDS)

to_quarterly_data <- do.call(merge, lapply(monthly_data, to.quarterly, OHLC = FALSE))["1947/2016-6"]

quarterly_data <- merge(quarterly_data, to_quarterly_data)
```

Now its time to functionally iterate over each series. I do this by `lapply`ing 
the `yth_filter` to each series, while iteratively `merge`ing results into one 
object with `do.call`. The optional argument of `output = "cycle"` is convenient
here as it returns the labeled univariate cycle component for each series. For
example, `GDPCE1.cycle`. The same approach is use to compute the `random` 
component for each series as well.

```{r, warning = FALSE, message = FALSE}
cycle <- do.call(merge, lapply(quarterly_data, yth_filter, output = "cycle"))

random <- do.call(merge, lapply(quarterly_data, yth_filter, output = "random"))
```

Now that all data have been transformed into both `cycle` and `random` series, 
its time to estimate the standard deviation for each, as well as each components correlation with `GDP`. This is also a good opportunity to `t`ranspose each of our estimates into vertical columned `data.frames`, matching Hamilton's format. 

```{r, warning = FALSE, message = FALSE}
cycle.sd <- t(data.frame(lapply(cycle, sd, na.rm = TRUE)))
GDP.cor <- t(data.frame(lapply(cycle, cor, cycle[,1], use = "complete.obs")))
random.sd <- t(data.frame(lapply(random, sd, na.rm = TRUE)))
random.cor <- t(data.frame(lapply(random, cor, random[,1], use = "complete.obs")))

my_table_2 <- round(data.frame(cbind(cycle.sd, GDP.cor, random.sd, random.cor)), 2)
```

Hamilton displays the date ranges of his samples, so we will do the same, while
keeping the `xts` date range syntax format. I use a simple function I call 
`sample_range` to extract the first and last observation of each series' `index.xts`. This approach serves as a check on the work, as oppose to manually creating labels.
Sample ranges are then `t`ransposed into vertical `data.frames` and `cbind`'d to 
the existing table of estimates. 

```{r, warning = FALSE, message = FALSE}
sample_range <- function(x) {
  x <- na.omit(x)
  gsub(" ", "-", paste0(index(x[1,]), "/", index(x[NROW(x),])))
}

data_sample <- t(data.frame(lapply(quarterly_data, sample_range)))

my_table_2 <- cbind(my_table_2, data_sample)
names(my_table_2) <- names(Hamilton_table_2)
```


Finally, `rbind` Hamilton's table 2 with my table for a visual comparison. The 
results are nearly identical, inspiring confidence in the replication of the 
approach, as the functions of the `neverhpfilter` package.


According to the 'code and data' link on the ['Current Working Papers'](http://econweb.ucsd.edu/~jhamilto/#working) page of Hamilton's site,
both Matlab and RATS were used for computation of the table. It is not
surprising that minor differences in estimates would occur, likely due to 
differences in the underlying data or internal computational choices made by each commercial software product. While economic time series are publicly available 
and have a central source at [FRED](https://fred.stlouisfed.org/), that is not 
so for Standard & Poor's index data. Unsurprisingly, the `SP500` data shows the 
most divergence, and it is not clear what source was used in the original paper
(though I have my suspicions for future exploration).

Below, see Hamilton's table 2 compared with estimates from neverhpfilter::yth_filter, sorted by standard deviation of the cycle component. yth_filter estimates are labeled with the suffix **`.cycle`**

```{r, warning = FALSE, message = FALSE, caption = "Comparison table: Hamilton vs neverhpfilter"}
 # Combined table
combined_table <- rbind(Hamilton_table_2[-NROW(Hamilton_table_2),], my_table_2)

combined_table[order(combined_table$cycle.sd),]
```

# Summary

The estimates generated with the `neverhpfilter` package are nearly identical to those displayed by Hamilton (2017). If one has the use case, the generalized functions 
which inherit methods from `glm` and `xts` will estimate higher frequency time 
series as well as error distributions other than Gaussian. In addition to 
consulting the paper which inspired this package, check out the documentation 
for `yth_filter` to learn more, or reach out to me with any questions.


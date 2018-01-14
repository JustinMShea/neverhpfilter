
## Resubmission

* Undirected quotation marks in the Description field have been removed.

* Title has been written in title case.

* Thank you for your suggestion of putting everything in one function! It forced
  me to revisit my reasoning and use cases. 

* However, the use of four simple function as oppose to one was inspired by Hadley Wickham 
  and the book "The Clean Coder", which suggest that functions should do one thing 
  only and one thing well. As the intended audience of this package will be Economists 
  and students who may have difficulty with R, I wanted consider that.
  
  The output of the `yth_filter` function was inspired by the `hpfilter` function found in 
  Mehmet Balcilar's `mFilter` package. The `hpfilter` function returns the original
  series, trend, and cycle, which are components of interest during such an analysis. 
  Adding a fourth series, the Random walk, is suggested by Hamilton for diagnostics.
  For exploring a single economic time series, this is best.
  
  The `yth_cycle` and `yth_trend` functions exist so one can use them to easily 
  `lapply` over an xts object containing dozens or hundreds of economic time series. 
  As many economic time series are of quarterly periodicity, the default setting 
  will suffice, meaning one can do something like `lapply(xts_object, yth_cycle)`, 
  which is compact and easy to remember.
  
  Instead of creating my own optimization, I chose the `glm` function as it has 
  a rich set of arguments that might prove useful. While I originally did not 
  intend to include the `yth_glm` function in the package, I decided to include 
  it as one may want to examine the model and use generic functions associated 
  with objects of class `glm` to do so.

# Test environments passing
* Local: R version 3.4.3 (2017-11-30), x86_64-w64-mingw32 (64-bit)
* win-builder: , R Under development (unstable) (2018-01-09 r74104), x86_64-w64-mingw32(64-bit)
* travis-ci: R version 3.4.2 (2017-01-27), x86_64-pc-linux-gnu (64-bit), Ubuntu 14.04.5 LTS, R 3.4.1 
* AppVeyor: R version 3.4.3 Patched (2018-01-07 r74099), i386-w64-mingw32/i386 (32-bit), Windows Server 2012 R2 x64 (build 9600)

## Local R CMD check results
There were no ERRORs, WARNINGs or NOTEs
0 errors | 0 warnings | 0 notes
R CMD check succeeded

## win-builder
Status: 1 NOTE
Possibly mis-spelled words in DESCRIPTION:
Hodrick (3:36, 6:72)
neverhpfilter (8:71)
  
## travis-ci
Done. Your build exited with 0.

## AppVeyor
Build success
  

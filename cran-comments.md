
## Resubmission

* Undirected quotation marks in the Description field have been removed.

* Title has been written in title case.

* Thank you for pointing out code redundancy in my functions.
  It forced me to revisit use cases and ultimately consolidate four functions into 
  two. I also added more data to recreate more of Hamilton's work and illustrate 
  the use cases for returning univariate series of the yth_filter. Specifically, 
  cleanly lapply-ing over xts objects containing multiple series, a common approach in
  practice.
  
* Feature version bump to 0.2-0.

# Test environments passing
* Local: R version 3.4.2 (2017-09-28), x86_64 mingw32 (64-bit)
* win-builder: , R Under development (unstable) (2018-01-23 r74154), x86_64-w64-mingw32(64-bit)
* travis-ci: R version 3.4.2 (2017-01-27), x86_64-pc-linux-gnu (64-bit), Ubuntu 14.04.5 LTS, R 3.4.1 
* AppVeyor: R version 3.4.3 Patched (2018-01-20 r74151), i386-w64-mingw32/i386 (32-bit), Windows Server 2012 R2 x64 (build 9600)
* r-hub: R version 3.4.1 (2017-06-30)macOS 10.11 El Capitan, R-release (experimental)

## Local R CMD check results
R CMD check results
0 errors | 0 warnings | 0 notes
R CMD check succeeded

## win-builder
Status: 1 NOTE
Possibly mis-spelled words in DESCRIPTION:
Hodrick (3:36, 6:72)
neverhpfilter (8:31)
  
## travis-ci
Done. Your build exited with 0.

## AppVeyor
Build success

## r-hub
Finished: SUCCESS
0 errors ✔ | 0 warnings ✔ | 0 notes ✔

  

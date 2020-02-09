# minor version bump to 0.3-1
## Test environments passing

# Linux
* Local Ubuntu 18.04: R version 3.6.3, x86_64-pc-linux-gnu (64-bit)
* travis-ci Ubuntu 16.04.6 LTS: R version 3.6.2 (2017-01-27), x86_64-pc-linux-gnu (64-bit)
 ## R CMD check results
 ### Local results
      Status: OK
      R CMD check succeeded
 ### travis-ci results
      Done. Your build exited with 0.

# Mac
* r-hub macOS 10.11 El Capitan R-release (experimental): R version 3.6.2 (2019-12-12) x86_64-apple-darwin15.6.0 (64-bit)
 ## R CMD check results
 ### r-hub: macOS 10.11 El Capitan 
      Status: OK
      Finished: SUCCESS


# Windows
* AppVeyor Windows Server 2012 R2 x64 (build 9600): R version 3.6.2 Patched (2020-02-07 r77779), x86_64-w64-mingw32/x64 (64-bit)
* r-hub Windows Server 2008 R2 SP1, R-release, 32/64 bit: R version 3.6.2 (2019-12-12), x86_64-w64-mingw32 (64-bit)
* r-hub Windows Server 2012, R-devel, Rtools4.0, 32/64 bit (experimental): R version 4.0.0 Under development (Testing Rtools) (2019-09-30 r77236), x86_64-w64-mingw32 (64-bit) 
#  Windows Server 2008 R2 SP1, R-devel, 32/64 bit: R Under development (unstable) (2020-01-22 r77697), x86_64-w64-mingw32 (64-bit) 
 ## R CMD check results
  ### AppVeyor
       Status: OK
      Build success
  ### r-hub: Windows Server 2008 R2 SP1, R-release, 32/64 bit
       Status: OK
       Finished: SUCCESS
  ### r-hub: Windows Server 2012, R-devel, Rtools4.0, 32/64 bit (experimental)
       Status: OK
       Finished: SUCCESS
  ### r-hub:  Windows Server 2008 R2 SP1, R-devel, 32/64 bit
       Status: OK
       Finished: SUCCESS
  
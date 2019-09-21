# Check and build package
devtools::check()	
devtools::build()

# build for windows and submit to win-builder-r-project.org
devtools::build_win()

# R-hub Build
rhub::list_validated_emails()
rhub::validate_email()

rhub::platforms()
rhub::platforms()$name

rhub::check(platform = rhub::platforms()$name[1]) # "debian-clang-devel" 
rhub::check(platform = rhub::platforms()$name[2]) # "debian-gcc-devel"  
rhub::check(platform = rhub::platforms()$name[7]) # "fedora-gcc-devel"  
rhub::check(platform = rhub::platforms()$name[10]) # "linux-x86_64-rocker-gcc-san"

rhub::check(platform = rhub::platforms()$name[11]) # "macos-elcapitan-release" 

rhub::check(platform = rhub::platforms()$name[12]) # "solaris-x86-patched" 

rhub::check(platform = rhub::platforms()$name[16]) # "windows-x86_64-devel"
rhub::check(platform = rhub::platforms()$name[17]) # "windows-x86_64-devel-rtools4"
rhub::check(platform = rhub::platforms()$name[20]) # "windows-x86_64-release"

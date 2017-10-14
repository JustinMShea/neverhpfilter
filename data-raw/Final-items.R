
###############
# Final items #
###############

# time to roxygenize those .R description files we wrote!
devtools::document()

# Build a vignette template
devtools::use_vignette()

# Render .pdf and .html vignettes
library(rmarkdown)
rmarkdown::render("vignettes/Hamilton-Leff-Filter-vignette.Rmd", "all")
rmarkdown::render("vignettes/US_Economic_Data_Management.Rmd", "all")

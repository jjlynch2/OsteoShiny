#Current development status for 1.2.11
# Installation
To install directly from GitHub use the devtools R package:

`install.packages("devtools")`

`library(devtools)`

`install_github("jjlynch2/OsteoShiny", force = TRUE)`

# Depends
* OsteoSort (>= 1.2.6)
* htmltools
* zip
* plyr
* DT
* shiny

# Changes for OsteoShiny version : 1.2.11

## Minor changes:
* Updated Example_Data to include outliers
* Updated imports for DESC

## Moderate changes:
* Removed shinyRGL and switched to intern rgl widget functions
* Added option to use Boxcox transformation for t-tests
* Added option to select number of Principal Components for regression analysis
* Added option (default) to select number of Principal Components based on cumulative variance 

## Bug fixes:
* Fixed two bugs in the single user interface to avoid crashing when running association analyses with the Radius and Femur
* Fixed a bug with supplemental measurements and the ulna crashing in the single user interface

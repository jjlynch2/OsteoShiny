#Current development status for 1.3.0
# Installation
To install directly from GitHub use the devtools R package:

`install.packages("devtools")`
`library(devtools)`

`install_github("jjlynch2/OsteoShiny")`

# Depends
* OsteoSort (>= 1.3.0)
* htmltools
* zip
* plyr
* DT
* shiny

# Changes for OsteoShiny version : 1.3.0

## Minor changes:
* Updated Example_Data to include outliers
* Updated imports for DESC

## Moderate changes:
* Removed shinyRGL and switched to intern rgl widget functions
* Added option to use Boxcox transformation for t-tests
* Added option to select number of Principal Components for regression analysis

## Major changes:
* Development prototype for 3D pair-matching is now working.
* Development prototype for fragmented 3D pair-matching is now working.
* Development of 3D preprocessing tool for rough registration and fragmented margin identification is now working. 

## Bug fixes:
*Fixed two bugs in the single user interface to avoid crashing when running association analyses with the Radius and Femur
*Fixed a bug with supplemental measurements and the ulna crashing in the single user interface
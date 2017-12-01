OsteoShiny

A Shiny based GUI R package for the OsteoSort package.

Changes for OsteoShiny version 1.2.2:


Modules:




Minor changes:

Removed number of smooth iterations for 2D method. 

Removed Procrustes distance as an option from 2D settings.

Changed function call for match.2d.invariant to match.2d

Updated Help page information.

Updated user manual (15.NOVEMBER.2017).

Overhaul of UI to simplify.

Added fragmentary example data.



Moderate changes:

Added options for fragmented 2D analysis to the 2D module.

Redesigned the 2D interface and fixed several minor bugs resulting in shiny crashes.

Added dilated hausdorff distance to 2D settings.

Added statistical option to change from 1 to 2 tail t-tests.

Removed shinyBS dep for bsModals.

Switched terminology from cores to threads for functions.



Bug fixes:

Fixed issue with returning a single match for 2D not being a data.frame.
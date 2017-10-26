OsteoShiny

A Shiny based GUI R package for the OsteoSort package.

Changes for OsteoShiny version 1.2.1:


Modules:

Added a new module to test the strength of evidence for an antemortem stature to postmortem measurement


Minor changes:

Added ability to switch output metric between inches, millimeters, and centimeters for the statsort function.

Adjusted the descriptive statistic outputs to be more generalized.

Re-ran roxygenize for man pages. 

Adjusted width of left sidebar.

Updated text on help page.


Bug fixes:

Fixed error with quotes around desktop icon path creation for Windows.

Fixed the settings interface for 2D so max and average are available for Hausdorff rather than just Segmented-Hausdorff.

Appended Osc_05 measurement to settings for metric outlier analysis. 

Fixed HTML code appear in windowTitle. 
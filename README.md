# Changes for OsteoShiny version : 1.2.8

## Minor changes:
* Added vb script to generate a .lnk shortcut rather than using a .bat file
* Added .desktop for Linux
* Added .command for mac
* Updated measurement standards table switching Sca_03 to 44 and Sca_04 to 43
* Removed plyr as dependency
* Removed shinythemes as dependency
* Adjusted articulation default options
* Cleaned up code indenting and changed default bootstrap theme to yeti (smaller font looks cleaner across different screen resolutions)

## Bug fixes:
* Added conditional statement to remove images in 2D analysis, if present, when clicking the clear action button. This prevents crashing when running fragmentary analysis prior to complete. The new images are not overwritten so the old images are run through the analysis. 
* Added conditional statements to prevent UI crashing with articulation and pair-matching missing values
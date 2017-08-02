OsteoShiny
A Shiny based GUI R package for the OsteoSort package.

Changes for OsteoShiny version 1.1.0:

Bug fixes:
1. Switch to using a loop for large file zip archive creation to avoid crashing. The new way appends one file at a time to an archive. 
2. Changed variable name ID from template and argument input to lowercase id to avoid excel bug with csv sylk file error.

API changes:
1. Removed plotme function in favor of generating plots directly in the OsteoSort package.

Document changes:
1. Updated help guide with grammatical changes.
2. Updated all man pages for argument changes.

Module changes:
1. Removed 3D demo due to javascript bug with the example.

Other changes:
1. Added an action button to create desktop icon to start OsteoShiny 

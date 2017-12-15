#' Shiny ui.r file
#' 
#' This is the ui.r file for the interface that utilizes all previous functions. 
#' runApp("osteosort")
options(warn = -1)

library(shiny)
library(shinythemes)

#Navigation bar interface
shinyUI(



	navbarPage(theme = shinytheme("flatly"), 
		windowTitle = "OsteoSort",
		title=div(img(src="OsteoSort.png", width = "30px"), "OsteoSort"),



	navbarMenu("Help",
			tabPanel("About",

						HTML(paste("<h1><span style='font-family: 'Times New Roman', serif;'><strong>OsteoSort</strong></span></h1><hr/>",
								#"<p>&nbsp;</p><p>Automated osteological sorting of human commingled assemblages</p>",
								
								"<strong>OsteoSort:  </strong>", gsub("'", "" , packageVersion("OsteoSort")),"<p></p>",
								"<strong>OsteoShiny:  </strong>", gsub("'", "" , packageVersion("OsteoShiny")),"<p></p>",
								"<strong>R: </strong>", gsub('R ', '', gsub('version.string R ', '', version['version.string'])),"<p></p>",
								"<strong>Platform:  </strong>", Sys.info()[['sysname']],

								#"<p>&nbsp;</p> <p>The methods are split into four primary modules:</p>",
								#"<p>&nbsp;</p><ul><li>Osteometric sorting</li><li>Outlier sorting</li><li>Osteoshape sorting</li><li>Antemortem sorting</li></ul><p>&nbsp;</p>",
						sep = "")),


						HTML("<hr><span style='font-family: 'Times New Roman', serif;'> 
							<p>
							<h2>
							References
							</h2>
							<p>&nbsp;</p>
							Lynch JJ, Byrd JE, LeGarde CB. The power of exclusion using automated osteometric sorting: pair-matching. J Forensic Sci 2018 [In press]. https://doi.org/10.1111/1556-4029.13560. Epub 2017 May 26.
							<p>&nbsp;</p>
							Lynch JJ. An analysis on the choice of alpha level in the osteometric pair-matching of the os coxa, scapula, and clavicle. J Forensic Sci 2018 [In press]. https://doi.org/10.1111/1556-4029.13599. Epub 2017 July 18.
							<p>&nbsp;</p>
							Lynch JJ. The automation of regression modeling in osteometric sorting: an ordination approach. J Forensic Sci 2018 [In press]. https://doi.org/10.1111/1556-4029.13597. Epub 2017 July 21.
							<p>&nbsp;</p>
							Lynch JJ. An automated two-dimensional form registration method for osteological pair-matching. J Forensic Sci 2018 [In press]. https://doi.org/10.1111/1556-4029.13670. Epub 2017 Oct 16.
							<p>&nbsp;</p>
							Lynch JJ. An automated two-dimensional pairwise form registration for pair-matching fragmented skeletal elements. [Under Review].
							<p>&nbsp;</p>
							Lynch JJ and Byrd JE. Antemortem stature association using osteometric sorting: a new method for shortlisting elements with known individuals. [Under Review].
							<p>&nbsp;</p>
							</p>
						")
			),

			tabPanel("Files",
						HTML("<hr><span style='font-family: 'Times New Roman', serif;'> 
						<p>
						<strong>Postmortem template: </strong> Standardized template for importing postmortem data
						<p>&nbsp;</p>
						<strong>Antemortem template: </strong> Standardized template for importing antemortem data
						<p>&nbsp;</p>
						<strong>Help guide: </strong> User help guide for using OsteoSort
						<p>&nbsp;</p>
						<strong>Example data: </strong> Example data for testing analytics
						<p>&nbsp;</p>
						</p>
						"),
						downloadButton('postmortem_template', 'Postmortem template'),
						downloadButton('antemortem_template', 'Antemortem template'),
						downloadButton('osteoguide', 'Help guide'),
						downloadButton('example_data', "Example data")
			),
			tabPanel("Measurements",

				DT::dataTableOutput('measurement_conversion_table')

			),
			tabPanel("Misc",
					actionButton('Create_Desktop_Icon', 'Create Desktop Icon', icon = icon("gears"))
			)


		),



		navbarMenu("Osteometric sorting",
			tabPanel("Single comparison",
				titlePanel(""),
				sidebarLayout(

					sidebarPanel(
						selectInput('testtype', 'Analysis', c(Pair='Pair_match',Articulation='Articulation_match',Association='Regression_match'), 'Pair_match'),
						uiOutput("testtype"),
							conditionalPanel(condition = "input.zz == 'huur' || input.zz == 'hurr' || input.zz == 'hufr' || input.zz == 'hutr' || input.zz == 'hufir' || input.zz == 'ulrr' || input.zz == 'ulfr' || input.zz == 'ultr' || input.zz == 'ulfir' || input.zz == 'rafr' || input.zz == 'ratr' || input.zz == 'rafir' || input.zz == 'fetr' || input.zz == 'fefir' || input.zz == 'tifir' || input.zz == 'humerus' || input.zz == 'ulna' || input.zz == 'radius' || input.zz == 'femur' || input.zz == 'tibia' || input.zz == 'fibula' || input.zz == 'scapula' || input.zz == 'os_coxa' || input.zz == 'clavicle' ",
									selectInput("a", "Measurements", c(Standard='single_standard', Supplemental='single_supplemental'))
							),		
						conditionalPanel(condition = "input.testtype == 'Regression_match'",
							selectInput("prr", label = "Predictor", c("Bone1", "Bone2"))
						),
							conditionalPanel(condition = "input.a == 'single_standard'", 
								conditionalPanel(condition = "input.zz == 'huur'",
									fluidRow(
											column(6,
											
											selectInput("huurside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'huur40', label = 'Hum_01', value = ''),								
											numericInput(inputId = 'huur41', label = 'Hum_02', value = ''),		
											numericInput(inputId = 'huur42', label = 'Hum_03', value = ''),																		
											numericInput(inputId = 'huur43', label = 'Hum_04', value = ''),	
											numericInput(inputId = 'huur44', label = 'Hum_05', value =  '')																								
										),
										column(6,
											
											selectInput("huurside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'huur48', label = 'Uln_01', value = ''),							
											numericInput(inputId = 'huur49', label = 'Uln_04', value = ''),	
											numericInput(inputId = 'huur50', label = 'Uln_05', value = ''),	
											numericInput(inputId = 'huur51', label = 'Uln_06', value = '')
											#numericInput(inputId = 'huur52', label = '52', value = '')
										)
									)
								),
								
								
								conditionalPanel(condition = "input.zz == 'hurr'",
									fluidRow(
											column(6,
											
											selectInput("hurrside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'hurr40', label = 'Hum_01', value = ''),								
											numericInput(inputId = 'hurr41', label = 'Hum_02', value = ''),		
											numericInput(inputId = 'hurr42', label = 'Hum_03', value = ''),																		
											numericInput(inputId = 'hurr43', label = 'Hum_04', value = ''),	
											numericInput(inputId = 'hurr44', label = 'Hum_05', value =  '')																								
										),
										column(6,
											
											selectInput("hurrside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'hurr45', label = 'Rad_01', value = ''),								
											numericInput(inputId = 'hurr46', label = 'Rad_05', value = ''),	
											numericInput(inputId = 'hurr47', label = 'Rad_06', value = '')
										)
									)
								),
								
								
								conditionalPanel(condition = "input.zz == 'hufr'",
									fluidRow(
											column(6,
											
											selectInput("hufrside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'hufr40', label = 'Hum_01', value = ''),								
											numericInput(inputId = 'hufr41', label = 'Hum_02', value = ''),		
											numericInput(inputId = 'hufr42', label = 'Hum_03', value = ''),																		
											numericInput(inputId = 'hufr43', label = 'Hum_04', value = ''),	
											numericInput(inputId = 'hufr44', label = 'Hum_05', value =  '')																								
										),
										column(6,
											
											selectInput("hufrside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'hufr60', label = 'Fem_01', value = ''),								
											numericInput(inputId = 'hufr61', label = 'Fem_02', value = ''),
											numericInput(inputId = 'hufr62', label = 'Fem_03', value = ''),
											numericInput(inputId = 'hufr63', label = 'Fem_04', value = ''),
											numericInput(inputId = 'hufr65', label = 'Fem_05', value = ''),
											numericInput(inputId = 'hufr64', label = 'Fem_06', value = ''),
											numericInput(inputId = 'hufr66', label = 'Fem_07', value = '')
											#numericInput(inputId = 'hufr67', label = 'Fem_08', value = ''),
											#numericInput(inputId = 'hufr68', label = '68', value = '')
										)
									)
								),
								
								
								conditionalPanel(condition = "input.zz == 'hutr'",
									fluidRow(
											column(6,
											
											selectInput("hutrside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'hutr40', label = 'Hum_01', value = ''),								
											numericInput(inputId = 'hutr41', label = 'Hum_02', value = ''),		
											numericInput(inputId = 'hutr42', label = 'Hum_03', value = ''),																		
											numericInput(inputId = 'hutr43', label = 'Hum_04', value = ''),	
											numericInput(inputId = 'hutr44', label = 'Hum_05', value =  '')																								
										),
										column(6,
											
											selectInput("hutrside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'hutr69', label = 'Tib_01', value = ''),								
											numericInput(inputId = 'hutr70', label = 'Tib_02', value = ''),
											numericInput(inputId = 'hutr71', label = 'Tib_03', value = ''),
											numericInput(inputId = 'hutr72', label = 'Tib_04', value = ''),
											numericInput(inputId = 'hutr73', label = 'Tib_05', value = '')
											#numericInput(inputId = 'hutr74', label = 'Tib_06', value = '')
										)
									)
								),
								
								
								conditionalPanel(condition = "input.zz == 'hufir'",
									fluidRow(
											column(6,
											
											selectInput("hufirside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'hufir40', label = 'Hum_01', value = ''),								
											numericInput(inputId = 'hufir41', label = 'Hum_02', value = ''),		
											numericInput(inputId = 'hufir42', label = 'Hum_03', value = ''),																		
											numericInput(inputId = 'hufir43', label = 'Hum_04', value = ''),	
											numericInput(inputId = 'hufir44', label = 'Hum_05', value =  '')																								
										),
										column(6,
											
											selectInput("hufirside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'hufir75', label = 'Fib_01', value = ''),								
											numericInput(inputId = 'hufir76', label = 'Fib_02', value = '')
										)
									)
								),
								
								conditionalPanel(condition = "input.zz == 'ulrr'",
									fluidRow(
										column(6,
											
											selectInput("ulrrside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'ulrr48', label = 'Uln_01', value = ''),							
											numericInput(inputId = 'ulrr49', label = 'Uln_04', value = ''),	
											numericInput(inputId = 'ulrr50', label = 'Uln_05', value = ''),	
											numericInput(inputId = 'ulrr51', label = 'Uln_06', value = '')
											#numericInput(inputId = 'ulrr52', label = '52', value = '')
										),
										column(6,
											
											selectInput("ulrrside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'ulrr45', label = 'Rad_01', value = ''),								
											numericInput(inputId = 'ulrr46', label = 'Rad_05', value = ''),	
											numericInput(inputId = 'ulrr47', label = 'Rad_06', value = '')
										)
									)
								),
								
								conditionalPanel(condition = "input.zz == 'ulfr'",
									fluidRow(
										column(6,
											
											selectInput("ulfrside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'ulfr48', label = 'Uln_01', value = ''),							
											numericInput(inputId = 'ulfr49', label = 'Uln_04', value = ''),	
											numericInput(inputId = 'ulfr50', label = 'Uln_05', value = ''),	
											numericInput(inputId = 'ulfr51', label = 'Uln_06', value = '')
											#numericInput(inputId = 'ulfr52', label = '52', value = '')
										),
										column(6,
											
											selectInput("ulfrside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'ulfr60', label = 'Fem_01', value = ''),								
											numericInput(inputId = 'ulfr61', label = 'Fem_02', value = ''),
											numericInput(inputId = 'ulfr62', label = 'Fem_03', value = ''),
											numericInput(inputId = 'ulfr63', label = 'Fem_04', value = ''),
											numericInput(inputId = 'ulfr65', label = 'Fem_05', value = ''),
											numericInput(inputId = 'ulfr64', label = 'Fem_06', value = ''),
											numericInput(inputId = 'ulfr66', label = 'Fem_07', value = '')
											#numericInput(inputId = 'ulfr67', label = 'Fem_08', value = ''),
											#numericInput(inputId = 'ulfr68', label = '68', value = '')
										)
										

									)
								),
								
								conditionalPanel(condition = "input.zz == 'ultr'",
									fluidRow(
										column(6,
											
											selectInput("ultrside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'ultr48', label = 'Uln_01', value = ''),							
											numericInput(inputId = 'ultr49', label = 'Uln_04', value = ''),	
											numericInput(inputId = 'ultr50', label = 'Uln_05', value = ''),	
											numericInput(inputId = 'ultr51', label = 'Uln_06', value = '')
											#numericInput(inputId = 'ultr52', label = '52', value = '')
										),
										
										column(6,
											
											selectInput("ultrside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'ultr69', label = 'Tib_01', value = ''),								
											numericInput(inputId = 'ultr70', label = 'Tib_02', value = ''),
											numericInput(inputId = 'ultr71', label = 'Tib_03', value = ''),
											numericInput(inputId = 'ultr72', label = 'Tib_04', value = ''),
											numericInput(inputId = 'ultr73', label = 'Tib_05', value = '')
											#numericInput(inputId = 'ultr74', label = 'Tib_06', value = '')
										)

									)
								),
								conditionalPanel(condition = "input.zz == 'ulfir'",
									fluidRow(
										column(6,
											
											selectInput("ulfirside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'ulfir48', label = 'Uln_01', value = ''),							
											numericInput(inputId = 'ulfir49', label = 'Uln_04', value = ''),	
											numericInput(inputId = 'ulfir50', label = 'Uln_05', value = ''),	
											numericInput(inputId = 'ulfir51', label = 'Uln_06', value = '')
											#numericInput(inputId = 'ulfir52', label = '52', value = '')
										),
										column(6,
											
											selectInput("ulfirside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'ulfir75', label = 'Fib_01', value = ''),								
											numericInput(inputId = 'ulfir76', label = 'Fib_02', value = '')
										)

									)
								),
								conditionalPanel(condition = "input.zz == 'rafr'",
									fluidRow(
										column(6,
											
											selectInput("rafrside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'rafr45', label = 'Rad_01', value = ''),								
											numericInput(inputId = 'rafr46', label = 'Rad_05', value = ''),	
											numericInput(inputId = 'rafr47', label = 'Rad_06', value = '')
										),
										column(6,
											
											selectInput("rafrside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'rafr60', label = 'Fem_01', value = ''),								
											numericInput(inputId = 'rafr61', label = 'Fem_02', value = ''),
											numericInput(inputId = 'rafr62', label = 'Fem_03', value = ''),
											numericInput(inputId = 'rafr63', label = 'Fem_04', value = ''),
											numericInput(inputId = 'rafr65', label = 'Fem_05', value = ''),
											numericInput(inputId = 'rafr64', label = 'Fem_06', value = ''),
											numericInput(inputId = 'rafr66', label = 'Fem_07', value = '')
											#numericInput(inputId = 'rafr67', label = 'Fem_08', value = ''),
											#numericInput(inputId = 'rafr68', label = '68', value = '')
										)

									)
								),
								conditionalPanel(condition = "input.zz == 'ratr'",
									fluidRow(
										column(6,
											
											selectInput("ratrside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'ratr45', label = 'Rad_01', value = ''),								
											numericInput(inputId = 'ratr46', label = 'Rad_05', value = ''),	
											numericInput(inputId = 'ratr47', label = 'Rad_06', value = '')
										),
										column(6,
											
											selectInput("ratrside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'ratr69', label = 'Tib_01', value = ''),								
											numericInput(inputId = 'ratr70', label = 'Tib_02', value = ''),
											numericInput(inputId = 'ratr71', label = 'Tib_03', value = ''),
											numericInput(inputId = 'ratr72', label = 'Tib_04', value = ''),
											numericInput(inputId = 'ratr73', label = 'Tib_05', value = '')
											#numericInput(inputId = 'ratr74', label = 'Tib_06', value = '')
										)


									)
								),
								conditionalPanel(condition = "input.zz == 'rafir'",
									fluidRow(
										column(6,
											
											selectInput("rafirside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'rafir45', label = 'Rad_01', value = ''),								
											numericInput(inputId = 'rafir46', label = 'Rad_05', value = ''),	
											numericInput(inputId = 'rafir47', label = 'Rad_06', value = '')
										),
										column(6,
											
											selectInput("rafirside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'rafir75', label = 'Fib_01', value = ''),								
											numericInput(inputId = 'rafir76', label = 'Fib_02', value = '')
										)


									)
								),
								conditionalPanel(condition = "input.zz == 'fetr'",
									fluidRow(
										column(6,
											
											selectInput("fetrside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'fetr60', label = 'Fem_01', value = ''),								
											numericInput(inputId = 'fetr61', label = 'Fem_02', value = ''),
											numericInput(inputId = 'fetr62', label = 'Fem_03', value = ''),
											numericInput(inputId = 'fetr63', label = 'Fem_04', value = ''),
											numericInput(inputId = 'fetr65', label = 'Fem_05', value = ''),
											numericInput(inputId = 'fetr64', label = 'Fem_06', value = ''),
											numericInput(inputId = 'fetr66', label = 'Fem_07', value = '')
											#numericInput(inputId = 'fetr67', label = 'Fem_08', value = '')
										),
										column(6,
											
											selectInput("fetrside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'fetr69', label = 'Tib_01', value = ''),								
											numericInput(inputId = 'fetr70', label = 'Tib_02', value = ''),
											numericInput(inputId = 'fetr71', label = 'Tib_03', value = ''),
											numericInput(inputId = 'fetr72', label = 'Tib_04', value = ''),
											numericInput(inputId = 'fetr73', label = 'Tib_05', value = '')
										)

									)
								),
								conditionalPanel(condition = "input.zz == 'fefir'",
									fluidRow(
										column(6,
											
											selectInput("fefirside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'fefir60', label = 'Fem_01', value = ''),								
											numericInput(inputId = 'fefir61', label = 'Fem_02', value = ''),
											numericInput(inputId = 'fefir62', label = 'Fem_03', value = ''),
											numericInput(inputId = 'fefir63', label = 'Fem_04', value = ''),
											numericInput(inputId = 'fefir65', label = 'Fem_05', value = ''),
											numericInput(inputId = 'fefir64', label = 'Fem_06', value = ''),
											numericInput(inputId = 'fefir66', label = 'Fem_07', value = '')
											#numericInput(inputId = 'fefir67', label = 'Fem_08', value = '')
										),
										column(6,
											
											selectInput("fefirside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'fefir75', label = 'Fib_01', value = ''),								
											numericInput(inputId = 'fefir76', label = 'Fib_02', value = '')
										)

									)
								),
								conditionalPanel(condition = "input.zz == 'tifir'",
									fluidRow(
										column(6,
											
											selectInput("tifirside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'tifir69', label = 'Tib_01', value = ''),								
											numericInput(inputId = 'tifir70', label = 'Tib_02', value = ''),
											numericInput(inputId = 'tifir71', label = 'Tib_03', value = ''),
											numericInput(inputId = 'tifir72', label = 'Tib_04', value = ''),
											numericInput(inputId = 'tifir73', label = 'Tib_05', value = '')
										),
										column(6,
											
											selectInput("tifirside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'tifir75', label = 'Fib_01', value = ''),								
											numericInput(inputId = 'tifir76', label = 'Fib_02', value = '')
										)

									)
								),
							

								conditionalPanel(condition = "input.zz == 'humerus'",
									fluidRow(
										
										column(6,
											h4("Left"),
											numericInput(inputId = 'a401', label = 'Hum_01', value = ''),								
											numericInput(inputId = 'a411', label = 'Hum_02', value = ''),		
											numericInput(inputId = 'a421', label = 'Hum_03', value = ''),																		
											numericInput(inputId = 'a431', label = 'Hum_04', value = ''),	
											numericInput(inputId = 'a441', label = 'Hum_05', value = '')																								
										),
										column(6,
											h4("Right"),
											numericInput(inputId = 'a402', label = 'Hum_01', value = ''),								
											numericInput(inputId = 'a412', label = 'Hum_02', value = ''),		
											numericInput(inputId = 'a422', label = 'Hum_03', value = ''),																		
											numericInput(inputId = 'a432', label = 'Hum_04', value = ''),	
											numericInput(inputId = 'a442', label = 'Hum_05', value = '')
										)
									)
								
								),
								
								conditionalPanel(condition = "input.zz == 'ulna'",
									fluidRow(
										
										column(6,
											h4("Left"),
											numericInput(inputId = 'a481', label = 'Uln_01', value = ''),							
											numericInput(inputId = 'a491', label = 'Uln_04', value = ''),	
											numericInput(inputId = 'a501', label = 'Uln_05', value = ''),	
											numericInput(inputId = 'a511', label = 'Uln_06', value = '')
											#numericInput(inputId = 'a521', label = '52', value = '')																																																						
										),
										column(6,
										   h4("Right"),
											numericInput(inputId = 'a482', label = 'Uln_01', value = ''),							
											numericInput(inputId = 'a492', label = 'Uln_04', value = ''),	
											numericInput(inputId = 'a502', label = 'Uln_05', value = ''),	
											numericInput(inputId = 'a512', label = 'Uln_06', value = '')
											#numericInput(inputId = 'a522', label = '52', value = '')				
										)
									)
								
								),
								
								conditionalPanel(condition = "input.zz == 'radius'",
									fluidRow(
										
										column(6,
											h4("Left"),
											numericInput(inputId = 'a451', label = 'Rad_01', value = ''),								
											numericInput(inputId = 'a461', label = 'Rad_05', value = ''),	
											numericInput(inputId = 'a471', label = 'Rad_06', value = '')								
										),
										column(6,
											h4("Right"),
											numericInput(inputId = 'a452', label = 'Rad_01', value = ''),								
											numericInput(inputId = 'a462', label = 'Rad_05', value = ''),	
											numericInput(inputId = 'a472', label = 'Rad_06', value = '')		
										)
									)
								),
								
								conditionalPanel(condition = "input.zz == 'femur'",
									fluidRow(
										
										column(6,
											h4("Left"),
											numericInput(inputId = 'a601', label = 'Fem_01', value = ''),								
											numericInput(inputId = 'a611', label = 'Fem_02', value = ''),
											numericInput(inputId = 'a621', label = 'Fem_03', value = ''),
											numericInput(inputId = 'a631', label = 'Fem_04', value = ''),
											numericInput(inputId = 'a651', label = 'Fem_05', value = ''),
											numericInput(inputId = 'a641', label = 'Fem_06', value = ''),
											numericInput(inputId = 'a661', label = 'Fem_07', value = '')
											#numericInput(inputId = 'a671', label = 'Fem_08', value = ''),
											#numericInput(inputId = 'a681', label = '68', value = '')														
										),
										column(6,
											h4("Right"),
											numericInput(inputId = 'a602', label = 'Fem_01', value = ''),								
											numericInput(inputId = 'a612', label = 'Fem_02', value = ''),
											numericInput(inputId = 'a622', label = 'Fem_03', value = ''),
											numericInput(inputId = 'a632', label = 'Fem_04', value = ''),
											numericInput(inputId = 'a652', label = 'Fem_05', value = ''),
											numericInput(inputId = 'a642', label = 'Fem_06', value = ''),
											numericInput(inputId = 'a662', label = 'Fem_07', value = '')
											#numericInput(inputId = 'a672', label = 'Fem_08', value = ''),
											#numericInput(inputId = 'a682', label = '68', value = '')		
										)
									)
								),
								conditionalPanel(condition = "input.zz == 'tibia'",
									fluidRow(
										
										column(6,
											h4("Left"),
											numericInput(inputId = 'a691', label = 'Tib_01', value = ''),								
											numericInput(inputId = 'a701', label = 'Tib_02', value = ''),
											numericInput(inputId = 'a711', label = 'Tib_03', value = ''),
											numericInput(inputId = 'a721', label = 'Tib_04', value = ''),
											numericInput(inputId = 'a731', label = 'Tib_05', value = '')	
											#numericInput(inputId = 'a741', label = 'Tib_06', value = '')													
										),
										column(6,
											h4("Right"),
											numericInput(inputId = 'a692', label = 'Tib_01', value = ''),								
											numericInput(inputId = 'a702', label = 'Tib_02', value = ''),
											numericInput(inputId = 'a712', label = 'Tib_03', value = ''),
											numericInput(inputId = 'a722', label = 'Tib_04', value = ''),
											numericInput(inputId = 'a732', label = 'Tib_05', value = '')	
											#numericInput(inputId = 'a742', label = 'Tib_06', value = '')	
										)
									)
								),	
								conditionalPanel(condition = "input.zz == 'fibula'",
									fluidRow(
										
										column(6,
											h4("Left"),
											numericInput(inputId = 'a751', label = 'Fib_01', value = ''),								
											numericInput(inputId = 'a761', label = 'Fib_02', value = '')								
										),
										column(6,
											h4("Right"),
											numericInput(inputId = 'a752', label = 'Fib_01', value = ''),								
											numericInput(inputId = 'a762', label = 'Fib_02', value = '')	
										)
									)
								),
								
								
								conditionalPanel(condition = "input.zz == 'os_coxa'",
									fluidRow(

										column(6,
											h4("Left"),
											numericInput(inputId = 'a561', label = 'Osc_01', value = ''),								
											numericInput(inputId = 'a571', label = 'Osc_02', value = '')								
										),
										column(6,
											h4("Right"),
											numericInput(inputId = 'a562', label = 'Osc_01', value = ''),								
											numericInput(inputId = 'a572', label = 'Osc_02', value = '')	
										)
									)
								),
								
								
								conditionalPanel(condition = "input.zz == 'scapula'",
									fluidRow(
										
										column(6,
											h4("Left"),
											numericInput(inputId = 'a381', label = 'Sca_01', value = ''),								
											numericInput(inputId = 'a391', label = 'Sca_02', value = '')								
										),
										column(6,
											h4("Right"),
											numericInput(inputId = 'a382', label = 'Sca_01', value = ''),								
											numericInput(inputId = 'a392', label = 'Sca_02', value = '')	
										)
									)
								),
								
								
								conditionalPanel(condition = "input.zz == 'clavicle'",
									fluidRow(
										
										column(6,
											h4("Left"),
											numericInput(inputId = 'a351', label = 'Cla_01', value = ''),								
											numericInput(inputId = 'a361', label = 'Cla_04', value = ''),
											numericInput(inputId = 'a371', label = 'Cla_05', value = '')
										),
										column(6,
											h4("Right"),
											numericInput(inputId = 'a352', label = 'Cla_01', value = ''),								
											numericInput(inputId = 'a362', label = 'Cla_04', value = ''),
											numericInput(inputId = 'a372', label = 'Cla_05', value = '')	
										)
									)
								)				
								
							),
################std
################sup
							conditionalPanel(condition = "input.a == 'single_supplemental'",
								conditionalPanel(condition = "input.zz == 'humerus'",
									fluidRow(
										
										column(6,
											h4("Left"),
											numericInput(inputId = 'a41A1', label = 'Hum_06', value = ''),								
											numericInput(inputId = 'a42A1', label = 'Hum_07', value = ''),
											numericInput(inputId = 'a44B1', label = 'Hum_08', value = ''),
											numericInput(inputId = 'a44D1', label = 'Hum_09', value = '')								
										),
										column(6,
											h4("Right"),
											numericInput(inputId = 'a41A2', label = 'Hum_06', value = ''),								
											numericInput(inputId = 'a42A2', label = 'Hum_07', value = ''),
											numericInput(inputId = 'a44B2', label = 'Hum_08', value = ''),
											numericInput(inputId = 'a44D2', label = 'Hum_09', value = '')	
										)
									)
								
								),
								
								conditionalPanel(condition = "input.zz == 'ulna'",
									fluidRow(
										
										column(6,
											h4("Left"),
											numericInput(inputId = 'a51A1', label = 'Uln_09', value = ''),							
											numericInput(inputId = 'a51B1', label = 'Uln_10', value = ''),
											numericInput(inputId = 'a51C1', label = 'Uln_11', value = '')							
										),
										column(6,
											h4("Right"),
											numericInput(inputId = 'a51A2', label = 'Uln_09', value = ''),							
											numericInput(inputId = 'a51B2', label = 'Uln_10', value = ''),
											numericInput(inputId = 'a51C2', label = 'Uln_11', value = '')	
										)
									)
								
								),
								
								conditionalPanel(condition = "input.zz == 'radius'",
									fluidRow(
										
										column(6,
											h4("Left"),
											numericInput(inputId = 'a47A1', label = 'Rad_07', value = ''),								
											numericInput(inputId = 'a47B1', label = 'Rad_08', value = ''),
											numericInput(inputId = 'a47C1', label = 'Rad_09', value = ''),
											numericInput(inputId = 'a47D1', label = 'Rad_04', value = ''),
											numericInput(inputId = 'a47E1', label = 'Rad_10', value = '')							
										),
										column(6,
											h4("Right"),
											numericInput(inputId = 'a47A2', label = 'Rad_07', value = ''),								
											numericInput(inputId = 'a47B2', label = 'Rad_08', value = ''),
											numericInput(inputId = 'a47C2', label = 'Rad_09', value = ''),
											numericInput(inputId = 'a47D2', label = 'Rad_04', value = ''),
											numericInput(inputId = 'a47E2', label = 'Rad_10', value = '')	
										)
									)
								),
								
								conditionalPanel(condition = "input.zz == 'femur'",
									fluidRow(
										
										column(6,
											h4("Left"),
											numericInput(inputId = 'a68A1', label = 'Fem_14', value = ''),								
											numericInput(inputId = 'a68B1', label = 'Fem_15', value = ''),
											numericInput(inputId = 'a68D1', label = 'Fem_16', value = ''),
											numericInput(inputId = 'a68E1', label = 'Fem_17', value = '')								
										),
										column(6,
											h4("Right"),
											numericInput(inputId = 'a68A2', label = 'Fem_14', value = ''),								
											numericInput(inputId = 'a68B2', label = 'Fem_15', value = ''),
											numericInput(inputId = 'a68D2', label = 'Fem_16', value = ''),
											numericInput(inputId = 'a68E2', label = 'Fem_17', value = '')	
										)
									)
								),
								
								
								conditionalPanel(condition = "input.zz == 'tibia'",
									fluidRow(
										
										column(6,
											h4("Left"),
											numericInput(inputId = 'a74A1', label = 'Tib_10', value = ''),								
											numericInput(inputId = 'a74B1', label = 'Tib_11', value = ''),
											numericInput(inputId = 'a74F1', label = 'Tib_12', value = '')								
										),
										column(6,
											h4("Right"),
											numericInput(inputId = 'a74A2', label = 'Tib_10', value = ''),								
											numericInput(inputId = 'a74B2', label = 'Tib_11', value = ''),
											numericInput(inputId = 'a74F2', label = 'Tib_12', value = '')	
										)
									)
								),	
								
								
								conditionalPanel(condition = "input.zz == 'fibula'",
									fluidRow(
										
										column(6,
											h4("Left"),
											numericInput(inputId = 'a76A1', label = 'Fib_03', value = ''),								
											numericInput(inputId = 'a76B1', label = 'Fib_04', value = ''),
											numericInput(inputId = 'a76C1', label = 'Fib_05', value = '')								
										),
										column(6,
											h4("Right"),
											numericInput(inputId = 'a76A2', label = 'Fib_03', value = ''),								
											numericInput(inputId = 'a76B2', label = 'Fib_04', value = ''),
											numericInput(inputId = 'a76C2', label = 'Fib_05', value = '')	
										)
									)
								),
								
								
								conditionalPanel(condition = "input.zz == 'os_coxa'",
									fluidRow(
										h3("Os_coxae"),
										column(6,
											h4("Left"),
											numericInput(inputId = 'a59A1', label = 'Osc_14', value = ''),								
											numericInput(inputId = 'a59B1', label = 'Osc_15', value = ''),
											numericInput(inputId = 'a59C1', label = 'Osc_16', value = ''),
											numericInput(inputId = 'a59D1', label = 'Osc_05', value = ''),
											numericInput(inputId = 'a59E1', label = 'Osc_17', value = '')								
										),
										column(6,
											h4("Right"),
											numericInput(inputId = 'a59A2', label = 'Osc_14', value = ''),								
											numericInput(inputId = 'a59B2', label = 'Osc_15', value = ''),
											numericInput(inputId = 'a59C2', label = 'Osc_16', value = ''),
											numericInput(inputId = 'a59D2', label = 'Osc_05', value = ''),
											numericInput(inputId = 'a59E2', label = 'Osc_17', value = '')
										)
									)
								),
								
								
								conditionalPanel(condition = "input.zz == 'scapula'",
									fluidRow(
										
										column(6,
											h4("Left"),
											numericInput(inputId = 'a39A1', label = 'Sca_03', value = ''),								
											numericInput(inputId = 'a39B1', label = 'Sca_04', value = ''),
											numericInput(inputId = 'a39D1', label = 'Sca_05', value = '')								
										),
										column(6,
											h4("Right"),
											numericInput(inputId = 'a39A2', label = 'Sca_03', value = ''),								
											numericInput(inputId = 'a39B2', label = 'Sca_04', value = ''),
											numericInput(inputId = 'a39D2', label = 'Sca_05', value = '')	
										)
									)
								),
								
								
								conditionalPanel(condition = "input.zz == 'clavicle'",
									fluidRow(
										
										column(6,
											h4("Left"),
											numericInput(inputId = 'a37A1', label = 'Cla_06', value = ''),								
											numericInput(inputId = 'a37B1', label = 'Cla_07', value = ''),
											numericInput(inputId = 'a37E1', label = 'Cla_08', value = ''),
											numericInput(inputId = 'a37D1', label = 'Cla_09', value = '')							
										),
										column(6,
											h4("Right"),
											numericInput(inputId = 'a37A2', label = 'Cla_06', value = ''),								
											numericInput(inputId = 'a37B2', label = 'Cla_07', value = ''),
											numericInput(inputId = 'a37E2', label = 'Cla_08', value = ''),
											numericInput(inputId = 'a37D2', label = 'Cla_09', value = '')
										)
									)
								),	
	
											
								conditionalPanel(condition = "input.zz == 'huur'",
									fluidRow(
											column(6,
											
											selectInput("shuurside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'shuur41A', label = 'Hum_06', value = ''),								
											numericInput(inputId = 'shuur42A', label = 'Hum_07', value = ''),
											numericInput(inputId = 'shuur44B', label = 'Hum_08', value = ''),
											numericInput(inputId = 'shuur44D', label = 'Hum_09', value = '')																								
										),
										column(6,
											
											selectInput("shuurside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'shuur51A', label = 'Uln_09', value = ''),							
											numericInput(inputId = 'shuur51B', label = 'Uln_10', value = ''),
											numericInput(inputId = 'shuur51C', label = 'Uln_11', value = '')
										)
									)
								),
								
								
								conditionalPanel(condition = "input.zz == 'hurr'",
									fluidRow(
											column(6,
											
											selectInput("shurrside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'shurr41A', label = 'Hum_06', value = ''),								
											numericInput(inputId = 'shurr42A', label = 'Hum_07', value = ''),
											numericInput(inputId = 'shurr44B', label = 'Hum_08', value = ''),
											numericInput(inputId = 'shurr44D', label = 'Hum_09', value = '')																								
										),
										column(6,
											
											selectInput("shurrside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'shurr47A', label = 'Rad_07', value = ''),								
											numericInput(inputId = 'shurr47B', label = 'Rad_08', value = ''),
											numericInput(inputId = 'shurr47C', label = 'Rad_09', value = ''),
											numericInput(inputId = 'shurr47D', label = 'Rad_04', value = ''),
											numericInput(inputId = 'shurr47E', label = 'Rad_10', value = '')	
										)
									)
								),
								
								
								conditionalPanel(condition = "input.zz == 'hufr'",
									fluidRow(
											column(6,
											
											selectInput("shufrside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'shufr41A', label = 'Hum_06', value = ''),								
											numericInput(inputId = 'shufr42A', label = 'Hum_07', value = ''),
											numericInput(inputId = 'shufr44B', label = 'Hum_08', value = ''),
											numericInput(inputId = 'shufr44D', label = 'Hum_09', value = '')																							
										),
										column(6,
											
											selectInput("shufrside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'shufr68A', label = 'Fem_14', value = ''),								
											numericInput(inputId = 'shufr68B', label = 'Fem_15', value = ''),
											numericInput(inputId = 'shufr68D', label = 'Fem_16', value = ''),
											numericInput(inputId = 'shufr68E', label = 'Fem_17', value = '')
										)
									)
								),
								
								
								conditionalPanel(condition = "input.zz == 'hutr'",
									fluidRow(
											column(6,
											
											selectInput("shutrside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'shutr41A', label = 'Hum_06', value = ''),								
											numericInput(inputId = 'shutr42A', label = 'Hum_07', value = ''),
											numericInput(inputId = 'shutr44B', label = 'Hum_08', value = ''),
											numericInput(inputId = 'shutr44D', label = 'Hum_09', value = '')																							
										),
										column(6,
											
											selectInput("shutrside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'shutr74A', label = 'Tib_10', value = ''),								
											numericInput(inputId = 'shutr74B', label = 'Tib_11', value = ''),
											numericInput(inputId = 'shutr74F', label = 'Tib_12', value = '')
										)
									)
								),
								
								
								conditionalPanel(condition = "input.zz == 'hufir'",
									fluidRow(
											column(6,
											
											selectInput("shufirside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'shufir41A', label = 'Hum_06', value = ''),								
											numericInput(inputId = 'shufir42A', label = 'Hum_07', value = ''),
											numericInput(inputId = 'shufir44B', label = 'Hum_08', value = ''),
											numericInput(inputId = 'shufir44D', label = 'Hum_09', value = '')																							
										),
										column(6,
											
											selectInput("shufirside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'shufir76A', label = 'Fib_03', value = ''),								
											numericInput(inputId = 'shufir76B', label = 'Fib_04', value = ''),
											numericInput(inputId = 'shufir76C', label = 'Fib_05', value = '')
										)
									)
								),
								
								conditionalPanel(condition = "input.zz == 'ulrr'",
									fluidRow(
										column(6,
											
											selectInput("sulrrside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'sulrr51A', label = 'Uln_09', value = ''),							
											numericInput(inputId = 'sulrr51B', label = 'Uln_10', value = ''),
											numericInput(inputId = 'sulrr51C', label = 'Uln_11', value = '')
										),
										column(6,
											
											selectInput("sulrrside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'sulrr47A', label = 'Rad_07', value = ''),								
											numericInput(inputId = 'sulrr47B', label = 'Rad_08', value = ''),
											numericInput(inputId = 'sulrr47C', label = 'Rad_09', value = ''),
											numericInput(inputId = 'sulrr47D', label = 'Rad_04', value = ''),
											numericInput(inputId = 'sulrr47E', label = 'Rad_10', value = '')
										)
									)
								),
								
								conditionalPanel(condition = "input.zz == 'ulfr'",
									fluidRow(
										column(6,
											
											selectInput("sulfrside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'sulfr51A', label = 'Uln_09', value = ''),							
											numericInput(inputId = 'sulfr51B', label = 'Uln_10', value = ''),
											numericInput(inputId = 'sulfr51C', label = 'Uln_11', value = '')
										),
										column(6,
											
											selectInput("sulfrside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'sulfr68A', label = 'Fem_14', value = ''),								
											numericInput(inputId = 'sulfr68B', label = 'Fem_15', value = ''),
											numericInput(inputId = 'sulfr68D', label = 'Fem_16', value = ''),
											numericInput(inputId = 'sulfr68E', label = 'Fem_17', value = '')
										)
										

									)
								),
								
								conditionalPanel(condition = "input.zz == 'ultr'",
									fluidRow(
										column(6,
											
											selectInput("sultrside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'sultr51A', label = 'Uln_09', value = ''),							
											numericInput(inputId = 'sultr51B', label = 'Uln_10', value = ''),
											numericInput(inputId = 'sultr51C', label = 'Uln_11', value = '')
										),
										
										column(6,
											
											selectInput("sultrside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'sultr74A', label = 'Tib_10', value = ''),								
											numericInput(inputId = 'sultr74B', label = 'Tib_11', value = ''),
											numericInput(inputId = 'sultr74F', label = 'Tib_12', value = '')
										)

									)
								),
								conditionalPanel(condition = "input.zz == 'ulfir'",
									fluidRow(
										column(6,
											
											selectInput("sulfirside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'sulfir51A', label = 'Uln_09', value = ''),							
											numericInput(inputId = 'sulfir51B', label = 'Uln_10', value = ''),
											numericInput(inputId = 'sulfir51C', label = 'Uln_11', value = '')
										),
										column(6,
											
											selectInput("sulfirside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'sulfir76A', label = 'Fib_03', value = ''),								
											numericInput(inputId = 'sulfir76B', label = 'Fib_04', value = ''),
											numericInput(inputId = 'sulfir76C', label = 'Fib_05', value = '')
										)

									)
								),
								conditionalPanel(condition = "input.zz == 'rafr'",
									fluidRow(
										column(6,
											
											selectInput("srafrside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'srafr47A', label = 'Rad_07', value = ''),								
											numericInput(inputId = 'srafr47B', label = 'Rad_08', value = ''),
											numericInput(inputId = 'srafr47C', label = 'Rad_09', value = ''),
											numericInput(inputId = 'srafr47D', label = 'Rad_04', value = ''),
											numericInput(inputId = 'srafr47E', label = 'Rad_10', value = '')
										),
										column(6,
											
											selectInput("srafrside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'srafr68A', label = 'Fem_14', value = ''),								
											numericInput(inputId = 'srafr68B', label = 'Fem_15', value = ''),
											numericInput(inputId = 'srafr68D', label = 'Fem_16', value = ''),
											numericInput(inputId = 'srafr68E', label = 'Fem_17', value = '')
										)

									)
								),
								conditionalPanel(condition = "input.zz == 'ratr'",
									fluidRow(
										column(6,
											
											selectInput("sratrside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'sratr47A', label = 'Rad_07', value = ''),								
											numericInput(inputId = 'sratr47B', label = 'Rad_08', value = ''),
											numericInput(inputId = 'sratr47C', label = 'Rad_09', value = ''),
											numericInput(inputId = 'sratr47D', label = 'Rad_04', value = ''),
											numericInput(inputId = 'sratr47E', label = 'Rad_10', value = '')
										),
										column(6,
											
											selectInput("sratrside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'sratr74A', label = 'Tib_10', value = ''),								
											numericInput(inputId = 'sratr74B', label = 'Tib_11', value = ''),
											numericInput(inputId = 'sratr74F', label = 'Tib_12', value = '')
										)


									)
								),
								conditionalPanel(condition = "input.zz == 'rafir'",
									fluidRow(
										column(6,
											
											selectInput("srafirside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'srafir47A', label = 'Rad_07', value = ''),								
											numericInput(inputId = 'srafir47B', label = 'Rad_08', value = ''),
											numericInput(inputId = 'srafir47C', label = 'Rad_09', value = ''),
											numericInput(inputId = 'srafir47D', label = 'Rad_04', value = ''),
											numericInput(inputId = 'srafir47E', label = 'Rad_10', value = '')
										),
										column(6,
											
											selectInput("srafirside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'srafir76A', label = 'Fib_03', value = ''),								
											numericInput(inputId = 'srafir76B', label = 'Fib_04', value = ''),
											numericInput(inputId = 'srafir76C', label = 'Fib_05', value = '')
										)


									)
								),
								conditionalPanel(condition = "input.zz == 'fetr'",
									fluidRow(
										column(6,
											
											selectInput("sfetrside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'sfetr68A', label = 'Fem_14', value = ''),								
											numericInput(inputId = 'sfetr68B', label = 'Fem_15', value = ''),
											numericInput(inputId = 'sfetr68D', label = 'Fem_16', value = ''),
											numericInput(inputId = 'sfetr68E', label = 'Fem_17', value = '')
										),
										column(6,
											
											selectInput("sfetrside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'sfetr74A', label = 'Tib_10', value = ''),								
											numericInput(inputId = 'sfetr74B', label = 'Tib_11', value = ''),
											numericInput(inputId = 'sfetr74F', label = 'Tib_12', value = '')
										)

									)
								),
								conditionalPanel(condition = "input.zz == 'fefir'",
									fluidRow(
										column(6,
											
											selectInput("sfefirside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'sfefir68A', label = 'Fem_14', value = ''),								
											numericInput(inputId = 'sfefir68B', label = 'Fem_15', value = ''),
											numericInput(inputId = 'sfefir68D', label = 'Fem_16', value = ''),
											numericInput(inputId = 'sfefir68E', label = 'Fem_17', value = '')
										),
										column(6,
											
											selectInput("sfefirside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'sfefir76A', label = 'Fib_03', value = ''),								
											numericInput(inputId = 'sfefir76B', label = 'Fib_04', value = ''),
											numericInput(inputId = 'sfefir76C', label = 'Fib_05', value = '')
										)

									)
								),
								conditionalPanel(condition = "input.zz == 'tifir'",
									fluidRow(
										column(6,
											
											selectInput("stifirside1", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'stifir74A', label = 'Tib_10', value = ''),								
											numericInput(inputId = 'stifir74B', label = 'Tib_11', value = ''),
											numericInput(inputId = 'stifir74F', label = 'Tib_12', value = '')
										),
										column(6,
											
											selectInput("stifirside2", "Side", c(Left='Left', Right='Right')),
											numericInput(inputId = 'stifir76A', label = 'Fib_03', value = ''),								
											numericInput(inputId = 'stifir76B', label = 'Fib_04', value = ''),
											numericInput(inputId = 'stifir76C', label = 'Fib_05', value = '')
										)

									)
								)
						),							
################sup
														
						conditionalPanel(condition = "input.zz == 'hu' | input.zz == 'hr' | input.zz == 'hs' | input.zz == 'hss' | input.zz == 'fi' | input.zz == 'ft' | input.zz == 'ftt'",
							fluidRow(
								column(12,
										selectInput("side1", "Side", c(Left='Left', Right='Right'))

								))
						),

						conditionalPanel(condition = "input.zz == 'hu'",								
								
								fluidRow(

									column(6,
										numericInput(inputId = 'b41A1', label = 'Hum_06', value = '')
									),
									column(6,							
										numericInput(inputId = 'b51C1', label = 'Uln_11', value = '')								
									)
								)
							
						),
						
						conditionalPanel(condition = "input.zz == 'hr'",
								fluidRow(

									column(6,
										numericInput(inputId = 'b41A12', label = 'Hum_06', value = '')								
									),
									column(6,							
										numericInput(inputId = 'b47D1', label = 'Rad_04', value = '')	
									)
								)							
						),
						
						conditionalPanel(condition = "input.zz == 'hs'",
								fluidRow(

									column(6,
										numericInput(inputId = 'b421', label = 'Hum_07', value = '')

									),
									column(6,							
										numericInput(inputId = 'b39A1', label = 'Sca_03', value = '')

									)
								)							
						),
						conditionalPanel(condition = "input.zz == 'hss'",
								fluidRow(

									column(6,

										numericInput(inputId = 'b42A1', label = 'Hum_07', value = '')							
									),
									column(6,							

										numericInput(inputId = 'b39B1', label = 'Sca_04', value = '')	
									)
								)							
						),
						conditionalPanel(condition = "input.zz == 'fi'",
								fluidRow(

									column(6,
										numericInput(inputId = 'b631', label = 'Fem_04', value = '')								
									),
									column(6,							
										numericInput(inputId = 'b59E1', label = 'Osc_17', value = '')	
									)
								)							
						),
						
						conditionalPanel(condition = "input.zz == 'ft'",
								fluidRow(

									column(6,
										numericInput(inputId = 'b6311', label = 'Fem_03', value = '')								
									),
									column(6,							
										numericInput(inputId = 'b701', label = 'Tib_02', value = '')	
									)
								)							
						),
						
						conditionalPanel(condition = "input.zz == 'ftt'",
								fluidRow(

									column(6,
										numericInput(inputId = 'b76C1', label = 'Fib_05', value = '')								
									),
									column(6,							
										numericInput(inputId = 'b74F1', label = 'Tib_12', value = '')	
									)
								)							
						),
							fluidRow(
							column(6,
							textInput(inputId = 'ID1', label = '1st ID #', value = 'X1')	
							),
							column(6,
							textInput(inputId = 'ID2', label = '2nd ID #', value = 'X2')		
							)
							),
		
							fluidRow(
								column(6,
									actionButton("settings2","settings", icon=icon("keyboard-o"))
								),
								column(6,
									actionButton("proc","process ", icon = icon("cog"))
								)
							),
							fluidRow(br()),
							fluidRow(
								column(6),
								column(6,
									downloadButton("downloadData2", "save")
								)
							),
							tags$style(type = "text/css", "#downloadData2 { width:110% }"),
							tags$style(type = "text/css", "#settings2 { width:110% }"),
							tags$style(type = "text/css", "#proc { width:110% }"),
							width=2
						
					),
					
		
					
					mainPanel(
						htmlOutput('contents2'),
						imageOutput('plotplot', width=400, height=400),
						DT::dataTableOutput('table2'),

						bsModal("settingssingle", title = "Settings", trigger = "settings2", size = "large", 
							tabsetPanel(id="tabSelected2",
					 		
							tabPanel("Output Parameters",
								checkboxInput(inputId = "fileoutput3", label = "Output excel file", value = TRUE),
								checkboxInput(inputId = "fileoutput333", label = "Output plot", value = TRUE)
					 		),
					 		tabPanel("Statistical Parameters",
							
							fluidRow(
								column(4, 
									h4("Association"),
										radioButtons(inputId ="regtesttypes", label = "Regression type", choices = c("PCA-CCA", "Simple"), selected = "PCA-CCA"),
			
										conditionalPanel(condition = "input.regtesttypes == 'Simple'",
											checkboxInput(inputId = "alphapred", label = "Use alpha level hypothesis", value = FALSE)
										),
								sliderInput(inputId = "alphalevels2", label = "Prediction interval level", min=0.01, max=1, value=0.95, step = 0.01)
								),
								column(4,
									h4("Common"),
										sliderInput(inputId = "alphalevels", label = "Alpha level", min=0.01, max=1, value=0.05, step = 0.01)
								),
								column(4,
									h4("Pair & Articulation"),
									checkboxInput(inputId = "absolutevalues", label = "Absolute D-value |a-b|", value = TRUE),
									conditionalPanel(condition = "input.absolutevalues",
										checkboxInput(inputId = "power1", label = "Half-normalization transformation", value = TRUE)
									),
									sliderInput(inputId = "tails1", label = "Tails", min=1, max=2, value=1, step=1),
									checkboxInput(inputId = "testagainstsingle", label = "Zero sample mean", value = FALSE)
								)
							)

								)
							)	
						)
						
					)
				)
			),
			



		
		

		tabPanel("Multiple comparison",
			titlePanel(""),
				sidebarLayout(
					sidebarPanel(
					
					
						selectInput('testtype2', 'Analysis', c(Pair='Pair_match',Articulation='Articulation_match',Association='Regression_match'), 'Pair_match'),

					

							uiOutput("testtype2"),
							
							conditionalPanel(condition = "input.testtype2 == 'Regression_match' || input.bone == 'alttp' || input.bone == 'altt' || input.bone == 'humerus' || input.bone == 'ulna' || input.bone == 'radius' || input.bone == 'femur' || input.bone == 'tibia' || input.bone == 'fibula' || input.bone == 'scapula' || input.bone == 'os_coxa' || input.bone == 'clavicle' ",
								selectInput('standard', 'Measurements', c(Standard='Standard', Supplemental='Supplemental'),'Standard')		
							),		
							uiOutput('resettableInput'),	


							fluidRow(
								column(6,
									actionButton("settings1","settings", icon=icon("keyboard-o"))
								),
								column(6,
									actionButton("pro","process ", icon = icon("cog"))
								)
							),
							fluidRow(br()),
							fluidRow(
								column(6,
									actionButton("clearFile1", "clear   ", icon = icon("window-close"))
								),
								column(6,
									downloadButton("downloadData", "save    ")
								)
							),
							tags$style(type = "text/css", "#settings1 { width:110% }"),
							tags$style(type = "text/css", "#pro { width:110% }"),
							tags$style(type = "text/css", "#clearFile1 { width:110% }"),
							tags$style(type = "text/css", "#downloadData { width:110% }"),
							width=2
					),
					mainPanel(
						htmlOutput('contents'),
						
						tabsetPanel(id="tabSelected",
							tabPanel("Not excluded",
					 			DT::dataTableOutput('table')),
					 			
					 		tabPanel("Excluded",
					 			DT::dataTableOutput('tablen'))),
					 	bsModal("settings", title = "Settings", trigger = "settings1", size = "large", 
					 		tabsetPanel(id="tabSelected2",
					 			tabPanel("Output Parameters",
									checkboxInput(inputId = "fileoutput1", label = "Output excel files", value = TRUE),
									checkboxInput(inputId = "fileoutput1plot", label = "Output plot files (WARNING: This option will generate a plot for every comparison)", value = FALSE)
					 			),
					 			tabPanel("Measurements",

									
					 				selectInput("suppp", "Measurement type: ", c(Standard='Standard', Supplemental='Supplemental'),'Standard'),
					 				conditionalPanel(condition = "input.suppp == 'Standard'",

					 						fluidRow(
					 							column(3,
													uiOutput('measurements1')
												),
												column(9,
													checkboxGroupInput(inputId = 'MeasurementsUsed1', '', c('Cla_01','Cla_04','Cla_05'), inline = TRUE, selected = c('Cla_01','Cla_04','Cla_05'))
												)
											),
					 						fluidRow(
					 							column(3,
													uiOutput('measurements2')
												),
												column(9,
													checkboxGroupInput(inputId = 'MeasurementsUsed2', ' ', c('Sca_01','Sca_02'), inline = TRUE, selected = c('Sca_01','Sca_02'))
												)
											),
					 						fluidRow(
					 							column(3,
													uiOutput('measurements3')
												),
												column(9,
													checkboxGroupInput(inputId = 'MeasurementsUsed3', '', c('Hum_01','Hum_02','Hum_03','Hum_04','Hum_05'), inline = TRUE, selected = c('Hum_01','Hum_02','Hum_03','Hum_04','Hum_05'))
												)
											),
					 						fluidRow(
					 							column(3,
													uiOutput('measurements5')
												),
												column(9,
													checkboxGroupInput(inputId = 'MeasurementsUsed5', '', c('Rad_01','Rad_05','Rad_06'), inline = TRUE, selected = c('Rad_01','Rad_05','Rad_06'))
												)
											),
					 						fluidRow(
					 							column(3,
													uiOutput('measurements4')
												),
												column(9,
													checkboxGroupInput(inputId = 'MeasurementsUsed4', '', c('Uln_01','Uln_04','Uln_05','Uln_06'), inline = TRUE, selected = c('Uln_01','Uln_04','Uln_05','Uln_06')) #52 removed
												)
											),
					 						fluidRow(
					 							column(3,
													uiOutput('measurements6')
												),
												column(9,
													checkboxGroupInput(inputId = 'MeasurementsUsed6', '', c('Osc_01','Osc_02'), inline = TRUE, selected = c('Osc_01','Osc_02'))
												)
											),
					 						fluidRow(
					 							column(3,
													uiOutput('measurements7')
												),
												column(9,
													checkboxGroupInput(inputId = 'MeasurementsUsed7', '', c('Fem_01','Fem_02','Fem_03','Fem_04','Fem_06','Fem_05','Fem_07'), inline = TRUE, selected = c('Fem_01','Fem_02','Fem_03','Fem_04','Fem_06','Fem_05','Fem_07')) #67 68 removed
												)
											),
					 						fluidRow(
					 							column(3,
													uiOutput('measurements8')
												),
												column(9,
													checkboxGroupInput(inputId = 'MeasurementsUsed8', '', c('Tib_01','Tib_02','Tib_03','Tib_04','Tib_05'), inline = TRUE, selected = c('Tib_01','Tib_02','Tib_03','Tib_04','Tib_05')) #74 removed
												)
											),
					 						fluidRow(
					 							column(3,
													uiOutput('measurements9')
												),
												column(9,
													checkboxGroupInput(inputId = 'MeasurementsUsed9', '', c('Fib_01','Fib_02'), inline = TRUE, selected = c('Fib_01','Fib_02'))
												)
											)
									),
					 				conditionalPanel(condition = "input.suppp == 'Supplemental'",

					 						fluidRow(
					 							column(3,
													uiOutput('measurementsa')
												),
												column(9,
													checkboxGroupInput(inputId = 'MeasurementsUseda', '', c('Cla_06','Cla_07','Cla_08','Cla_09'), inline = TRUE, selected = c('Cla_06','Cla_07','Cla_08','Cla_09'))
												)
											),
					 						fluidRow(
					 							column(3,
													uiOutput('measurementsb')
												),
												column(9,
													checkboxGroupInput(inputId = 'MeasurementsUsedb', ' ', c('Sca_03','Sca_04','Sca_05'), inline = TRUE, selected = c('Sca_03','Sca_04','Sca_05'))
												)
											),
					 						fluidRow(
					 							column(3,
													uiOutput('measurementsc')
												),
												column(9,
													checkboxGroupInput(inputId = 'MeasurementsUsedc', '', c('Hum_06','Hum_07','Hum_08','Hum_09'), inline = TRUE, selected = c('Hum_06','Hum_07','Hum_08','Hum_09'))
												)
											),
					 						fluidRow(
					 							column(3,
													uiOutput('measurementsd')
												),
												column(9,
													checkboxGroupInput(inputId = 'MeasurementsUsede', '', c('Rad_07','Rad_08','Rad_09','Rad_04','Rad_10'), inline = TRUE, selected = c('Rad_07','Rad_08','Rad_09','Rad_04','Rad_10'))
												)
											),
					 						fluidRow(
					 							column(3,
													uiOutput('measurementse')
												),
												column(9,
													checkboxGroupInput(inputId = 'MeasurementsUsedd', '', c('Uln_09','Uln_10','Uln_11'), inline = TRUE, selected = c('Uln_09','Uln_10','Uln_11'))
												)
											),
					 						fluidRow(
					 							column(3,
													uiOutput('measurementsf')
												),
												column(9,
													checkboxGroupInput(inputId = 'MeasurementsUsedf', '', c('Osc_14','Osc_15','Osc_16','Osc_05','Osc_17'), inline = TRUE, selected = c('Osc_14','Osc_15','Osc_16','Osc_05','Osc_17'))
												)
											),
					 						fluidRow(
					 							column(3,
													uiOutput('measurementsg')
												),
												column(9,
													checkboxGroupInput(inputId = 'MeasurementsUsedg', '', c('Fem_14','Fem_15','Fem_16','Fem_17'), inline = TRUE, selected = c('Fem_14','Fem_15','Fem_16','Fem_17'))
												)
											),
					 						fluidRow(
					 							column(3,
													uiOutput('measurementsh')
												),
												column(9,
													checkboxGroupInput(inputId = 'MeasurementsUsedh', '', c('Tib_10','Tib_11','Tib_12'), inline = TRUE, selected = c('Tib_10','Tib_11','Tib_12'))
												)
											),
					 						fluidRow(
					 							column(3,
													uiOutput('measurementsi')
												),
												column(9,
													checkboxGroupInput(inputId = 'MeasurementsUsedi', '', c('Fib_03','Fib_04','Fib_05'), inline = TRUE, selected = c('Fib_03','Fib_04','Fib_05'))
												)
											)
									)
												
									
									
								),
								tabPanel("Statistical Parameters",
								fluidRow(
									column(4,
										h4("Association"),

										radioButtons(inputId ="regtesttypem", label = "Regression:", choices = c("PCA-CCA", "Simple"), selected = "PCA-CCA"),

										conditionalPanel(condition = "input.regtesttypem == 'Simple'",
											checkboxInput(inputId = "alphapred2", label = "Use alpha levels for regression", value = FALSE)
										),

										sliderInput(inputId = "asspredlevel", label = "Prediction interval level", min=0.01, max=1, value=0.95, step=0.01)
									),
									column(4,
										h4("Common"),
										sliderInput(inputId = "alphalevel", label = "Alpha level", min=0.01, max=1, value=0.05, step = 0.01),
										checkboxInput(inputId = "research", label = "Calculate research statistics", value = FALSE)								
									),
									column(4,
										h4("Pair & Articulation"),
	
										checkboxInput(inputId = "absolutevalue", label = "Absolute D-value |a-b|", value = TRUE),
										conditionalPanel(condition = "input.absolutevalue",
											checkboxInput(inputId = "power2", label = "Half-normalization transformation", value = TRUE)
										),
										sliderInput(inputId = "tails2", label = "Tails", min=1, max=2, value=1, step=1),
										checkboxInput(inputId = "testagainst", label = "Zero sample mean", value = FALSE)
									)
								)								
								),
								tabPanel("Computational Parameters",
									uiOutput('ncores')
								)
								
							)
						)

					)			
				)
			)
	),











		
		
		navbarMenu("Outlier sorting", 		
			tabPanel("Metric",
				sidebarLayout(
					sidebarPanel(					

							uiOutput("testtype3"),
							selectInput("outlierside", "Side", c(Left='Left', Right='Right', Both='Both'), 'Both'),
							uiOutput('resettableInput3'),	

							fluidRow(
								column(6,
									actionButton("settings3","settings", icon=icon("keyboard-o"))
								),
								column(6,
									actionButton("pro3","process ", icon = icon("cog"))
								)
							),
							fluidRow(br()),
							fluidRow(
								column(6,
									actionButton("clearFile3", "clear   ", icon = icon("window-close"))
								),
								column(6,
									downloadButton("outlierdownload", "save    ")
								)
							),
							tags$style(type = "text/css", "#settings3 { width:110% }"),
							tags$style(type = "text/css", "#pro3 { width:110% }"),
							tags$style(type = "text/css", "#clearFile3 { width:110% }"),
							tags$style(type = "text/css", "#outlierdownload { width:110% }"),
							width=2
					),
					mainPanel(
					
						htmlOutput('outliercontent'),
						imageOutput('plotoutlier', width=400, height=400),
						tabsetPanel(id="tabSelectedoutlier",
							tabPanel("Upper outliers",
								DT::dataTableOutput('tjbingworka')
							),		
							tabPanel("Lower outliers",
						 		DT::dataTableOutput('tjbingworkb')
						 	),
						 	tabPanel("Non-outliers",
						 		DT::dataTableOutput('tjbingworkc')
						 	)
					 	),
					
					
					 	bsModal("settingsoutlier", title = "Settings", trigger = "settings3", size = "large", 
					 		tabsetPanel(id="tabSelected2",
								tabPanel("Output Paramters",
									checkboxInput(inputId = "fileoutputl1", label = "Output excel file", value = TRUE),
									checkboxInput(inputId = "fileoutputl2", label = "Output plot", value = TRUE)
								),	
					 			tabPanel("Measurements",
					 						fluidRow(
					 							column(12,
													radioButtons(inputId = 'claviclemeasurements', 'Clavicle', c('Cla_01','Cla_04','Cla_05','Cla_06','Cla_07','Cla_08','Cla_09'), inline = TRUE, selected = 'Cla_01')
												)
											),
					 						fluidRow(
												column(12,
													radioButtons(inputId = 'scapulameasurements', 'Scapula', c('Sca_01','Sca_02','Sca_03','Sca_04','Sca_05'), inline = TRUE, selected = 'Sca_01')
												)
											),
					 						fluidRow(
												column(12,
													radioButtons(inputId = 'humerusmeasurements', 'Humerus', c('Hum_01','Hum_02','Hum_03','Hum_04','Hum_05','Hum_06','Hum_07','Hum_08','Hum_09'), inline = TRUE, selected = 'Hum_01')
												)
											),
					 						fluidRow(
												column(12,
													radioButtons(inputId = 'radiusmeasurements', 'Radius', c('Rad_01','Rad_05','Rad_06','Rad_07','Rad_08','Rad_09','Rad_04','Rad_10'), inline = TRUE, selected = 'Rad_01')
												)
											),
					 						fluidRow(
												column(12,
													radioButtons(inputId = 'ulnameasurements', 'Ulna', c('Uln_01','Uln_04','Uln_05','Uln_06','Uln_07','Uln_09','Uln_10','Uln_11'), inline = TRUE, selected = 'Uln_01')
												)
											),
					 						fluidRow(
												column(12,
													radioButtons(inputId = 'os_coxameasurements', 'Os_coxa', c('Osc_01','Osc_02', 'Osc_05', 'Osc_14','Osc_15','Osc_16','Osc_05','Osc_17'), inline = TRUE, selected = 'Osc_01')
												)
											),
					 						fluidRow(
												column(12,
													radioButtons(inputId = 'femurmeasurements', 'Femur', c('Fem_01','Fem_02','Fem_03','Fem_04','Fem_06','Fem_05','Fem_07','Fem_08','Fem_11','Fem_14','Fem_15','Fem_16','Fem_17'), inline = TRUE, selected = 'Fem_01')
												)
											),
					 						fluidRow(
												column(12,
													radioButtons(inputId = 'tibiameasurements', 'Tibia', c('Tib_01','Tib_02','Tib_03','Tib_04','Tib_05','Tib_06','Tib_10','Tib_11','Tib_12'), inline = TRUE, selected = 'Tib_01')
												)
											),
					 						fluidRow(
												column(12,
													radioButtons(inputId = 'fibulameasurements', 'Fibula', c('Fib_01','Fib_02','Fib_03','Fib_04','Fib_05'), inline = TRUE, selected = 'Fib_01')
												)
											)					
								),
								tabPanel("Statistical Parameters",
								fluidRow(
									column(6,
										radioButtons('method', '', c(standard_deviation='Standard_deviation', quartiles='Quartiles'),'Standard_deviation')
									),
									column(6,									
										conditionalPanel(condition = "input.method == 'Standard_deviation'",
											sliderInput(inputId = "standard_dev", label = "Standard Deviation Cutoff", min=0.5, max=10, value=c(2.0,2), step = 0.1)
										),
										conditionalPanel(condition = "input.method == 'Quartiles'",
											sliderInput(inputId = "Quartiles", label = "Interquartile Cutoff", min=0.5, max=10, value=c(1.5,1.5), step = 0.1)
										)
									)
								)
								)
							)
						)

					)
				)

			),
			tabPanel("Stature",
				sidebarLayout(
					sidebarPanel(					

							selectInput(inputId = 'metric_type2', 'Stature metric', c(Millimeters = "mm", Centimeters = "cm", Inches = "in"), selected = 'in'),
							uiOutput("testtype4"),
							selectInput("outlierside4", "Side", c(Left='Left', Right='Right', Both='Both'), 'Both'),
							
							conditionalPanel(condition ="input.zz4 == 'tibia' || input.zz4 == 'femur'",
								selectInput("population5G", "Population", c(Genoves_cstat_mexican_female='genoves-cstat-mexican-female',Genoves_cstat_mexican_male='genoves-cstat-mexican-male',FDB_19th_cstat_any='19th-cstat-any',FDB_19th_cstat_white_male='19th-cstat-white-male',FDB_19th_cstat_white_female='19th-cstat-white-female',FDB_19th_cstat_black_male='19th-cstat-black-male',FDB_19th_cstat_black_female='19th-cstat-black-female',FDB_20th_FStat_any='20th-FStat-any', FDB_20th_FStat_white_male='20th-FStat-white-male', FDB_20th_FStat_white_female='20th-FStat-white-female', FDB_20th_FStat_black_male='20th-FStat-black-male', FDB_20th_FStat_black_female='20th-FStat-black-female', FDB_20th_FStat_hispanic_male='20th-FStat-hispanic-male', Trotter_any_male='Trotter-any-male', Trotter_black_male='Trotter-black-male', Trotter_white_male='Trotter-white-male'), 'genoves-cstat-mexican-female')
							),
							conditionalPanel(condition ="input.zz4 != 'tibia' && input.zz4 != 'femur'",
								selectInput("population4", "Population", c(FDB_19th_cstat_any='19th-cstat-any',FDB_19th_cstat_white_male='19th-cstat-white-male',FDB_19th_cstat_white_female='19th-cstat-white-female',FDB_19th_cstat_black_male='19th-cstat-black-male',FDB_19th_cstat_black_female='19th-cstat-black-female',FDB_20th_FStat_any='20th-FStat-any', FDB_20th_FStat_white_male='20th-FStat-white-male', FDB_20th_FStat_white_female='20th-FStat-white-female', FDB_20th_FStat_black_male='20th-FStat-black-male', FDB_20th_FStat_black_female='20th-FStat-black-female', FDB_20th_FStat_hispanic_male='20th-FStat-hispanic-male', Trotter_any_male='Trotter-any-male', Trotter_black_male='Trotter-black-male', Trotter_white_male='Trotter-white-male'), 'Trotter-any-male')
							),
							
							uiOutput('resettableInput4'),	

							fluidRow(
								column(6,
									actionButton("settings4","settings", icon=icon("keyboard-o"))
								),
								column(6,
									actionButton("pro4","process ", icon = icon("cog"))
								)
							),
							fluidRow(br()),
							fluidRow(
								column(6,
									actionButton("clearFile4", "clear   ", icon = icon("window-close"))
								),
								column(6,
									downloadButton("outlierdownload4", "save    ")
								)
							),
							tags$style(type = "text/css", "#settings4 { width:110% }"),
							tags$style(type = "text/css", "#pro4 { width:110% }"),
							tags$style(type = "text/css", "#clearFile4 { width:110% }"),
							tags$style(type = "text/css", "#outlierdownload4 { width:110% }"),
							width=2
					),
					mainPanel(
					
						htmlOutput('outliercontent4'),
						imageOutput('plotoutlier4', width=400, height=400),
						tabsetPanel(id="tabSelectedoutlier",
							tabPanel("Upper outliers",
								DT::dataTableOutput('tjbingworka4')
							),		
							tabPanel("Lower outliers",
								DT::dataTableOutput('tjbingworkb4')
						 	),
						 	tabPanel("Non-outliers",
					 			DT::dataTableOutput('tjbingworkc4')
						 	)
					 	),
					
					
					 	bsModal("settingsoutlier4", title = "Settings", trigger = "settings4", size = "large", 
					 		tabsetPanel(id="tabSelected2",
								tabPanel("Output Paramters",
									checkboxInput(inputId = "fileoutputstature1", label = "Output excel file", value = TRUE),
									checkboxInput(inputId = "fileoutputstature2", label = "Output plot", value = TRUE)
								),					 			
								tabPanel("Measurements",
					 						fluidRow(
												column(12,
													radioButtons(inputId = 'humerusmeasurements4', 'Humerus', c('Hum_01'), inline = TRUE, selected = 'Hum_01')
												)
											),
					 						fluidRow(
												column(12,
													radioButtons(inputId = 'radiusmeasurements4', 'Radius', c('Rad_01'), inline = TRUE, selected = 'Rad_01')
												)
											),
					 						fluidRow(
												column(12,
													radioButtons(inputId = 'ulnameasurements4', 'Ulna', c('Uln_01'), inline = TRUE, selected = 'Uln_01')
												)
											),
					 						fluidRow(
												column(12,
													radioButtons(inputId = 'femurmeasurements4', 'Femur', c('Fem_01'), inline = TRUE, selected = 'Fem_01')
												)
											),
					 						fluidRow(
												column(12,
													radioButtons(inputId = 'tibiameasurements4', 'Tibia', c('Tib_01'), inline = TRUE, selected = 'Tib_01')
												)
											),
					 						fluidRow(
												column(12,
													radioButtons(inputId = 'fibulameasurements4', 'Fibula', c('Fib_01'), inline = TRUE, selected = 'Fib_01')
												)
											)					
								),
								tabPanel("Statistical Parameters",
									fluidRow(
										column(6,
											radioButtons('method4', '', c(standard_deviation='Standard_deviation', quartiles='Quartiles'),'Standard_deviation')
										),
										column(6,
											conditionalPanel(condition = "input.method4 == 'Standard_deviation'",
												sliderInput(inputId = "standard_dev4", label = "Standard Deviation Cutoff", min=0.5, max=10, value=c(2,2), step = 0.1)
											),
											conditionalPanel(condition = "input.method4 == 'Quartiles'",
												sliderInput(inputId = "Quartiles4", label = "Interquartile Cutoff", min=0.5, max=10, value=c(1.5,1.5), step = 0.1)
											)
										)	
									)
								)
							)
						)

					)
				))
		),		
	





	navbarMenu("Osteoshape sorting",		
			tabPanel("2D comparison",

				titlePanel(""),
					sidebarLayout(
						sidebarPanel(
							selectInput(inputId ="fragcomp", label = "Analysis:", choices = c("Complete", "Fragmented"), selected = "Complete"),
							uiOutput('resettableInput2D'),	
							uiOutput('resettableInput2DD'),
							conditionalPanel(condition = "input.fragcomp == 'Complete'",
								uiOutput('mspec')
							),


							fluidRow(
								column(6,
									actionButton("settings2D","settings", icon=icon("keyboard-o"))
								),
								column(6,
									actionButton("pro2D","process ", icon = icon("cog"))
								)
							),
							fluidRow(br()),
							fluidRow(
								column(6,
									actionButton("clearFile2D", "clear   ", icon = icon("window-close"))
								),
								column(6,
									downloadButton("downloadData2D", "save    ")
								)
							),
							tags$style(type = "text/css", "#settings2D { width:110% }"),
							tags$style(type = "text/css", "#pro2D { width:110% }"),
							tags$style(type = "text/css", "#clearFile2D { width:110% }"),
							tags$style(type = "text/css", "#downloadData2D { width:110% }"),
							width = 2
						),
						mainPanel(
							uiOutput("contents2D"),
							uiOutput("tabpanpan"),

							bsModal("settings2DD", title = "Settings", trigger = "settings2D", size = "large", 
								tabsetPanel(id="tabSelected2",
									tabPanel("Output Parameters",
										uiOutput('fileoutput2Dexcel1'),
										uiOutput('fileoutput2Dexcel2'),
										uiOutput('fileoutput2Dplot'),
										uiOutput('fileoutput2Dtps')
									),
						 			
									tabPanel("Statistical Parameters",
										fluidRow(
											column(4,
												h4("Outline"),
												uiOutput('nthreshold'),
												uiOutput('mirror2D'),
								 				conditionalPanel(condition = "input.fragcomp == 'Complete'",
													uiOutput('efa_options1'),
													uiOutput('efa_options2'),
													uiOutput('efa_options3')
												)
											),

											column(4, 
												h4("Registration"),
												conditionalPanel(condition = "input.fragcomp == 'Complete'",
														uiOutput('comp_options')
												),
												uiOutput('icp2D'),
												uiOutput('trans2D')
											),
											column(4,
												h4("Distance"),
												uiOutput('distance2D'),
								 				conditionalPanel(condition = "input.distance2D == 'Segmented-Hausdorff' || input.distance2D == 'Uni-Hausdorff' || input.distance2D == 'Hausdorff'",
													uiOutput('max_avg_distance')
												),
								 				conditionalPanel(condition = "input.distance2D == 'Segmented-Hausdorff'",
													uiOutput('n_regions')
												),
												sliderInput(inputId = "shortlistn", label = "Number of shortest distance matches", min = 1, max = 100, value = 1, step = 1),
												checkboxInput(inputId = "hidedist", label = "Hide distance from results", value = FALSE)
											)
										)
									),
									tabPanel("Computational Parameters",
										uiOutput('ncores2D')
									)
								)		
							)
						)
					)
			),
			tabPanel("3D comparison"

			)
			
			
			
			
			
		
		),


		navbarMenu("Antemortem sorting",	


			tabPanel("Single stature",
				sidebarLayout(
					sidebarPanel(	



								selectInput(inputId = 'metric_type', 'Stature metric', c(Millimeters = "mm", Centimeters = "cm", Inches = "in"), selected = 'in'),
							uiOutput("antestat_test"),
								selectInput("antestat_population", "Population", c(DPAA_any_male = "DPAA-any-male", DPAA_white_male = "DPAA-white-male", DPAA_black_male = "DPAA-black-male",FDB_20th_FStat_any='20th-FStat-any', FDB_20th_FStat_white_male='20th-FStat-white-male', FDB_20th_FStat_white_female='20th-FStat-white-female', FDB_20th_FStat_black_male='20th-FStat-black-male', FDB_20th_FStat_black_female='20th-FStat-black-female', Trotter_any_male='Trotter-any-male', Trotter_black_male='Trotter-black-male', Trotter_white_male='Trotter-white-male'), 'Trotter-any-male'),
											selectInput("ante_side", "Side", c(Left='Left', Right='Right')),									
									fluidRow(
										column(6,
											conditionalPanel(condition = "input.antestat == 'humerus'",
												numericInput(inputId = 'hu_antestat', label = 'Hum_01', value = '')																															
											),
											conditionalPanel(condition = "input.antestat == 'radius'",
												numericInput(inputId = 'ra_antestat', label = 'Rad_01', value = '')																															
											),
											conditionalPanel(condition = "input.antestat == 'ulna'",
												numericInput(inputId = 'ul_antestat', label = 'Uln_01', value = '')																															
											),
											conditionalPanel(condition = "input.antestat == 'femur'",
												numericInput(inputId = 'fe_antestat', label = 'Fem_01', value = '')																															
											),
											conditionalPanel(condition = "input.antestat == 'tibia'",
												numericInput(inputId = 'ti_antestat', label = 'Tib_01', value = '')																															
											),
											conditionalPanel(condition = "input.antestat == 'fibula'",
												numericInput(inputId = 'fi_antestat', label = 'Fib_01', value = '')																															
											),
											textInput(inputId = 'Postmortem_ID', label = 'Postmortem ID', value = 'X2')	

										),
										column(6,
											numericInput(inputId = 'antestat_input', label = 'Stature', value = ''),
											textInput(inputId = 'Antemortem_ID', label = 'Antemortem ID', value = 'X1')							

										)
									),
		
							fluidRow(
								column(6,
									actionButton("settingsante","settings", icon=icon("keyboard-o"))
								),
								column(6,
									actionButton("proantestat","process ", icon = icon("cog"))
								)
							),
							fluidRow(br()),
							fluidRow(
								column(6

								),
								column(6,
									downloadButton("downloadantestat", "save    ")
								)
							),

							tags$style(type = "text/css", "#settingsante { width:110% }"),
							tags$style(type = "text/css", "#proantestat { width:110% }"),
							tags$style(type = "text/css", "#downloadantestat { width:110% }"),
							width=2
					),
					mainPanel(
					
						htmlOutput('antestat_output'),
						imageOutput('plotplotante', width=400, height=400),
					
						DT::dataTableOutput('antestat_table'),

					 	bsModal("settingsante2", title = "Settings", trigger = "settingsante", size = "large", 
					 		tabsetPanel(id="tabSelected2s",
								tabPanel("Output Paramters",
									checkboxInput(inputId = "fileoutputant1", label = "Output excel file", value = TRUE),
									checkboxInput(inputId = "fileoutputant2", label = "Output plot", value = TRUE)
								),	

								tabPanel("Statistical Parameters",
									fluidRow(column(6,
											sliderInput(inputId = "predlevelantestat", label = "Prediction interval level", min=0.01, max=1, value=0.95, step = 0.01),
											sliderInput(inputId = "alphalevelsantestat", label = "Alpha level", min=0.01, max=1, value=0.05, step = 0.01)
										),
										column(6,									
											radioButtons(inputId = "alphatest1s", label = "Test type", choices = c(Alpha = "Alpha", PI = "PI"),"Alpha")
											#conditionalPanel(condition = "input.alphatest1s == 'Alpha'",
											#	sliderInput(inputId = "tailsaa", label = "Tails", min=1, max=2, value=1, step=1)
											#)
										)
									)
								)								
							)
						)
					)

				)	
			),


			tabPanel("Multiple stature",
				sidebarLayout(
					sidebarPanel(	



							selectInput(inputId = 'metric_typem', 'Stature metric', c(Millimeters = "mm", Centimeters = "cm", Inches = "in"), selected = 'in'),
							uiOutput("antestat_testm"),
							selectInput("antestat_populationm", "Population", c(DPAA_any_male = "DPAA-any-male", DPAA_white_male = "DPAA-white-male", DPAA_black_male = "DPAA-black-male",FDB_20th_FStat_any='20th-FStat-any', FDB_20th_FStat_white_male='20th-FStat-white-male', FDB_20th_FStat_white_female='20th-FStat-white-female', FDB_20th_FStat_black_male='20th-FStat-black-male', FDB_20th_FStat_black_female='20th-FStat-black-female', Trotter_any_male='Trotter-any-male', Trotter_black_male='Trotter-black-male', Trotter_white_male='Trotter-white-male'), 'Trotter-any-male'),

							uiOutput('resettableInputante1'),	
							uiOutput('resettableInputante2'),	

							fluidRow(
								column(6,
									actionButton("settingsantem","settings", icon=icon("keyboard-o"))
								),
								column(6,
									actionButton("proantestatm","process ", icon = icon("cog"))
								)
							),
							fluidRow(br()),
							fluidRow(
								column(6,
									actionButton("clearFile1ante", "clear   ", icon = icon("window-close"))
								),
								column(6,
									downloadButton("downloadantestatm", "save    ")
								)
							),

							tags$style(type = "text/css", "#settingsantem { width:110% }"),
							tags$style(type = "text/css", "#proantestatm { width:110% }"),
							tags$style(type = "text/css", "#clearFile1ante { width:110% }"),
							tags$style(type = "text/css", "#downloadantestatm { width:110% }"),
							width=2
					),
					mainPanel(
					
						htmlOutput('antestat_outputm'),
						tabsetPanel(id="tabSelected",
							tabPanel("Not excluded",
					 			DT::dataTableOutput('antestat_table1m')),
					 			
					 		tabPanel("Excluded",
					 			DT::dataTableOutput('antestat_table2m'))),

					 	bsModal("settingsante2m", title = "Settings", trigger = "settingsantem", size = "large", 
					 		tabsetPanel(id="tabSelected2m",
								tabPanel("Output Paramters",
									checkboxInput(inputId = "fileoutputant1m", label = "Output excel file", value = TRUE),
									checkboxInput(inputId = "fileoutputant2m", label = "Output plot (WARNING: This option will generate a plot for every comparison)", value = FALSE)
								),	

								tabPanel("Statistical Parameters",
									fluidRow(column(6,
										sliderInput(inputId = "predlevelantestatm", label = "Prediction interval level", min=0.01, max=1, value=0.95, step = 0.01),
										sliderInput(inputId = "alphalevelsantestatm", label = "Alpha level", min=0.01, max=1, value=0.05, step = 0.01)
										),
										column(6,									
											radioButtons(inputId = "alphatest1m", label = "Test type", choices = c(Alpha = "Alpha", PI = "PI"), "Alpha"),								
											#conditionalPanel(condition = "input.alphatest1m == 'Alpha'",
											#	sliderInput(inputId = "tailsbb", label = "Tails", min=1, max=2, value=1, step=1)
											#),
											checkboxInput(inputId = "research_mm", label = "Calculate research statistics", value = FALSE)
										)
									)

								),
								tabPanel("Computational Parameters",
									uiOutput('ncoresm')
								)
							)
						)

					)
				)
			)#
				
		)




))
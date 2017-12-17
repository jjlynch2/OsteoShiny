#' Shiny server.r file
#' 
#' This is the server.r file for the interface that utilizes all previous functions. 
#' runApp("osteosort")
#' shinyServer()

library(shiny)
library(plyr)	#loaded for multiple.r

options(shiny.maxRequestSize=30*1024^2) #increased file upload size to 30MB
options(warn = -1) #disables warnings

shinyServer(function(input, output, session) {


	################generates temporary directories for multiuser environment
	workingdd <- getwd()
	sessiontempd <- OsteoSort:::randomstring(n = 1, length = 12)
	dir.create('tmp') #new for package
	setwd('tmp')
	dir.create(sessiontempd)
	setwd(sessiontempd)
	sessiontemp <- getwd()


	#defines which modules to include
	source("../../server/multiple.r", local=TRUE) ###imports multiple comparison server code
	source("../../server/single.r", local=TRUE) ###imports single comparison server code
	source("../../server/metric.r", local=TRUE) ###imports metric comparison server code
	source("../../server/stature.r", local=TRUE) ###imports stature outlier comparison server code
	source("../../server/twod.r", local=TRUE) ###imports two-dimensional scomparison server code
	source("../../server/antestat_single.r", local=TRUE) ###imports two-dimensional scomparison server code
	source("../../server/antestat_multiple.r", local=TRUE) ###imports two-dimensional scomparison server code
	################stops the shiny app when closing session
	session$onSessionEnded(function() { stopApp()})

	################delete session temp directory on session end
	session$onSessionEnded(function() {
		unlink(sessiontemp, recursive = TRUE)    
	})
	


	#download handlers for files on the help page
	output$postmortem_template <- downloadHandler(
		filename <- function() {
			"postmortem_template.csv"
		},
		content <- function(file) {
			file.copy(system.file("extdata", 'postmortem_template.csv', package = "OsteoShiny"), file)                  
		},
	)  

	#download handlers for files on the help page
	output$antemortem_template <- downloadHandler(
		filename <- function() {
			"antemortem_template.csv"
		},
		content <- function(file) {
			file.copy(system.file("extdata", 'antemortem_template.csv', package = "OsteoShiny"), file)                  
		},
	)  
	
	output$osteoguide <- downloadHandler(
		filename <- function() {
			"OsteoSort_User_Manual.pdf"
		},
		content <- function(file) {
			file.copy(system.file("extdata", 'OsteoSort_User_Manual.pdf', package = "OsteoShiny"), file)                  
		},
	)  			


	output$example_data <- downloadHandler(
		filename <- function() {
			"Example_Data.zip"
		},
		content <- function(file) {
			file.copy(system.file("extdata", 'Example_Data.zip', package = "OsteoShiny"), file)                  
		},
	)  	


	output$measurement_conversion_table <- DT::renderDataTable(read.table(system.file("extdata", "Standardized_Measurements.csv", package = "OsteoShiny"), header = TRUE, sep=","), options = list(lengthMenu = c(10,20,30,40,50), pageLength = 20), rownames = FALSE)
	

	  


	observeEvent(input$Create_Desktop_Icon, {
		if(Sys.info()[['sysname']] == "Windows") {

			#creates .bat to LNK to
			cat(paste(paste('"',normalizePath(gsub("/","\\\\", file.path(R.home("bin"), "R.exe"))),'"',sep=""),  "-e", "library(OsteoShiny);OsteoSort()", sep=" "), file = 	paste(system.file("extdata"), "osteosort.bat", sep="/") )


			target <- normalizePath(system.file("extdata/osteosort.bat"))
			icon <- normalizePath(system.file("OsteoSort/www/OsteoSort.png", package = "OsteoShiny"))
			pathname <- normalizePath(paste(gsub("/Documents", "", file.path(path.expand("~"), "Desktop") ), "OsteoSort.LNK", sep = "/"))
			R.utils::createWindowsShortcut(pathname, target=target, icon=icon, overwrite = TRUE)
		}
		if(Sys.info()[['sysname']] == "Linux") {
			icon_name <- "OsteoSort.desktop"
			cat(		paste(
						"[Desktop Entry]\nEncoding=UTF-8\nTerminal=true\nType=Application\nCategories=Application\nName=OsteoSort\n",
						"Version=",	packageVersion("OsteoShiny"),"\n",

						 "Icon=",		system.file("OsteoSort/www/OsteoSort.png", package = "OsteoShiny"),"\n",
						 "Exec=",		paste(file.path(R.home("bin"), "R"), "-e", "library(OsteoShiny);OsteoSort()", sep=" ")
					,sep=""),#paste
				file = paste(file.path(path.expand("~"), "Desktop"), "OsteoSort.desktop", sep = "/")
			)#cat
			Sys.chmod(paste(file.path(path.expand("~"), "Desktop"), "OsteoSort.desktop", sep="/"), mode = "0777", use_umask = TRUE)
		}
		if(Sys.info()[['sysname']] != "Linux" && Sys.info()[['sysname']] != "Windows") { #temporary for mac
			icon_name <- "OsteoSort.sh"
			cat(paste(file.path(R.home("bin"), "R"), "-e", "'library(OsteoShiny);OsteoSort()'", sep=" "), file = paste(file.path(path.expand("~"), "Desktop"), "OsteoSort.sh", sep = "/"))
			Sys.chmod(paste(file.path(path.expand("~"), "Desktop"), "OsteoSort.sh", sep="/"), mode = "0777", use_umask = TRUE)
		}

	})
	

})
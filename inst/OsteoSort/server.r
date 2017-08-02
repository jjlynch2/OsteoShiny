#' Shiny server.r file
#' 
#' This is the server.r file for the interface that utilizes all previous functions. 
#' runApp("osteosort")
#' shinyServer()

library(shiny)
library(shinyBS)
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
	#source("../../server/twod.r", local=TRUE) ###imports two D server code
	source("../../server/multiple.r", local=TRUE) ###imports multiple comparison server code
	source("../../server/single.r", local=TRUE) ###imports single comparison server code
	source("../../server/outlier.r", local=TRUE) ###imports outlier comparison server code
	source("../../server/stature.r", local=TRUE) ###imports stature outlier comparison server code
	source("../../server/twod.r", local=TRUE) ###imports two-dimensional scomparison server code
	################stops the shiny app when closing session
	session$onSessionEnded(function() { stopApp()})

	################delete session temp directory on session end
	session$onSessionEnded(function() {
		unlink(sessiontemp, recursive = TRUE)    
	})
	


	#download handlers for files on the help page
	output$standardtemplate <- downloadHandler(
		filename <- function() {
			"standardtemplate.csv"
		},
		content <- function(file) {
			file.copy(system.file("extdata", 'standardtemplate.csv', package = "OsteoShiny"), file)                  
		},
	)  
			
	output$osteoguide <- downloadHandler(
		filename <- function() {
			"OsteoSort_User_Manual_1AUGUST2017.pdf"
		},
		content <- function(file) {
			file.copy(system.file("extdata", 'OsteoSort_User_Manual_1AUGUST2017.pdf', package = "OsteoShiny"), file)                  
		},
	)  			

	observeEvent(input$Create_Desktop_Icon, {
		if(Sys.info()[['sysname']] == "Windows") {
			icon_name <- "OsteoSort.bat"
		cat(paste(gsub("/","\\\\", file.path(R.home("bin"), "R.exe")), "-e", "'library(OsteoShiny);OsteoSort()'", sep=" "), file = paste(gsub("/Documents", "", file.path(path.expand("~"), "Desktop") ), icon_name, sep = "/"))
		}
		if(Sys.info()[['sysname']] != "Windows") {
			icon_name <- "OsteoSort.sh"
			excc <- "R"
			cat(paste(file.path(R.home("bin"), "R"), "-e", "'library(OsteoShiny);OsteoSort()'", sep=" "), file = paste(file.path(path.expand("~"), "Desktop"), icon_name, sep = "/"))
			Sys.chmod(paste(file.path(path.expand("~"), "Desktop"), icon_name, sep="/"), mode = "0777", use_umask = TRUE)
		}

	})
	

})
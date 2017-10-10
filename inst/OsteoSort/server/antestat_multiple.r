   
	numbercoresglobalm <- reactiveValues(ncore = 1)
	
	observeEvent(input$numbercoresm, {
		numbercoresglobalm$ncorem <- input$numbercoresm
	})
	output$ncoresm <- renderUI({
		sliderInput(inputId = "numbercoresm", label = "Number of cores", min=1, max=detectCores(), value=1, step =1)
	})

	 ####This is the antemortem - postmortem comparison server side code made for local import into server.r
	output$antestat_testm <- renderUI({
		selectInput('antestatm', 'Elements', c(Humerus='humerus', Ulna='ulna', Radius='radius', Femur='femur', Tibia='tibia', Fibula='fibula'),'humerus')
	})
	
	
	output$antestat_outputm <- renderUI({
	   HTML(paste("Upload the antemortem stature and postmortem measurement files and select process to begin.</br></br>"))
	})	

	#file upload render for multiple comparison
	output$resettableInputante1 <- renderUI({
		input$clearFile1ante
		input$uploadFormat
		fileInput('file1ante', 'Upload antemortem statures', accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv'))  
	})
	#file upload render for multiple comparison
	output$resettableInputante2 <- renderUI({
		input$clearFile1ante
		input$uploadFormat
		fileInput('file2ante', 'Upload postmortem measurements', accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv'))  
	})
	#clears session for multiple comparison
	observeEvent(input$clearFile1ante, {
		fileInput('file1ante', 'Upload antemortem statures', accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv'))  
		fileInput('file2ante', 'Upload postmortem measurements', accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv'))  
	})

	observeEvent(input$proantestatm, {
		showModal(modalDialog(title = "Calculation has started...Window will update when finished.", easyClose = FALSE, footer = NULL))
		
		withProgress(message = 'Calculation has started',
		            detail = 'This may take a while...', value = 0, {       
		            for (i in 1:15) {
		       incProgress(1/15)
		       Sys.sleep(0.10)
		     
		     }
		})

		#Upload CSV file
		inFile1 <- input$file1ante
		inFile2 <- input$file2ante
		 #return null if not uploaded
		if (is.null(inFile1) || is.null(inFile2)){
			removeModal()                             
			return(NULL) 
		}


		tempdata1m <- read.csv(inFile1$datapath, header=TRUE, sep=input$sep, na.strings=c("", " ", "NA"))## see na.strings forces NA for blanks, spaces, etc
		tempdata2m <- read.csv(inFile2$datapath, header=TRUE, sep=input$sep, na.strings=c("", " ", "NA"))## see na.strings forces NA for blanks, spaces, etc		

			#calls sorting function
			outtemp1m <- antestat.input(bone = input$antestatm, metric = input$metric_typem, antemortem_stature = tempdata1m, postmortem_measurement = tempdata2m, population = input$antestat_populationm)
			outtemp2m <- antestat.regtest(cores = numbercoresglobalm$ncorem, sort = outtemp1m[[1]], ref = outtemp1m[[2]], prediction_interval = input$predlevelantestatm, alphalevel = input$alphalevelsantestatm, alphatest = input$alphatest1m, output_options = c(input$fileoutputant1m, input$fileoutputant2m), sessiontempdir = sessiontemp)
		
			#display output
			output$antestat_outputm <- renderUI({
					HTML(paste("Statistical analysis complete.", '<br/>'))
			})   

#	if(input$research_mm) {
			#used to assess accuracy of methodology
			
#			globala <- as.matrix(outtemp2m[[3]][1])
#			globalb <- as.matrix(outtemp2m[[3]][3])
#			cn <- 0
#			for(xx in 1:nrow(globala)) {
#				if(globala[xx] == globalb[xx]) {cn <- cn +1}
#			}
			
#			global1 <- as.matrix(outtemp2m[[2]][1])
#			global2 <- as.matrix(outtemp2m[[2]][3])
#			co <- 0
#			 for(i in 1:nrow(global1)) {
#			 	if(global1[i] == global2[i]) {co <- co + 1}
#			 }		
			#used to assess accuracy of methodology
#			nmatch <- outtemp2m[[2]]
#			TP <- (ll - cn) - nmatch
#			FP <- cn
#			FN <- nmatch - co
#			TN <- co

		
#			co <- paste("True Positive: ", TP, "<br/>", "False Positive: ", FP, "<br/>", "False Negative: ", FN, "<br/>", "True Negative: ", TN, "<br/>", "FPR: ", 1 - round(TN/(TN+FP), digits = 3) ,"<br/>", "Sensitivity: ", round(TP/(TP+FN), digits = 3), "<br/>", "Specificity: ", round(TN/(TN+FP), digits = 3),"<br/>",  "Positive Predictive Value: ", round(TP/(TP+FP), digits = 3), "<br/>", "Negative Predictive Value: ", round(TN/(TN+FN), digits = 3),"<br/>", "False Discovery Rate: ", round(FP/(FP+TP), digits = 3), "<br/>","Efficiency: ", round((TP+TN) / (TP+TN+FN+FP), digits = 3), "<br/>", sep = "")

#		}

			output$antestat_table1m <- DT::renderDataTable({
				DT::datatable(outtemp2m[[2]], options = list(lengthMenu = c(5,10,15,20,25,30), pageLength = 10), rownames = FALSE)
			})
			output$antestat_table2m <- DT::renderDataTable({
				DT::datatable(outtemp2m[[3]], options = list(lengthMenu = c(5,10,15,20,25,30), pageLength = 10), rownames = FALSE)
			})

			if(input$fileoutputant1m || input$fileoutputant2m) {
				#Zip handler       
				direc6 <- outtemp2m[[1]] #direc temp
				files <- list.files(direc6, recursive = TRUE)
				setwd(direc6)
				zip:::zip(zipfile = paste(direc6,'.zip',sep=''), files = files)

				setwd(sessiontemp)  #restores session
		
				#Download handler       
				output$downloadantestatm <- downloadHandler(
					filename <- function() {
						paste("results.zip")
					},      
					content <- function(file) {
						setwd(direc6)
						file.copy(paste(direc6,'.zip',sep=''), file) 
						setwd(sessiontemp)  
					},
					contentType = "application/zip"
				)
			}
		
			setwd(sessiontemp) #restores session
			removeModal() #removes modal
	})
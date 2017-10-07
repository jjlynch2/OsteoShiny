    ####This is the antemortem - postmortem comparison server side code made for local import into server.r
	output$antestat_test <- renderUI({
		selectInput('antestat', 'Elements', c(Humerus='humerus', Ulna='ulna', Radius='radius', Femur='femur', Tibia='tibia', Fibula='fibula'),'humerus')
	})
	
	
	output$antestat_output <- renderUI({
	   HTML(paste("Enter the parameters and select process to begin.</br></br>"))
	})	
	

	observeEvent(input$proantestat, {
		showModal(modalDialog(title = "Calculation has started...Window will update when finished.", easyClose = FALSE, footer = NULL))
		
		withProgress(message = 'Calculation has started',
		            detail = 'This may take a while...', value = 0, {       
		            for (i in 1:15) {
		       incProgress(1/15)
		       Sys.sleep(0.10)
		     
		     }
		})
		
		if(input$antestat == "humerus") {pmm <- input$hu_antestat}
		if(input$antestat == "radius") {pmm <- input$ra_antestat}
		if(input$antestat == "ulna") {pmm <- input$ul_antestat}
		if(input$antestat == "femur") {pmm <- input$fe_antestat}
		if(input$antestat == "tibia") {pmm <- input$ti_antestat}
		if(input$antestat == "fibula") {pmm <- input$fi_antestat}

		#calls sorting function
		outtemp <- antestat(metric = input$metric_type, antemortem_stature = input$antestat_input, postmortem_measurement = pmm, prediction_interval = input$predlevelantestat, population = input$antestat_population, output_options = c(input$fileoutputant1, input$fileoutputant2), sessiontempdir = sessiontemp)

		
		#display output
		output$antestat_output <- renderUI({
				HTML(paste("Statistical analysis complete.", '<br/>'))
		})   

		
		output$antestat_table <- DT::renderDataTable({
			DT::datatable(outtemp[[2]], options = list(lengthMenu = c(1), pageLength = 10), rownames = FALSE)
		})

		output$antestat_plot <- renderPlot({outtemp[[3]]})
		removeModal() #removes modal
		
		#Zip handler       
		direc6 <- outtemp[[1]] #direc temp
		files <- list.files(direc6, recursive = TRUE)
		setwd(direc6)
		zip:::zip(zipfile = paste(direc6,'.zip',sep=''), files = files)

		setwd(sessiontemp)  #restores session
		
		#Download handler       
		output$downloadantestat <- downloadHandler(
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

		setwd(sessiontemp) #restores session
	})
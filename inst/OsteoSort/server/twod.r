
	output$contents2D <- renderUI({
	   HTML(paste("Select the parameters and upload images to begin."))
	})	

	output$resettableInput2D <- renderUI({
		input$clearFile2D
		input$uploadFormat
		fileInput('leftimages', 'Upload first image set', accept=c('jpeg', "jpg"), multiple = TRUE)
	})

	output$resettableInput2DD <- renderUI({
		input$clearFile2D
		input$uploadFormat
		fileInput('rightimages', 'Upload second image set', accept=c('jpeg', "jpg"), multiple = TRUE)
	})

	observeEvent(input$clearFile2D, {
		fileInput('leftimages', 'Upload first image set', accept=c('jpeg', "jpg"), multiple = TRUE)
		fileInput('rightimages', 'Upload second image set', accept=c('jpeg', "jpg"), multiple = TRUE)
	})

	
	ncores2D <- reactiveValues(ncores2D = 1)
	
	observeEvent(input$ncores2D, {
		ncores2D$ncores2D <- input$ncores2D
	})

	output$fragment_options1 <- renderUI({
		sliderInput(inputId = "nnb", label = "Number of K-nearest neighbors for mean estimation", min=1, max=1000, value=40, step=1)
	})

	output$efa_options1 <- renderUI({
		sliderInput(inputId = "efaH2D", label = "Number of Elliptical Fourier Analysis Harmonics", min=1, max=1000, value=40, step=1)
	})

	output$efa_options2 <- renderUI({
		sliderInput(inputId = "npoints2D", label = "Number of landmarks during inverse Elliptical Fourier Analysis transformation", min=20, max=1000, value=200, step=1)
	})
	output$efa_options2 <- renderUI({
		checkboxInput(inputId = "scale2D", label = "Scale to centroid size after inverse Elliptical Fourier Analysis transformation", value = TRUE)
	})

	output$ncores2D <- renderUI({
		sliderInput(inputId = "ncores2D", label = "Number of cores", min=1, max=detectCores(), value=1, step =1)
	})


	output$n_regions <- renderUI({			
		sliderInput(inputId = "n_regions", label = "Number of regions", min = 2, max = input$npoints2D, value = 6, step = 1)										
	})

	output$max_avg_distance <- renderUI({
		radioButtons(inputId = "max_avg_distance", label = "Segmented-Hausdorff distance:", choices = c("maximum",  "average"), selected = "average")
	})

	#renders temporary mean
	observeEvent(input$rightimages, {
		output$mspec <- renderUI({
			sliderInput(inputId = "mspec", label = "Choose specimen # for temporary mean", min=1, max=nrow(input$leftimages) + nrow(input$rightimages), value = 1, step = 1)
		})
	})			
	
	observeEvent(input$mspec, {
		nimages <- rbind(input$leftimages$datapath, input$rightimages$datapath)
		nimages <- nimages[input$mspec]
		output$meanImage <- renderImage({
			list(src = nimages,
				contentType = 'image/jpg',
				width = 600,
				height = 600,
				alt = "A"
			)
		}, deleteFile = FALSE)
	})
	#renders temporary mean


	observeEvent(input$pro2D, {
		output$contents2D <- renderUI({
		   HTML(paste(""))
		})	

		showModal(modalDialog(title = "Calculation has started...Window will update when finished.", easyClose = FALSE, footer = NULL))
	
	
		withProgress(message = 'Calculation has started',
			detail = 'This may take a while...', value = 0, {       
				for (i in 1:25) {
				incProgress(1/25)
				Sys.sleep(0.10)
		     
			}
		})
		 	

#need to add ifstatement to check if images have been uploaded to avoid crashing the app when hitting process without data

		leftimages <- input$leftimages$datapath
		rightimages <- input$rightimages$datapath

		file.copy(input$leftimages$datapath, input$leftimages$name)
		file.copy(input$rightimages$datapath, input$rightimages$name)

		if(length(input$leftimages$name) < 2) {}
		if(length(input$rightimages$name) < 2) {}

		if(input$fragcomp == "Complete") {fragment <- FALSE}
		if(input$fragcomp == "Fragmented") {fragment <- TRUE}


		out1 <- outline.images(imagelist1 = input$rightimages$name, imagelist2 = input$leftimages$name, fragment = fragment, threshold =input$nthreshold, scale = input$scale2D, mirror = input$mirror2D, npoints = input$npoints2D, nharmonics = input$efaH2D)

		out2 <- match.2d(outlinedata = out1, hide_distances = input$hidedist, nnb = input$nnb, fragment = fragment, dist = input$max_avg_distance, n_regions = input$n_regions, n_lowest_distances = input$shortlistn, output_options = c(input$fileoutput2Dexcel, input$fileoutput2Dplot, input$fileoutput2Dtps), sessiontempdir = sessiontemp, transformation = input$trans2D, cores = ncores2D$ncores2D, test = input$distance2D, temporary_mean_specimen =, mean_iterations = input$meanit2D)
		direc <- out2[[3]]
		

			setwd(sessiontemp)
			setwd(direc)
			if(input$fileoutput2Dplot) {
				nimages <- list.files()
				nimages <- paste(sessiontemp, "/", direc, "/", nimages[grep(".png", nimages)], sep="")

				output$plotplottd <- renderImage({
					list(src = nimages,
						contentType = 'image/png',
						alt = "A"
					)
				}, deleteFile = FALSE)
			}





		output$table2D <- DT::renderDataTable({
			DT::datatable(out2[[2]], options = list(lengthMenu = c(5,10,15,20,25,30), pageLength = 10), rownames = FALSE)
		})



		output$contents2D <- renderUI({
			HTML(paste("Potential Matches: ", nrow(as.matrix(out2[[2]][,1]))))
		})

		setwd(sessiontemp)
		files <- list.files(direc, recursive = TRUE)
		setwd(direc)
		zip:::zip(zipfile = paste(direc,'.zip',sep=''), files = files)

			#Download handler       
		output$downloadData2D <- downloadHandler(
			filename <- function() {
				paste("results.zip")
			},      
			content <- function(file) {
				setwd(direc)
				file.copy(paste(direc,'.zip',sep=''), file)  
				setwd(sessiontemp)    
			},
			contentType = "application/zip"
		)
		setwd(sessiontemp)



		for(i in 10) { gc() } #clean up 
		removeModal()  
	})
	
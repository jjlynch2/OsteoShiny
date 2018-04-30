
	filelist3 <- reactiveValues(list=list())
	position <- reactiveValues(pos = 1)
	landmarks <- reactiveValues(landmarks=list())

output$resettableInput3Da <- renderUI({
	input$clearFile3Da
	input$uploadFormat
	fileInput('aligndata', 'Upload data set', accept=c("xyz"), multiple = TRUE)
})

observeEvent(input$clearFile3Da, {
	if(!is.null(input$aligndata$datapath)) {
		file.remove(input$aligndata$datapath)
		file.remove(input$aligndata$name)
	}
	try(rgl.close())
	filelist3$list = list()
	position$pos = 1
	landmarks$landmarks = list()
	fileInput('aligndata', 'Upload data set', accept=c("xyz"), multiple = TRUE)
})
				
observeEvent(input$aligndata$datapath, {
	file.copy(input$aligndata$datapath, input$aligndata$name)

	filelist3$list <- input.3d(input$aligndata$name) #imports 3D xyzrbg data
	landmarks$landmarks <- landmarks$landmarks[1:length(filelist3$list)] #populate as NULL x file length on upload


######broken code to reimport landmarks
	for(i in 1:length(filelist3$list)) {
		if(ncol(filelist3$list[[i]]) > 3) {
			if(!is.null(filelist3$list[[i]]$l1) && !is.null(filelist3$list[[i]]$l2) && !is.null(filelist3$list[[i]]$l3) && !is.null(filelist3$list[[i]]$ml)) {
				temp1 <- as.numeric(na.omit(filelist3$list[[i]]$l1))
				temp2 <- as.numeric(na.omit(filelist3$list[[i]]$l2))
				temp3 <- as.numeric(na.omit(filelist3$list[[i]]$l3))
				temp4 <- as.numeric(na.omit(filelist3$list[[i]]$ml))

				if(length(temp1) > 0 && length(temp2) > 0 && length(temp3) > 0 && length(temp4) > 0) {
					landmarks$landmarks[[i]][[1]] <- c(temp1, temp2, temp3)
					landmarks$landmarks[[i]][[2]] <- temp4
				}
			}
		}
	}
######broken code to reimport landmarks

	pos_destroy_me <- observeEvent(position$pos, {
		output$webgl3Dalign <- renderRglwidget ({
   			try(rgl.close())
			tt1 <- filelist3$list[[position$pos]]
			points3d(tt1, size=3, col="dimgray", box=FALSE)

			if(!is.null(landmarks$landmarks[[position$pos]]))  {
				p1 <- tt1[landmarks$landmarks[[position$pos]][[1]][1],]
				p2 <- tt1[landmarks$landmarks[[position$pos]][[1]][2],]
				p3 <- tt1[landmarks$landmarks[[position$pos]][[1]][3],]
				mp <- tt1[landmarks$landmarks[[position$pos]][[2]],]
				points3d(p1, size=10, col="red", box=FALSE)
				points3d(p2, size=10, col="blue", box=FALSE)
				points3d(p3, size=10, col="green", box=FALSE)
				points3d(mp, size=10, col="black", box=FALSE)
			}
			axes3d(c('x++', 'y++', 'z++'))
			title3d(main = input$aligndata$name[position$pos], col = "DODGERBLUE")
			rglwidget()
		})
	})

})



observeEvent(input$nnext, {
	if(position$pos < length(filelist3$list)) {
		position$pos = position$pos + 1
	}
})

observeEvent(input$previous, {
	if(position$pos > 1) {
		position$pos = position$pos - 1
	}
})

observeEvent(input$start, {
	showModal(modalDialog(title = "Digitization has started...Please check the RGL window.", easyClose = FALSE, footer = NULL))
	temp_p <- filelist3$list[[position$pos]][,c(1:3)]
	landmarks$landmarks[[position$pos]] <- digitize.3d(temp_p)
	removeModal()  
})

output$savedata <- downloadHandler(
	filename <- function() {
		paste("aligned.zip")
	},      
	content <- function(file) {
		#eventually move this to OsteoSort in output_functions. Here as proof-of-concept
		direc <- OsteoSort:::analytical_temp_space(output_options <- TRUE, sessiontempdir = sessiontemp)
		setwd(sessiontemp)
		setwd(direc)
		for(i in 1:length(filelist3$list)) {
			if(!is.null(landmarks$landmarks[[i]])) {
				r1 <- length(landmarks$landmarks[[i]][[2]])
				saveme <- cbind(x = filelist3$list[[i]][,1], y = filelist3$list[[i]][,2], z = filelist3$list[[i]][,3], l1 = c(landmarks$landmarks[[i]][[1]][1], rep(NA, nrow(filelist3$list[[i]]) - 1)), l2 = c(landmarks$landmarks[[i]][[1]][2], rep(NA, nrow(filelist3$list[[i]]) - 1)), l3 = c(landmarks$landmarks[[i]][[1]][3], rep(NA, nrow(filelist3$list[[i]]) - 1)), ml = c(landmarks$landmarks[[i]][[2]], rep(NA, nrow(filelist3$list[[i]]) - r1))
				)
			}
			if(is.null(landmarks$landmarks[[i]])) {
				saveme <- cbind(x = filelist3$list[[i]][,1], y = filelist3$list[[i]][,2], z = filelist3$list[[i]][,3])
			}
			write.table(saveme, sep = ' ', file = input$aligndata$name[i], row.names = FALSE)
		}
		setwd(sessiontemp)
		files <- list.files(direc, recursive = TRUE)
		setwd(direc)
		zip:::zip(zipfile = paste(direc,'.zip',sep=''), files = files)
		file.copy(paste(direc,'.zip',sep=''), file)

	},
	contentType = "application/zip"
)
setwd(sessiontemp)
	
#=============================================================================#
#                                                                             #
#     USAGE: THIS IS NOT A FUNCTIONAL SCRIPT.                                 #
#     It is a part of a Shiny app                                             #
#                                                                             #
#     AUTHOR: Jacques SERIZAY                                                 #
#     CREATED: 2018/07/13                                                     #
#     REVISION: 2018/10/05                                                    #
#                                                                             #
#=============================================================================#

## Define server function ----------------------------------------------------------------------------------------------------

shinyServer <- function(input, output, session) {

    # Read input data
    #preData <- reactive ({ read.csv(input$preDrug$datapath, header = T, row.names = 1, stringsAsFactors = F)[,1] })
    #postData <- reactive ({ read.csv(input$postDrug$datapath, header = T, row.names = 1, stringsAsFactors = F)[,1] })
    

    # Swith tab when submit data
    observeEvent(input$submitData, { 
        updateTabItems(session, "tabs", "results") 
        #preData <- reactive ({ read.csv(input$preDrug$datapath, header = T, row.names = 1, stringsAsFactors = F)[,1] })
        #postData <- reactive ({ read.csv(input$postDrug$datapath, header = T, row.names = 1, stringsAsFactors = F)[,1] })
    })
    
    plot <- output$plot <- renderPlot({
        
        #Combined = cbind(tab, preData(), postData())
        #metadata = rbind(tabMetadata, c(colnames(preData()), "Before", "Cisplatin", "Unknown"))
        #metadata = rbind(metadata, c(colnames(postData()), "After", "Cisplatin", "Unknown"))
        #metadata$Responder = as.factor(metadata$Responder)
        #pca = as.data.frame(prcomp(t(Combined))$x[,1:2])
        #pca = cbind(pca, metadata)
        #pca$size = as.character(pca$Responder)
        #pca[which(pca$Responder == "No" | pca$Responder == "Yes"),"size"] = 1
        #pca[which(pca$Responder == "Patient"),"size"] = 5
        #Plot
        ggplot(data = pca, aes(x = PC1, y = PC2, color = Responder, shape = Time, size = size)) + geom_point() + scale_color_manual(values = c("royalblue", "black", "deeppink2")) + guides(size=FALSE) + theme_bw()

    })

    output$plot2 <- plot
    
}

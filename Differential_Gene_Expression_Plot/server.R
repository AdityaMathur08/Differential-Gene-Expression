# Define server logic
# To access any input use input$[inputId]
#                     ex. input$G_groups (the first select input value)
# To assign any output use output$[outputId] output$
#                      ex. output$myplot (assign the plot output)
server <- function(input, output) {
    output$odataset <- renderPrint({
        paste(input$My_dataset," = ", gn$Gene[gn$GeneID==input$My_dataset])
    })
    
    # using GeneBook library to construct a link to the gene database
    abbreviation <- reactive((GeneCard_ID_Convert(input$My_dataset)))
    
    # output for the odataset_link
    output$odataset_link <- renderPrint({
        tags$a(
            href = paste(
                "https://www.genecards.org/cgi-bin/carddisp.pl?gene=",
                as.character(abbreviation()[1]),
                sep = ''
            ),
            as.character(abbreviation()[1])
        )
    })
    
    
    full_file_name <-reactive(paste("./inc/", input$G_groups, ".csv", sep = ""))
    
    output$downloadData <- downloadHandler(
        
        filename = full_file_name,
        
        content = function(file){
            write.csv(read.csv(full_file_name()), quote = FALSE,file)
        } )
    
    output$myplot = renderPlot({
        g_x <- read.csv(full_file_name())
        
        p <- ggplot(g_x, aes(x=Gene_ID, y=log(Relative_expression_levels),
                             fill=Resistant_or_Susceptible_strains)) +
            
            geom_bar(stat="identity", position=position_dodge()) +
            geom_errorbar(aes(ymin=log(Relative_expression_levels)-(SD/10),
                              ymax=log(Relative_expression_levels)+(SD/10)),width=.3,
                          position=position_dodge(.9))
        p + scale_fill_brewer(palette="Paired")+
            ggtitle(paste("Relative expression levels of candidate gene list","\n",
                          "expressed as mean fold difference between pre- and",
                          "\n", "post-infection ± standard deviation (SD) ")) +
            guides(fill=guide_legend(title=NULL))
        
        p$theme <- theme(axis.text.x = element_text(angle = 90, hjust = 1))
        p$labels$x <- "Gene ID"
        p$labels$y <- "Log (base 10) Relative Expression Levels"
        p$labels$fill <- NULL
        
        return(p)
        
    })
    
    
    # renderDT() from DT library is a replacement for Shiny renderDataTable()
    output$datatable1 <- renderDT(datatable(g1))
    output$datatable2 <- renderDT(datatable(g2))
    output$datatable3 <- renderDT(datatable(g3))
    
    output$text1 <- renderUI({
        if(input$More_info=="Introduction"){
            includeHTML("inc/introduction.html")
        } else if(input$More_info=="Information"){
            includeHTML("inc/information.html")
        } else if(input$More_info=="Help"){
            includeHTML("inc/help.html")
        } else if(input$More_info=="Table-1"){
            DTOutput('datatable1')
        } else if(input$More_info=="Table-2"){
            DTOutput('datatable2')
        } else if(input$More_info=="Table-3"){
            DTOutput('datatable3')
        } else if(input$More_info=="References"){
            includeHTML("inc/references.html")
        }
    })
    
    output$messageMenu <- renderMenu({
        # Code to generate each of the messageItems here, in a list. This assumes
        # that gn is a data frame with two columns, 'GeneID' and 'Gene'.
        messageList <- apply(gn[1:3, ], 1, function(row) {
            messageItem(
                from = row[["GeneID"]],
                message = row[["Gene"]],
                icon = icon("question"),
                href = paste("https://www.genecards.org/cgi-bin/carddisp.pl?gene=",
                             as.character(row[["GeneID"]]),
                             sep = '')
            )
        })
        
        # This is equivalent to calling:
        #   dropdownMenu(type="messages", msgs[[1]], msgs[[2]], ...)
        dropdownMenu(type = "messages", .list = messageList)
    })
}
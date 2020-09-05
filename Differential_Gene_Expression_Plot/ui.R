# Define UI for application that draws a histogram
#
# uncomment and run the following line to
# file.edit('C:/Users/Administrator/shiny2020/Task-6/themes/www/mytheme.css')
# file.edit('C:/Users/Administrator/shiny2020/Task-6/themes/www/bootstrap.css')
# file.edit('C:/Users/Administrator/shiny2020/Task-6/themes/www/bootstrap.min.css')
#

ui <- dashboardPage(
    dashboardHeader(
        title = "Gene Expression"
        ,
        # ==== Messages Menu =======================================
        dropdownMenu(
            type = "messages",
            messageItem(
                from = "The Other Side",
                message = "I'll leave that up to you.",
                href = "http://coursera.org/search?query=rhyme",
                icon = icon("user"),  # Try another icon: 'question', 'life-ring'
                time = "13:31")       # Try different date/time format '2020-4-29', '2020-4-29 01:45'
            
            # , # If you add one more messageItem you need one more comma!
            
        ),
        
        # ==== Tasks Menu ==========================================
        dropdownMenu(
            type = "tasks",
            badgeStatus = "success",
            # Other badgeStatus are 'primary', 'success', 'info', 'warning', 'danger', NULL
            
            taskItem(
                value = 92,
                color = "green",
                text = "Documentation")
            ,
            taskItem(
                value = 75,
                color = "yellow",
                text = "Sequencing")
            ,
            taskItem(
                value = 17,
                color = "aqua",
                text = "Project X"
            ),
            
            taskItem(
                value = 19,
                color = "red",
                text = "Known Interaction Network")
        ),
        
        # ==== Notifications menu ==================================
        dropdownMenu(
            type = "notifications",
            notificationItem(
                text = "5 new users today",
                icon = icon("users"),
                status = "info"
            ),
            
            notificationItem(
                text = "12 items delivered",
                icon = icon("truck"),
                status = "success"
            ),
            notificationItem(
                text = "Server load at 86%",
                icon = icon("exclamation-triangle"),
                status = "warning"
            )
        ),
        
        # ====  Message Menu filled by server function =============
        dropdownMenuOutput("messageMenu")
    ) 
    ,
    
    dashboardSidebar(
        selectInput(
            inputId = "G_groups",
            label = "A- Choose Group to plot:",
            choices = c(
                "1- Genes down regulated in resistant while
                                   up regulated in susceptible " = "g1",
                "2- Genes down regulated in both resistant
                                   and susceptible" = "g2",
                "3- Genes up regulated in both resistant and
                                   susceptible " = "g3"
            )
        )
        ,
        # We need comma between each input
        
        selectInput(
            inputId = "My_dataset",
            label = "B- Choose Gene ID to show it's full name:",
            choices = levels(as.factor(gn$GeneID))
        ),
        
        selectInput(
            inputId = "More_info",
            label = "C- Documentation:",
            choices = c(
                'Introduction',
                'Information',
                'Help',
                'References',
                'Table-1',
                'Table-2',
                'Table-3'
            ),
            selected = "Introduction"
        )
        
    ),
    
    dashboardBody(
        downloadButton(outputId = "downloadData",
                       label = "Download Data"),
        
        plotOutput(
            outputId = "myplot",
            width = "100%",
            height = "400px"
        ),
        
        verbatimTextOutput(outputId = "odataset"),
        
        uiOutput(outputId = "odataset_link"),
        
        uiOutput(outputId = "text1")
        
    )
)

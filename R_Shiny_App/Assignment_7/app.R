#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(ggplot2)
library(jsonlite)
library(dplyr)

library(shiny)

#For this project, I will be using the px2M.json file. I converted this to a tsv using an online website. The tsv is imported at a later step

select_race <- c("WHITE", "BLACKORAFRICANAMERICAN", "AMERICANINDIANORALASKANATIVE", "HISPANICORLATINO")

# Define UI for application that draws a plot and Race selection
ui <- fluidPage(

    # Application title
    titlePanel("Age at Diagnosis by Pathogenic Chromosome Position 1 All Separated by Race"),
    
    sidebarLayout(
        sidebarPanel(
          selectInput(inputId = "race", label = "Select Race:", choices = select_race)),
          mainPanel(
            plotOutput("plot")
          )
          )
      
        )
   


# Define server logic required to draw a ggplot (NOTE=> You will need to modify file path)
server <- function(input, output) {
    data <- read.table("/Users/bigyambat/Downloads/px2.tsv", sep="\t", header=TRUE)
  
    output$plot <- renderPlot({
      ggplot(data[data$race == input$race, ], aes(x = age_at_diagnosis, y = Pathogenic_Chr_Pos_1)) +
        geom_point()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)

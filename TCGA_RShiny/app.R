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

#Note that I used a modified version of IDH1 tsv file. The headers for each column had spaces (which messes up R syntax). So I inserted underscores for the specific columns I used. 

cancer_types <- c("Oligoastrocytoma", "Oligodendroglioma", "Anaplastic Astrocytoma")

# Define UI for application that draws a histogram
ui <- fluidPage(

  # Application title
  titlePanel("First Symptom Longest Duration by Allele Frequency (T)"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "Cancer_Type_Detailed", label = "Select Cancer Type:", choices = cancer_types)),
    mainPanel(
      plotOutput("plot")
    )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  data <- read.table("/Users/bigyambat/Downloads/IDH1_modified3.tsv", sep="\t", header=TRUE)
  
  output$plot <- renderPlot({
    ggplot(data[data$Cancer_Type_Detailed == input$Cancer_Type_Detailed, ], aes(x = First_symptom_longest_duration, y = Allele_Freq_T)) +
      geom_violin(alpha = 0.5, size = 0.8, color = "black", draw_quantiles = c(0.25, 0.5, 0.75), trim = FALSE) +
      labs(x = "First Symptom Longest Duration", y = "Allele Frequency (T)", title = "First Symptom Longest Duration by Allele Frequency (T)")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

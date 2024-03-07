library(shiny)
library(tidyverse)
library(shinydashboard)



ui <- dashboardPage(
  dashboardHeader(title="UC_admissions"),
  dashboardSidebar(disable = T),
  dashboardBody(
    fluidRow(
      box(
        selectInput("x", "Select Campus", choices = c(unique(UC_admit$Campus)), hr()),
      ),
      box(
        selectInput("y","Select Year",choices = c(unique(UC_admit$Academic_Yr), hr()))
      ),
      box(
        selectInput("z","Select Applicant",choices = c(unique(UC_admit$Category), hr()))
      ),
      box(
        plotOutput("plot", width = "400px", height = "400px"))
    )
  )
)


server <- function(input, output, session) {
  session$onSessionEnded(stopApp)
  output$plot <- renderPlot({
    UC_admit %>% 
      filter(Campus==input$x & Academic_Yr==input$y & Category==input$z) %>% 
      group_by(Academic_Yr) %>% 
      ggplot(aes(x=Ethnicity, y=FilteredCountFR,fill=Ethnicity))+
      geom_col()+
      coord_flip()
  })
  
}

shinyApp(ui, server)

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
        selectInput("y","Select Ethnicity",choices = c(unique(UC_admit$Ethnicity), hr()))
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
      mutate(Academic_Yr=as.factor(Academic_Yr)) %>% 
      filter(Campus==input$x & Ethnicity==input$y & Category==input$z) %>% 
      group_by(Academic_Yr) %>% 
      ggplot(aes(x=Academic_Yr, y=FilteredCountFR,fill=Ethnicity))+
      geom_col()+
      coord_flip()
    })
  
}

shinyApp(ui, server)

shinyServer(function(input, output, session) {
  
  output$a <- renderUI({ 
    if (input$sbMenu=="individual") { # has to be at menuSubItem if it exists
      inputPanel(
        selectInput("author", "Select",authors)
      )
    }
  })
source("code/individual.R", local = TRUE)
  
  
})

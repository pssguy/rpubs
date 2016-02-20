
shinyServer(function(input, output, session) {
  
  output$a <- renderUI({ 
    if (input$sbMenu=="individual") { # has to be at menuSubItem if it exists
      inputPanel(
        selectInput("author", "Select",authors)
      )
    } else if (input$sbMenu=="latest") { # has to be at menuSubItem if it exists
      inputPanel(
        selectInput("allAuthors", "Add or Delete",authors, multiple = TRUE,selected=rs)
      )
    } else if (input$sbMenu=="input") {
      inputPanel(
      textInput("chosen", "Enter handle(s) (e.g. walkerke) Sep with comma"),
      actionButton("getArticles","Go")
      )
    }
  })
source("code/individual.R", local = TRUE)
  source("code/latest.R", local = TRUE)
  source("code/input.R", local = TRUE)
  
})

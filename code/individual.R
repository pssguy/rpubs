
indData <- reactive({
  req(input$author)
  
  page <- read_html(input$author)
  
  
  
  gravatar <- page %>%
    html_nodes(".gravatar") %>%
    html_attr("src")
  
  mainpage <- page %>%
    html_nodes(".userblock a") %>%
    html_attr("href")
  
  number <- page %>%
    html_nodes(".pubthumb") %>%
    length()
  
  link <- page %>%
    html_nodes(".pubinfo a") %>%
    html_attr("href")
  
  title <- page %>%
    html_nodes(".pubinfo a") %>%
    html_text()
  
  
  date <- page %>%
    html_nodes(".pubinfo time") %>%
    html_attr("datetime") %>%
    as.Date()
  
  thumbnail <- page %>%
    html_nodes(".pubthumb") %>%
    html_attr("src")
  
  
  df <- data.frame(date = date,
                   link = link,
                   title = title)
  
  
  info = list(df = df)
  
})

output$indTable <- DT::renderDataTable({
  indData()$df %>%
    mutate(subject = paste0("<a href=\"", link, "\" target=\"_blank\">", title, "</a>")) %>%
    select(date, subject) %>%
    DT::datatable(
      class = 'compact stripe hover row-border order-column',
      rownames = FALSE,
      escape = FALSE,
      options = list(
        paging = TRUE,
        searching = TRUE,
        info = FALSE
      )
    )
  
})
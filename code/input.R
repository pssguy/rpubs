



chosenData <- eventReactive(input$getArticles,{
  
  req(input$chosen)
  

  
  selAuthors <- str_split(input$chosen,",")[[1]] %>% 
    str_trim()
 

  for(i in 1:length(selAuthors)) ({
    
    u <- paste0("https://rpubs.com/",selAuthors[i],"/")
page <- read_html(u)


gravatar<- page %>% 
  html_nodes(".gravatar") %>% 
  html_attr("src") 
mainpage <-page %>% 
  html_nodes(".userblock a") %>% 
  html_attr("href")  

number <-page %>% 
  html_nodes(".pubthumb") %>% 
  length() 

link <- page %>% 
  html_nodes(".pubinfo a") %>% 
  html_attr("href") 


title <- page %>% 
  html_nodes(".pubinfo a") %>% 
  html_text() 


date <-page %>% 
  html_nodes(".pubinfo time") %>% 
  html_attr("datetime") %>% 
  as.Date()


thumbnail <-page %>% 
  html_nodes(".pubthumb") %>% 
  html_attr("src") 

authorName  <- page %>% 
  html_nodes("h3") %>% 
  html_text() 


df <- data.frame(date=date,link=link,title=title, stringsAsFactors = FALSE)
df$author <- authorName

if (i!=1) {
  all <- rbind(all,df)
} else {
  all <- df
}

})

info=list(all=all)

})

output$selectTable <- DT:: renderDataTable({
  
  chosenData()$all %>%
    arrange(desc(date)) %>% 
    mutate(subject=paste0("<a href=\"",link,"\" target=\"_blank\">",title,"</a>")) %>% 
    select(date,author,subject) %>% 
 DT::datatable(class='compact stripe hover row-border order-column',
               rownames=FALSE,
               escape=FALSE,
               options= list(paging = TRUE, searching = TRUE,info=FALSE))
  
})

output$selectTimeline <- renderPlotly({
  
  
  df <- chosenData()$all %>% 
    mutate(reps=1) 
  

  
  plot_ly(df ,
          x=date,
          y=reps,
          type="bar",
          group=author,
          showlegend = TRUE,
          hoverinfo="text",
          text=paste(author,"<br>",date,"<br>",title)) %>% 
    
    layout(hovermode = "closest", barmode="stack",
           xaxis=list(title=" "),
           yaxis=list(title="Publications By Day"),
           title="Timeline of Publications by Selected Authors",
           titlefont=list(size=16)
    ) 
  
})




allData <- reactive({
  
  req(input$allAuthors)
  
  authors <- input$allAuthors

  for(i in 1:length(authors)) ({
page <- read_html(input$allAuthors[i])
#page <- read_html("https://rpubs.com/walkerke/")

authorName <- myFaves[myFaves$url==input$allAuthors[i],]$Author

gravatar<- page %>% 
  html_nodes(".gravatar") %>% 
  html_attr("src") #"http://www.gravatar.com/avatar/5cf92204cc3691d9a5155632012d8644?s=64"

mainpage <-page %>% 
  html_nodes(".userblock a") %>% 
  html_attr("href")  #"http://www.rpubs.com/ramnathv"

number <-page %>% 
  html_nodes(".pubthumb") %>% 
  length() #12

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

df <- data.frame(date=date,link=link,title=title, author=authorName)

if (i!=1) {
  all <- rbind(all,df)
} else {
  all <- df
}

})

#print(glimpse(all))

info=list(all=all)

})

output$allTable <- DT:: renderDataTable({
  
  allData()$all %>%
    arrange(desc(date)) %>% 
    mutate(subject=paste0("<a href=\"",link,"\" target=\"_blank\">",title,"</a>")) %>% 
    select(date,author,subject) %>% 
 DT::datatable(class='compact stripe hover row-border order-column',
               rownames=FALSE,
               escape=FALSE,
               options= list(paging = TRUE, searching = TRUE,info=FALSE))
  
})

output$allTimeline <- renderPlotly({
  
  
  df <- allData()$all %>% 
    mutate(reps=1) 
  
  print(glimpse(df))
  
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
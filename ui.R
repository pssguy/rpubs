

dashboardPage(
  title = "RPubs",
  skin = "yellow",
  dashboardHeader(title = "Rpubs"),
  
  dashboardSidebar(
    includeCSS("custom.css"),
    
    uiOutput("a"),
    
    
    
    
    sidebarMenu(
      id = "sbMenu",
      
      menuItem("Individual", tabName = "individual"),
      menuItem("Latest", tabName = "latest"),
      
      
      tags$hr(),
      menuItem(
        text = "",
        href = "https://mytinyshinys.shinyapps.io/dashboard",
        badgeLabel = "All Dashboards and Trelliscopes (14)"
      ),
      tags$hr(),
      
      tags$body(
        a(
          class = "addpad",
          href = "https://twitter.com/pssGuy",
          target = "_blank",
          img(src =
                "images/twitterImage25pc.jpg")
        ),
        a(
          class = "addpad2",
          href = "mailto:agcur@rogers.com",
          img(src = "images/email25pc.jpg")
        ),
        a(
          class = "addpad2",
          href = "https://github.com/pssguy",
          target = "_blank",
          img(src =
                "images/GitHub-Mark30px.png")
        ),
        a(
          href = "https://rpubs.com/pssguy",
          target = "_blank",
          img(src = "images/RPubs25px.png")
        )
      )
    )
  ),
  
  
  
  
  dashboardBody(tabItems(
    tabItem("individual"),
    
    tabItem("latest"),
    
    tabItem("info", includeMarkdown("about.md"))
    
    
    
    
    
    
    
    
    
  ) # tabItems
  ) # body
  ) # page
  
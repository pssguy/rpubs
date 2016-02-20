
library(markdown)
library(shiny)
library(shinydashboard)

library(stringr)
library(dplyr) 
library(rvest)
# library(tidyr)
# library(DT)
 library(readr)
# library(plotly)
# 
# 
# library(purrr)
# library(gh)

# starting point for faves

myFaves <- read_csv("data/authors.csv") %>% 
         arrange(Author)

RStudio <- myFaves %>% 
  filter(RStudio=="Y")

authors <- myFaves$url
names(authors) <- myFaves$Author



rs <- RStudio$url
names(rs) <- RStudio$Author
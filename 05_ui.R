# Data Science Capstone: Next word prediction
# NextWord! UI code

# Loading libraries

library(shiny)
library(shinythemes)
library(stringr)
library(tidyverse)
library(dplyr)
library(data.table)
library(stringdist)
library(shinybusy)



# Define UI for application that output correct next word
shinyUI(fluidPage(theme = shinytheme("darkly"),
          
use_busy_bar(color = "darkblue", height = "15px"),

# Application title  
navbarPage("NextWord!",

  # tabPanel Word prediction
  tabPanel("Word prediction", icon = icon("console", lib = "glyphicon"),
    sidebarLayout(
      sidebarPanel(
        textInput("user_app_input", "Text input:", "")
    ),
    # Text output
    mainPanel(
      div(style="background-color: #303030; margin: 0px 0; padding: 22px; height:125px",
          HTML(paste(tags$span(style="color:blue; font-weight:bold", "Prediction engine"), sep = "")), htmlOutput("text_prediction"))
      )
  )
  ),
  
  # tabPanel How it Works
  tabPanel("How it works", icon = icon("wrench", lib = "glyphicon"),
    sidebarLayout(
      sidebarPanel(
        div(style="background-color: #303030; margin: 0px; padding: 0px; height:40px",
        h3("How it works")),
        HTML(paste(tags$span(style="color:blue; font-weight:bold", "User input"), sep = "")),
        tags$br(),
        print("Please enter text in the text input box. Please only use english words. Numbers and punctuation are ignored. The engine is not case-sensitive."),
        tags$br(),
        tags$br(),
        HTML(paste(tags$span(style="color:blue; font-weight:bold", "Input interpretation"), sep = "")),
        tags$br(),
        print("The prediction engine will show you the most probable next word (see image number 1). In this case, your input will be repeated in green color."),
        tags$br(),
        tags$br(),
        HTML(paste(tags$span(style="color:blue; font-weight:bold", "Fallback"), sep = "")),
        tags$br(),
        print("If your input can't be interpreted by the engine, the engine will show you in yellow color the most probable input you might have meant and show you the probable next word for this input (see image number 2)."),
        tags$br(),
        tags$br(),
        HTML(paste(tags$span(style="color:blue; font-weight:bold", "Further understanding"), sep = "")),
        tags$br(),
        print("The prediction works with the last 3 words of your input at most. If you are interested in further understanding of the prediction model, please read the 'About' section.")
        
    ),
    mainPanel(
      img(src="howitworks.png", align = "left", width = "100%", style="max-width: 500px; margin-left: auto; margin-right: auto;")
    )
  )
  ),
      
  # tabPanel About
      tabPanel("About", icon = icon("info-sign", lib = "glyphicon"),
           div(style="background-color: #303030; margin: 10px; padding: 10px",
              h3("About"),
              HTML(paste(tags$span(style="color:blue; font-weight:bold", "Purpose of this app"), sep = "")),
              tags$br(),
              tags$br(),
              print("This app was created as a Capstone project as part of the"),
              a("Coursera Data Science specialization", target="_blank",     href="https://www.coursera.org/specializations/jhu-data-science"),
              print("at"),
              a("Johns Hopkins University", target="_blank",     href="https://www.jhu.edu/"),
              print(". The goal was to build a user-friendly app that predicts the next word based on user input. In addition, the idea is briefly introduced in a pitch deck."),
              tags$hr(),
              HTML(paste(tags$span(style="color:blue; font-weight:bold", "Data Preprocessing"), sep = "")),
              tags$br(),
              tags$br(),
              print("The"),
              a("dataset", target="_blank",     href="https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"),
              print("consists of different text files from twitter, news sites and blogs. Only English texts were chosen. Exploratory analysis and data preprocessing are described in this"),
              a("Data Science Capstone - Milestone Report.", target="_blank",     href="https://rpubs.com/pgajda/Milestone_Report"),
              tags$hr(),
              HTML(paste(tags$span(style="color:blue; font-weight:bold", "Methodology"), sep = "")),
              tags$br(),
              tags$br(),
              print("The methodology is mainly based on two concepts:"),
              tags$br(),
              tags$ul(
                tags$li("ngram-tokenization: basis for the next word prediction"), 
                tags$li("levenshtein-prediction: fallback for non-interpretable user input")), 
              tags$br(),
              print("Here you find a brief description of the principle of ngram tokenization and its purpose for this app. The main goal of ngrams is to make the data set machine readable. Let's assume we have a dataset consisting of the sentence 'this is a test'. If we decide to build bigrams, trigrams and quadgrams we would create the structure shown below. A bigram consists of two consecutive words, therefore we create three bigrams. A trigram consists of three consecutive words, therefore we create two trigrams and so on. Based on this dataset the most likely word that follows the phrase 'is a' would be 'test'. Please note that in the case of phrases of longer than 4 words still only bi-, tri- and quadgrams are formed. For further understanding of this method please read"),
              a("Text Mining with R.", target="_blank",     href="https://www.tidytextmining.com/ngrams.html"),
              tags$br(),
              tags$br(),
              HTML(paste(tags$span(style="font-size:10px", "image: ngram-structure"), sep = "")),
              tags$br(),
              img(src="ngram.png", width = "100%", style="max-width: 400px; margin-left: auto; margin-right: auto;"),
              tags$br(),
              print("Of course, it can happen that a user does not write a word correctly and the machine cannot interpret this input. In this case the engine wouldn't be able to provide a prediction of  a next word. In order to improve user experience, the engine has a build in fallback solution. If the user input doesn't match with a possible ngram (or parts of it), the engine starts building a levenshtein simulations per word. The sum of all levenshtein simulation provides the most probable phrase which the user could have meant. Based on this outcome the prediction algorithm starts a new evaluation and provides the most probable next word."),
              tags$br(),
              tags$br(),
              HTML(paste(tags$span(style="font-size:10px", "image: levenshtein-simulation for 'wher ar yo' based on trigram"), sep = "")),
              tags$br(),
              img(src="levenshtein.PNG", width = "100%", style="max-width: 600px; margin-left: auto; margin-right: auto;"),
              tags$br(),
              tags$hr(),
              HTML(paste(tags$span(style="color:blue; font-weight:bold", "Appendix"), sep = "")),
              tags$br(),
              tags$br(),
              print("Here you find further information about the app and the author."),
              tags$ul(
                tags$li(a("Github repository", target="_blank", href="https://github.com/petergajda/Data-Science-Capstone")),
                tags$li(a("Pitchdeck", target="_blank", href="https://rpubs.com/pgajda/Next_Word_Prediction")),
                tags$li(a("Peter Gajda on Twitter: @ptrgjd", target="_blank", href="https://twitter.com/ptrgjd")))
              )),
  
  collapsible = TRUE

  )

))

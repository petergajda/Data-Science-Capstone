# Data Science Capstone: Next word prediction
# NextWord! Server code

# Loading libraries

library(shiny)
library(stringr)
library(tidyverse)
library(dplyr)
library(data.table)
library(stringdist)
library(shinybusy)




# Define server logic required to output correct next word
shinyServer(function(input, output) {
  
  # Read RDS files
  update_busy_bar(0)
  uni_words <- readRDS(file = "uni_words.rds")
  update_busy_bar(10)
  bi_words <- readRDS(file = "bi_words.rds")
  update_busy_bar(20)
  tri_words <- readRDS(file = "tri_words.rds")
  update_busy_bar(30)
  quad_words <- readRDS(file = "quad_words.rds")
  update_busy_bar(50)
  leven_bi <- readRDS(file = "leven_bi.rds")
  update_busy_bar(60)
  leven_tri <- readRDS(file = "leven_tri.rds")
  update_busy_bar(70)
  leven_quad <- readRDS(file = "leven_quad.rds")
  update_busy_bar(100)
  output$text_prediction <- renderText({
    
    # Generate start time
    start <- Sys.time()
    
    # Validate and need for changing error messages
    validate(
      need(input$user_app_input != "", "Please enter text")
    )
    
    # input$submit
    # # Generate user_input based in input
    user_input_original <- c(input$user_app_input)
    
    # Handling user input: Remove digits, irrelevant whitespace, punctuation, lower cases
    user_input <- gsub('[[:digit:]]+', '', user_input_original)
    user_input <- str_replace(gsub("\\s+", " ", str_trim(user_input)), "B", "b")
    user_input <- gsub('[[:punct:] ]+'," ",user_input)
    user_input <- trimws(user_input)
    user_input <- tolower(user_input)
    
    # Calculate number words, seperate words
    numw <- sapply(strsplit(as.character(user_input[1]), " "), length)
    user_input_words <- unlist(strsplit(as.character(user_input), " "))
    
    # correction if user input is to long to three words
    if(numw == 0) { stop("Please enter Text")}
    
    # correction if user input is to long to three words
    if(numw > 3){
      user_input_words <- user_input_words[(numw-2):numw]
    }
    
    
    # recaculate number words
    numw <- sum(sapply(strsplit(as.character(user_input_words), " "), length))
    
    
    # Functions for filtering
    filter_quad <- function(user_input_words) {
      output <- filter(quad_words, word1 == user_input_words[numw-2], word2 == user_input_words[numw-1], word3 == user_input_words[numw])
      output <- as.character(output[1,4])
      return(output)
    }
    
    
    filter_tri <- function(user_input_words) {
      output <- filter(tri_words, word1 == user_input_words[numw-1], word2 == user_input_words[numw])
      output <- as.character(output[1,3])
      return(output)
    }
    
    filter_bi <- function(user_input_words) {
      output <- filter(bi_words, word1 == user_input_words[numw])
      output <- as.character(output[1,2])
      return(output)
    }
    
    
    # Functions for corrections
    correct_uni <- function(user_input_words) {
      uni_input_correction <- data.table(leven_bi[1], stringsim(user_input_words[numw], leven_bi$word1)) %>%
        'colnames<-'(c("word1", "Lsum")) %>%
        arrange(desc(Lsum))
      uni_input_correction <- paste(uni_input_correction[1, 1])
      return(uni_input_correction)
    }
    
    
    correct_bi <- function(user_input_words) {
      bi_input_correction <- data.table(leven_tri[1:2], stringsim(user_input_words[numw-1], leven_tri$word1)) %>%
        data.table(stringsim(user_input_words[numw], leven_tri$word2)) %>%
        'colnames<-'(c("word1", "word2", "L1", "L2")) %>%
        mutate(Lsum = L1 + L2) %>%
        arrange(desc(Lsum))
      bi_input_correction <- paste(bi_input_correction[1, 1], bi_input_correction[1, 2])
      bi_input_correction <- unlist(strsplit(as.character(bi_input_correction), " "))
      return(bi_input_correction)
    }
    
    
    correct_tri <- function(user_input_words) {
      tri_input_correction <- data.table(leven_quad[1:3], stringsim(user_input_words[numw-2], leven_quad$word1)) %>%
        data.table(stringsim(user_input_words[numw-1], leven_quad$word2)) %>%
        data.table(stringsim(user_input_words[numw], leven_quad$word3)) %>%
        'colnames<-'(c("word1", "word2", "word3", "L1", "L2", "L3")) %>%
        mutate(Lsum = L1 + L2 + L3) %>%
        arrange(desc(Lsum))
      tri_input_correction <- paste(tri_input_correction[1, 1], tri_input_correction[1, 2], tri_input_correction[1, 3])
      tri_input_correction <- unlist(strsplit(as.character(tri_input_correction), " "))
      return(tri_input_correction)
    }
    
    # Create didyoumean with default NA
    didyoumean <- NA
    
    # Create output word and didyoumean placeholder if input is invalid
    output <- if(numw == 1 & is.na(filter_bi(user_input_words)) == FALSE){
      filter_bi(user_input_words)
    } else if(numw == 1 & is.na(filter_bi(user_input_words)) == TRUE){
      didyoumean <- correct_uni(user_input_words)
      filter_bi(didyoumean)
    } else if(numw == 2 & is.na(filter_tri(user_input_words)) == FALSE){
      filter_tri(user_input_words)
    } else if(numw == 2 & is.na(filter_tri(user_input_words)) == TRUE){
      didyoumean <- correct_bi(user_input_words)
      filter_tri(didyoumean)
    } else if(numw == 3 & is.na(filter_quad(user_input_words)) == FALSE){
      filter_quad(user_input_words)
    } else {
      didyoumean <- correct_tri(user_input_words)
      filter_quad(didyoumean)
    }
    
    # Extract correct input
    input_correct <- if (is.na(didyoumean[1]) != TRUE) {
      paste(didyoumean, collapse=" ")
    } else if (is.na(didyoumean[1]) == TRUE) {
      NA
    }
    
    # calculate stop time and timeoutput
    stop <- Sys.time()
    timeoutput <- stop - start
    timeoutput <- round(timeoutput, digits = 3)
    
    # FINAL OUTPUT
    if (is.na(input_correct) == TRUE) {
      paste("<i>", "<p style=color:green>", "Your input: ", user_input_original, "</i>", "</p>", "Your next word: ", output, "</br>", "<p style='color:grey; font-size:9px'>","(runtime:", timeoutput, "sec )")
    } else if (is.na(input_correct) == FALSE) {
      paste("<i>", "<p style=color:yellow>", "Did you mean: ", input_correct, "</i>", "</p>", "Your next word: ",output, "</br>", "<p style='color:grey; font-size:9px'>","(runtime:", timeoutput, "sec )")
    }


  })
  
})

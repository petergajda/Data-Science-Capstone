################################################
######## Code for datasize manipulation ########
################################################


# clear all
rm(list = ls())

# libraries
library(stringr)
library(tidyverse)
library(dplyr)
library(data.table)
library(stringdist)

# Import of rds files
uni_words <- readRDS(file = "C:/Projekte/Projects/R/Coursera/Week 10/rds-preprocessed/uni_words.rds")
bi_words <- readRDS(file = "C:/Projekte/Projects/R/Coursera/Week 10/rds-preprocessed/bi_words.rds")
tri_words <- readRDS(file = "C:/Projekte/Projects/R/Coursera/Week 10/rds-preprocessed/tri_words.rds")
quad_words <- readRDS(file = "C:/Projekte/Projects/R/Coursera/Week 10/rds-preprocessed/quad_words.rds")



# Transformation of ngrams with only remaining top words per group
bi_words <- as.data.table(bi_words)[as.data.table(bi_words)[, .I[which.max(n)], by=word1]$V1]
leven_bi <- filter(bi_words, n > 1)

tri_words <- as.data.table(tri_words)[as.data.table(tri_words)[, .I[which.max(n)], by=c("word1", "word2")]$V1]
tri_words <- filter(tri_words, n > 1)
leven_tri <- filter(tri_words, n > 3)

quad_words <- as.data.table(quad_words)[as.data.table(quad_words)[, .I[which.max(n)], by=c("word1", "word2", "word3")]$V1]
quad_words <- filter(quad_words, n > 2)
leven_quad <- filter(quad_words, n > 10)


# save rds

saveRDS(uni_words, file = "C:/Projekte/Projects/R/Coursera/Week 10/rds-final/uni_words.rds")
saveRDS(bi_words, file = "C:/Projekte/Projects/R/Coursera/Week 10/rds-final/bi_words.rds")
saveRDS(tri_words, file = "C:/Projekte/Projects/R/Coursera/Week 10/rds-final/tri_words.rds")
saveRDS(quad_words, file = "C:/Projekte/Projects/R/Coursera/Week 10/rds-final/quad_words.rds")
saveRDS(leven_bi, file = "C:/Projekte/Projects/R/Coursera/Week 10/rds-final/leven_bi.rds")
saveRDS(leven_tri, file = "C:/Projekte/Projects/R/Coursera/Week 10/rds-final/leven_tri.rds")
saveRDS(leven_quad, file = "C:/Projekte/Projects/R/Coursera/Week 10/rds-final/leven_quad.rds")

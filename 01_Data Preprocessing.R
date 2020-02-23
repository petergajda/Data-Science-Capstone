# Data preprocessing for Data Science capstone
# for Milestone Report

rm(list = ls(all.names = TRUE)) 

# Loading libraries
library(dplyr)
library(tidytext)
library(tm)
library(ngram)
library(data.table)
library(tidyr)
library(treemap)
library(ggraph)
library(igraph)

# Creating mainpaths
mainpath  <- "C:/Projekte/Projects/R/Coursera/Week 10/data/"
blogstxt <- "en_US.blogs.txt"
newstxt  <- "en_US.news.txt"
twittertxt <- "en_US.twitter.txt"

# Reading in Data
twitter <- readLines(paste(mainpath, twittertxt, sep=""), warn=FALSE, encoding="UTF-8")
blogs <- readLines(paste(mainpath, blogstxt, sep=""), warn=FALSE, encoding="UTF-8")
news <- readLines(paste(mainpath, newstxt, sep=""), warn=FALSE, encoding="UTF-8")


# # Unique Words
# set.seed(202003)
# twitter100 <- tibble(line = 1:length(twitter), text = twitter) %>%
#   unnest_tokens(word, text)
#
# twitter_sample10 <- twitter[rbinom(twitter_lines, 1, 0.1) == 1]
# twitter_sample10 <- tibble(line = 1:length(twitter_sample10), text = twitter_sample10) %>%
#   unnest_tokens(word, text)
#
# twitter_sample30 <- twitter[rbinom(twitter_lines, 1, 0.3) == 1]
# twitter_sample30 <- tibble(line = 1:length(twitter_sample30), text = twitter_sample30) %>%
#   unnest_tokens(word, text)
#
# twitter_sample50 <- twitter[rbinom(twitter_lines, 1, 0.5) == 1]
# twitter_sample50 <- tibble(line = 1:length(twitter_sample50), text = twitter_sample50) %>%
#   unnest_tokens(word, text)
#
# twitter_sample70 <- twitter[rbinom(twitter_lines, 1, 0.7) == 1]
# twitter_sample70 <- tibble(line = 1:length(twitter_sample70), text = twitter_sample70) %>%
#   unnest_tokens(word, text)
#
# twitter_sample90 <- twitter[rbinom(twitter_lines, 1, 0.9) == 1]
# twitter_sample90 <- tibble(line = 1:length(twitter_sample90), text = twitter_sample90) %>%
#   unnest_tokens(word, text)
#
# blogs100 <- tibble(line = 1:length(blogs), text = blogs) %>%
#   unnest_tokens(word, text)
#
# blogs_sample10 <- blogs[rbinom(blogs_lines, 1, 0.1) == 1]
# blogs_sample10 <- tibble(line = 1:length(blogs_sample10), text = blogs_sample10) %>%
#   unnest_tokens(word, text)
#
# blogs_sample30 <- blogs[rbinom(blogs_lines, 1, 0.3) == 1]
# blogs_sample30 <- tibble(line = 1:length(blogs_sample30), text = blogs_sample30) %>%
#   unnest_tokens(word, text)
#
# blogs_sample50 <- blogs[rbinom(blogs_lines, 1, 0.5) == 1]
# blogs_sample50 <- tibble(line = 1:length(blogs_sample50), text = blogs_sample50) %>%
#   unnest_tokens(word, text)
#
# blogs_sample70 <- blogs[rbinom(blogs_lines, 1, 0.7) == 1]
# blogs_sample70 <- tibble(line = 1:length(blogs_sample70), text = blogs_sample70) %>%
#   unnest_tokens(word, text)
#
# blogs_sample90 <- blogs[rbinom(blogs_lines, 1, 0.9) == 1]
# blogs_sample90 <- tibble(line = 1:length(blogs_sample90), text = blogs_sample90) %>%
#   unnest_tokens(word, text)
#
# news100 <- tibble(line = 1:length(news), text = news) %>%
#   unnest_tokens(word, text)
#
# news_sample10 <- news[rbinom(news_lines, 1, 0.1) == 1]
# news_sample10 <- tibble(line = 1:length(news_sample10), text = news_sample10) %>%
#   unnest_tokens(word, text)
#
# news_sample30 <- news[rbinom(news_lines, 1, 0.3) == 1]
# news_sample30 <- tibble(line = 1:length(news_sample30), text = news_sample30) %>%
#   unnest_tokens(word, text)
#
# news_sample50 <- news[rbinom(news_lines, 1, 0.5) == 1]
# news_sample50 <- tibble(line = 1:length(news_sample50), text = news_sample50) %>%
#   unnest_tokens(word, text)
#
# news_sample70 <- news[rbinom(news_lines, 1, 0.7) == 1]
# news_sample70 <- tibble(line = 1:length(news_sample70), text = news_sample70) %>%
#   unnest_tokens(word, text)
#
# news_sample90 <- news[rbinom(news_lines, 1, 0.9) == 1]
# news_sample90 <- tibble(line = 1:length(news_sample90), text = news_sample90) %>%
#   unnest_tokens(word, text)
#
#
# t100 <- n_distinct(twitter100$word) / n_distinct(twitter100$word) * 100
# t90 <- n_distinct(twitter_sample90$word) / n_distinct(twitter100$word) * 100
# t70 <- n_distinct(twitter_sample70$word) / n_distinct(twitter100$word) * 100
# t50 <- n_distinct(twitter_sample50$word) / n_distinct(twitter100$word) * 100
# t30 <- n_distinct(twitter_sample30$word) / n_distinct(twitter100$word) * 100
# t10 <- n_distinct(twitter_sample10$word) / n_distinct(twitter100$word) * 100
#
# b100 <- n_distinct(blogs100$word) / n_distinct(blogs100$word) * 100
# b90 <- n_distinct(blogs_sample90$word) / n_distinct(blogs100$word) * 100
# b70 <- n_distinct(blogs_sample70$word) / n_distinct(blogs100$word) * 100
# b50 <- n_distinct(blogs_sample50$word) / n_distinct(blogs100$word) * 100
# b30 <- n_distinct(blogs_sample30$word) / n_distinct(blogs100$word) * 100
# b10 <- n_distinct(blogs_sample10$word) / n_distinct(blogs100$word) * 100
#
# n100 <- n_distinct(news100$word) / n_distinct(news100$word) * 100
# n90 <- n_distinct(news_sample90$word) / n_distinct(news100$word) * 100
# n70 <- n_distinct(news_sample70$word) / n_distinct(news100$word) * 100
# n50 <- n_distinct(news_sample50$word) / n_distinct(news100$word) * 100
# n30 <- n_distinct(news_sample30$word) / n_distinct(news100$word) * 100
# n10 <- n_distinct(news_sample10$word) / n_distinct(news100$word) * 100
#
#
# unique_words <- data.frame(File = c("blogs", "news", "twitter"),
#                               p100  = c(b100, n100, t100),
#                            p90 = c(b90, n90, t90),
#                            p70 = c(b70, n70, t70),
#                            p50 = c(b50, n50, t50),
#                            p30 = c(b30, n30, t30),
#                            p10 = c(b10, n10, t10))
#
# unique_words
#
# unique_words_combination <- combine(news_sample50$word, blogs_sample50$word, twitter_sample10$word)
# unique_words_100 <- combine(news100$word, blogs100$word, twitter100$word)
# n_distinct(unique_words_combination) / n_distinct(unique_words_100)
#
#
# #
#
# rm(twitter100,
# twitter_sample10,
# twitter_sample30,
# twitter_sample50,
# twitter_sample70,
# twitter_sample90,
# news100,
# news_sample10,
# news_sample30,
# news_sample50,
# news_sample70,
# news_sample90,
# blogs100,
# blogs_sample10,
# blogs_sample30,
# blogs_sample50,
# blogs_sample70,
# blogs_sample90,
# t100,
# t90,
# t70,
# t50,
# t30,
# t10,
# n100,
# n90,
# n70,
# n50,
# n30,
# n10,
# b100,
# b90,
# b70,
# b50,
# b30,
# b10,
# unique_words,
# unique_words_combination,
# unique_words_100)


# Creating overview of Input file
twitter_size <- file.info(paste(mainpath, twittertxt, sep=""))$size/1024/1024
twitter_lines <- as.numeric(summary(twitter)[1])
twitter_words <- wordcount(twitter)
twitter_characters <- sum(nchar(twitter))

blogs_size <- file.info(paste(mainpath, blogstxt, sep=""))$size/1024/1024
blogs_lines <- as.numeric(summary(blogs)[1])
blogs_words <- wordcount(blogs)
blogs_characters <- sum(nchar(blogs))

news_size <- file.info(paste(mainpath, newstxt, sep=""))$size/1024/1024
news_lines <- as.numeric(summary(news)[1])
news_words <- wordcount(news)
news_characters <- sum(nchar(news))


file_exploration <- data.frame(File = c("blogs", "news", "twitter"),
           Size_MB = c(blogs_size, news_size, twitter_size),
           Lines = c(blogs_lines, news_lines, twitter_lines),
           Words = c(blogs_words, news_words, twitter_words),
           Characters = c(blogs_characters, news_characters, twitter_characters),
           Words_per_Line = c(blogs_words/blogs_lines, news_words/news_lines, twitter_words/twitter_lines),
           Characters_per_Line = c(blogs_characters/blogs_lines, news_characters/news_lines, twitter_characters/twitter_lines)
           )


# Subsetting Data via coinflip with biased probability
set.seed(202003)
twitter_sample <- twitter[rbinom(twitter_lines, 1, 0.1) == 1]
blogs_sample <- blogs[rbinom(blogs_lines, 1, 0.1) == 1]
news_sample <- news[rbinom(news_lines, 1, 0.3) == 1]



# Removing unnecessary data files
rm(twitter)
rm(blogs)
rm(news)

rm(blogs_characters)
rm(blogs_lines)
rm(blogs_size)
rm(blogs_words)

rm(news_characters)
rm(news_lines)
rm(news_size)
rm(news_words)

rm(twitter_characters)
rm(twitter_lines)
rm(twitter_size)
rm(twitter_words)

# Creating overview of Sample file
twitter_size <- as.numeric(object.size(twitter_sample)/1024/1024)
twitter_lines <- as.numeric(summary(twitter_sample)[1])
twitter_words <- wordcount(twitter_sample)
twitter_characters <- sum(nchar(twitter_sample))

blogs_size <- as.numeric(object.size(blogs_sample)/1024/1024)
blogs_lines <- as.numeric(summary(blogs_sample)[1])
blogs_words <- wordcount(blogs_sample)
blogs_characters <- sum(nchar(blogs_sample))


news_size <- as.numeric(object.size(news_sample)/1024/1024)
news_lines <- as.numeric(summary(news_sample)[1])
news_words <- wordcount(news_sample)
news_characters <- sum(nchar(news_sample))


file_exploration_sample <- data.frame(File = c("blogs", "news", "twitter"),
                               Size_MB = c(blogs_size, news_size, twitter_size),
                               Lines = c(blogs_lines, news_lines, twitter_lines),
                               Words = c(blogs_words, news_words, twitter_words),
                               Characters = c(blogs_characters, news_characters, twitter_characters),
                               Words_per_Line = c(blogs_words/blogs_lines, news_words/news_lines, twitter_words/twitter_lines),
                               Characters_per_Line = c(blogs_characters/blogs_lines, news_characters/news_lines, twitter_characters/twitter_lines)
)



# Show date table of Input file overview and sample file overview
file_exploration
file_exploration_sample


# Creating treemaps for visualization
file_source <- c("Blogs","News","Twitter")
number_words <- c(file_exploration$Words)
number_words_sample <- c(file_exploration_sample$Words)
data_file <- data.frame(file_source, number_words)
data_sample <- data.frame(file_source, number_words_sample)


treemap(data_file,
        index="file_source",
        palette = "Set3",
        vSize="number_words",
        type="index"
)

treemap(data_sample,
        index="file_source",
        palette = "Set3",
        vSize="number_words_sample",
        type="index"
)



# Removing unnecessary objects

rm(blogs_characters)
rm(blogs_lines)
rm(blogs_size)
rm(blogs_words)

rm(news_characters)
rm(news_lines)
rm(news_size)
rm(news_words)

rm(twitter_characters)
rm(twitter_lines)
rm(twitter_size)
rm(twitter_words)

rm(mainpath)
rm(data_file)
rm(blogstxt)
rm(newstxt)
rm(twittertxt)


# Create one data file containing all data from twitter, blogs and news  !!!!!!
data_sample <- paste(twitter_sample, blogs_sample, news_sample)

# Remove unnecessary data at this point
rm(twitter_sample)
rm(blogs_sample)
rm(news_sample)


# Create a data_corpus for further manipulation of the data via tm-package
data_corpus <- VCorpus(VectorSource(data_sample))

# Remove unnecessary data at this point
rm(data_sample)

# Using generic filter and transformation operations via tm-package
# see: Text Mining Infrastructure in R, Journal of Statistical Science, Ingo Feinerer, Kurt Hornik, David Meyer / p. 19
# see: https://www.jstatsoft.org/article/view/v025i05
data_corpus <- tm_map(data_corpus, tolower)
data_corpus <- tm_map(data_corpus, removePunctuation)
data_corpus <- tm_map(data_corpus, removeNumbers)
data_corpus <- tm_map(data_corpus, stripWhitespace)
data_corpus <- tm_map(data_corpus, PlainTextDocument)


#  Transformation of datacorpus and creation of uni-, bi-, tri- and quadgram using the tidyr-package
# see: https://www.tidytextmining.com/ngrams.html

# transform tm data corpus into tidyr data corpus
corpus_td <- tidy(data_corpus) 

# Remove unnecessary data at this point
rm(data_corpus)

# Save corpus_td into rds
saveRDS(corpus_td, file = "C:/Projekte/Projects/R/Coursera/Week 10/RDS/corpus_td.rds")
corpus_td <- readRDS("C:/Projekte/Projects/R/Coursera/Week 10/RDS/corpus_td.rds")


# Creating ngrams via tidyr
corpus_unigrams <- corpus_td %>%
  unnest_tokens(word, text) %>%
  count(word, sort = TRUE) %>%
  mutate(share = n / sum(n))
saveRDS(corpus_unigrams, file = "C:/Projekte/Projects/R/Coursera/Week 10/RDS/corpus_unigrams.rds")


corpus_bigrams <- corpus_td %>%
  unnest_tokens(word, text, token = "ngrams", n=2) %>%
  count(word, sort = TRUE) %>%
  mutate(share = n / sum(n))
saveRDS(corpus_bigrams, file = "C:/Projekte/Projects/R/Coursera/Week 10/RDS/corpus_bigrams.rds")


corpus_trigrams <- corpus_td %>%
  unnest_tokens(word, text, token = "ngrams", n=3) %>%
  count(word, sort = TRUE) %>%
  mutate(share = n / sum(n))
saveRDS(corpus_trigrams, file = "C:/Projekte/Projects/R/Coursera/Week 10/RDS/corpus_trigrams.rds")


corpus_quadgrams <- corpus_td %>%
  unnest_tokens(word, text, token = "ngrams", n=4) %>%
  count(word, sort = TRUE) %>%
  mutate(share = n / sum(n))
saveRDS(corpus_quadgrams, file = "C:/Projekte/Projects/R/Coursera/Week 10/RDS/corpus_quadgrams.rds")


# Plots showing the most frequent ngrams

unigram_plot <- ggplot(data = slice(corpus_unigrams, 1:20), aes(x = reorder(word, n), y = n)) +
  geom_bar(stat="identity", fill="darkblue") +
  theme_minimal() +
  coord_flip() +
  labs(x = "unigram", y = "count", title = "Number of Top 20 unigrams")

bigram_plot <- ggplot(data = slice(corpus_bigrams, 1:20), aes(x = reorder(word, n), y = n)) +
  geom_bar(stat="identity", fill="darkblue") +
  theme_minimal() +
  coord_flip() +
  labs(x = "bigram", y = "count", title = "Number of Top 20 bigrams")

trigram_plot <- ggplot(data = slice(corpus_trigrams, 1:20), aes(x = reorder(word, n), y = n)) +
  geom_bar(stat="identity", fill="darkblue") +
  theme_minimal() +
  coord_flip() +
  labs(x = "trigram", y = "count", title = "Number of Top 20 trigrams")

quadgram_plot <- ggplot(data = slice(corpus_quadgrams, 1:20), aes(x = reorder(word, n), y = n)) +
  geom_bar(stat="identity", fill="darkblue") +
  theme_minimal() +
  coord_flip() +
  labs(x = "quadgram", y = "count", title = "Number of Top 20 quadgrams")



# Separating words in ngrams via tidyr

uni_words <- corpus_unigrams

bi_words <- corpus_bigrams %>%
  separate(word, c("word1", "word2"), sep = " ")

tri_words <- corpus_trigrams %>%
  separate(word, c("word1", "word2", "word3"), sep = " ")

quad_words <- corpus_quadgrams %>%
  separate(word, c("word1", "word2", "word3", "word4"), sep = " ")


# Visualizing a network of the most common ngrams
# see: https://www.tidytextmining.com/ngrams.html

bigram_graph <- subset(bi_words, bi_words[, 3] > 3000) %>%
  graph_from_data_frame()

set.seed(202003)
a <- grid::arrow(type = "closed", length = unit(.05, "inches"))
ggraph(bigram_graph, layout = "fr") +
  geom_edge_link(aes(edge_alpha = n), show.legend = FALSE,
                 arrow = a, end_cap = circle(.07, 'inches')) +
  geom_node_point(color = "darkblue", size = 1) +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1)
  theme_void()



trigram_graph <- subset(tri_words, tri_words[, 4] > 500) %>%
  graph_from_data_frame()
  
set.seed(202003)
a <- grid::arrow(type = "closed", length = unit(.05, "inches"))
ggraph(trigram_graph, layout = "fr") +
  geom_edge_link(aes(edge_alpha = n), show.legend = FALSE,
                 arrow = a, end_cap = circle(.07, 'inches')) +
  geom_node_point(color = "darkblue", size = 1) +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1)
  theme_void()
  
  
quadgram_graph <- subset(quad_words, quad_words[, 5] > 100) %>%
  graph_from_data_frame()
  
set.seed(202003)
a <- grid::arrow(type = "closed", length = unit(.05, "inches"))
ggraph(quadgram_graph, layout = "fr") +
  geom_edge_link(aes(edge_alpha = n), show.legend = FALSE,
                 arrow = a, end_cap = circle(.07, 'inches')) +
  geom_node_point(color = "darkblue", size = 1) +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1)
  theme_void()


# remove unnecessary files at this point
rm(a)
rm(unigram_plot)
rm(bigram_graph)
rm(bigram_plot)
rm(trigram_graph)
rm(trigram_plot)
rm(quadgram_graph)
rm(quadgram_plot)
rm(file_exploration)
rm(file_exploration_sample)
rm(corpus_td)


# remove unnecessary files at this point
rm(uni_words)
rm(bi_words)
rm(tri_words)
rm(quad_words)
rm(corpus_unigrams)
rm(corpus_bigrams)
rm(corpus_trigrams)
rm(corpus_quadgrams)



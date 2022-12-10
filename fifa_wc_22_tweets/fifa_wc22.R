library(tidyverse)

if(!require(pacman))install.packages("pacman")

pacman::p_load('dplyr', 'tidyr', 'gapminder',
               'ggplot2',  'ggalt',
               'forcats', 'R.utils', 'png', 
               'grid', 'ggpubr', 'scales',
               'bbplot')

# Using the BBC R theme https://bbc.github.io/rcookbook/
devtools::install_github('bbc/bbplot')

# source https://www.kaggle.com/datasets/tirendazacademy/fifa-world-cup-2022-tweets
# variables: X, Date.Created, Number.of.Likes, Sentiment, Source.of.Tweet, Tweet
tweets <- read.csv("fifa_world_cup_2022_tweets.csv", header = TRUE)

# Question:
#   What is the ratio of likes for positive tweets vs negative tweets
sentiment_frame <- tweets %>% 
  group_by(Sentiment) %>% 
  mutate(Sentiment = str_to_title(Sentiment)) %>% 
  summarise(Total = sum(Number.of.Likes), .groups = "drop")

sentiment_img <- ggplot(sentiment_frame, aes(x = Sentiment, y = Total)) + 
  geom_bar(stat = "identity", position="identity", fill = "#1380A1") + 
  scale_y_continuous(labels = scales::comma) +
  bbc_style() +
  labs(title = "Sentiment to Likes", subtitle = "Summary of how many likes grouped by Tweet sentiment")

finalise_plot(plot_name = sentiment_img,
              source_name = "https://www.kaggle.com/datasets/tirendazacademy/fifa-world-cup-2022-tweets",
              save_filepath = "fifa_wc22_sentiment.png",
              width_pixels = 600,
              height_pixels = 400)
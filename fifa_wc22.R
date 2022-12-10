library(tidyverse)

# source https://www.kaggle.com/datasets/tirendazacademy/fifa-world-cup-2022-tweets
# variables: X, Date.Created, Number.of.Likes, Sentiment, Source.of.Tweet, Tweet
tweets <- read.csv("datasets/fifa_world_cup_2022_tweets.csv", header = TRUE)

# Question:
#   What is the ratio of likes for positive tweets vs negative tweets
sentiment_frame <- tweets %>% 
  group_by(Sentiment) %>% 
  summarise(Total = sum(Number.of.Likes), .groups = "drop")

?scale_y_continuous
sentiment_img <- ggplot(sentiment_frame, aes(x = Sentiment, y = Total)) + 
  geom_bar(stat = "identity") + 
  scale_y_continuous(labels = scales::comma) +
  theme_classic()

sentiment_img

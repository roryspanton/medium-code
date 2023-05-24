## Actions and calculations

rm(list = ls())

library(tidyverse)

# Example of code block

read_csv("sales_data.csv") %>%
  select(date, transaction_id, category, item_price) %>%
  filter(date == "2023-05-10") %>%
  group_by(category) %>%
  summarise(day_turnover = sum(item_price)) %>%
  write_csv("sales_summaries/day_turnover_2023-05-10.csv")

calculate_turnover <- function(sales_data, day) {
  sales_data %>%
    select(date, transaction_id, category, item_price) %>%
    filter(date == day) %>%
    group_by(category) %>%
    summarise(day_turnover = sum(item_price))
}

action_turnover <- function(day) {
  read_csv("sales_data.csv") %>%
    calculate_turnover(day) %>%
    write_csv(paste0("sales_summarise/day_turnover_", day, ".csv"))
}
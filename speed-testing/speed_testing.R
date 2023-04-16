# Speed testing and profiling code

rm(list=ls())

library(tidyverse)
library(tictoc)

# Example 1: tictoc --------


tic()

tech_stocks <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-07/big_tech_stock_prices.csv")

toc()

# Example 2: profvis -------

# Filter tech stocks to only include FAANG prices from last year, calculate daily pct gain
stock_pct_gain <- tech_stocks %>%
  filter(stock_symbol %in% c("META", "AAPL", "AMZN", "NFLX", "GOOGL") & date > "2022-03-18") %>%
  mutate(gainloss = (close - open)/open)

# Get the mean daily gain/loss percentage for FAANG stocks
stock_pct_gain %>%
  group_by(stock_symbol) %>%
  summarise(mean(gainloss))

# Plot closing prices of FAANG stocks
stock_pct_gain %>%
  ggplot(aes(y = close, x = date, colour = stock_symbol)) +
  geom_line() +
  labs(x = "Date", y = "Closing Price") +
  scale_x_date(date_breaks = "2 months") +
  scale_y_continuous(breaks = seq(100, 400, 50)) +
  theme_classic()


# Example 3: microbenchmark -------

# Define stocks of interest (to avoid repetition)
big_tech <- c("META", "AAPL", "AMZN", "NFLX", "GOOGL")

# Option 1: dplyr::filter
dplyr::filter(tech_stocks, stock_symbol %in% big_tech & date > "2022-03-18")

# Option 2: base::subset
base::subset(tech_stocks, stock_symbol %in% big_tech & date > "2022-03-18")

# Option 3: base indexing
tech_stocks[(tech_stocks$stock_symbol %in% big_tech & tech_stocks$date > "2022-03-18"),]

# Option 4: data.table filtering
tech_stocks_dt <- data.table::as.data.table(tech_stocks)
tech_stocks_dt[stock_symbol %in% big_tech & date > "2022-03-18",]

# Storing each as inside a list
expressions <- list()

expressions[[1]] <- substitute(dplyr::filter(tech_stocks, stock_symbol %in% big_tech & date > "2022-03-18"))
expressions[[2]] <- substitute(base::subset(tech_stocks, stock_symbol %in% big_tech & date > "2022-03-18"))
expressions[[3]] <- substitute(tech_stocks[(tech_stocks$stock_symbol %in% big_tech & tech_stocks$date > "2022-03-18"),])
expressions[[4]] <- substitute(tech_stocks_dt[stock_symbol %in% big_tech & date > "2022-03-18",])

names(expressions) <- c("dplyr::filter", "base::subset", "base indexing", "data.table filtering")

# Microbenchmarking each option
library(microbenchmark)

microbenchmark(list = expressions, times = 200)

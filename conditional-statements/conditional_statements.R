## Conditional statements

rm(list=ls())

library(tidyverse)

set.seed(123)

# Basic if else statements ---------

# Basic if statement
age <- 25

if (age >= 18) {
  age_group <- "adult"
}

# Basic if else statement
if (age >= 18) {
  age_group <- "adult"
} else {
  age_group <- "child"
}

# Inline conditional statements ---------

# Inline if else keywords
age_group <- if (age >= 18) "adult" else "child"

# ifelse function
age_group <- ifelse(age >= 18, "adult", "child")

# Running the above again with a vector of values
age <- c(16, 45, 23, 82)

age_group <- ifelse(age >= 18, "adult", "child")
# Returns "child" "adult" "adult" "adult"

# Conditional subsetting ---------

# Make some data
user_data <- tibble(
  user_id = 1:10,
  age = floor(runif(10, min = 13, max = 35)),
  region = sample(c("UK", "USA", "EU"), 10, replace = TRUE)
)

# Pulling the user ids of users that are under 18
user_data$user_id[user_data$age < 18]

# Replacing the UK region entries with EU coding
user_data$region[user_data$region == "UK"] <- "EU"

# Filtering only USA rows
user_data[user_data$region == "USA",]

# case_when ----------

# Create new column that codes for legal drinking age
user_data %>%
  mutate(drinking_age = case_when(region == "USA" & age >= 21 ~ TRUE,
                                  region == "EU" & age >= 18 ~ TRUE,
                                  .default = FALSE))

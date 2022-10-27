library(tidyverse)

# This formula reverses interval scales of any interval, with positive or negative values. Amazing!
x <- 1:7
min(x) - x + max(x)

# Define the scale
myscale <- 1:7

# Generate some simple data
survey_data <- tibble(
  participant = 1:7,
  worried_thoughts = sample(myscale, 7),
  anxiety_effects = sample(myscale, 7)
)

# Reversing values in a single column -----
# The tidyverse way
survey_data <- survey_data %>%
  mutate(anxiety_effects_reversed = min(myscale) - anxiety_effects + max(myscale))

# The base R way
survey_data$anxiety_effects_reversed <- min(myscale) - survey_data$anxiety_effects + max(myscale)


# Selectively reversing multiple questions -----
# Generate more data
full_survey_data <- tibble(
  question = unlist(map(1:5, ~ rep(paste0("Question", .), 5))),
  participant = rep(1:5, 5),
  response = sample(myscale, 25, replace = T)
)

# Define vector of question names that you want to reverse
reverse_questions <- c("Question2", "Question3")

# Recode long format data
full_survey_reversed <- full_survey_data %>%
  mutate(response = case_when(question %in% reverse_questions ~ min(myscale) - response + max(myscale),
                              TRUE ~ as.integer(response)))

# Sum up each participant's survey score
full_survey_reversed %>%
  group_by(participant) %>%
  summarise(total_score = sum(response))

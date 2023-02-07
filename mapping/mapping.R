
library(tidyverse)

# Set seed for reproducibility
set.seed(1234)

# map --------

# Generate list of numeric values for this example
values_list <- list(rnorm(100, 100, 15), 
                    rnorm(100, 110, 20), 
                    rnorm(100, 75, 15))

# Use map to get the mean of each set of numbers
map(values_list, mean)

# Add some missing values to the second element of the list
values_list[[2]][c(2, 24, 93)] <- NA

# Get the means with map again, this time discounting NAs
map(values_list, ~ mean(., na.rm = T))

# Expressing the operation above as a loop
for (i in values_list) {
  print(mean(i, na.rm = TRUE))
}


# map2 -------

x <- c("mpg", "hp", "wt")
y <- c("hp", "wt", "mpg")

map2(x, y, ~ lm(get(.x) ~ get(.y), data = mtcars))

# pmap -------

baseline <- c(101, 92.3, 98.2)
treatment <- c(103.3, 92.1, 99.8)
followup <- c(112.1, 95.4, 104.2)

pmap(list(baseline, treatment, followup), ~ c(..1, ..2, ..3))

# map control variants -------

map_dbl(values_list, ~ mean(., na.rm = TRUE))

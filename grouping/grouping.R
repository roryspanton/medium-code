
library(tidyverse)
library(palmerpenguins)

# Grouping basics -----

# The palmer penguins dataset
penguins

# Grouping by species
penguins_species <- penguins %>%
  group_by(species)

penguins_species

# Getting the grouping structure with group_keys
group_keys(penguins_species)

# Getting the mean body mass for each group
penguins_species %>%
  summarise(mean_body_mass = mean(body_mass_g, na.rm = TRUE))

# Grouping by more than one variable
penguins %>%
  filter(!is.na(sex)) %>%
  group_by(species, sex) %>%
  summarise(mean_body_mass = mean(body_mass_g, na.rm = TRUE))

# Creating variables within group_by -----

# The long-form way of creating a grouping variable...
penguins %>%
  mutate(StudyName = penguins_raw$studyName) %>%
  group_by(StudyName) %>%
  summarise(mean_body_mass = mean(body_mass_g, na.rm = TRUE))

# ...and the shorter way, which still does the same thing
penguins %>%
  group_by(StudyName = penguins_raw$studyName) %>%
  summarise(mean_body_mass = mean(body_mass_g, na.rm = TRUE))

# Grouping temporarily using with_groups -----

heavy_penguins <- penguins %>%
  group_by(species) %>%
  slice_max(body_mass_g, n = 3, with_ties = F) %>%
  ungroup()

group_keys(heavy_penguins)

heavy_penguins_temp <- penguins %>%
  with_groups(.groups = species, ~ slice_max(., body_mass_g, n = 3, with_ties = F))

group_keys(heavy_penguins_temp)
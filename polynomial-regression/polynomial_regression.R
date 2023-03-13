# Polynomial regression

library(tidyverse)

set.seed(8032023)

# Generate some data
example_data <- tibble(
  X = rnorm(100, 5, 2),
  error = rnorm(100, 0, 1)
) %>%
  mutate(Y = -5 + (4.1*X) - (0.33*X^2) + error) %>%
  filter(Y > -5)

# Graphing the data and model fits
example_data %>%
  ggplot(aes(X, Y)) +
  geom_point(color = "#003eaa", size = 2) +
  theme_classic() +
  theme(axis.title = element_text(size = 15))

example_data %>%
  ggplot(aes(X, Y)) +
  geom_point(color = "#003eaa", size = 2) +
  theme_classic() +
  theme(axis.title = element_text(size = 15)) +
  geom_smooth(method = "lm", se = F, color = "#AB2611") 

example_data %>%
  ggplot(aes(X, Y)) +
  geom_point(color = "#003eaa", size = 2) +
  theme_classic() +
  theme(axis.title = element_text(size = 15)) +
  geom_smooth(method = "lm", se = F, color = "#AB2611") +
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), se = F, color = "#003eaa")

# Fitting and evaluating the models the frequentist way -------
# The simple linear model
model1 <- lm(Y ~ X, data = example_data)
summary(model1)

# Testing the addition of a quadratic polynomial component
model2 <- lm(Y ~ poly(X, 2), data = example_data)
summary(model2)

anova(model1, model2)

# Testing the addition of a cubic component
model3 <- lm(Y ~ poly(X, 3), data = example_data)
summary(model3)

anova(model2, model3)

# Fitting and evaluating models the Bayesian way -------

library(BayesFactor)

# The following code throws an error
# lmBF(outcome ~ poly(predictor, 2), data = example_data)

# Instead, we can use this equivalent phrasing
example_data$X_poly2 <- poly(example_data$X, 2)[,"2"]

BF_poly2 <- lmBF(Y ~ X + X_poly2, data = as.data.frame(example_data))

BF_poly2

# Testing improvement from simpler model
BF_simple <- lmBF(Y ~ X, data = as.data.frame(example_data))

BF_poly2 / BF_simple



### Binomial probability simulation

rm(list=ls())

library(tidyverse)

## A simple example
journeysim <- function(nturns, p) {
  simturns <- rbinom(nturns, 1, p)
  ifelse(any(simturns == 1), return(1), return(0))
}

allsims <- map_dbl(1:100000, ~ journeysim(10, 0.05))

print(sum(allsims == 1) / length(allsims))


## A more advanced example
long_journeysim <- function(journeylengths) {
  simturns <- map_dbl(journeylengths, ~ journeysim(.x, 0.05))
  ifelse(sum(simturns == 1) == 2, return(1), return(0))
}

allsims <- map_dbl(1:100000, ~ long_journeysim(c(10, 10, 10, 10)))

print(sum(allsims == 1) / length(allsims))

## Working out the advanced solution mathematically
vprob <- 1 - (1 - 0.05)^10
comb4_2 <- factorial(4)/(factorial(2)*factorial(4-2))
print(comb4_2*vprob^2*(1-vprob)^2)

## A problem that more or less necessitates simulation
adv_journeysim <- function(journeylengths) {
  simturns <- map_dbl(journeylengths, ~ journeysim(.x, 0.01))
  ifelse(sum(simturns == 1) %in% c(1, 2, 3), return(1), return(0))
}

allsims <- map_dbl(1:100000, ~ adv_journeysim(c(112, 73, 187, 144)))

print(sum(allsims == 1) / length(allsims))

## Working out even more advanced solution mathematically
vprobs <- 1 - (1 - 0.01)^c(112, 73, 187, 144)
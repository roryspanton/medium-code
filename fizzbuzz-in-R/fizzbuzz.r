## Fizzbuzz in R

rm(list=ls())

# For input 1:50, print fizz, buzz, or fizzbuzz

## Method 1: naive for loop -----------------------

fbnums <- 1:50
output <- vector()

for (i in fbnums) {
  if (i %% 3 == 0 && i %% 5 == 0) {
    output[i] <- "FizzBuzz"
  } else if (i %% 3 == 0) {
    output[i] <- "Fizz"
  } else if (i %% 5 == 0) {
    output[i] <- "Buzz"
  } else {
    output[i] <- i
  }
}

print(output)

## Method 2: efficient for loop -----------

fbnums <- 1:50
output <- vector()

for (i in fbnums) {
  output[i] <- ""
  
  if (i %% 3 == 0) {output[i] <- paste0(output[i], "Fizz")}
  if (i %% 5 == 0) {output[i] <- paste0(output[i], "Buzz")}
  if (output[i] == "") {output[i] <- i}
}

print(output)

## Method 3: fizzbuzzR function -------------

library(fizzbuzzR)

fizzbuzz(start = 1, end = 50, step = 1, mod1 = 3, mod2 = 5)

## Method 4: case_when ----------------------

library(tidyverse)

fbnums <- 1:50

output <- case_when(fbnums %% 15 == 0 ~ "FizzBuzz",
          fbnums %% 3 == 0 ~ "Fizz",
          fbnums %% 5 == 0 ~ "Buzz",
          TRUE ~ as.character(fbnums))

print(output)

## Method 5: map ---------------------------

fbnums <- 1:50

fbmap <- function(input, mod1, mod2, exp1, exp2) {
  output <- ""
  
  if (input %% mod1 == 0) {output <- paste0(output, exp1)}
  if (input %% mod2 == 0) {output <- paste0(output, exp2)}
  if (output == "") {output <- as.character(input)}
  
  return(output)
}

output <- map_chr(fbnums, ~ fbmap(.x, 3, 5, "Fizz", "Buzz"))

print(output)
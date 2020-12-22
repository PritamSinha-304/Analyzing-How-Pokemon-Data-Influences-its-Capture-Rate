#### Preamble ####
# Purpose: Prepare and clean the pokemon data downloaded from https://www.kaggle.com/rounakbanik/pokemon
# Author: Pritam Sinha
# Data: 21 December 2020
# Contact: pritam.sinha@mail.utoronto.ca
# License: MIT


#### Work space setup ####

library(haven)
library(tidyverse)
library(dplyr)
library(janitor)
library(backports)

# Read in the raw data.

setwd("~/Desktop/STA304/Final Project")

raw_data <- read.csv("pokemon.csv")

# Selecting variables of interest

reduced_data <-
  raw_data %>%
  select(pokedex_number,
         capture_rate,
         type1, 
         type2,
         hp,
         attack,
         defense,
         sp_attack,
         sp_defense,
         speed,
         height_m,
         weight_kg,
         generation,
         is_legendary)

# Renaming variables 

reduced_data <- reduced_data %>% clean_names() %>% 
  
  rename(health_points = hp,
         special_attack = sp_attack,
         special_defence = sp_defense,
         location = generation,
         height = height_m,
         weight = weight_kg)

# Making the location variable show its region name 

reduced_data <- reduced_data %>% 
  mutate(location = case_when(
    location == 1 ~ "Kanto",
    location == 2 ~ "Johto",
    location == 3 ~ "Hoenn",
    location == 4 ~ "Sinnoh",
    location== 5 ~ "Unova",
    location == 6 ~ "Kalos",
    location == 7 ~ "Alola"
    )) 

# Making the capture_rate variable to have integers

reduced_data <- transform(reduced_data, capture_rate = as.numeric(capture_rate))

# Omitting NA values due to unavailable data

pokemon_data <- na.omit(reduced_data)


#### Saving the reduced and cleaned pokemon data as a csv file ####

write_csv(pokemon_data, "pokemon data.csv")



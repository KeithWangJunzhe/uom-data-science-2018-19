# Introduction to data science with applications in R and git
# University of Manchester 
# Tutorial led by Tom Franklin, 06/02/2019

####
# Tutorial 1 Code ----
# 1. Install and load libraries
# 2. Load data 
# 3. Data manipulation with dplyr
# 4. Data summarisation 
# 5. Graphics with ggplot2 

####
# 1. Install and load libraries ----

# Installing R packages
install.packages("tidyverse")

# Loading R packages
library("tidyverse")

# Tasks: 
# How would I install the skimr package? 
# How would I load the skimr package? 
# Do the same for following packages:
# `skimr`, `RColorBrewer` and `ggthemes` 

####
# 2. Load data ----
raw_data <- readr::read_csv("data/passenger_data.csv")

# This is equivilant but we don't use this! 
readr::read_csv("data/passenger_data.csv") -> raw_data 

# Quick glance at the data
# Install skimr
install.packages("skimr")
library(skimr)

skimr::skim(raw_data)

####
# 3. Data manipulation with dplyr ----

# In words, can you explain what %>% stands for? 

# Selecting columns 

raw_data %>%
  dplyr::select()

# Task:

# i. Select Age and Sex columns only 
SelectData1 <- raw_data %>%
  dplyr::select(Age, Sex)

# ii. Select all data apart from the Survived column
SelectData2 <- raw_data %>%
  dplyr::select(-Survived)

# iii. Select the first three variables using numeric 
Selected_Data3 <- raw_data %>%
  dplyr::select(1:3)

# Filtering data

# i. Filter data to keep only those where Pclass (passenger class) is equal to 1
filtered_data1 <- raw_data %>%
  dplyr::filter(Pclass == 3)
  
# 11. Filter the data to keep only data where there's first 
#     class passengers and passengers are aged over 50
filtered_data2 <- raw_data %>%
  dplyr::filter(Pclass == 1 & Age > 50)

# iii. Filter data to keep only 2nd and 3rd Class passengers 
filtered_data3 <- raw_data %>%
  dplyr::filter(Pclass == 3 | Pclass ==2)
# iv. Filter data for only those who Embarked n the journey from Cherbourg
filtered_data3 <- raw_data %>%
  dplyr::filter(Embarked == "C")
# Renaming data

# i. Rename the Sex column to be Gender, 

# tip: rename(new_column_name = old_column_name)
renamed_data1 <- raw_data %>%
  dplyr::rename(Gender = Sex)
# Arranging data

# i. Arrange the dataframe from low to high 
arranged_data1 <- raw_data %>%
  dplyr::arrange(Age)
# ii. Arrange Fare data from high to low
arranged_data2 <- raw_data %>%
  dplyr::arrange(desc(Fare))
# Make new variablea (mutate)

# i. Create a new variable called fare_in_dollars, multiplying the fare by a conversion rate of 1.37
american_data <- raw_data %>%
  dplyr::mutate(fare_in_dollars = Fare * 1.37)
# ii. Create an estimate of a passengers birth year by using their Age information!
DOB_estimation <- raw_data %>%
  dplyr::mutate(DOB_estimation = round(1912 - Age)) %>%
  arrange(DOB_estimation)
# iii. Create a flag to indicate those who have an above average age (29.70)
raw_data %>%
  dplyr::group_by(Pclass) %>%
  dplyr::summarise(average_age = mean(Age, na.rm = TRUE))

raw_data %>%
  dplyr::group_by(Sex) %>%
  dplyr::summarise(average_age = mean(Age, na.rm = TRUE))

raw_data %>%
  dplyr::group_by(Sex) %>%
  dplyr::summarise(average_fare = mean(Fare, na.rm = TRUE))

raw_data %>%
  dplyr::group_by(Sex, Pclass) %>%
  dplyr::summarise(average_fare = mean(Fare, na.rm = TRUE))
#Flags
Data_with_flag <- raw_data %>%
  dplyr::mutate(above_average_age = ifelse(age>29.7,1,0))

# Summary statistics - refer to the booklet for tasks! 

# Recoding data 

# i. Recode the integer values of passenger classes to be "1st Class", "2nd Class" etc...

# Distinct data

# i. Get a distinct list of the Cabin names on the titanic 

# Advanced exercises 


####
# 4. Data summarisation (using base R syntax)

# Summary stats of passenger Sex
table(raw_data$Sex)

# Cross tabulation of passenger Sex and whether they Survived or not

# Proportion tables...

# Column sum table 

# Row sum table 

# 3 way cross tab breakdown by Passenger class, Sex and Survival status 

####
# 5. Graphics with ggplot2 ----

# Make your first ggplot2 bar chart! 
ggplot(data = raw_data, aes(x = Pclass)) + geom_bar() 

# Make a filled bar chart 
ggplot(raw_data, aes(x = Pclass, fill = Sex)) + geom_bar(position = "fill")
# Make a ggplot2 with a theme
ggplot(raw_data, aes(x = Pclass, fill = Sex)) + geom_bar(position = "fill") + 
  theme_minimal() +
  labs(title = "Men outnumbered women across all passenger class",
       subtitle = "On the titanic disaster",
       x = "Passenger class",
       y = "Proportion of Male/female",
       caption = "Source: National archives")

# Make a scatterplot
ggplot(data = raw_data, aes(
  x = Age,
  y = Fare,
  colour = as.factor(Pclass)
)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_minimal()+
  scale_color_manual(values = c ("red","blue", "orange"))

# Make an interactive scatterplot 
# - Note that you'll need the `ploty` package to do this!



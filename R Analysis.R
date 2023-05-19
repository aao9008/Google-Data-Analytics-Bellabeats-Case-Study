# Install packages and load them

install.packages("tidyverse")
install.packages("here")
install.packages("skimr")
install.packages("janitor")
install.packages("dplyr")
install.packages("sjmisc")

library("here")
library("skimr")
library("janitor")
library("dplyr")
library("tidyverse")
library("sjmisc")
library("lubridate")

# Import Datasets

# get file names from directory
setwd("/cloud/project")

files <- list.files(path = "./Fitabase Data 4.12.16-5.12.16")
print(files)
# Split to save names; name for data frame will be first element

names <- strsplit(files, "\\.")

# now get the files

# Change directory to dataset directory in order to open and read files 

setwd("/cloud/project/Fitabase Data 4.12.16-5.12.16")

for (i in 1:length(files)) { # for each file in the list named files
    
  fileName <- files[i] # save file name of element i
  
  dataName <- names[[i]][[1]] # save data name of element i

  tempData <- read.csv(fileName) # read csv file
  
  assign (dataName, tempData, envir=.GlobalEnv) # assign the results of the file to the data named
}

setwd(here()) # Change back to root directory

# View data frames for null values, commonalities, and any anomalies.

# dailyActivity
head(dailyActivity_merged)

colnames(dailyActivity_merged)

glimpse(dailyActivity_merged)

# dailyCalories
head(dailyCalories_merged)

colnames(dailyCalories_merged)

glimpse(dailyCalories_merged)

# dailyIntensities
head(dailyIntensities_merged)

colnames(dailyIntensities_merged)

glimpse(dailyIntensities_merged)

# dailySteps
head(dailySteps_merged)

colnames(dailySteps_merged)

glimpse(dailySteps_merged)

# heartrate_seconds
head(heartrate_seconds_merged)

colnames(heartrate_seconds_merged)

glimpse(heartrate_seconds_merged)

# minuteMets
head(minuteMETsNarrow_merged)

colnames(minuteMETsNarrow_merged)

glimpse(minuteMETsNarrow_merged)

# sleepDay Log
head(sleepDay_merged)

colnames(sleepDay_merged)

glimpse(sleepDay_merged)

# weightLogs
head(weightLogInfo_merged)

colnames(weightLogInfo_merged)

glimpse(weightLogInfo_merged)

# Use SQL to determine if dailyActivites contains data from other daily data frame sets. 
install.packages("sqldf")

library(sqldf)

# Create new temporary data frame with dailyCalories info from dailyActivity data frame
dailyActivity2 <- dailyActivity_merged %>%
  select(Id, ActivityDate, Calories)

# Check that data frame structure is correct
head(dailyActivity2)

# Compare to dailiyCalories data frame using SQL intersect query
sql_check <- sqldf('SELECT * FROM dailyActivity2 INTERSECT SELECT * FROM dailyCalories_merged')

# Check structure of data frame that results for sql_check
head(sql_check)

# If number of observations in sql_check == number of observation in dailyCaloires, then dailyActivites data frame contains all of dailyCalories data
nrow(sql_check)
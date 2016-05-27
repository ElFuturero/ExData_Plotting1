# Exploratory Data Analysis Project 1
# Student: Hector E. Meza Delgado
# May 2016

# Plot 2

# First we load up the dplyr libray in order to best use data frames

library(dplyr)

# Now we want to create a data directory if one hasn't been created

if(!file.exists("data")){
  dir.create("data")
}

# Now we want to download and decompress the data if we haven't done so

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileDest <- "./data/hhpower.zip"

if (!file.exists(fileDest)){
  download.file(fileURL, fileDest, method = "curl")
  # Now let's unzip the file contents
  unzip(fileDest, exdir = "./data" )
}

# Now we will read the household_power_consumption.txt file and load it up into a dataframe.
# We'll use piping and the dplyr library in order to read only the rows corresponding to the
# dates that we want.

# we know from preliminary exploration of the file that it is separated by semi-colons so
# we'll use the read.csv2 function

globalActive <- read.csv2("./data/household_power_consumption.txt", stringsAsFactors = FALSE) %>%
  tbl_df %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  select(Global_active_power, Date)  %>%  # we use select to get only the column we want for this plot
  mutate(Global_active_power = as.numeric(Global_active_power))

# Now let's graph. First let's set the device that we want

# png("plot1.png", width = 480, height = 480)
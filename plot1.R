# Exploratory Data Analysis Project 1
# Student: Hector E. Meza Delgado
# May 2016

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

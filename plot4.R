# Exploratory Data Analysis Project 1
# Student: Hector E. Meza Delgado
# May 2016

# Plot 3

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

hhpower <- read.csv2("./data/household_power_consumption.txt", stringsAsFactors = FALSE) %>%
  tbl_df %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>% # we get the dates we want
  mutate(Voltage = as.numeric(Voltage)) %>%  # we transform the variables into numeric
  mutate(Global_active_power = as.numeric(Global_active_power)) %>%
  mutate(Global_reactive_power = as.numeric(Global_reactive_power)) %>%
  mutate(Sub_metering_1 = as.numeric(Sub_metering_1)) %>%
  mutate(Sub_metering_2 = as.numeric(Sub_metering_2)) %>%
  mutate(Sub_metering_3 = as.numeric(Sub_metering_3)) %>%
  mutate(datetime = paste(Date, Time, sep = " ")) %>%
  mutate(datetime = as.POSIXct(strptime(datetime, "%d/%m/%Y %H:%M:%S")))


# Now let's graph. First let's set the device that we want

png("plot4.png", width = 480, height = 480)

# Now let's set our layout with mfcol

par(
  mfcol = c(2,2)
)

# Now let's create our first plot.

plot(
  hhpower$datetime,
  hhpower$Global_active_power,
  type = "l",
  col = "black",
  ylab = "Global Active Power",
  xlab = ""
)

# Now our second plot

# Here's the one for the first sub meter

plot(
  hhpower$datetime,
  hhpower$Sub_metering_1,
  type = "l",
  xlab ="",
  ylab ="Energy sub metering"
  )

# Now let's do the second sub-meter

lines(
  hhpower$datetime,
  hhpower$Sub_metering_2,
  type = "l",
  col = "red"
  )

# Now let's add the final sub-meter

lines(
  hhpower$datetime,
  hhpower$Sub_metering_3,
  type = "l",
  col = "blue"
  )

# # Now let's annotate with the legend function

legend(
  "topright",
  legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
  col = c("black", "red", "blue"),
  lty = c(1,1,1),
  bty = "n"
  )

# Now for the new plots for this exercise, first Voltage vs. datetime

plot(
  hhpower$datetime,
  hhpower$Voltage,
  col = "black",
  type = "l",
  xlab = "datetime",
  ylab = "Voltage"
  )

# Now the final plot of Global_reactive_power vs. datetime

plot(
  hhpower$datetime,
  hhpower$Global_reactive_power,
  col = "black",
  type = "l",
  xlab = "datetime",
  ylab = "Global_reactive_power"
  )

# Now finally let's turn off the device

dev.off()

# Done! :)
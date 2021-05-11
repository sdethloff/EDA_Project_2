## 1. Install packages

install.packages("dplyr")
install.packages("tidyr")
install.packages("tidyverse")

## 2. Load libraries

library(dplyr)
library(tidyr)
library(tidyverse)

## 3. Set Working Directory

setwd("/Users/ussadethlo/Desktop/DSTR/EDA_Project_2/EDA_Project_2")

## 4. Download and Extract file

zip_file <- download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip', 'data_for_peer_assessment.zip', mode = 'wb')
unzip(zipfile = "data_for_peer_assessment.zip", exdir = "/Users/ussadethlo/Desktop/DSTR/EDA_Project_2/EDA_Project_2")

## 5. Read RDS Files

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## 6. Question 5. Make a Plot Showing How Motor Vehicle Emissions Changed in Baltimore City

SCC_Motor_Vehicle <- SCC %>%
  subset(grepl('Vehicle', SCC.Level.Two))

png(filename = 'plot5.png')

NEI_blt_motor_vehicle <- left_join(SCC_Motor_Vehicle, NEI) %>% 
  subset(fips == "24510") %>%
  group_by(year) %>% 
  summarize(Emissions = sum(Emissions))

with(NEI_blt_motor_vehicle, barplot(Emissions, names = year, xlab = "Years", ylab = "Emissions from Motor Vehicles", main = "Total Emissions from Motor Vehicles in Baltimore City", col = c("Blue","Green","Red","Purple")))

dev.off()
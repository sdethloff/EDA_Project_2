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

## 6. Question 2. Make a Base Plot of total PM2.5 emissions for Baltimore City

png(filename = 'plot2.png')

NEI_blt_total <- NEI %>% 
  subset(fips == "24510") %>%
  group_by(year) %>% 
  summarize(Emissions = sum(Emissions))

with(NEI_blt_total, barplot(Emissions, names = year, xlab = "Years", ylab = "Emissions", main = "Total Emissions in Baltimore City", col = c("Blue","Green","Red","Purple")))
dev.off()
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

## 6. Question 4. Make a Plot Showing How Coal Combustion-Related Emissions Have Changed

SCC_Coal <- SCC %>%
  subset(grepl('Coal',EI.Sector))

png(filename = 'plot4.png')

NEI_Coal_total <- left_join(SCC_Coal, NEI) %>% 
  group_by(year) %>% 
  summarize(Emissions = sum(Emissions))

with(NEI_Coal_total, barplot(Emissions, names = year, xlab = "Years", ylab = "Emissions from Coal", main = "Total Emissions from Coal Combustion Sources", col = c("Blue","Green","Red","Purple")))

dev.off()

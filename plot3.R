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

## 6. Question 3. Make a Plot using GGPlot2 to show emissions in Baltimore City by Type

png(filename = 'plot3.png')

NEI_blt_type <- NEI %>% 
  subset(fips == "24510") %>%
  group_by(year, type) %>% 
  summarize(Emissions = sum(Emissions))

ggplot(NEI_blt_type, aes(factor(year), Emissions, fill=type)) +
  geom_bar(stat = "identity") +
  facet_grid(.~type, scales = "free", space = "free") +
  labs(x = "year", y = "Total Emissions (Tons)", title = "Emissions in Baltimore City by Type")
dev.off()
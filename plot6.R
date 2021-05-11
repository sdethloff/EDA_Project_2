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

## 6. Question 6. Make a Plot Showing How Motor Vehicle Emissions Changed in Baltimore City as compared to Los Angeles County

SCC_Motor_Vehicle <- SCC %>%
  subset(grepl('Vehicle', SCC.Level.Two))

png(filename = 'plot6.png')

NEI_blt_la_motor_vehicle <- left_join(SCC_Motor_Vehicle, NEI) %>% 
  subset(fips == "06037" | fips == "24510") %>%
  group_by(year, fips) %>% 
  summarize(Emissions = sum(Emissions)) %>%
  add_column(City = 
               if_else(.$fips == "06037", "Los Angeles", "Baltimore City"),
             .after="fips")

ggplot(NEI_blt_la_motor_vehicle, aes(factor(year), Emissions, fill=City)) +
  geom_bar(stat = "identity") +
  facet_grid(.~City, scales = "free", space = "free") +
  labs(x = "year", y = "Total Emissions (Kilotons)", title = "Emissions from Motor Vehicles in Baltimore City and Los Angeles")

dev.off()

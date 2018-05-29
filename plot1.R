# PLOT 1

# Plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

library(RColorBrewer)

setwd("/Users/danielthornton/workspace/Data Science/Exploratory_Data_Analysis/week_4/plotting_particulate_matter")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

group_by_year <- aggregate(Emissions ~ year, NEI, sum)

pastels <- brewer.pal(4, "Pastel1")

png(filename = "plot1.png",width = 580, height = 480)

barplot(group_by_year$Emissions, col = pastels, names.arg = group_by_year$year,
         main = "Total particulate matter (PM2.5) emissions per year in the US", 
        xlab = "Year", ylab = "PM2.5 emitted (tons)", 
        args.legend = list(x = "topright"), axis.lty=1)

dev.off()
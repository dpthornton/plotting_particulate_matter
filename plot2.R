# PLOT 2

# Plot showing the total PM2.5 emission from Baltimore City
# for each of the years 1999, 2002, 2005, and 2008.

setwd("/Users/danielthornton/workspace/Data Science/Exploratory_Data_Analysis/week_4/plotting_particulate_matter")

library(RColorBrewer)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI_filtered <- NEI[NEI$fips=="24510",]

group_by_year <- aggregate(Emissions ~ year, NEI_filtered, sum)

pastels <- brewer.pal(4, "Pastel1")

png(filename = "plot2.png",width = 580, height = 480)

barplot(group_by_year$Emissions, 
        col = pastels, 
        names.arg = group_by_year$year,
        main = "Total particulate matter (PM2.5) emissions per year in Baltimore City", 
        xlab = "Year", ylab = "PM2.5 emitted (tons)", 
        args.legend = list(x = "topright"), 
        axis.lty=1)

dev.off()
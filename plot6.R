# PLOT 6

# Plot showing comparison of total PM2.5 emission from motor vehicles between
# Baltimore City and Los Angeles the years 1999, 2002, 2005, and 2008.

setwd("/Users/danielthornton/workspace/Data Science/Exploratory_Data_Analysis/week_4/plotting_particulate_matter")

library(ggplot2)
library(data.table)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

merged_data <- merge(NEI, SCC, by.x="SCC", by.y="SCC")
comb_data <- merged_data[merged_data$fips == "06037" | merged_data$fips == "24510",]
comb_data <- comb_data[comb_data$EI.Sector %like% "Vehicles",]

group_by_year <- aggregate(Emissions ~ year + fips, data=comb_data, sum)

ggplot(data=group_by_year, aes(x=as.factor(year), y=Emissions, fill=factor(fips, labels = c("Los Angeles","Baltimore City")))) +
  geom_bar(stat="identity") +
  ggtitle("Motor vehicle particulate matter (PM2.5) emissions per year in Los Angeles and Baltimore City") +
  labs(y= "PM2.5 emitted (tons)", x = "Year") +
  guides(fill=guide_legend("Vehicle pollution source")) +
  theme(plot.title = element_text(size=11,margin = margin(b = 20)),
        plot.margin = margin(r=10,l=10,t=10,b=10))

ggsave("plot6.png",dpi=300,device="png")
# PLOT 4

# Plot showing the total PM2.5 emission from coal cumbustion in the US
# for each of the years 1999, 2002, 2005, and 2008.

setwd("/Users/danielthornton/workspace/Data Science/Exploratory_Data_Analysis/week_4/plotting_particulate_matter")

library(ggplot2)
library(data.table)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

merged_data <- merge(NEI, SCC, by.x="SCC", by.y="SCC")
comb_data <- merged_data[merged_data$EI.Sector %like% "Coal" & merged_data$EI.Sector %like% "Comb",]

group_by_year <- aggregate(Emissions ~ year + EI.Sector, data=comb_data, sum)

ggplot(data=group_by_year, aes(x=as.factor(year), y=Emissions, fill=factor(EI.Sector,labels=c("Comm/Institutional","Electric Generation","Industrial Boilers")))) +
  geom_bar(stat="identity") +
  ggtitle("Particulate matter (PM2.5) emissions per year in the US from coal cumbustion sources") +
  labs(y= "PM2.5 emitted (tons)", x = "Year") + 
  guides(fill=guide_legend("Coal Cumbustion Source")) +
  theme(plot.title = element_text(size=11,margin = margin(b = 20)),
        plot.margin = margin(r=10,l=10,t=10,b=10))

ggsave("plot4.png",dpi=300,device="png")
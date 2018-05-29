# PLOT 3

# Plot showing the total PM2.5 emission from Baltimore City by type
# for each of the years 1999, 2002, 2005, and 2008.

setwd("/Users/danielthornton/workspace/Data Science/Exploratory_Data_Analysis/week_4/plotting_particulate_matter")

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI_filtered <- NEI[NEI$fips=="24510",]

group_by_year <- aggregate(Emissions ~ year + type, data=NEI_filtered, sum)

ggplot(data=group_by_year, aes(x=as.factor(year), y=Emissions, fill=type)) +
  geom_bar(stat="identity") +
  scale_colour_manual(values=c("red","green","blue","orange")) + 
  ggtitle("Particulate matter (PM2.5) emissions per year in Baltimore City by type (1999-2008)") +
  labs(y= "PM2.5 emitted (tons)", x = "Year") +
  theme(plot.title = element_text(size=11,margin = margin(b = 20)),
      plot.margin = margin(r=10,l=10,t=10,b=10))

ggsave("plot3.png",dpi=300,device="png")
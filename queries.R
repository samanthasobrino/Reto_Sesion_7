install.packages("DBI")
install.packages("RMySQL")
install.packages("dplyr")
install.packages("ggplot2")
library(dplyr)
library(DBI)
library(RMySQL)
library(ggplot2)

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

dbListTables(MyDataBase)

dbListFields(MyDataBase, 'CountryLanguage')

Languages <- dbGetQuery(MyDataBase, "select * from CountryLanguage")
names(Languages)

ESP <- Languages %>% filter(Language == "Spanish")
ESP.df <- as.data.frame(ESP) 


ESP.df %>% ggplot(aes( x = CountryCode, y=Percentage, fill = IsOfficial )) + 
  geom_bar(position = "dodge", stat="identity")+
  geom_bin2d() +
  coord_flip()

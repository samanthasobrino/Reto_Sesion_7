### RETO 2 ###
library(rvest)

link <- "https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm"

file<-read_html(link)

tables<-html_nodes(file, "table")
table1 <- html_table(tables[1], fill = TRUE)

table <- na.omit(as.data.frame(table1))

str(table)

  # Limpiamos 

s <- gsub("[^[:alnum:][:blank:]?]", "", table$Sueldo)
s <- gsub("MXN","", s)
s <- gsub("mes", "", s)
s <- as.numeric(s)
table$Sueldo <- s

# cargo
c <- gsub("Sueldos para Data Scientist en ", "", table$Cargo)
table$Cargo <-c

# Sueldo más alto
max.sueldo <- which.max(table$Sueldo)
table[max.sueldo,]

# Sueldo más bajo
min.sueldo <- which.min(table$Sueldo)
table[min.sueldo,]

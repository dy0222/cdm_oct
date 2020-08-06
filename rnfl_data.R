rm(list = ls())

setwd("D:/OCT Project")
options(java.parameters = c("-XX:+UseConcMarkSweepGC", "-Xmx8192m"))
options(java.parameters = "-Xmx8000m")


library(readxl)
all_result <- read_excel("D:/OCT Project/all_result.xlsx")

warnings()

colnames(all_result)

all_result_cut <- select(all_result, -c(,9:55))
View(all_result_cut)

colnames(all_result_cut)

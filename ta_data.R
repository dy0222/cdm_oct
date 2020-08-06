#rm(list = ls())

setwd("D:/OCT Project")
#options(java.parameters = c("-XX:+UseConcMarkSweepGC", "-Xmx8192m"))
#options(java.parameters = "-Xmx8000m")

library(dplyr)
library(readxl)
library(lubridate)

# 데이터 불러오기
data_ta <- read_excel("ta_20200320.xlsx", sheet = "data")

warnings()
View(data_ta)
str(data_ta)

# 불필요한 열 제거
data_ta <- data_ta[,1:10]
data_ta <- data_ta[,-c(6)]

# 열 이름 변경
colnames(data_ta) <- c("id", "name", "sex", "DOB", "index_date", "IOP_Rt", "IOP_Lt", "Ta_od", "Ta_os")

# ID수 == 총 환자 수 
m <- max(data_ta$id)
m

# ID순으로 정렬
data_ta <- data_ta %>% arrange(id)

# DOB, index_date 날짜로 변환
data_ta$DOB <- as.Date(data_ta$DOB)
data_ta$index_date <- as.Date(data_ta$index_date)
str(data_ta)

# 나이계산
date <- now()
data_ta$age <- year(date) - year(data_ta$DOB)

# 결측치 빈도수
table(is.na(data_ta$id)) # NA : 없음
table(is.na(data_ta$name)) # NA : 79888개 
table(is.na(data_ta$sex)) # NA : 79888개 
table(is.na(data_ta$DOB)) # NA : 79888개 
table(is.na(data_ta$index_date)) # NA : 79888개 
table(is.na(data_ta$IOP_Rt)) # NA : 80330개 
table(is.na(data_ta$IOP_Lt)) # NA : 80330개 
table(is.na(data_ta$Ta_od)) # NA : 9개 
table(is.na(data_ta$Ta_os)) # NA : 6개 

table(is.na(data_ta$Ta_od))
data_ta_NAcut <- data_ta %>% filter(!is.na(Ta_od))
table(is.na(data_ta_NAcut$Ta_od))

table(is.na(data_ta_NAcut$Ta_os))
data_ta_NAcut <- data_ta_NAcut %>% filter(!is.na(Ta_os))
table(is.na(data_ta_NAcut$Ta_os))


# ID별 Ta_od / Ta_os 그래프
gensym <- thedat[thedat$age==8,4]

pdf("Ta_od.pdf",width=8)
interaction.plot(data_ta_NAcut$age,thedat$id,thedat$distance,xlab="Age (years)",
                 ylab="Distance (mm)",lty=1,legend=FALSE,type="b",
                 pch=as.character(gensym))
title("Dental Study Data")
graphics.off()


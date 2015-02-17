rm(list=ls())

# xml
library(XML)

APIKey <- paste("__________", sep = "")

getUrls <- function(startNum, endNum, type){
  url <- paste("http://openAPI.seoul.go.kr:8088/")
  urls <- NULL
  urls <- c(urls, paste(url, APIKey, "/", type, "/ListRainfallService/", startNum, "/", endNum, sep = ""))
  return (urls)
}
getUrls(1,100,"xml")

getData <- function(url){
  root <- xmlRoot(xmlParse(url))
  raingaugeName <- xmlSApply(getNodeSet(root, "//RAINGAUGE_NAME"), xmlValue)
  raingaugeCode <- xmlSApply(getNodeSet(root, "//RAINGAUGE_CODE"), xmlValue)
  guName <- xmlSApply(getNodeSet(root, "//GU_NAME"), xmlValue)
  guCode <- xmlSApply(getNodeSet(root, "//GU_CODE"), xmlValue)
  rainFallHour <- xmlSApply(getNodeSet(root, "//RAINFALLHOUR"), xmlValue)
  rainDay <- xmlSApply(getNodeSet(root, "//RAINFALLDAY"), xmlValue)
  rainAnnual <- xmlSApply(getNodeSet(root, "//RAINFALLACCU"), xmlValue)
  storedTime <- xmlSApply(getNodeSet(root, "//STORED_TIME"), xmlValue)
  rainFall <- cbind(raingaugeName, raingaugeCode, guName, rainFallHour, rainDay, rainAnnual, storedTime)
  rainFall <- as.data.frame(rainFall, rownames=NULL)
  return (rainFall)
}

rainFall <- getData(getUrls(1, 10, "xml"))
head(rainFall)
str(rainFall)

write.csv(rainFall, "rainFall.txt")

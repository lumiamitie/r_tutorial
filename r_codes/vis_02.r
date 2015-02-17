#install.packages("maps")
library(maps)
costcos = read.csv("http://book.flowingdata.com/ch08/geocode/costcos-geocoded.csv", sep=",")
map(database="state") #기반 지도 레이어
symbols(costcos$Longitude, costcos$Latitude, circles = rep(1, length(costcos$Longitude)), inches = 0.05, add=TRUE)
# symbols() 함수는 매장위치를 나타내는 상위 레이어다
# circles 인수를 똑같이 1값을 갖는 배열로 전달했기 때문에 모든 마커의 크기가 일정하다
# 균일한 원의 크기는 0.05 인치로 결정

# 지도의 색상과 원의 색상 변경
map(database="state", col = "#cccccc")
symbols(costcos$Longitude, costcos$Latitude, bg= "#e2373f", fg = "#ffffff", lwd = 0.5,
        circles = rep(1, length(costcos$Longitude)), inches = 0.05, add=TRUE)
# 점마커의 색상은 빨간색으로, 지역 구분선은 옅은 회색으로 했다.

# 알래스카와 하와이가 빠져있네
# 세계지도로 살펴보자
map(database="world", col = "#cccccc")
symbols(costcos$Longitude, costcos$Latitude, bg= "#e2373f", fg = "#ffffff", lwd = 0.5,
        circles = rep(1, length(costcos$Longitude)), inches = 0.05, add=TRUE)
# 엄청나게 공간을 낭비하고있음..
# 옵션에서 적용해볼 수 있는 다양한 옵션도 있고, 일러스트레이터로 그냥 수정하는 방법도 있음

# 특정 주의 매장 위치만 보고싶다면?
# region 인수를 추가
map(database="state", region = c("California","Nevada","Oregon","Washington"), col = "#cccccc")
symbols(costcos$Longitude, costcos$Latitude, bg= "#e2373f", fg = "#ffffff", lwd = 0.5,
        circles = rep(1, length(costcos$Longitude)), inches = 0.05, add=TRUE)
# 선택한 주에 해당하지 않는 위치의 마커가 일부 표시되었다.
# 선택한 위치는 아니지만 지도 그래픽의 영역에 포함되기 때문
# 벡터 그래픽 에디터로 수정해버리던가, 넣는 데이터를 필터링 하자

### 지도 위에 있는 점 간의 연결관계를 선으로 표시해보자
# 가장 쉬운 방법은 lines
faketrace = read.csv("http://book.flowingdata.com/ch08/points/fake-trace.txt", sep="\t")
map(database = "world", col = "#cccccc")
lines(faketrace$longitude, faketrace$latitude, col="#bb4cd4", lwd = 2)
symbols(faketrace$longitude, faketrace$latitude, bg = "#bb4cd4", fg = "#ffffff", lwd = 1,
        circles = rep(1, length(faketrace$longitude)), inches = 0.05, add=TRUE)

# 현재 위치로부터 각각의 연결선
map(database = "world", col = "#cccccc")
for(i in 2:length(faketrace$longitude)-1) {
  lngs = c(faketrace$longitude[8], faketrace$longitude[i])
  lats = c(faketrace$latitude[8], faketrace$latitude[i])
  lines(lngs, lats, col = "#bb4cd4", lwd = 2)
}

### 버블차트
# 데이터는 미성년 출산율 데이터의 sqrt() 결과
fertility = read.csv("http://book.flowingdata.com/ch08/points/adol-fertility.csv")
map("world", fill = FALSE, col = "#cccccc")
symbols(fertility$longitude, fertility$latitude, inches = 0.15, bg= "#93ceef", fg = "#ffffff",
        circles = sqrt(fertility$ad_fert_rate), add=TRUE)
# 원이 어느 정도의 값을 나타내는지 알 수 없으니 summary() 함수로 확인해보자
summary(fertility$ad_fert_rate)




### 샘플데이터
spl = read.csv("vis_sample.csv")
spl_seoul = read.csv("vis_sample_seoul.csv")
### rworldmap 패키지
library(rworldmap)
newmap=getMap(resolution='low')
plot(newmap,xlim=c(124,132),ylim=c(31,39))
points(spl$longitude, spl$latitude, col= "#e2373f", cex = 0.5)

### RgoogleMaps 패키지
library(RgoogleMaps)
mapseoul=GetMap(center=c(37.55,126.98),size=c(640,640),zoom=12,destfile="newmap.jpg",maptype="terrain")
PlotOnStaticMap(mapseoul,lat=spl_seoul$longitude ,lon=spl_seoul$latitude)


### ggmap 패키지
library(ggmap)
mapseoul2=get_map(location=c(lon=126.98,lat=37.55),zoom=12, maptype=c("roadmap"))
ggmapseoul = ggmap(mapseoul2)
ggmapseoul + geom_point(aes(x=longitude,y=latitude),data=spl_seoul)
ggmapseoul + geom_density2d(mapping=aes(x=longitude,y=latitude),data=spl_seoul)

# maptype 변경
mapseoul01=get_map(location=c(lon=126.98,lat=37.55),zoom=12, maptype=c("terrain"))
ggmapseoul01 = ggmap(mapseoul01)
ggmapseoul01 + geom_point(aes(x=longitude,y=latitude),data=spl_seoul)

mapseoul02=get_map(location=c(lon=126.98,lat=37.55),zoom=12, maptype=c("toner"))
ggmapseoul02 = ggmap(mapseoul02)
ggmapseoul02 + geom_point(aes(x=longitude,y=latitude),data=spl_seoul,size = 4)

# zoom
mapseoul03=get_map(location=c(lon=126.98,lat=37.55),zoom=11, maptype=c("roadmap"))
ggmap(mapseoul03) + geom_point(aes(x=longitude,y=latitude),data=spl_seoul,size = 4)

# 오류???? maptype = "toner" is only available with source = "stamen". resetting to source = "stamen"... 
mapseoul03=get_map(location=c(lon=126.98,lat=37.55),source="stamen",zoom=11, maptype=c("toner"))
ggmap(mapseoul03) + geom_point(aes(x=longitude,y=latitude),data=spl_seoul,size = 4)



###ggplot2
dat = data.frame(xval = 1:4, yval = c(3,5,6,9), group = c("A", "B", "A", "B"))
#기본
ggplot(dat, aes(x = xval, y = yval) )
ggplot(dat, aes(x = xval, y = yval) ) + geom_point()

p = ggplot(dat, aes(x = xval, y = yval) )
p + geom_point()

p + geom_point(aes(colour = group))
p + geom_point(aes(colour = "blue"))
p + geom_point(aes(colour = group)) + scale_x_continuous(limits = c(0,8))
p + geom_point() + scale_colour_manual(values = c("orange", "forestgreen"))

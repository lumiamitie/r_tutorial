#시간 시각화########################################
#막대 그래프
hotdogs = read.csv("http://datasets.flowingdata.com/hot-dog-contest-winners.csv", sep="," , header=T) #이게 정석
read.csv("http://datasets.flowingdata.com/hot-dog-contest-winners.csv") #개떡같이말해도 철썩같이 알아듣는다 
#year 연도 / winner 우승자 이름 / dogs.eaten 우승자가 먹은 핫도그 수 / country 우승자 국적 / new.record 세계기록 경신시 1
barplot(hotdogs$Dogs.eaten)
#plot(hotdogs$Dogs.eaten)
#막대에 연도 라벨 추가
barplot(hotdogs$Dogs.eaten, names.arg=hotdogs$Year)
#축의 라벨, 외곽선 설정, 색상
barplot(hotdogs$Dogs.eaten, names.arg=hotdogs$Year, col="red", border=NA, xlab="Year", ylab="Hotdogs and buns (HDB) eaten")

#미국인이 우승한 해의 막대와 그렇지 않은 해의 색상을 구분해보자
#색상정보를 담은 리스트 or 벡터를 만들어야 한다
fill_colors = c()
for (i in 1:length(hotdogs$Country)){
  if (hotdogs$Country[i] == "United States"){
      fill_colors = c(fill_colors,"#821122")
  } else {
      fill_colors = c(fill_colors, "#cccccc")  
  }
  
}

barplot(hotdogs$Dogs.eaten, names.arg=hotdogs$Year, col=fill_colors, border=NA, xlab="Year", ylab="Hotdogs and buns (HDB) eaten")

#space 막대간격 / main 제목설정
barplot(hotdogs$Dogs.eaten, names.arg=hotdogs$Year, col=fill_colors, border=NA, space = 0.3,
        main="Nathan's Hot Dog Eating Contest Results, 1980-2010",
        xlab="Year", ylab="Hotdogs and buns (HDB) eaten")



#누적 막대 그래프
hot_dog_places = read.csv("http://datasets.flowingdata.com/hot-dog-places.csv",sep=",",header=T)
#열이름이 숫자로 되어있을 경우 R에서 자동으로 'X'를 앞에 붙여 String으로 만든다
#원래대로 수정해주자

names(hot_dog_places) = c("2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010")
#이 경우 데이터 프레임인 hot_dog_places 를 행렬로 바꿔줘야한다.
hot_dog_matrix = as.matrix(hot_dog_places)
barplot(hot_dog_matrix, border=NA, space=0.25, ylim=c(0,200), xlab="Year", ylab="Hot dogs and buns (HDBs) eaten",
        main="Hot Dog Eating Contest Results, 1980-2010")
barplot(hot_dog_matrix, border=NA, col=c("magenta","cyan","yellow"),space=0.25, ylim=c(0,200), xlab="Year", ylab="Hot dogs and buns (HDBs) eaten",
        main="Hot Dog Eating Contest Results, 1980-2010")


#스캐터플롯
subscribers = read.csv("http://datasets.flowingdata.com/flowingdata_subscribers.csv",sep=",",header=T)
plot(subscribers$Subscribers)
plot(subscribers$Subscribers,type="p", ylim=c(0,30000))
#type 그래프 형태 : p는 점 h는 고밀도 수직선 그래프

plot(subscribers$Subscribers, type="h", ylim=c(0,30000), xlab="Day", ylab="Subscribers")
points(subscribers$Subscribers, pch=19, col="black")
abline(0,1000)

#연속형 데이터###################
#시계열 그래프
population = read.csv("http://datasets.flowingdata.com/world-population.csv", sep=",", header=T)
plot(population$Year,population$Population,type="l", ylim=c(3000000000, 7000000000),xlab="Year", ylab="Population")
#계단식 그래프
postage = read.csv("http://datasets.flowingdata.com/us-postage.csv", sep=",", header=T)
plot(postage$Year, postage$Price, type="s")
#type 's
plot(postage$Year, postage$Price, type="s", main="US Postage Rates for Letters, First Ounce, 1991-2010",
     xlab="Year",ylab="Postage Rate (Dallars)")

#loess
#미국 실업률 1948-2010
unemployment = read.csv("http://datasets.flowingdata.com/unemployment-rate-1948-2010.csv",sep=",")
plot(1:length(unemployment$Value),unemployment$Value)
lnth=1:length(unemployment$Value)
abline(lm(unemployment$Value ~ lnth))
scatter.smooth(x=1:length(unemployment$Value),y=unemployment$Value)
#degree와 span으로 곡률 조정
?scatter.smooth


#분포 시각화######################################################
#트리맵 만들기
posts = read.csv("http://datasets.flowingdata.com/post-data.txt")
#install.packages("portfolio")
library(portfolio)
map.market(id = posts$id, area = posts$views, group = posts$category, color = posts$comments, main = "FlowingData Map")

#파이 차트
# Simple Pie Chart
slices <- c(10, 12,4, 16, 8)
lbls <- c("US", "UK", "Australia", "Germany", "France")
pie(slices, labels = lbls, main="Pie Chart of Countries")

# Pie Chart with Percentages
slices <- c(10, 12, 4, 16, 8) 
lbls <- c("US", "UK", "Australia", "Germany", "France")
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) # add percents to labels 
lbls <- paste(lbls,"%",sep="") # ad % to labels 
pie(slices,labels = lbls, col=rainbow(length(lbls)),main="Pie Chart of Countries")

# Pie Chart from data frame with Appended Sample Sizes
mytable <- table(iris$Species)
lbls <- paste(names(mytable), "\n", mytable, sep="")
pie(mytable, labels = lbls, main="Pie Chart of Species\n (with sample sizes)")

#관계 시각화##########################################
#Scatter Plot
crime = read.csv("http://datasets.flowingdata.com/crimeRatesByState2005.csv", sep=",",header=T)
plot(crime$murder, crime$burglary) #살인에 대한 절도 범죄 건수
crime2 = crime[crime$state != "District of Columbia",] #아웃라이어를 일단 제거하고 해보자
crime2 = crime2[crime2$state != "United States",] #미국 전체 데이터도 제거
plot(crime2$murder, crime2$burglary)
plot(crime2$murder, crime2$burglary,xlim=c(0,10),ylim=c(0,1200)) #축 조정
scatter.smooth(crime2$murder, crime2$burglary, xlim=c(0,10), ylim=c(0,1200)) #loess 추세선 추가

#Scatter Plot matrix
plot(crime2[,2:9])
pairs(crime2[,2:9], panel = panel.smooth) #추세선을 포함
#panel 인수는 x, y에 대한 함수를 변수로 받아 전달한다
#예제 코드에선 panel.smooth() 함수(LOESS 추세선을 그려주는 함수)를 전달했다.
#자신이 만든 함수도 전달가능

#Burble Chart
crime = read.csv("http://datasets.flowingdata.com/crimeRatesByState2005.tsv", header=T, sep="\t")
symbols(crime$murder, crime$burglary, circles = crime$population)
#원의 면적을 통해 데이터를 표현하자 (반지름 X)
#원의 면적 : pi * r^2
#r = sqrt(원의면적/pi) 여기서 비례를 구하려는 것이니 파이는 무시해도 된다
radius = sqrt(crime$population/pi)
symbols(crime$murder, crime$burglary, circles = radius) #음.... 원이 전체적으로 다 커보인다
symbols(crime$murder, crime$burglary, circles = radius, inches=0.35, fg="white", bg="red", xlab="Murder Rate", ylab="Burglary Rate")
#inches : 가장 큰원의 크기를 inch 단위로 설정
#fg : foreground / bg : background

#symbols 함수는 다른 모형을 선택할 수도 있다.
symbols(crime$murder,crime$burglary, squares=sqrt(crime$population),inches = 0.5)
text(crime$murder, crime$burglary, crime$state, cex=0.5)
#cex 는 출력 문구의 크기(기본값 1)

#히스토그램
tvs=read.table("http://datasets.flowingdata.com/tv_sizes.txt",sep="\t",header=T)
##아웃라이어 제거
tvs=tvs[tvs$size <80,]
tvs=tvs[tvs$size >10,]
##히스토그램 구간 수 설정
breaks = seq(10, 80, by=5)
##레이아웃 설정
par(mfrow=c(4,2))
##히스토그램 그리기
hist(tvs[tvs$year == 2009,]$size, breaks=breaks)
hist(tvs[tvs$year == 2008,]$size, breaks=breaks)
hist(tvs[tvs$year == 2007,]$size, breaks=breaks)
hist(tvs[tvs$year == 2006,]$size, breaks=breaks)
hist(tvs[tvs$year == 2005,]$size, breaks=breaks)
hist(tvs[tvs$year == 2004,]$size, breaks=breaks)
hist(tvs[tvs$year == 2003,]$size, breaks=breaks)
hist(tvs[tvs$year == 2002,]$size, breaks=breaks)

par(mfrow=c(1,1))

#비교 시각화####################################
##히트맵 만들기 heatmap()
bball = read.csv("http://datasets.flowingdata.com/ppg2008.csv",header=T) #2008년 NBA 농구선수 통계
bball_byfgp = bball[order(bball$FGP, decreasing =T),]
bball = bball[order(bball$PTS, decreasing = F),]
row.names(bball) = bball$Name #행이름을 선수 이름으로
bball=bball[,2:20]
###히트맵을 그리려면 데이터프레임이 아니라 행렬 형태여야 한다
bball_matrix = data.matrix(bball)
bball_heatmap = heatmap(bball_matrix, Rowv = NA, Colv = NA, col=cm.colors(256), scale = "column", margins = c(5,10))
### scale 인수를 column으로 설정하면 최대최소값을 전체 행렬이 아니라 열기준으로 결정
### cm.colors() : 사용할 색상의 범위를 파랑(cyan)부터 빨강(magenta)으로 설정
###               입력한 숫자 단계(여기서는 256) 길이의 파랑에서 빨강까지의 색상범위를 16진수 색상코드 벡터로 반환
### ?cm.colors 를 입력하여 자세한 도움말 확인 가능
## 따뜻한 색감으로 바꿔보자
bball_heatmap = heatmap(bball_matrix, Rowv = NA, Colv = NA, col=heat.colors(256), scale = "column", margins = c(5,10))
cm.colors(10) #10개의 색상 벡터를 확인할 수 있다.

##### 0to255.com 참고
## 색상 코드를 직접 입력해보자
red_colors = c("#ffd3cd","#ffc4bc", "#ffb5ab", "#ffa69a", "#ff9789", "#ff8978", "#ff7a67", "#ff6b56", "#ff5c45", "#ff4d34")
bball_heatmap = heatmap(bball_matrix, Rowv = NA, Colv = NA, col=red_colors, scale = "column", margins = c(5,10))

##RColorBrewer 패키지
### ?brewer.pal 을 통해 자세한 옵션 확인
#install.packages("RColorBrewer")
library(RColorBrewer)
bball_heatmap = heatmap(bball_matrix, Rowv = NA, Colv = NA, col=brewer.pal(9,"Blues"), scale = "column", margins = c(5,10))

#체르노프 페이스
#install.packages("aplpack")
library(aplpack)
bball = read.csv("http://datasets.flowingdata.com/ppg2008.csv",header=T) #다시 불러오자
faces(bball[,2:16],ncolors=0)

#Star Chart
crime = read.csv("http://datasets.flowingdata.com/crimeRatesByState2005.csv", sep=",",header=T) #다시
stars(crime)

row.names(crime) = crime$state #주 이름을 행이름으로
crime = crime[,2:7] #테이블에서 주 이름을 제거
stars(crime, flip.labels=FALSE, key.loc = c(15,0.5))
##flip.labels를 기본값인 T로 놔두면 라벨을 차트의 높이에 따라 위아래를 오가며 배치한다.
##key.loc은 범례 위치인것같다
stars(crime, flip.labels=FALSE, key.loc = c(15,1.5), full =FALSE)
##full옵션을 끄면 윗부분만 가지고 그린다

##Nightingale chart / Polar Area Diagram
##draw.segments 옵션을 켜면 점의 위치 대신 거리로 수치를 나타낸다
stars(crime, flip.labels=FALSE, key.loc = c(15,1.5),draw.segments=TRUE)


#평행좌표계 Parallel coordinates
education = read.csv("http://datasets.flowingdata.com/education.csv",header=T)
##주이름 / SAT 읽기 평균 / 수학평균 / 쓰기평균 / SAT응시비율 / 고등학교졸업직후 취업하는학생비율 / 고교 중퇴율
##변수들을 분명한 상관관계로 엮을 수 있는가?
##고교 중퇴율이 높은 주는 과연 평균 SAT점수도 낮을까???
library(lattice)
parallelplot(education)
parallelplot(education,horizontal.axis = FALSE)  #취향따라...

##state열은 빼고, 검은색으로 바꿔보자
parallelplot(education[,2:7],horizontal.axis = FALSE, col="#000000")
## 읽기,수학,쓰기는 평행에 가깝다
## SAT점수와 응시율???? 높은 평균점수는 낮은 응시율을 보이고 그 반대도 보인다
## 읽기 점수를 기준으로 50%씩 나누어서 상위는 검정색, 하위는 회색으로 하자
## 중앙값은 summary()를 통해 확인
summary(education) #reading의 중앙값은 523이다

reading_colors = c()
for (i in 1:length(education$state)){
  if (education$reading[i]>523){
      col = "#000000"
  } else {
      col = "#cccccc"
  }
  reading_colors = c(reading_colors, col)
}
parallelplot(education[,2:7],horizontal.axis = FALSE, col=reading_colors)

##중퇴율에 대해서도 살펴보자
##중앙값 대신 첫 4분위수(상위25%)로 필터링 : 여기서는 5.3%
dropout_colors=c()
for (i in 1:length(education$state)){
  if (education$dropout_rate[i]>5.3){
    col = "#000000"
  } else {
    col = "#cccccc"
  }
  dropout_colors = c(dropout_colors, col)
}
parallelplot(education[,2:7],horizontal.axis = FALSE, col=dropout_colors)
##불분명해보임

#다차원척도법(MDS)
education = read.csv("http://datasets.flowingdata.com/education.csv",header=T) #다시
ed.dis = dist(education[,2:7]) #모든 주에 대해서 그 주와 나머지 모든 주 사이의 거리를 구한다, 첫열은 주이름이니 제외
#행렬의 한 위치는 행의 주와 열의 주가 얼마만큼의 (유클리드)거리 로 떨어져 있어야 하는지를 보여줌
ed.dis = cmdscale(ed.dis) #cmdscale함수는 거리 행렬을 입력으로 받아서 각 점을 입력된 거리에 맞게 배치한 좌표를 반환한다
x=ed.dis[,1] #구한 좌표를 변수에 각각 저장
y=ed.dis[,2]
plot(x,y)
#한 점이 어떤주를 나타내는지 알 수 없으니 라벨을 붙여보자
plot(x,y,type="n")
text(x,y,labels = education$state)
#주 라벨에 dropout_colors를 적용해보자
plot(x,y,type="n")
text(x,y,labels = education$state,col=dropout_colors)
#별로 의미없어보임
plot(x,y,type="n")
text(x,y,labels = education$state,col=reading_colors)
#오...............
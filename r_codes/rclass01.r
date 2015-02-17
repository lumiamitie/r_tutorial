#index
iris[iris[,5]=='setosa',] #setosa 품종만
iris[iris[,5]=='setosa',][order(iris[iris[,5]=='setosa',1]),] #setosa 품종만 1열에 대해 정렬

#subset
#subset(data.frame, select=c(colname1,colname2,....), subset = logical sentence)

subset(iris,select=c(Sepal.Length, Sepal.Width, Petal.Width), subset= (Species=='setosa' & Petal.Width <0.3))

#order
iris[order(iris[,1]),] #1열에 대해 정렬
subset(iris[order(iris[,1]),] , subset= (Species == 'setosa')) #1열에 대해 정렬 + setosa

install.packages("sqldf")
#sqldf
library(sqldf)
sqldf("select * from iris
      where Species = 'setosa' 
      order by Sepal_Length 
      ")

#plyr package
#ddply : apply for data.frame???
#summarise
ddply(iris,"Species",summarise,mean1=mean(Sepal.Length),mean2=mean(Sepal.Width),mean3=mean(Petal.Length),mean4=mean(Petal.Width))
ddply(iris,"Species",summarise,sd1=sd(Sepal.Length),sd2=sd(Sepal.Width),sd3=sd(Petal.Length),sd4=sd(Petal.Width))
# 함수라면 모두 적용가능
# 직접만든 함수도 가능

#transform
ddply(iris,"Species",transform,mean1=mean(Sepal.Length))

#mutate
ddply(iris,"Species",mutate,mean1=mean(Sepal.Length))
#transform과 mutate의 차이???
ddply(iris,"Species",transform,mean1=mean(Sepal.Length),diff=Sepal.Length-mean1)
ddply(iris,"Species",mutate,mean1=mean(Sepal.Length),diff=Sepal.Length-mean1)
#mutate는 단계별로 진행 / transform은 한꺼번에 뙇

#ddply란??
#입력값이 data.frame (d)이고 출력값이 data.frame(d) 인 apply계열 함수
#출력값으로 list를 원하면 dlply
#입력값이 array인데 출력이 list이면 alply 등등



######################
#install.packages("xlsx")
library(xlsx)
sell <- read.xlsx("식수현황.xlsx", sheetIndex=2,encoding="UTF-8",startRow=4)
sell <- sell[,(1:14)]
sell <- sell[c(-4,-5,-8,-11,-14)]
sell <- sell[1:30,] 


######################
install.packages("rjson")
library(rjson)
moviejson='http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=3126eda58d1b5b576f1e638410faed33&targetDt=20140101'
jsonRS=fromJSON(file=moviejson)
jsonRS$boxOfficeResult$dailyBoxOfficeList[[1]]

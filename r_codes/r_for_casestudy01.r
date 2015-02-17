# 자료형을 따로 설정할 필요가 없다.
# <- 는 할당연산자. R studio에서는 단축키 Alt + ( - )        
#ex) a<-"Hello World" 또는 "Hello World" -> a

a= "Hello World"
mode(a) #character

b= 42
mode(b) #numeric

c=list(A=c(1,2), B=c("a","b"))
mode(c) #list (파이썬의 딕셔너리와 비슷)

d=data.frame(A=c(1,2,3),B=c("a","b","c"))
mode(d) #list!! list의 하위항목?인 data.frame

is.list(c) #true
is.data.frame(c) #false
is.list(d) #true
is.data.frame(d) #true

# list와 data.frame의 차이???
c$A
c$B
c[1] #첫번째 성분
c[2] #두번째 성분

d$A
d$B
d[,1] #[행,열]
d[,2]
d[1,] #data 하나




# plot
# 써볼만한데이터 : cars(기본), iris(다변량), HairEyeColor(범주형 : contingency table),  Nile(시계열)

plot(cars)
abline(lm(cars$dist~cars$speed))
lines(lowess(cars),lty=2)

plot(cars,type="b") #plot type 변경

plot(HairEyeColor) #mosaic plot
plot(HairEyeColor,col=c("magenta","cyan"))
plot(HairEyeColor,col=c("#8dbbf1","#f17ed4"))

plot(iris)
boxplot(iris)
hist(iris[,1])
boxplot(Sepal.Length~Species,data=iris)
boxplot(Sepal.Length~Species,data=iris,col="#d24999")
table(iris[,5]) #품종별 데이터 수

par(mfrow=c(1,2))
plot(Nile)
boxplot(Nile)
hist(Nile)

data()
#read.table : txt , dat
#read.csv : csv (comma seperated value)

#text 파일을 한 개 만든다 test.txt
#"1" "ybigta"
#"2" "orpheus"
#"3" "esc"
#"4" "ycv"
#"5" "eulim"

read.table("d:/data/r/test.txt")

#test2.txt
#1, ybigta
#2, orpheus
#3, esc
#4, ycv
#5, eulim

read.table("d:/data/r/test2.txt")
#이렇게하면 V1에 comma가 들어간다 => "구분자"를 변경!!
read.table("d:/data/r/test2.txt",sep=",")

#생각해보니 불러오면 row number가 찍히니까 V1은 필요가 없다?
read.table("d:/data/r/test2.txt",sep=",",row.names=1)

#test3.txt
#"number""activity"
#"1" "ybigta"
#"2" "orpheus"
#"3" "esc"
#"4" "ycv"
#"5" "eulim"

read.table("d:/data/r/test3.txt") #이럴경우 테이블의 제목들까지 한 행으로 인식한다
read.table("d:/data/r/test3.txt",header=T) #이렇게 하면 첫번째 행을 열 제목으로 인식

#working directory 안에 넣어두면 파일명만으로 불러올 수 있다.

#text파일의 경우 맨 마지막에 빈칸 한 줄을 넣어줘야 EOF로 인식. 없어도 실행은 되는데 warning message



#알아두면 좋은 내용
#?함수명 : '함수명' 의 문서
?plot
#??내용 : '내용' 에 대해 검색
??plot
#getwd() : working directory 주소 
getwd()
#setwd() : working directory 설정

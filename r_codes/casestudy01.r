movie=read.csv("d:\\docu\\ybigta\\casestudy\\sample_boxoffice.csv",header=T)
movie_info=read.csv("d:\\docu\\ybigta\\casestudy\\sample_moviedata.csv",header=T)
movie14=read.csv("d:\\docu\\ybigta\\casestudy\\2014moviedata.csv",header=T)
# audiCnt : 해당일 관객수
# audiInten : 전일 대비 관객수 증감분
# scrnCnt : 해당일자에 상영한 스크린 수
# ShowCnt : 해당일자에 상영된 횟수

plot(movie[movie[,2]=="셜록홈즈  그림자 게임",c(19,14)]) #당일관객수가 많은날과 적은날을 구분하면 선형관계가 명확해 보임
plot(movie[movie[,2]=="범죄와의 전쟁 나쁜놈들 전성시대",c(19,14)]) # 커버쳐로 볼수도 있고 굳이 구분해보자면 선형으로 나눌수는 있을듯

#필요한거 : 요일 및 공휴일 정보 + 휴일 전날...?

movie2=movie[,c(1,2,14,15,16,17,18,19)]
movie14_2=movie14[,-c(3,4,5,6,7,9,10,11,12)]

movie_info[movie_info[,6]=="공포" & movie_info[,2]>2011,1]

library(sqldf)
head(sqldf("select movie.movieNm,movie_info.director from movie join movie_info on movie.movieNm = movie_info.title"))


movie2014=read.csv("d:/docu/ybigta/casestudy/2014moviedata.csv",header=T)
head( merge(movie[,c(1,2,14,17,18,19)],movie_info[,c(1,3,4,5)],by.x="movieNm",by.y="title") , n=50)



##################################################
#토르 : 다크월드
thor=data.frame(index=1:36,subset(movie2,subset=(movieNm=="토르 다크 월드"))[,c(1,3,4,5,6,7,8)])
thor=data.frame(index=thor[,1],date=as.Date(as.character(thor$date),"%Y%m%d"),thor[,-c(1,2)]) #시간형식으로 날짜 추가
thor=data.frame(thor,day=format(thor$date,"%a")) # 요일추가
thor_weekend=c()
for ( i in 1:length(thor$day)){
  if (thor$day[i]=="토" | thor$day[i]=="일"){
    thor_weekend=c(thor_weekend,"#821122")
  }else{
    thor_weekend=c(thor_weekend,"#cccccc")
  }
}
barplot(thor$audiCnt,col=thor_weekend,border=NA,main="토르 : 다크월드")
plot(thor$audiCnt,type="l");points(thor$audiCnt,col=thor_weekend)
plot(thor$scrnCnt,type="l");points(thor$scrnCnt,col=thor_weekend)
plot(thor$showCnt,type="l");points(thor$showCnt,col=thor_weekend)

##################################################
#관상?????
kwansang=subset(movie2,subset=(movieNm=="관상"))
kwansang=data.frame(index=1:length(kwansang[,1]),subset(movie2,subset=(movieNm=="관상"))[,c(1,3,4,5,6,7,8)])
kwansang=data.frame(index=kwansang[,1],date=as.Date(as.character(kwansang$date),"%Y%m%d"),kwansang[,-c(1,2)])
kwansang=data.frame(kwansang,day=format(kwansang$date,"%a"))

kwansang_weekend=c()
for ( i in 1:length(kwansang$day)){
  if (kwansang$day[i]=="토" | kwansang$day[i]=="일"){
    kwansang_weekend=c(kwansang_weekend,"#821122")
  }else{
    kwansang_weekend=c(kwansang_weekend,"#cccccc")
  }
}
barplot(kwansang$audiCnt,col=kwansang_weekend,border=NA,main="관상")
plot(kwansang$scrnCnt,type="l");points(kwansang$scrnCnt,col=kwansang_weekend)

plot( kwansang$audiCnt / kwansang$scrnCnt , type='l') ; points(kwansang$audiCnt / kwansang$scrnCnt , col = kwansang_weekend)

x= 1:12
abline(lm((subset(kwansang, subset=(day=="토" | day=="일" ))$audiCnt / subset(kwansang, subset=(day=="토" | day=="일" ))$scrnCnt)~x))
#################################################
#숨바꼭질
hideseek=subset(movie2,subset=(movieNm=="숨바꼭질"))
hideseek=data.frame(index=1:length(hideseek[,1]),subset(movie2,subset=(movieNm=="숨바꼭질"))[,c(1,3,4,5,6,7,8)])
hideseek=data.frame(index=hideseek[,1],date=as.Date(as.character(hideseek$date),"%Y%m%d"),hideseek[,-c(1,2)])
hideseek=data.frame(hideseek,day=format(hideseek$date,"%a"))
hideseek_weekend=c()
for ( i in 1:length(hideseek$day)){
  if (hideseek$day[i]=="토" | hideseek$day[i]=="일"){
    hideseek_weekend=c(hideseek_weekend,"#821122")
  }else{
    hideseek_weekend=c(hideseek_weekend,"#cccccc")
  }
}
barplot(hideseek$audiCnt,col=hideseek_weekend,border=NA,main="숨바꼭질")
plot(hideseek$scrnCnt,type="l");points(hideseek$scrnCnt,col=hideseek_weekend)

###################################################
#주온 : 끝의 시작
juon = subset(movie14_2,subset=(movieNm == "주온 : 끝의 시작"))
juon = data.frame(date=as.Date(as.character(juon$date),"%Y%m%d"),juon[,-1])
juon = data.frame(juon,day = format(juon$date,"%a"))

juon_weekend=c()
for ( i in 1:length(juon$day)){
  if (juon$day[i]=="토" | juon$day[i]=="일"){
    juon_weekend=c(juon_weekend,"#821122")
  }else{
    juon_weekend=c(juon_weekend,"#cccccc")
  }
}
barplot(juon$audiCnt,col=juon_weekend,border=NA,main="주온 : 끝의 시작",ylim=c(0,100000),names.arg=juon$audiCnt)
plot(juon$scrnCnt,type="l",,ylim=c(250,400));points(juon$scrnCnt,col=juon_weekend)

#######################################
#7월의 누적관객수는 해마다 증가하는가? (영화관람객 수 전체의 파이는 증가하고 있는가??)
sum(subset(movie2,subset=(date>20120700 & date<20120727))$audiCnt) #15201486명
sum(subset(movie2,subset=(date>20130700 & date<20130727))$audiCnt) #14427108명
sum(subset(movie14_2,subset=(date>20140700 & date<20140727))$audiCnt) #14793179명 
#아닌듯

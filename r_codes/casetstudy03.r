library(plyr)
plot(ddply(movie2,"date",summarise,sum(audiCnt))[,2],type="l") #요일별로 영화 관객수를 합산한 결과에 대한 시계열 그래프

dailysum = ddply(movie2,"date",summarise,sum(audiCnt))
names(dailysum) = c("date","audiSum")
dailysum = data.frame(date=as.Date(as.character(dailysum[,1]),"%Y%m%d"),audiSum=dailysum$audiSum)
dailysum = data.frame(dailysum,day=format(dailysum[,1],"%a"))

plot(subset(dailysum,subset=(day != "일" & day!= "토"))[,2], type='l') #평일 영화관객수합
plot(subset(dailysum,subset=(day == "일" | day == "토"))[,2], type='l')
plot(dailysum[,2],type='l')


#########현재 생각한 방법
# 영화는 "선택의 문제"다
# 영화를 볼 때는 그날 볼 수 있는 여러가지 영화들 중에서 볼 수 있거나 보고싶은 영화를 본다
# 그러니까 각 영화의 시계열 보다는 하루하루를 한 덩어리로 생각해서 예측해야하지 않을까???
# 매일 boxoffice top10영화들 전체의 audiCnt 합을 예측
# 그 중에서 타겟 영화가 몇 %를 가져갈 수 있을 것인가!! (ScrnCnt 혹은 showCnt를 이용하자)
# 다양하게 적용해보고 적당한 가중치를 결정하자

##어떻게 구하지? -1
#ddply로 매일 audiCnt합을 구해서 한 열로 만든다 (summarise말고 transform)
#생각해둔 비교값으로 (일단은 scrnCnt보다는 showCnt가 나아보인다) 예상값을 구해본다
#가중치를 조정해서 원하는 값을 구해본다
#2014년에 적용해본다
#우선 2012년과 2013년 7월의 dailysum값 추이를 분석해야 할듯


dailypred = ddply(movie2,"date",mutate,
                    audiSum=sum(audiCnt),scrnRat=scrnCnt/sum(scrnCnt),showRat=showCnt/sum(showCnt),
                    showPred=round(audiSum*showRat,1),scrnPred=round(audiSum*scrnRat,1),
                    showRes=audiCnt-showPred, scrnRes=audiCnt-scrnPred )
subset(dailypred[,c(1,2,3,6,12,13,14,15)],subset=(showRes>100000))

##어떻게 구하지? -2
#전날의 영화 비율을 예측한 내일 영화관객수에 곱해서 구한다?
#장르/특징을 통해 기본적인 비율을 예측해보고 거기에다가 가능한 보정값을 추가
#생각해볼것!!!!!!!!!!!!!!!! 신작이 개봉할때 얼마만큼 기존 비율을 잠식해 들어갈까
#신작의 개봉이 영화 관객의 전체 파이를 키우는 경우가 있는지 살펴보고 있다면 있는경우와 없는경우를 비교하쟝

subset(ddply(movie,"date",mutate,audiSum=sum(audiCnt),audiRat=round(audiCnt/audiSum,2)),select=c(1,2,14,17:21),subset=(rank==1))
#1위일 때의 비율

head(read.csv("d:/docu/ybigta/casestudy/movie3_kofic_all.csv"),header=T)
kofic_all = read.table("d:/docu/ybigta/casestudy/movie3_kofic_all_ansi.txt",header=T,sep="\t")


# 좌석점유율????
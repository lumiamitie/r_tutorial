#정렬, 필터링

#데이터 프레임 정렬을 해보자
d = data.frame( A=c(1,3,2) , B=c("a","b","c") )

#d의 1열인 A의 오름차순으로 정렬을 하려면???
#일단 3개밖에 없으니깐 수작업으로 해보자
d[,]
d[c(1,2,3),] #똑같다.. 그러면 c() 안에있는 내용의 순서를 바꿔보면?
d[c(1,3,2),]

#그렇다면 이걸 함수를 이용해서 자동으로 하려면??? 뭐가 필요할까

#order 함수
order(c(4,5,3,8,1))
#결과는 5,3,1,2,4 => 무슨 뜻일까??
#가장 작은수가 5번째 항목, 2번째로 작은수가 3번째 항목, 3번째로 작은수가 1번째 항목, .......
#어떻게 이용하지?? => 데이터 프레임 정렬

head(iris)
#첫번째 항목인 Sepal.Length 기준으로 전체 데이터를 정렬해 보자

order(iris[,1]) #를 해보면 iris 1열에 대해 작은 순서대로 '인덱스'를 출력한다

iris[order(iris[,1]),]
#필터링
# 1) iris 데이터에서 Sepal.Width 가 3.0 이상인 것만 추려보고 싶으면?
#다시 d를 불러봐요
d
d[,]
d[c(T,T,T),] #똑같다!! 인덱스 뿐만 아니라 불리언 값도 들어감
d[c(T,F,T),] #2번이 빠지고 1,3만 
#c() 안에 들어있는 불리언 값의 개수가 row의 개수와 다르다면??
#R의 "재사용성" -> R초급 수업에서 했을껄
d[c(T,T),] # c(T,T,T) 와 같다
d[c(T,F),] # c(T,F,T) 와 같다
d[c(F,T),] # c(F,T,F) 와 같다
#왠만하면 개수 맞춰라 ㅋㅋㅋㅋㅋㅋ
#필터링을 한다면서 이걸 왜했냐고?
d[,1]>1 #의 결과값은?? FALSE TRUE TRUE
d[c(F,T,T),]
d[d[,1]>1,] #ㅇㅋ?

#그러면 iris에 적용해보자
iris[iris[,2]>3.0,]

# 2) setosa 종만 불러보자
#앞하고 내용 똑같지만 비교연산자만 바꾸면됨
d[,2]=="a" #TRUE FALSE FALSE
d[d[,2]=="a",] # B가 a인 것만 나온다

iris[iris[,5]=="setosa",]

#참고
levels(iris[,5]) # iris자료의 5열은 factor 이다

# 3) setosa 품종에 대해서 Petal.Length 기준으로 오름차순
d #는 데이터 프레임
d[,] #d가 데이터 프레임이니까 가능
d[d[,1]>1,] #이것도 데이터 프레임
d[d[,1]>1,][,] #그럼 얘는......??
d[d[,1]>1,][d[d[,1]>1,2]=="b",] #이건 무슨 의미일까
#d[d[,1]>1,]중에서 d[d[,1]>1,2]=="b" 인 행을 불러온다
#iris에 적용해보자 

iris[iris[,5]=="setosa",][order(iris[iris[,5]=="setosa",3]),]


###########################################################################
#merge 함수
#SQL의 Join과 비슷하다

e=data.frame(B=c('a','c','b'),D=c(11,33,22))
merge(d,e)

f=data.frame(C=c('a','c','b'),D=c(11,33,22))
merge(d,f) #?????
merge(d,f,by.x="B",by.y="C")


#install.packages("sqldf")
library(sqldf)
sqldf("select * from iris
      where Species = 'setosa' and Sepal_width > 3.0 
      order by Sepal_Length 
      ")

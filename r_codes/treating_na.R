# NA 에 대해 알아보자. Not Available !

# NA - 보통 관찰되지 않아 기록이 없을 경우에 사용된다. missing value. 빈 칸은 아니다.
#    - NA 가 들어간 연산은 결과가 늘 NA 이다.
#    - na.rm=TRUE  이라는 argument로 NA 를 무시하고 작업을 수행할 수도 있다.

# cf) NaN(Not a Number) - 수학 연산에서 정의되지 않은 결과
#                       - R에서는, NaN 가 NA 에 포함된다.

# cf) NULL - '오브젝트가 없음'을 의미한다.
#          - function을 돌릴 때, 정의되지 않은 값을 넣어주면 결과로 NULL 이 나오는 걸 종종 볼 수 있다.?

# 어떠한 값이 NA 또는 NaN 인지 알아볼 때, == 을 절대 쓰지 말 것. 늘 NA 또는 NaN 만 출력되기 때문.

# ex.1
x <- c (NA, FALSE, TRUE)
outer(x, x, "&")
outer(x, x, "|")

# ex.2
0/0
5+NULL
(3+5i)*NULL

# ex.3
x <- NaN
is.na(x)
x == NA
is.nan(x)
y <- 1
y == NA
is.na(y)
z <- NA
is.nan(z)

###############################################################################################

# na.rm = TRUE 를 이용해보자.

v <- c(1, 3, NA, 5)
5*v
sum (v)
sum (v, na.rm = TRUE)
length (v)

# na.string="." 를 이용해보자.
# lifespandata_1.txt 파일을 디렉토리에 넣고, 불러온다.

read.table("data/lifespandata_1.txt", header=TRUE, na.string=".")
read.table("data/lifespandata_11.txt", header=TRUE, na.string=".") #안열림
read.table("data/lifespandata_111.txt", header=TRUE, na.string=".")

# lifespandata_111.txt 를 제대로 불러오기 위해서는 어떻게 해야 할까?
read.table("data/lifespandata_111.txt", header=TRUE, na.string=c(".","a"))

# caret 이라는 package를 이용해보자.
x <- data.frame (a=c(1, 2, 3) , b=c("a", NA , "c"), c=c("a", "b", NA))
x
na.omit (x)  # NA가 포함된 행을 제외.
na.pass (x)  # NA의 포함여부를 상관하지 않음.
na.fail (x)  # 데이터에 NA가 포함되어있을 경우 에러를 내보냄.


###############################################################################################

# 문제1
# V <- c(1, 3, NA, 5) 일때, NA가 아닌 값들로 이루어진 벡터 W1을 만들어보시오.
V <- c(1, 3, NA, 5)


#문제2 (어려운 것도 한 번 해봅시다.)

# 아래의 코드를 실행하여 6x10 인 행렬 aMat 을 생성하여라.  
set.seed(75)
aMat <- matrix(sample(100,size=60,replace=TRUE),nrow=6)

# aMat에 행 이름을 “obs1”, …, ”obs6”, 열 이름을 “v1”, ”v2”, … , ”v10”로 저장하자.  

rownames(aMat) = paste0("obs",1:6)
colnames(aMat) = paste0("v",1:10)

# aMat에서 각 열 별 평균이 50보다 큰 경우는 1, 50보다 작거나 같은 경우는 0의 값을 가지는 
# 길이 10인 벡터 aVec를 생성하여라. (벡터의 원소 값을 직접 입력하지 말 것)

sapply(apply(aMat,2,mean), function(x) ifelse(x>50, 1, 0))


# aMat에서 ‘5열의 원소가 5보다 크거나 같은 행’ 그리고 ‘3행 또는 4행의 원소가 5보다 크거나 같은 열’로만 
# 구성된 sub 행렬인 subMat를 생성하여라. 또한 subMat의 행 수와 열 수를 출력하여라. 
# (행렬의 원소 값 또는 행, 열 수를 직접 입력하지 말 것)  

subMat = aMat[aMat[,5] >= 5, aMat[3,]>=5|aMat[4,]>=5]
dim(subMat)

# aMat의 4행 2열 원소와 2행 7열 원소를 NA로 수정하여라.  
aMat[4,2] = NA
aMat[2,7] = NA


# 수정된 aMat에서 NA가 포함된 행을 제외한 나머지 자료에 대하여, 각 열 별 평균과 표준편차를 구하여라. 
# (해당 행 번호를 직접 입력하여 제거하도록 코드를 작성하지 말고, NA가 어디에 위치하든 관계없이 코드가 
# 수행될 수 있도록 일반화하여 작성할 것) 

apply(aMat, 2, function(x) mean(x, na.rm = TRUE))
apply(aMat, 2, function(x) sd(x, na.rm = TRUE))


# aMat에서 NA에 해당하는 두 원소 값을, 해당 원소를 포함하고 있는 열의 나머지 원소들의
# 평균 값으로 각각 대체하여라. (해당 원소의 위치를 직접 입력하여 수정하는 방식으로 코드를 작성하지 말고,
# NA가 어디에 위치하든 관계없이 코드가 수행될 수 있도록 일반화하여 작성할 것) 




for(i in 1:dim(aMat)[2]){
 if(is.na(sum(aMat[,i]))==TRUE){
   aMat[which(is.na(aMat[,i])), i] = apply(aMat, 2, function(x) mean(x, na.rm = TRUE))[i]
 }
}



#수정된 aMat를 행 별 합, 열 별 합, 전체 합이 포함되도록 확장한 6x10 행렬 aMat2를 생성하여라.  
aMat2 = cbind(aMat, colsum = apply(aMat,1, function(x) mean(x, na.rm = TRUE)))
aMat2 = rbind(aMat2, rowsum = apply(aMat2,2, function(x) mean(x, na.rm = TRUE)))


# 수정된 aMat에서 짝수인 원소들은 각각 몇 행 몇 열의 자료인지를 기록한 행렬 aMat3를 생성하여라. 
# 단, aMat3는 aMat에서 짝수인 원소의 개수를 행의 수로 가지고 열의 수는 2가 되도록 하여, aMat3에서 각 행은 
# aMat에서 짝수인 원소가 몇 행 몇 열의 자료인지를 나타내는 (행 인덱스, 열 인덱스)로 정의되어야 한다. 
# (행렬 원소 값을 직접 입력하지 말 것) 




##################################################
rm(list=ls())

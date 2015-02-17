install.packages("doBy")
library(doBy)

# summary 함수와 비교
# summary의 경우 Species와는 관계없이 전체 값에 대해 평균을 냄
summary(iris)

# 각 Species에 해당하는 평균
summaryBy(Sepal.Width + Sepal.Length ~ Species, iris)

# 기존 order 함수
iris[order(iris$Sepal.Width),]

# orderBy
orderBy(~ Sepal.Width, iris)

# Species, Sepal.Width별로 정렬
orderBy(~ Species + Sepal.Width, iris)


# 기존 sample()
sample(1:10, 5)
sample(1:10, 5, replace =TRUE) # 중복 추출

# 데이터 무작위로 섞기
# 데이터 개수만큼 sampling
sample(1:10, 10)


# sample
ind <- sample(2, 
              nrow(iris), 
              replace = TRUE, 
              prob = c(0.1, 0.9))
iris_sample <- iris[ind == 1,]
head(iris_sample)

# sampleBy()
sampleBy(~ Species, frac = 0.1, data = iris)


# split
iris_split <- split(iris, iris$Species) # list로 만들어짐
iris_split


# subset
subset(iris, Species == "setosa")

# merge
x <- data.frame(name = c("a", "b", "c"), math = c(1, 2, 3))

y <- data.frame(name = c("c", "b", "d"), english = c(4, 5, 6))

# NA값 제거하고 merge
merge(x, y, all = FALSE)

# NA값 포함
merge(x, y, all = TRUE)


# which
x <- c(2, 4, 6, 7, 10)
x %% 2
which(x %% 2 != 0)

# aggregate
# iris에서 Species별 Sepal.Width 평균 구하기
aggregate(Sepal.Width ~ Species, iris, mean)


# stack / unstack
x <- data.frame(medicine = c("a", "b", "c"),
                ctl = c(5, 3, 2),
                exp = c(4, 5, 7))

stacked_x <- stack(x)

###########################333

d <- matrix(1:9, ncol = 3)
d

apply(d, 1, sum) # 방향이 1이면 행의 합
apply(d, 2, sum) # 방향이 2이면 열의 합

apply(iris[,1:4], 2, sum)
colSums(iris[,1:4])


vect <- c(1:5)
vect

result <- lapply(vect, function(x){ x * 2})
result
unlist(result)

# 벡터의 경우 서로 다른 데이터 타입이 공존할 수 없기 때문에
# 숫자와 문자가 섞인경우 강제로 문자로 변환된다 -> 확인필요

unlist(lapply(iris[,1:4], mean))

sapply(iris[,1:4], mean) # numeric



tapply(1:10, rep(1,10), sum) # 동일한 색인 1

index <- c(1:10) %% 2 == 1
index
tapply(1:10, index, sum)

tapply(iris$Sepal.Length, iris$Species, mean)


m <- matrix(1:8, 
            ncol = 2, 
            dimnames = list(c("spring", "summer", "fall", "winter"),
                            c("male", "female")))

tapply(m, c(1, 1, 2, 2, 1, 1, 2, 2), sum)

tapply(m, list(c(1, 1, 2, 2, 1, 1, 2, 2),
               c(1, 1, 1, 1, 2, 2, 2, 2)), sum)

mapply(function(i, s){
  sprintf("%d%s", i, s)
}, 1:3, c("a", "b", "c"))


# 갑자기 생각나서.... 구구단 만들기
mapply(function(i,j){
  sprintf("%d x %d = %d", i, j, i*j)
},rep(1:9,9), rep(1:9, each =9))

# 갑자기 생각나서....2 구구단 만들기
outer(1:9, 1:9, function(x, y){sprintf("%d x %d = %d",x, y, x*y)})
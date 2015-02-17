# 서울시 중구 가로등 현황 자료
#streetlamp <- read.csv("streetlamp.csv",header = T)
streetlamp <- 
  read.csv("https://raw.githubusercontent.com/lumiamitie/lumiamitie.github.io/master/data/streetlamp.csv",
  header = T,
  fileEncoding = "UTF-8")

# install.packages(reshape2)
library(reshape2)

# melt는 피벗테이블 처럼 생긴 자료를 id, variable, value 형태로 반환해준다
# melt(데이터, value.name = "value변수이름")
tidy_streetlamp <- melt(streetlamp, value.name = "count")

# names(데이터프레임) 은 각 열의 이름들을 반환해준다
# names(데이터프레임) = c(열 이름 목록) 을 통해 원하는 이름으로 변경할 수 있다
names(tidy_streetlamp) = c("location", "year", "count")
head(tidy_streetlamp)

tidy_streetlamp$year # factor

# grub("찾을단어", "바꿀단어", "데이터")
tidy_streetlamp$year <- gsub("X|년", "", tidy_streetlamp$year)
head(tidy_streetlamp)


# install.packages(dplyr)
library(dplyr)

dplyr_streetlamp <- melt(streetlamp, value.name = "count")
dplyr_streetlamp <- mutate(dplyr_streetlamp, year = gsub("X|년","",variable))
dplyr_streetlamp <- select(dplyr_streetlamp, location = X, year, count)
filter(dplyr_streetlamp, year == 2011)

# 연도별 평균 계산하기
# group_by(데이터프레임, 그룹화할 변수)
# summarise(데이터프레임, 요약하는데 쓸 함수)
year_streetlamp <- group_by(dplyr_streetlamp, year)
summarise(year_streetlamp, mean(count))
mutate(year_streetlamp, mean(count))
mutate(year_streetlamp, mean = mean(count), diff = count - mean)

# 동별 평균 계산하기
location_streetlamp <- group_by(dplyr_streetlamp, location)
summarise(location_streetlamp, mean(count))
mutate(location_streetlamp, mean(count))
mutate(location_streetlamp, mean = mean(count), diff = count - mean)

# count와 mean(count)를 구한다음에 그 차이가 0 이하인 경우
filter(mutate(location_streetlamp, 
         mean = mean(count), 
         diff = count - mean), diff < 0)

# 위 결과에서 동별로 diff < 0 이었던 횟수 구하기
count_minus <- summarise(filter(mutate(location_streetlamp, 
                         mean = mean(count), 
                         diff = count - mean),diff < 0),count = n())
count_minus

# count를 기준으로 내림차순 정렬하기
arrange(count_minus, desc(count))

# count를 기준으로 오름차순 정렬하기
arrange(count_minus, count)


# pipe operator "%>%"
# RStudio Keyboard Shortcut : ctrl + shift + m (맥은 cmd + shift + m )
# 이전 문장의 결과물을 다음 문장의 첫번째 인자로 투입
# function(X1,X2,X3) 는 X1 %>% function(X2, X3)와 같다
# 위에있는 filter(mutate(location_streetlamp, mean = mean(count), diff = count - mean), diff < 0) 는
location_streetlamp %>%
  mutate(mean = mean(count), diff = count - mean) %>%
  filter(diff < 0)
# 와 같은 결과물이다

# '연도별 평균 계산하기'를 pipe operator 이용해서 계산하기
pipe_result <- 
  streetlamp %>%
  melt(value.name = "count") %>%
  mutate(year = gsub("X|년","",variable)) %>%
  select(location = X, year, count) %>%
  group_by(year) %>%
  mutate(mean = round(mean(count),2), 
         diff = round(count - mean, 2))

#### 우리말 풀이 #################################################
# pipe_result라는 변수는
# streetlamp라는 변수를
# melt() 시키는데 value 이름은 count로 바꿔주고
# variable 항목에서 "X"랑 "년"을 빈칸으로 바꾼다음에 year라고 이름을 바꾸고
# X로 location으로 이름을 바꿔서 location, year, count 변수만 보여주는데
# location으로 그룹을 묶어서
# 그룹별로 평균을 구하고 각 값에서 평균을 뺀 값을 diff라고 할게요
# 라는 의미!!

# 저걸 원래대로 쓰면
mutate(group_by(select(mutate(melt(streetlamp, value.name = "count"), year = gsub("X|년","",variable)), location = X, year, count), location), mean = mean(count), diff = count - mean)

# 동 ~ 연도별 diff 데이터로 wide format 데이터 만들기
# dcast(데이터, 세로축변수 ~ 가로축변수, value.var = "값으로 들어갈 변수")
diff_streetlamp <- dcast(pipe_result, location ~ year, value.var = "diff")

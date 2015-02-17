library(maptools)
library(ggplot2)
library(dplyr)
library(magrittr)

### 기본적인 지도 그리기 + 지역 구분
shp <- readShapePoly("D:\\data\\gis\\KOR_adm\\KOR_adm1.shp")
# 데이터는 head(shp@data)로 확인

# NAME_1 변수를 기준으로 지역을 구분하기
shp_ffd <- fortify(shp, region = "NAME_1")
# fortify에서 오류나면 rgeos 패키지를 설치해보자

ggplot(data = shp_ffd, aes(x = long, y = lat, group = group)) + geom_path()

# 지역목록
region_adm1 <- unique(shp_ffd$id)

# 지역에 해당하는 값 지정
region_val <- data.frame(region_adm1, value = 1:16)

# fortify 된 자료에 값을 추가
shp_val <- shp_ffd %>%
  left_join(region_val, by = c("id" = "region_adm1"))

ggplot(shp_val, aes(x=long, y=lat, group=group)) + geom_polygon(aes(fill = value))


###################################
# 시까지 구분된 shp파일
shp2 <- readShapePoly("D:\\data\\gis\\KOR_adm\\KOR_adm2.shp")

### 서울만 그리기 ###

# 서울로만 필터링
shp2_subset <- shp2[shp2$NAME_1 == "Seoul",]

# NAME_2 변수를 기준으로 지역 구분
shp2_ss_ffd <- fortify(shp2_subset, region="NAME_2")
ggplot(shp2_ss_ffd, aes(x=long, y=lat, group=group)) + geom_path()

# 지역 목록
region_adm2 <- unique(shp2_ss_ffd$id)
# 각 지역별로 값 대입하기
region_value2 <- data.frame(region_adm2, value = 1:length(region_adm2))

# fortify된 shp 자료에 값 추가하기
shp2_val <- shp2_ss_ffd %>%
  left_join(region_value2, by = c("id" = "region_adm2"))

ggplot(shp2_val, aes(x=long, y=lat, group=group)) + geom_path(aes(fill = value))

# 구별로 색칠하기
ggplot(shp2_val, aes(x=long, y=lat, group=group)) + geom_polygon(aes(fill = value))



# 샘플자료
smp = read.csv('vis_sample_seoul.csv')

# 지도위에 점찍기
ggplot(shp2_val, aes(x=long, y=lat)) + 
  geom_path(aes(group = group)) +
  geom_point(data = smp, aes(x=longitude, y=latitude), stat="identity")

# 등고선 형태
ggplot(shp2_val, aes(x=long, y=lat)) + 
  geom_path(aes(group = group)) +
  geom_density2d(data = smp, aes(x = longitude, y =latitude))


# 지도 + 히트맵
ggplot(shp2_val, aes(x=long, y=lat)) + 
  geom_path(aes(group = group)) +
  stat_density2d(data = smp, aes(x = longitude, y =latitude, alpha = ..level..), geom="polygon")

#############
# 성남 Seongnam
shp2_seongnam <- shp2[shp2$NAME_2 == "Seongnam",]
plot(shp2_seongnam)
# 구 구분이 안되어있음 ㅠㅠ
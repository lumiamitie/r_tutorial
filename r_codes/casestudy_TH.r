#merge(movie2,movie_info,by.x="movieNm",by.y="title")
movie_plusinfo=merge(movie2,movie_info,by.x="movieNm",by.y="title")[,c(1,2,3,6,7,8,10,11,13)]
movie_plusinfo=movie_plusinfo[order(movie_plusinfo[,1],movie_plusinfo[,2]),] #영화이름, 날짜로 다시 정렬
#SF, 판타지, 액션 => 사전 기호가 뚜렷??
#사전기호가 뚜렷하면 개봉초반에 관객이 집중되고 관객수가 많다

#정보접근성이 높은경우 관객감소세가 완만하다
#정보접근성 = 배급사의 규모

#movie_info 의 장르구분
levels(movie_info[,6])
#SF, 가족, 공포, 다큐멘터리, 드라마, 로맨스/멜로, 무협, 뮤지컬, 마스터리, 범죄, 스릴러, 시대극, 애니메이션, 액션, 어드벤처, 전쟁
#코미디, 판타지

#plot과 lines로 함께 표기가능.... 다만 정규화를 시킬지 생각해볼필요가
plot(subset(movie_plusinfo,select=c(3),subset=(movieNm=="설국열차"))[,],type='l')
lines(subset(movie_plusinfo,select=c(3),subset=(movieNm=="건축학개론"))[,],type='l',lty=2)

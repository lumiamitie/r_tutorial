#function for movie

searchByName=function(dfNm,mNm){
  df=get(dfNm)
  #head(get(dfNm))
  print(df[df["movieNm"]==mNm,])
  plot(subset(df,select=c(date,audiCnt),subset=(movieNm==mNm)), type='l')
  #plot(df[df["movieNm"]==movieNm,]["audiCnt"],type='l')
}

searchByMonth=function(dfNm,yymm,restrict){
  df=get(dfNm)
  target_month=20000000 + (yymm*100)
  subset_bymonth=subset(movie2,subset=(date > target_month & date<(target_month + 100 )))
  subset_othermonth=subset(movie2,subset=(date > (target_month-200) & date<(target_month + 300 )))
  monthly_list=list()
  #monthly_date=list()
  for (i in levels(factor(subset_bymonth[,"movieNm"]))) {
    if(restrict==TRUE){
      subset_byMonthName=subset(subset_bymonth,subset=(movieNm == i))
    }else{
      subset_byMonthName=subset(subset_othermonth,subset=(movieNm == i))
    }
    monthly_list[i] = list(subset_byMonthName[,"audiCnt"])
   # monthly_date[i] = list(subset_byMonthName[,"date"])
  }
 return (monthly_list)
}

dateByMonth=function(dfNm,yymm,restrict){
  df=get(dfNm)
  target_month=20000000 + (yymm*100)
  subset_bymonth=subset(movie2,subset=(date > target_month & date<(target_month + 100 )))
  subset_othermonth=subset(movie2,subset=(date > (target_month-200) & date<(target_month + 300 )))
  #monthly_list=list()
  monthly_date=list()
  for (i in levels(factor(subset_bymonth[,"movieNm"]))) {
    if(restrict==TRUE){
      subset_byMonthName=subset(subset_bymonth,subset=(movieNm == i))
    }else{
      subset_byMonthName=subset(subset_othermonth,subset=(movieNm == i))
    }
    #monthly_list[i] = list(subset_byMonthName[,"audiCnt"])
    monthly_date[i] = list(subset_byMonthName[,"date"])
  }
  return (monthly_date)
}

indexbyMonth=function(dfNm,yymm,restrict,mNm){
  df=get(dfNm)
  target_month=20000000 + (yymm*100) 
  subset_bymonth=subset(movie2,subset=(date > target_month & date<(target_month + 100 )))
  subset_othermonth=subset(movie2,subset=(date > (target_month-200) & date<(target_month + 300 )))
  if(restrict==TRUE){
    
  }else{
    
  }
}
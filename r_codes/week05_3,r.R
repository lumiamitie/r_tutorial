
library(xlsx)

sell <- read.xlsx("week05/식수현황.xlsx", sheetIndex=2,
                  encoding="UTF-8",startRow=3)

sell <- sell[,(1:12)]





sell <- read.xlsx("week05/식수현황.xlsx", sheetIndex=2,
                  encoding="UTF-8",startRow=4)

sell <- sell[,(1:14)]
sell <- sell[c(-4,-5,-8,-11,-14)]


head(sell)
names(sell) <- c("date","day","b.id","l.id","l.cou",
                 "l.a","l.b","d.id","d.cou")

head(sell)








################################


menu <- read.xlsx("week05/메뉴표.xlsx", sheetName="5-3",
                  encoding="UTF-8",startRow=3)
#error



menu <- read.xlsx("week05/메뉴표.xlsx", sheetName="5-3",
                  encoding="UTF-8",startRow=3,
                  colIndex=(2:6))
head(menu)
names(menu) <- paste("1405",12:16, sep="")


save(list=c("sell","menu"), file="week05.rdata")






###############################
sell = read.xlsx("식수현황.xlsx",sheetIndex=2)

head(sell)

sell = read.xlsx("식수현황.xlsx",sheetIndex=2,startRow=3)
head(sell)

#startRow, endRow 지정해주면 파일이 클 때도 빠르게 앞부분만 불러올 수 있다.
#local에서 할 때는 UTF=8 지정해주는게 좋을듯

sell <- read.xlsx("week05/식수현황.xlsx", sheetIndex=2,startRow=4)

sell <- sell[,(1:14)]
sell <- sell[c(-4,-5,-8,-11,-14)]
head(sell)
names(sell) <- c("date","day","b.id","l.id","l.cou",
                 "l.a","l.b","d.id","d.cou")

menu <- read.xlsx("메뉴표.xlsx", sheetName="5-3",
                  encoding="UTF-8",startRow=3,
                  colIndex=(2:6))

######################################

#establish connection
con <- dbConnect(MySQL(), user="root", password="ybigta", dbname="PARTY", host="ybigta.iptime.org")


#get table info through con
dbListTables(con)    #read table list
#same as dbGetQuery(con, "SHOW TABLES;")
dbListFields(con, "sell")    #read field list


#read entire data in the table
#d <- dbReadTable(con, "party")
d <- dbReadTable(con, "sell", as.data.frame) #as.data.frame은 지워도 괜찮다
d


#밑에 요건 자료형이 맘대로라서 sql들어가서 자료형 손봐줘야함 그래도 편해서좋음
dbWriteTable(con, "party2", d)


#dbGetQuery: fetch data right after excuting script
#dbSendQuery: create cursor and fetch data when excute 'fetch()'
dbGetQuery(con, "select count(*) from party") #dbGetQuery(컨넥션이름, 쿼리문)
dbGetQuery(con, "select * from party limit 3")
#d=dbSendQuery(con, "select * from sell") #rs:result
#fetch(rs, n=1) #1불러옴
#fetch(rs, n=1) #2불러옴
#fetch(rs, n=3) #3,4,5 불러옴
#dbSendQuery와 커서를 잘 이용하면 대용량데이터를 불러올 때 메모리 걱정안하고 끊어서 불러오는게 가능해짐
#보통은 getQuery 그냥 쓰면됨

dbGetQuery(con,"drop table abc")

rs <- dbSendQuery(con, "select * from party")    #rs : result set
d1 <- fetch(rs, n = 3)    #fatch some rows from result set
d2 <- fetch(rs, n = -1)   #-1 is the rest
dbClearResult(rs)    #clear result set. not delete rs itself


#get meta-info from connection
summary(MySQL(), verbose = TRUE)    #summary MySQL-driver
summary(con, verbose = TRUE)    #summary connection
summary(rs, verbose = TRUE)    #summary result set request(cursor)
dbListConnections(MySQL())    #list-up current connection
dbHasCompleted(rs)    #check whether cursor has been completed or not


#disconnect db connection
dbDisconnect(con)





##################################





library(RMySQL)
library(sqldf)


load("week05.rdata")
head(sell)

con <- dbConnect(MySQL(), user="root", password="ybigta", dbname="R", host="localhost")

#  row[,2] <- iconv(row[,2], 'EUCKR', 'UTF-8') #iconv함수는 인코딩을 바꿔준다. 한글은 UTF-8이면 안깨짐
#서버는 UTF-8, window는 보통 EUCKR
#assign 함수는 광역변수를 만들어준다. 반복문 사용 시 편리하다
#한 줄을 먼저 읽어서 변수에 넣고 그걸 insert문으로 집어넣는다
for(i in 1:30){
  assign("row", sell[i,])
  if(row[,2] != "토" & row[,2] != "일"){
    assign("date", paste("2014-04-0",row[,1],sep=""))
    assign("day", row[,2])
    assign("sql1", paste("INSERT INTO sell2(date, day, meal, isID, count) VALUE('",date,"', '", day,"', 'breakfast', ", 1, ", ", row[,3], ");", sep=""))
    assign("sql2", paste("INSERT INTO sell2(date, day, meal, isID, count) VALUE('",date,"', '", day,"', 'lunch', ", 1, ", ", row[,4], ");", sep=""))
    assign("sql3", paste("INSERT INTO sell2(date, day, meal, isID, count) VALUE('",date,"', '", day,"', 'lunch', ", 0, ", ", row[,5], ");", sep=""))
    assign("sql4", paste("INSERT INTO sell2(date, day, meal, shop, count) VALUE('",date,"', '", day,"', 'lunch', 'A', ", row[,6], ");", sep=""))
    assign("sql5", paste("INSERT INTO sell2(date, day, meal, shop, count) VALUE('",date,"', '", day,"', 'lunch', 'B', ", row[,7], ");", sep=""))
    assign("sql6", paste("INSERT INTO sell2(date, day, meal, isID, count) VALUE('",date,"', '", day,"', 'dinner', ", 1, ", ", row[,8], ");", sep=""))
    assign("sql7", paste("INSERT INTO sell2(date, day, meal, isID, count) VALUE('",date,"', '", day,"', 'dinner', ", 0, ", ", row[,9], ");", sep=""))
  }
  dbGetQuery(con, sql1)
  dbGetQuery(con, sql2)
  dbGetQuery(con, sql3)
  dbGetQuery(con, sql4)
  dbGetQuery(con, sql5)
  dbGetQuery(con, sql6)
  dbGetQuery(con, sql7)
}

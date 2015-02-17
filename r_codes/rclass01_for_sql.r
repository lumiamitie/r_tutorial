library(RMySQL)

#establish connection
#con <- dbConnect(MySQL(), user="root", password="ybigta", dbname="hjh", host="ybigta.com")
con <- dbConnect(MySQL(), user="root", password="ybigta", dbname="hjh", host="localhost")

#get table info through con
dbListTables(con)    #read table list
#same as dbGetQuery(con, "SHOW TABLES;")
dbListFields(con, "students")    #read field list

read entire data in the table
#d <- dbReadTable(con, "party")
d <- dbReadTable(con, "teachers", as.data.frame) #as.data.frame은 지워도 괜찮다
d

#dbGetQuery: fetch data right after excuting script
#dbSendQuery: create cursor and fetch data when excute 'fetch()'
dbGetQuery(con, "select count(*) from teachers") #dbGetQuery(컨넥션이름, 쿼리문)
dbGetQuery(con, "select * from students limit 3")
dbGetQuery(con, "select * from students")
#d=dbSendQuery(con, "select * from sell") #rs:result
#fetch(rs, n=1) #1불러옴
#fetch(rs, n=1) #2불러옴
#fetch(rs, n=3) #3,4,5 불러옴
#dbSendQuery와 커서를 잘 이용하면 대용량데이터를 불러올 때 메모리 걱정안하고 끊어서 불러오는게 가능해짐
#보통은 getQuery 그냥 쓰면됨

rs <- dbSendQuery(con, "select * from students")    #rs : result set
d1 <- fetch(rs, n = 3)    #fatch some rows from result set
d2 <- fetch(rs, n = -1)   #-1 is the rest
dbClearResult(rs)    #clear result set. not delete rs itself

dbDisconnect(con)
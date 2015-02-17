gundo_predRate = c(4.640824718,1.207772158,1.99935886,0.912403325,0.385491764,0.956974963,0.956344244,0.784291232,1.275000727,1.980382232,0.90075579,0.365187054,0.899358105,0.902966346,0.779718917,1.282240975,1.977466718,0.899888296,0.36849886,0.927468029,0.886842734,0.673388717,1.255555879,2.109845183,0.907110437,0.333886118,0.940112652,0.871874189,0.751215365,1.284755048)
juon_predRate = c(4.352799289,1.223172577,2.014295723,0.912525284,0.386915367,0.956414084,0.949393376,0.789876279,1.268820427,1.973103441,0.900836279,0.368639892,0.898164064,0.90187533,0.770485131,1.277766497,1.977232693,0.902206644,0.370968233,0.930793876,0.888889355,0.66523217,1.213670381,2.199406172,0.907193957,0.334065063,0.937654908,0.885640595,0.746440271,1.267221129)
guardian_predRate = c(4.572902475,1.208858138,2.006715305,0.912062285,0.385141591,0.957655097,0.959227497,0.783580725,1.275516265,1.98295367,0.900447227,0.363924036,0.898259711,0.902309333,0.77652424,1.283172137,1.988977236,0.900080114,0.366112993,0.930266932,0.890529605,0.67071912,1.258655967,2.117146495,0.906775172,0.331697712,0.939396193,0.87486512,0.754178261,1.286652441)

gundo_pre = 13964
gundo_1st =  subset(movie14_2,subset=(movieNm=="군도: 민란의 시대"))$audiCnt[-c(1,2)] #개봉이후 audiCnt 값
gundo_pred = gundo_1st
for (i in length(gundo_1st):30){
  gundo_pred[length(gundo_pred)+1] = round(gundo_pred[length(gundo_pred)] * gundo_predRate[i+1])
}

gundo_Acc = gundo_pre + gundo_1st[1]
for(i in 2:30){
  gundo_Acc[i] = gundo_Acc[i-1] + gundo_pred[i]
}

juon_pre = 216
juon_1st = subset(movie14_2,subset=(movieNm=="주온 : 끝의 시작"))$audiCnt
juon_pred = juon_1st
for (i in length(juon_1st):30){
  juon_pred[length(juon_pred)+1] = round(juon_pred[length(juon_pred)] * juon_predRate[i+1])
}

juon_Acc = juon_pre + juon_1st[1]
for(i in 2:30){
  juon_Acc[i] = juon_Acc[i-1] + juon_pred[i]
}



guardian_1st = 200000
guardian_pred = guardian_1st
for (i in length(guardian_1st):30){
  guardian_pred[length(guardian_pred)+1] = round(guardian_pred[length(guardian_pred)] * guardian_predRate[i+1])
}

guardian_Acc = guardian_1st[1]
for(i in 2:30){
  guardian_Acc[i] = guardian_Acc[i-1] + guardian_pred[i]
}
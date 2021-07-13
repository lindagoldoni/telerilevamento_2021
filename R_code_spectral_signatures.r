# R_code_spectral_signatures.r

# ogni roccia e minerale o viva ha una propria firma spettrale

library(raster)
setwd("C:/lab/cover")

#lavoriamo su defor2.jpg

defor2<-brick("defor2.jpg")

# defor2.1, defor2.2, defor2.3
# NIR, red, green

plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="hist")

#usiamo questo dataset per visualizzare delle firme spettrali con la funzione "click" contenuto nel pacchetto "rgdal"

library(rgdal)

click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")
#dobbiamo dire su quale mappa vogliamo cliccare e definire come vogliamo fare il click ovvero un punto "p" , definiamo dimensione e colore

#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 150.5 270.5 148570      200        9       24
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 155.5 237.5 172236      195       14       19
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 612.5 231.5 176995      101      143      159
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 632.5 268.5 150486       49       94      136


#facciamo una tabella con il numero di banda, poi con uso del suolo (foresta o acqua) e utilizzeremo questo dataframe per creare l'output

#definiamo le colonne del dataset
band<-c(1,2,3)
forest<-c(200,9,24)
water<-c(49,94,136)
#ora mettiamo tutto in una tabella con la funzione
spectrals<-data.frame(band,forest,water)

library(ggplot2)

#plottiamo la firma spettrale
ggplot(spectrals,aes(x=band))+ #nel grafico in x ci va la banda e in y in una mettiamo l'acqua e in una la foresta
       geom_line(aes(y=forest), color="green")+ #inserisce le geometrie delle linee di interesse
       geom_line(aes(y=water),color="blue", linetype="dotted")+
       labs(x="band",y="reflectance")
       
###################################################################
       
#multitemporal
defor1<-brick("defor1.jpg")
plotRGB(defor1, r=1,g=2,b=3, stretch="lin")
       
#firme spettrali di defor1 
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")
#      x     y   cell defor1.1 defor1.2 defor1.3
#1  52.5 349.5  91445      151       57       58
#2  57.5 377.5  71458      153       24       29
#3 100.5 381.5  68645      217       23       47
#4 105.5 345.5  94354      224       49       64
#5  81.5 334.5 102184      217       20       37
       
#facciamo la stessa cosa con defor2
plotRGB(defor2, r=1,g=2,b=3, stretch="lin")
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")   
#      x     y   cell defor2.1 defor2.2 defor2.3
#1  66.5 341.5  97579      200      202      191
#2  77.5 368.5  78231      211       15       37
#3 116.5 368.5  78270      172      149      131
#4 116.5 334.5 102648      200       15       31
#5  90.5 310.5 119830      173      167      153
       
#definiamo le colonne del dataset
band<-c(1,2,3)
time1<-c(151,57,58)
time1p2<-c(153,24,29)
time2<-c(200,202,191)
time2p2<-c(211,15,37)
       
spectralst<-data.frame(band,time1,time1p2,time2,time2p2)
       
ggplot(spectralst,aes(x=band)) + 
       geom_line(aes(y=time1), color="red",linetype="dotted") + 
       geom_line(aes(y=time1p2),color="red",linetype="dotted") +
       geom_line(aes(y=time2),color="green",linetype="dotted") +
       geom_line(aes(y=time2p2),color="green",linetype="dotted") + #in questo modo si genera la linea puntinata anziché quella continua
       labs(x="band",y="reflectance")

#esiste una funzione che estrae direttamente i valori delle bande sui pixel che vengono selezionati a random tramite un altra funzione e su quelli si fa il grafico (in modo da fare il confronto su più dati)

#facciamo una prova con una immagine presa da earth observatory
prova<-brick("prova.jpg")
plotRGB(prova, r=1, g=2, b=3, stretch="lin")
click(prova, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")
#    x     y   cell prova.1 prova.2 prova.3
#1 293.5 779.5 216294     247     247     247
#2 557.5 526.5 398718      17     107     118
#3 667.5 239.5 605468     146     127     110

band<-c(1,2,3)
snow<-c(247,247,247)
water<-c(17,107,118)
earth<-c(146,127,110)

spectralsg<-data.frame(band,snow,water,earth)
ggplot(spectralsg,aes(x=band)) + 
       geom_line(aes(y=snow), color="blue") + 
       geom_line(aes(y=water),color="red") +
       geom_line(aes(y=earth),color="green") +
       labs(x="band",y="reflectance")

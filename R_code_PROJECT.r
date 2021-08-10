# R_code_PROJECT.r

#This is the project for the exam of remote sensing 2020-2021


library(rasterdiv)
library(RStoolbox)
library(ggplot2)
library(raster)



setwd("C:/lab/project/australia/all")
# PLOT IMMAGINI .JPG

#------------2019-------------------

# In questo step sono state raccolte tutte le bande in una lista, da cui è stato ricavato il file raster, unite in un unico file infine plottate in RGB
# il procedimento è stato ripetuto per ciascuna delle tre sezioni per ognuno dei due anni

#01_2019
list01_19<-list.files(pattern="01_2019.TIF")   #il "pattern" è il nome che identifica un gruppo di immagini salvate
import01_19<-lapply(list01_19,raster)  # applico la funzione raster
TGr01_19<-stack(import01_19)   # tramite la funzione "stack" unisco le componenti della lista in un unico file
plot(TGr01_19) 
jpeg("01_2019.jpg", 600, 800)  # con tale funzione possiamo salvare l'immagine in formato .jpg
plotRGB(TGr01_19,r=5,g=4,b=3,stretch="lin") # faccio il plot in RGB mettendo nel rosso la banda infrarossa, nel verde la banda rossa e nel blu la banda verde
dev.off()

#02_2019
list02_19<-list.files(pattern="02_2019.TIF") 
import02_19<-lapply(list02_19,raster)
TGr02_19<-stack(import02_19)
plot(TGr02_19) 
jpeg("02_2019.jpg", 600, 800)
plotRGB(TGr02_19,r=5,g=4,b=3,stretch="lin")
dev.off()

#03_2019
list03_19<-list.files(pattern="03_2019.TIF") 
import03_19<-lapply(list03_19,raster)
TGr03_19<-stack(import03_19)
plot(TGr03_19) 
jpeg("03_2019.jpg", 600, 800)
plotRGB(TGr03_19,r=5,g=4,b=3,stretch="lin")
dev.off()

#------------2020-------------------

#01_2020
list01_20<-list.files(pattern="01_2020.TIF") 
import01_20<-lapply(list01_20,raster)
TGr01_20<-stack(import01_20)
plot(TGr01_20) 
jpeg("01_2020.jpg", 600, 800)
plotRGB(TGr01_20,r=5,g=4,b=3,stretch="lin")
dev.off()

#02_2020
list02_20<-list.files(pattern="02_2020.TIF") 
import02_20<-lapply(list02_20,raster)
TGr02_20<-stack(import02_20)
plot(TGr02_20) 
jpeg("02_2020.jpg", 600, 800)
plotRGB(TGr02_20,r=5,g=4,b=3,stretch="lin")
dev.off()

#03_2020
list03_20<-list.files(pattern="03_2020.TIF") 
import03_20<-lapply(list03_20,raster)
TGr03_20<-stack(import03_20)
plot(TGr03_20) 
jpeg("03_2020.jpg", 600, 800)
plotRGB(TGr03_20,r=5,g=4,b=3,stretch="lin")
dev.off()

jpeg("TOT.jpg", 1000, 800)
par(mfrow=c(2,3))
plotRGB(TGr01_19,r=5,g=4,b=3,stretch="lin")
plotRGB(TGr02_19,r=5,g=4,b=3,stretch="lin")
plotRGB(TGr03_19,r=5,g=4,b=3,stretch="lin")
plotRGB(TGr01_20,r=5,g=4,b=3,stretch="lin")
plotRGB(TGr02_20,r=5,g=4,b=3,stretch="lin")
plotRGB(TGr03_20,r=5,g=4,b=3,stretch="lin")
dev.off()
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# NORMALIZE BURN RATIO
#NBR = (Band 5 – Band 7) / (Band 5 + Band 7).

#Il Normalized Burn Ratio (NBR) è un indice progettato per evidenziare le aree bruciate. La formula è simile a NDVI, 
#tranne per il fatto che la formula combina l'uso delle lunghezze d'onda dell'infrarosso vicino (NIR) e dell'infrarosso a onde corte (SWIR).

#La vegetazione sana mostra una riflettanza molto alta nel NIR e una riflettanza bassa nella porzione SWIR dello spettro
#l'opposto di quanto si vede nelle aree devastate dal fuoco. 
#Le aree recentemente bruciate mostrano una bassa riflettanza nel NIR e un'alta riflettanza nello SWIR, cioè la differenza tra le risposte spettrali 
#della vegetazione sana e le aree bruciate raggiungono il loro picco nelle regioni NIR e SWIR dello spettro.

#In questo modo le aree bruciate sono individuate da indici NBR negativi

#NBR 01_2020
B501_2020<-brick("B501_2020.TIF") # richiamo il file .tif e lo salvo in una variabile che identifica la banda dell'infrarosso
B701_2020<-brick("B701_2020.TIF") # la banda 7 corrisponde all'infrarosso a onde corte
nbr01_2020<-(B501_2020-B701_2020)/(B501_2020+B701_2020) # si esegue il calcolo per ricavare il valore di NBR
cl <- colorRampPalette(c('black','purple','darkblue','red','orange','yellow','green'))(100)# specifico la palette di colori desiderata
jpeg("nbr01_2020.jpg", 800, 800)
plot(nbr01_2020, col=cl, main="NBR 2020 - 01") # si plotta il tutto
dev.off()

#NBR 02_2020
B502_2020<-brick("B502_2020.TIF")
B702_2020<-brick("B702_2020.TIF")
nbr02_2020<-(B502_2020-B702_2020)/(B502_2020+B702_2020)
cl <- colorRampPalette(c('black','purple','darkblue','red','orange','yellow','green'))(100) # specifico la palette di colori
jpeg("nbr02_2020.jpg", 800, 800)
plot(nbr02_2020, col=cl, main="NBR 2020 - 02")
dev.off()

#NBR 03_2020
B503_2020<-brick("B503_2020.TIF")
B703_2020<-brick("B703_2020.TIF")
nbr03_2020<-(B503_2020-B703_2020)/(B503_2020+B703_2020)
cl <- colorRampPalette(c('black','purple','darkblue','red','orange','yellow','green'))(100) # specifico la palette di colori
jpeg("nbr03_2020.jpg", 800, 800)
plot(nbr03_2020, col=cl, main="NBR 2020 - 03")
dev.off()

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#NDVI 
#Band 4 - Red
#Band 5 - Near Infrared

#(NIR-RED)/(NIR+RED)
# B1=NIR, B2=red, B3=green

#NDVI: normalizza il DVI, fa la standardizzazione del DVI sulla somma tra NIR e RED, in modo da ottenere numeri bassi e si possono confrontare immagini con risoluzione radiometrica differente
#il range dell'NDVI è [-1 , 1]
#in questo modo è possibile riconoscere la presenza di vegetazione sana e quella non sana

#Band 1 - Coastal / Aerosol
#Band 2 - Blue
#Band 3 - Green
#Band 4 - Red
#Band 5 - Near Infrared
#Band 6 - Short Wavelength Infrared
#Band 7 - Short Wavelength Infrared
#Band 8 - Panchromatic
#Band 9 - Cirrus

#il procedimento è stato ripetuto per ciascuna sezione di ogni anno
#------------2019-------------------

#NDVI 01_2019
B501_2019<-brick("B501_2019.TIF") #si caricano i file .tif con la funzione brick
B401_2019<-brick("B401_2019.TIF")
ndvi01_2019<-(B501_2019-B401_2019)/(B501_2019+B401_2019) #facciamo l'operazione per ricavare l'NDVI
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifico la palette di colori
jpeg("ndvi01_2019.jpg", 800, 800) #estraiamo l'immagine con la funzione jpeg
plot(ndvi01_2019, col=cl, main="NDVI 2019 - 01") #plottiamo l'NDVI usando il nome della variabile a cui lo abbiamo assegnato
dev.off()

#NDVI 02_2019
B502_2019<-brick("B502_2019.TIF")
B402_2019<-brick("B402_2019.TIF")
ndvi02_2019<-(B502_2019-B402_2019)/(B502_2019+B402_2019)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifico la palette di colori
jpeg("ndvi02_2019.jpg", 800, 800)
plot(ndvi02_2019, col=cl,main="NDVI 2019 - 02")
dev.off()

#NDVI 03_2019
B503_2019<-brick("B503_2019.TIF")
B403_2019<-brick("B403_2019.TIF")
ndvi03_2019<-(B503_2019-B403_2019)/(B503_2019+B403_2019)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifico la palette di colori
jpeg("ndvi03_2019.jpg", 800, 800)
plot(ndvi03_2019, col=cl,main="NDVI 2019 - 03")
dev.off()

#------------2020-------------------

#NDVI 01_2020
B501_2020<-brick("B501_2020.TIF")
B401_2020<-brick("B401_2020.TIF")
ndvi01_2020<-(B501_2020-B401_2020)/(B501_2020+B401_2020)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifico la palette di colori
jpeg("ndvi01_2020.jpg", 800, 800)
plot(ndvi01_2020, col=cl,main="NDVI 2020 - 01")
dev.off()

#NDVI 02_2020
B502_2020<-brick("B502_2020.TIF")
B402_2020<-brick("B402_2020.TIF")
ndvi02_2020<-(B502_2020-B402_2020)/(B502_2020+B402_2020)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifico la palette di colori
jpeg("ndvi02_2020.jpg", 800, 800)
plot(ndvi02_2020, col=cl,main="NDVI 2020 - 02")
dev.off()

#NDVI 03_2020
B503_2020<-brick("B503_2020.TIF")
B403_2020<-brick("B403_2020.TIF")
ndvi03_2020<-(B503_2020-B403_2020)/(B503_2020+B403_2020)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifico la palette di colori
jpeg("ndvi03_2020.jpg", 800, 800)
plot(ndvi03_2020, col=cl,main="NDVI 2020 - 03")
dev.off()

jpeg("NDVITOT.jpg", 1000, 800)
par(mfrow=c(2,3))
plot(ndvi01_2019, col=cl, main="NDVI 2019 - 01")
plot(ndvi02_2019, col=cl,main="NDVI 2019 - 02")
plot(ndvi03_2019, col=cl,main="NDVI 2019 - 03")
plot(ndvi01_2020, col=cl,main="NDVI 2020 - 01")
plot(ndvi02_2020, col=cl,main="NDVI 2020 - 02")
plot(ndvi03_2020, col=cl,main="NDVI 2020 - 03")
dev.off()

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# DIFFERENZA NDVI

#è stata effettuata la differenza tra gli NDVI del 2020 e quelli del 2019 per valutare se ci sia stato un aumento dell'indice o una diminuzione a causa degli incendi
#per ciascuna sezione è stato fatta la differenza tra 2020 e 2019

#il procedimento è stato ripetuto 3 volte per le 3 sezioni

#IMG01 2019 -> 2020
difndviIMG01<-(ndvi01_2020-ndvi01_2019) #operazione di sottrazione tra NDVI 2020 e NDVI 2019
cls <- colorRampPalette(c('pink','red','white','blue'))(100)
jpeg("difndviIMG01.jpg", 800, 800)
plot(difndviIMG01, col=cls, main="DIFFERENZA NDVI 2019-2020 - 01")
dev.off()

#IMG02 2019 -> 2020
difndviIMG02<-(ndvi02_2020-ndvi02_2019)
cls <- colorRampPalette(c('pink','red','white','blue'))(100)
jpeg("difndviIMG02.jpg", 800, 800)
plot(difndviIMG02, col=cls, main="DIFFERENZA NDVI 2019-2020 - 02")
dev.off()

#IMG03 2019 -> 2020
difndviIMG03<-(ndvi03_2020-ndvi03_2019)
cls <- colorRampPalette(c('pink','red','white','blue'))(100)
jpeg("difndviIMG03.jpg", 800, 800)
plot(difndviIMG03, col=cls, main="DIFFERENZA NDVI 2019-2020 - 03")
dev.off()


#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# UNSUPERVISORED CLASSIFICATION

#in questo modo siamo in grado di capire qual'è la percentuale di territorio che ha subito incendi, quella rivegetata e quella che nel caso non ha subito cambiamenti.
# utilizzando la unsupervisored classification l'unico compito dell'operatore è quello di specificare il numero di classi da individuare, in questo caso specifico sono 3

#il procedimento è stato ripetuto per ogni differenza di NDVI riferita a ciascuna sezione

# ----------------difndviIMG01------------------------------------

set.seed(42)
ucIMG01<-unsuperClass(difndviIMG01, nClasses=3) # specifichiamo su cosa vogliamo fare la classificazione e quanti classi vogliamo estrapolare
jpeg("ucIMG01.jpg", 800, 800)
plot(ucIMG01$map) # quando si fa la classificazione si generano diversi output, noi siamo interessati a plottare solo la mappa e la richiamiamo con il simbolo $
dev.off()

freq(ucIMG01$map) # sulla mappa calcoliamo la frequenza per ogni classe e tramite esse possiamo poi fare la percentuale sul totale

# 3 cambiamento positivo --> 8317900
# 1 nessun cambiamento  --> 22170001
# 2 cambiamento negativo  --> 9947932

sIMG01<-8317900+22170001+9947932
percpos01<-8317900/sIMG01 #0.2057062
percneutro01<-22170001/sIMG01 #0.5482761
percneg01<-9947932/sIMG01 #0.2460177
Percent01 <- c(20.57,54.82,24.60) #inseriamo i valori percentuali in y
Change01 <- c("Positivo","Nullo","Negativo") #inseriamo le etichette in x
jpeg("graficoIMG01.jpg", 800, 800)
percentages01 <- data.frame(Change01,Percent01)
ggplot(percentages01,aes(x=Change01,y=Percent01)) + geom_bar(stat="identity",fill="dark green") + #creiamo il grafico a istogramma con le etichette delle percentuali in alto
  geom_text(aes(label = Percent01),position=position_dodge(width=0.7), vjust=-0.25, size = 6)
dev.off()

# --------------------difndviIMG02----------------------------------

set.seed(42)
ucIMG02<-unsuperClass(difndviIMG02, nClasses=3) 
jpeg("ucIMG02.jpg", 800, 800)
plot(ucIMG02$map)
dev.off()

freq(ucIMG02$map)

# 3 cambiamento positivo --> 12534195
# 1 nessun cambiamento  --> 22785581
# 2 cambiamento negativo  --> 5122583

sIMG02<-12534195+22785581+5122583
percpos02<-12534195/sIMG02 #0.3099274
percneutro02<-22785581/sIMG02 #0.5634088
percneg02<-5122583/sIMG02 #0.1266638
Percent02 <- c(30.99,56.34,12.66)
Change02 <- c("Positivo","Neutro","Negativo")
jpeg("graficoIMG02.jpg", 800, 800)
percentages02 <- data.frame(Change02,Percent02)
ggplot(percentages02,aes(x=Change02,y=Percent02)) + geom_bar(stat="identity",fill="dark green") + 
  geom_text(aes(label = Percent02),position=position_dodge(width=0.7), vjust=-0.25, size = 6)
dev.off()

# --------------------difndviIMG03----------------------------------

set.seed(42)
ucIMG03<-unsuperClass(difndviIMG03, nClasses=3) 
jpeg("ucIMG03.jpg", 800, 800)
plot(ucIMG03$map)
dev.off()

freq(ucIMG03$map)

# 3 cambiamento positivo -->6124213 
# 1 nessun cambiamento  --> 25470723
# 2 cambiamento negativo  -->  8800386

sIMG03<-8800386+25470723+6124213
percpos03<-6124213/sIMG03 #0.151607
percneutro03<-25470723/sIMG03 #0.6305365
percneg03<-8800386/sIMG03 #0.2178566
Percent03 <- c(15.16,63.05,21.78)
Change03 <- c("Positivo","Neutro","Negativo")
jpeg("graficoIMG03.jpg", 800, 800)
percentages03 <- data.frame(Change03,Percent03)
ggplot(percentages03,aes(x=Change03,y=Percent03)) + geom_bar(stat="identity",fill="dark green") + 
  geom_text(aes(label = Percent03),position=position_dodge(width=0.7), vjust=-0.25, size = 6)
dev.off()

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# FIRMA SPETTRALE

# La firma spettrale è la riflettanza in funzione della lunghezza d'onda e ogni materiale è caratterizzato da una risposta univoca.
#è stata effettuata la firma spettrale su due porzioni di area boschiva in ciascuna immagine per determinare se gli incendi abbiano provocato un cambiamento da parte della vegetazione
#per ogni immagine sono stati presi due punti: uno su una porzione bruciata e uno su una porzione che è rimasta illesa dal fuoco

#--------------01_2020----------------------------
plotRGB(TGr01_20,r=5,g=4,b=3,stretch="lin") #prima di tutto si protta l'immagine in RGB
click(TGr01_20, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow") # con la funzione "click" si selezionano i punti sull'immagine di cui ricaverà il valore di isposta spettrale per ogni banda

# questi sono i valori di risposta per le bande interessate 
#       x        y     cell  B201_2020 B301_2020 B401_2020  B501_2020    
#1 242070 -3684270 31775739     7799      8065      8438      10463  foresta bruciata
#2 267180 -3738600 45578207     7658      8155      8076      15144   foresta sana
     

band<-c(2,3,4,5) # inseriamo i valori in un vettore e li salviamo in una variabile
forest1<-c(7799,8065,8438,10463)
forest2<-c(7658,8155,8076,15144)


spectrals<-data.frame(band,forest1,forest2) #facciamo una tabella con i valori ricavati
jpeg("firma01_20.jpg")
ggplot(spectrals,aes(x=band))+ #plottiamo tutto in un grafico in cui gli spettri cono identificati da due linee di diverso colore
       geom_line(aes(y=forest1),color="red")+ 
       geom_line(aes(y=forest2),color="blue")+
       labs(x="Banda",y="Risposta")
dev.off()

#per fare una valutazione corretta è necessario che i punti, presi nei due anni per la stessa sezione, siano gli stessi

#---------------------01_2019---------------------------------
plotRGB(TGr01_19,r=5,g=4,b=3,stretch="lin")
click(TGr01_19, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow") 

#       x        y     cell  B201_2019 B301_2019 B401_2019  B501_2019   
#1 242880 -3683610 31608174     7628      8010      8036      14085 
#2 265530 -3741300 46264112     7687      8219      8129      15943 


band<-c(2,3,4,5)
forest1<-c(7628,8010,8036,14085)
forest2<-c(7687,8219,8129,15943)

spectrals<-data.frame(band,forest1,forest2)
jpeg("firma01_19.jpg")
ggplot(spectrals,aes(x=band))+ 
       geom_line(aes(y=forest1),color="red")+
       geom_line(aes(y=forest2),color="blue")+
       labs(x="Banda",y="Risposta")
dev.off()

#--------------02_2020----------------------------
plotRGB(TGr02_20,r=5,g=4,b=3,stretch="lin")
click(TGr02_20, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow") 

#       x        y     cell  B202_2020 B302_2020 B402_2020  B502_2020       
#1 797070 -3877290 42906523       9601     10278     10847    12981 foresta bruciata
#2 858840 -3797220 21794123       7674      8260      8251    16540 foresta sana

band<-c(2,3,4,5)
forest1<-c(9601,10278,10847,12981)
forest2<-c(7674,8260,8251,16540)


spectrals<-data.frame(band,forest1,forest2)
jpeg("firma02_20.jpg")
ggplot(spectrals,aes(x=band))+ #nel grafico in x ci va la banda e in y in una mettiamo l'acqua e in una la foresta
       geom_line(aes(y=forest1),color="red")+ #inserisce le geometrie delle linee di interesse
       geom_line(aes(y=forest2),color="blue")+
       labs(x="Banda",y="Risposta")
dev.off()

#---------------------02_2019---------------------------------
plotRGB(TGr02_19,r=5,g=4,b=3,stretch="lin")
click(TGr02_19, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow") 

#       x        y     cell  B202_2019 B302_2019 B402_2019 B502_2019    
#1 796950 -3877290 42852359     7826      8324      8332     13923
#2 859560 -3798930 22217034     7706      8161      8054     14773
     
band<-c(2,3,4,5)
forest1<-c(7826,8324,8332,13923)
forest2<-c(7706,8161,8054,14773)

spectrals<-data.frame(band,forest1,forest2)
jpeg("firma02_19.jpg")
ggplot(spectrals,aes(x=band))+ #nel grafico in x ci va la banda e in y in una mettiamo l'acqua e in una la foresta
       geom_line(aes(y=forest1),color="red")+ #inserisce le geometrie delle linee di interesse
       geom_line(aes(y=forest2),color="blue")+
       labs(x="Banda",y="Risposta")
dev.off()

#--------------03_2020----------------------------
plotRGB(TGr03_20,r=5,g=4,b=3,stretch="lin")
click(TGr03_20, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow") 

#       x        y     cell B203_2020 B303_2020 B403_2020  B503_2020 
#1 758610 -4015620 37693272    8405      9091      9247     10938    
#2 719880 -4058160 48909779    7820      8831      8817     17737 

 
   
band<-c(2,3,4,5)
forest1<-c(8405,9091,9247,10938)
forest2<-c(7820,8831,8817,17737)


spectrals<-data.frame(band,forest1,forest2)
jpeg("firma03_20.jpg")
ggplot(spectrals,aes(x=band))+ #nel grafico in x ci va la banda e in y in una mettiamo l'acqua e in una la foresta
       geom_line(aes(y=forest1),color="red")+ #inserisce le geometrie delle linee di interesse
       geom_line(aes(y=forest2),color="blue")+
       labs(x="Banda",y="Risposta")
dev.off()

#--------------03_2019----------------------------
plotRGB(TGr03_19,r=5,g=4,b=3,stretch="lin")
click(TGr03_19, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow") 

#       x        y     cell  B203_2019 B303_2019 B403_2019  B503_2019
#1 760650 -4016340 37914404       7583      8048      7850    15633
#2 718050 -4058520 49021790       7621      8029      7887    16239   

   
band<-c(2,3,4,5)
forest1<-c(7583,8048,7850,15633)
forest2<-c(7621,8029,7887,16239)


spectrals<-data.frame(band,forest1,forest2)
jpeg("firma03_19.jpg")
ggplot(spectrals,aes(x=band))+ 
       geom_line(aes(y=forest1),color="red")+ 
       geom_line(aes(y=forest2),color="blue")+
       labs(x="Banda",y="Risposta")
       
dev.off()



# R_code_PROJECT.r

#This is the project for the exam of remote sensing 2020-2021

library(rasterVis)
library(rasterdiv)
library(gridExtra)
library(RStoolbox)
library(ggplot2)
library(raster)
library(ncdf4)


setwd("C:/lab/project/australia/all")
# PLOT IMMAGINI .JPG

#------------2019-------------------

#01_2019
list01_19<-list.files(pattern="01_2019.TIF") 
import01_19<-lapply(list01_19,raster)
TGr01_19<-stack(import01_19)
plot(TGr01_19) 
jpeg("01_2019.jpg", 600, 800)
plotRGB(TGr01_19,r=4,g=3,b=2,stretch="lin")
dev.off()

#02_2019
list02_19<-list.files(pattern="02_2019.TIF") 
import02_19<-lapply(list02_19,raster)
TGr02_19<-stack(import02_19)
plot(TGr02_19) 
jpeg("02_2019.jpg", 600, 800)
plotRGB(TGr02_19,r=4,g=3,b=2,stretch="lin")
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
B501_2020<-brick("B501_2020.TIF")
B701_2020<-brick("B701_2020.TIF")
nbr01_2020<-(B501_2020-B701_2020)/(B501_2020+B701_2020)
cl <- colorRampPalette(c('black','purple','darkblue','red','orange','yellow','green'))(100)# specifico la palette di colori
jpeg("nbr01_2020.jpg", 800, 800)
plot(nbr01_2020, col=cl, main="NBR 2020 - 01")
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

#Band 1 - Coastal / Aerosol
#Band 2 - Blue
#Band 3 - Green
#Band 4 - Red
#Band 5 - Near Infrared
#Band 6 - Short Wavelength Infrared
#Band 7 - Short Wavelength Infrared
#Band 8 - Panchromatic
#Band 9 - Cirrus

#------------2019-------------------

#NDVI 01_2019
B501_2019<-brick("B501_2019.TIF")
B401_2019<-brick("B401_2019.TIF")
ndvi01_2019<-(B501_2019-B401_2019)/(B501_2019+B401_2019)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifico la palette di colori
jpeg("ndvi01_2019.jpg", 800, 800)
plot(ndvi01_2019, col=cl, main="NDVI 2019 - 01")
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
plot(ndvi01_2020, col=cl)
dev.off()

#NDVI 02_2020
B502_2020<-brick("B502_2020.TIF")
B402_2020<-brick("B402_2020.TIF")
ndvi02_2020<-(B502_2020-B402_2020)/(B502_2020+B402_2020)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifico la palette di colori
jpeg("ndvi02_2020.jpg", 800, 800)
plot(ndvi02_2020, col=cl)
dev.off()

#NDVI 03_2020
B503_2020<-brick("B503_2020.TIF")
B403_2020<-brick("B403_2020.TIF")
ndvi03_2020<-(B503_2020-B403_2020)/(B503_2020+B403_2020)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifico la palette di colori
jpeg("ndvi03_2020.jpg", 800, 800)
plot(ndvi03_2020, col=cl)
dev.off()

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# DIFFERENZA NDVI

#IMG01 2019 -> 2020
difndviIMG01<-(ndvi01_2020-ndvi01_2019)
cls <- colorRampPalette(c('pink','red','white','blue'))(100)
jpeg("difndviIMG01.jpg", 800, 800)
plot(difndviIMG01, col=cls)
dev.off()

#IMG02 2019 -> 2020
difndviIMG02<-(ndvi02_2020-ndvi02_2019)
cls <- colorRampPalette(c('pink','red','white','blue'))(100)
jpeg("difndviIMG02.jpg", 800, 800)
plot(difndviIMG02, col=cls)
dev.off()

#IMG03 2019 -> 2020
difndviIMG03<-(ndvi03_2020-ndvi03_2019)
cls <- colorRampPalette(c('pink','red','white','blue'))(100)
jpeg("difndviIMG03.jpg", 800, 800)
plot(difndviIMG03, col=cls)
dev.off()


#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# UNSUPERVISORED CLASSIFICATION

#in questo modo siamo in grado di capire qual'è la percentuale di territorio che ha subito incendi, quella rivegetata e quella che nel caso non ha subito cambiamenti.

# ----------------difndviIMG01------------------------------------

set.seed(42)
ucIMG01<-unsuperClass(difndviIMG01, nClasses=3) 
jpeg("ucIMG01.jpg", 800, 800)
plot(ucIMG01$map)
dev.off()

freq(ucIMG01$map)

# cambiamento positivo --> 8522764
# nessun cambiamento  --> 22541421
# cambiamento negativo  --> 9371648

sIMG01<-9371648+22541421+8522764
percpos01<-8522764/sIMG01 #0.2107726
percneutro01<-22541421/sIMG01 #0.5574615
percneg01<-9371648/sIMG01 #0.2317659
Percent01 <- c(21.07,55.74,23.17)
Change01 <- c("Positivo","Neutro","Negativo")
jpeg("graficoIMG01.jpg", 800, 800)
percentages01 <- data.frame(Change01,Percent01)
ggplot(percentages01,aes(x=Change01,y=Percent01)) + geom_bar(stat="identity",fill="dark green") + 
  geom_text(aes(label = Percent01),position=position_dodge(width=0.7), vjust=-0.25, size = 6)
dev.off()

# --------------------difndviIMG02----------------------------------

set.seed(42)
ucIMG02<-unsuperClass(difndviIMG02, nClasses=3) 
jpeg("ucIMG02.jpg", 800, 800)
plot(ucIMG02$map)
dev.off()

freq(ucIMG02$map)

# cambiamento positivo --> 12534195
# nessun cambiamento  --> 22785581
# cambiamento negativo  --> 5122583

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
jpeg("ucIMG03.jpg", 600, 800)
plot(ucIMG03$map)
dev.off()

freq(ucIMG03$map)

# cambiamento positivo --> 8800386
# nessun cambiamento  --> 25470723
# cambiamento negativo  --> 6124213

sIMG03<-8800386+25470723+6124213
percpos03<-8800386/sIMG03 #0.2178566
percneutro03<-25470723/sIMG03 #0.6305365
percneg03<-6124213/sIMG03 #0.151607
Percent03 <- c(21.78,63.05,15.16)
Change03 <- c("Positivo","Neutro","Negativo")
jpeg("graficoIMG03.jpg", 800, 800)
percentages03 <- data.frame(Change03,Percent03)
ggplot(percentages03,aes(x=Change03,y=Percent03)) + geom_bar(stat="identity",fill="dark green") + 
  geom_text(aes(label = Percent03),position=position_dodge(width=0.7), vjust=-0.25, size = 6)
dev.off()

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# FIRMA SPETTRALE

#01_2020
click(TGr01_20, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow") 
#  B501_2020 B601_2020 B701_2020
#1     14784     14441     11761  f
#2     11306      8931      7924  f 
#3     14667     13425     10905  f
#4     20688     15806     11862  p
#5     24617     14559     10565  p
#6     16352     11284      9279  p

band<-c(1,2,3)
forest1<-c(14784,14441,11761)
forest2<-c(11306,8931,7924)
forest3<-c(14667,13425,10905)
prateria1<-c(20688,15806,11862)
prateria2<-c(24617,14559,10565)
prateria3<-c(16352,11284,9279)

spectrals<-data.frame(band,forest1,forest2,forest3,prateria1,prateria2,prateria3)
jpeg("firma01_20.jpg")
ggplot(spectrals,aes(x=band))+ #nel grafico in x ci va la banda e in y in una mettiamo l'acqua e in una la foresta
       geom_line(aes(y=forest1),color="green")+ #inserisce le geometrie delle linee di interesse
       geom_line(aes(y=forest2),color="green")+
       geom_line(aes(y=forest3),color="green")+
       geom_line(aes(y=prateria1),color="blue")+
       geom_line(aes(y=prateria2),color="blue")+
       geom_line(aes(y=prateria3),color="blue")+
       labs(x="band",y="reflectance")
dev.off()


#01_2019
click(TGr01_19, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow") 
#  B501_2019 B601_2019 B701_2019
#1     15378     11736      9374  f
#2      9175      7975      7505  f
#3     14994     12547      9780  f
#4     21558     17213     12506  p
#5     24217     14146     10466  p
#6     17452     13270     10209  p

band<-c(1,2,3)
forest1<-c(15378,11736,9374)
forest2<-c(9175,7975,7505)
forest3<-c(14994,12547,9780)
prateria1<-c(21558,17213,12506)
prateria2<-c(24217,14146,10466)
prateria3<-c(17452,13270,10209)

spectrals<-data.frame(band,forest1,forest2,forest3,prateria1,prateria2,prateria3)
jpeg("firma01_19.jpg")
ggplot(spectrals,aes(x=band))+ #nel grafico in x ci va la banda e in y in una mettiamo l'acqua e in una la foresta
       geom_line(aes(y=forest1),color="green")+ #inserisce le geometrie delle linee di interesse
       geom_line(aes(y=forest2),color="green")+
       geom_line(aes(y=forest3),color="green")+
       geom_line(aes(y=prateria1),color="blue")+
       geom_line(aes(y=prateria2),color="blue")+
       geom_line(aes(y=prateria3),color="blue")+
       labs(x="band",y="reflectance")
dev.off()


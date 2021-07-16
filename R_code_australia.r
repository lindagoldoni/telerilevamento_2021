#R_code_australia.r

# ANALISI DELLO STATO VEGETATIVO DELLA COSTA SUD-EST DELLO STATO DEL NUOVO GALLES DEL SUD, AUSTRALIA, PRIMA E DOPO GLI INCENDI DEL 2020 

library(rasterVis)
library(rasterdiv)
library(gridExtra)
library(RStoolbox)
library(ggplot2)
library(raster)
library(ncdf4)

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 2020
setwd("C:/lab/project/australia/2020/01")

# NDVI
#(NIR-RED)/(NIR+RED)
# B1=NIR, B2=red, B3=green

#NDVI: normalizza il DVI, fa la standardizzazione del DVI sulla somma tra NIR e RED, in modo da ottenere numeri bassi e si possono confrontare immagini con risoluzione radiometrica differente
#il range dell'NDVI è [-1 , 1]

small <- brick("LC08_L2SP_090085_20200507_20200820_02_T1_thumb_small.jpeg")

B101<-raster("B101.TIF")
B201<-raster("B201.TIF")

cl <- colorRampPalette(c('white','orange','red','pink','purple','blue'))(100)
par(mfrow=c(1,2))
plot(B101, col=cl)
plot(B201, col=cl)

ndvi01<-(B101-B201)/(B101+B201)
plot(ndvi01,col=cl) 
#--------------------------------------------
setwd("C:/lab/project/australia/2020/02")

B102<-raster("B102.TIF")
B202<-raster("B202.TIF")

cl <- colorRampPalette(c('white','orange','red','pink','purple','blue'))(100)
par(mfrow=c(1,2))
plot(B102, col=cl)
plot(B202, col=cl)

ndvi02<-(B102-B202)/(B102+B202)
plot(ndvi02,col=cl) 
#--------------------------------------------
setwd("C:/lab/project/australia/2020/03")

B103<-raster("B103.TIF")
B203<-raster("B203.TIF")

cl <- colorRampPalette(c('white','red','blue'))(100)
par(mfrow=c(1,2))
plot(B103, col=cl)
plot(B203, col=cl)

ndvi03<-(B103-B203)/(B103+B203)
plot(ndvi03,col=cl) 

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 2019

setwd("C:/lab/project/australia/2019/01")

B101<-raster("B101.TIF")
B201<-raster("B201.TIF")

cl <- colorRampPalette(c('white','orange','red','pink','purple','blue'))(100)
par(mfrow=c(1,2))
plot(B101, col=cl)
plot(B201, col=cl)

ndvi01<-(B101-B201)/(B101+B201)
plot(ndvi01,col=cl) 
#--------------------------------------------
setwd("C:/lab/project/australia/2019/02")

B102<-raster("B102.TIF")
B202<-raster("B202.TIF")

cl <- colorRampPalette(c('white','orange','red','pink','purple','blue'))(100)
par(mfrow=c(1,2))
plot(B102, col=cl)
plot(B202, col=cl)

ndvi02<-(B102-B202)/(B102+B202)
plot(ndvi02,col=cl) 
#--------------------------------------------
setwd("C:/lab/project/australia/2019/03")

B103<-raster("B103.TIF")
B203<-raster("B203.TIF")

cl <- colorRampPalette(c('white','red','blue'))(100)
par(mfrow=c(1,2))
plot(B103, col=cl)
plot(B203, col=cl)

ndvi03<-(B103-B203)/(B103+B203)
cls <- colorRampPalette(c('white','green','yellow'))(100)
plot(ndvi03,col=cls) 





























# in RStoolbox esistono tantissimi indici da poter calcolare con una funzione "spectralIndices", con un solo comando posso calcolare una moltitudine di indici


difndvi<-ndvi1-ndvi2
plot(difndvi,col=cld)

#RStoolbox: spectralIndices
library(RStoolbox) # dobbiamo richiamare questo pacchetto
si1<-spectralIndices(defor1,green=3,red=2,nir=1) #dobbiamo dichiarare le bande che abbiamo 
plot(si1, col=cl)
# ci sono i DVI e l'NDVI e altri molteplici indici
#NDWI lavora sull'acqua, quindi non solo sulla vegetazione

si2<-spectralIndices(defor2,green=3,red=2,nir=1) #dobbiamo dichiarare le bande che abbiamo 
plot(si2, col=cl) #facciamo la stessa cosa per la seconda immagine





#------------------------------------------------------------------------------------------------------------------------------------------------------------------------


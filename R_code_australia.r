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

IMG01 <- brick("01.jpeg")
IMG01
plotRGB(IMG01,r=1,g=2,b=3,stretch="lin")

B101<-IMG01$X01.1
B201<-IMG01$X01.2

cl <- colorRampPalette(c('white','orange','red','pink','purple','blue'))(100)
par(mfrow=c(1,2))
plot(B101, col=cl)
plot(B201, col=cl)

ndvi01<-(B101-B201)/(B101+B201)
plot(ndvi01,col=cl) 

# in RStoolbox esistono tantissimi indici da poter calcolare con una funzione "spectralIndices", con un solo comando posso calcolare una moltitudine di indici

Indici01<-spectralIndices(IMG01,green=3,red=2,nir=1)
plot(Indici01, col=cl)
#--------------------------------------------
setwd("C:/lab/project/australia/2020/02")
IMG02 <- brick("02.jpeg")
IMG02
plotRGB(IMG02,r=1,g=2,b=3,stretch="lin")

B102<-IMG02$X02.1
B202<-IMG02$X02.2

cl <- colorRampPalette(c('white','orange','red','pink','purple','blue'))(100)
par(mfrow=c(1,2))
plot(B102, col=cl)
plot(B202, col=cl)

ndvi02<-(B102-B202)/(B102+B202)
plot(ndvi02,col=cl) 

Indici02<-spectralIndices(IMG02,green=3,red=2,nir=1)
plot(Indici02, col=cl)
#--------------------------------------------
setwd("C:/lab/project/australia/2020/03")
IMG03 <- brick("03.jpeg")
IMG03
plotRGB(IMG03,r=1,g=2,b=3,stretch="lin")

B103<-IMG03$X03.1
B203<-IMG03$X03.2

cl <- colorRampPalette(c('white','red','blue'))(100)
par(mfrow=c(1,2))
plot(B103, col=cl)
plot(B203, col=cl)

ndvi03<-(B103-B203)/(B103+B203)
plot(ndvi03,col=cl) 

Indici03<-spectralIndices(IMG03,green=3,red=2,nir=1)
plot(Indici03, col=cl)
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 2019

setwd("C:/lab/project/australia/2019/01")
IMG01 <- brick("01.jpeg")
IMG01
plotRGB(IMG01,r=1,g=2,b=3,stretch="lin")

B101<-IMG01$X01.1 
B201<-IMG01$X01.2

cl <- colorRampPalette(c('white','orange','red','pink','purple','blue'))(100)
par(mfrow=c(1,2))
plot(B101, col=cl)
plot(B201, col=cl)

ndvi01<-(B101-B201)/(B101+B201)
plot(ndvi01,col=cl) 

Indici01<-spectralIndices(IMG01,green=3,red=2,nir=1)
plot(Indici01, col=cl)
#--------------------------------------------
setwd("C:/lab/project/australia/2019/02")
IMG02 <- brick("02.jpeg")
IMG02
plotRGB(IMG02,r=1,g=2,b=3,stretch="lin")

B102<-IMG02$X02.1 
B202<-IMG02$X02.2

cl <- colorRampPalette(c('white','orange','red','pink','purple','blue'))(100)
par(mfrow=c(1,2))
plot(B102, col=cl)
plot(B202, col=cl)

ndvi02<-(B102-B202)/(B102+B202)
plot(ndvi02,col=cl) 

Indici02<-spectralIndices(IMG02,green=3,red=2,nir=1)
plot(Indici02, col=cl)
#--------------------------------------------
setwd("C:/lab/project/australia/2019/03")
IMG03 <- brick("03.jpeg")
IMG03
plotRGB(IMG03,r=1,g=2,b=3,stretch="lin")

B103<-IMG03$X03.1
B203<-IMG03$X03.2

cl <- colorRampPalette(c('white','red','blue'))(100)
par(mfrow=c(1,2))
plot(B103, col=cl)
plot(B203, col=cl)

ndvi03<-(B103-B203)/(B103+B203)
cls <- colorRampPalette(c('red','white','blue'))(100)
plot(ndvi03,col=cls) 

Indici03<-spectralIndices(IMG03,green=3,red=2,nir=1)
plot(Indici03, col=cl)

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# UNSUPERVISORED CLASSIFICATION

set.seed(42)
soc<-unsuperClass(IMG03, nClasses=6) 
plot(soc$map)

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# GGPLOT

ggRGB(IMG03,3,2,1, stretch="lin")
ggRGB(IMG03,4,3,2, stretch="lin")
p1 <- ggRGB(IMG03,3,2,1, stretch="lin")
p2 <- ggRGB(IMG03,4,3,2, stretch="lin")
grid.arrange(p1, p2, nrow = 2) 







par(mfrow=c(2,1))
plotRGB(defor1,r=1,g=2,b=3,stretch="lin")
plotRGB(defor2,r=1,g=2,b=3,stretch="lin")

# in questo modo facciamo un analisi multitemporale
# vediamo che siamo nella stessa zona ma nella prima immagine il fiume si presenta più acceso perché probabilmente aveva più sali disciolti che assorbe meno l'infrarosso
# se il fiume fosse nero significa che è acqua pura perché assorbe tutto l'infrarosso
# tutta la parte rossa è vegetazione di foresta pluviale, la parte chiara è suolo agricolo

# utilizziamo il DVI che è la differenza tra riflettanza dell'infrarosso vicino e la riflettanza del rosso
#il pixel di vegetazione sana ha il massimo di riflettanza nel NIR e il minimo di riflettanza nel RED perché viene assorbita (solitamente è vicino a 0)
# possiamo normalizzarlo generando NDVI e si fa NIR-RED/NIR+RED

# rpima di tutto richiamiamo i pacchetti e settiamo la working directory
# carichiamo le immagini con "brick"
# successivamente plottiamo le immagini con il plotRGB

dvi1<- defor1$defor1.1 - defor1$defor1.2 #vediamo negli attributi i nomi delle bande NIR e RED e li leghiamo con il $ al nome dell'immagine, in questo modo stiamo facendo la differenza tra le due bande dell'immagine
plot(dvi1) # visualizziamo il prodotto grezzo con i colori di R
# le parti deforestate vengono visualizzate bene il rossastro e le parti vegetate in verde
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # cambiamo il colore all'immagine
plot(dvi1, col=cl, main="DVI at time 1") # tutto ciò che è rosso è vegetazione, aggiungiamo anche il titolo
# essendo al bordo nel lato superiore si genera un artefatto che non esiste realmente

dvi2<- defor2$defor2.1 - defor2$defor2.2 
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 
plot(dvi2, col=cl, main="DVI at time 2") # la parte gialla è suolo nudo e il rosso è la vegetazione
# faremo un calcolo per ricavare la percentuale di foresta persa nel tempo



#------------------------------------------------------------------------------------------------------------------------------------------------------------------------


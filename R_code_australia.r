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






# FIRMA SPETTRALE

click(IMG03, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")
#dobbiamo dire su quale mappa vogliamo cliccare e definire come vogliamo fare il click ovvero un punto "p" , definiamo dimensione e colore

#      x     y   cell X03.1 X03.2 X03.3
#1 701.5 637.5 395966   204   202   189
#2 412.5 271.5 770461   216   205   187
#3 276.5 206.5 836885   228   217   189
#4 800.5 218.5 825121   190   192   181

#facciamo una tabella con il numero di banda, poi con uso del suolo (foresta o acqua) e utilizzeremo questo dataframe per creare l'output

#definiamo le colonne del dataset
band<-c(1,2,3)
foresta<-c(204,202,189)
prateria<-c(216,205,187)
boh<-c(228,217,189)
acqua<-c(190,192,181)


#ora mettiamo tutto in una tabella con la funzione
spectrals<-data.frame(band,foresta,prateria,boh,acqua)

#plottiamo la firma spettrale
ggplot(spectrals,aes(x=band))+ 
       geom_line(aes(y=foresta), color="green")+ 
       geom_line(aes(y=prateria),color="yellow")+
       geom_line(aes(y=boh),color="black")+
       geom_line(aes(y=acqua),color="blue")+
       labs(x="band",y="reflectance")


#ALBEDO

albedo20<-raster("albedo20.nc") 
albedo20<-raster::reclassify(albedo20,cbind(252,255,NA),right=TRUE)
cl <- colorRampPalette(c('yellow','dark green','red','brown'))(100)
plot(albedo20, col=cl)




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

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# FIRMA SPETTRALE

click(IMG03, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")
#dobbiamo dire su quale mappa vogliamo cliccare e definire come vogliamo fare il click ovvero un punto "p" , definiamo dimensione e colore

#      x     y   cell X03.1 X03.2 X03.3
#1 573.5 409.5 629310   183   185   172
#2 430.5 272.5 769455   198   201   180
#3 286.5 219.5 823583   207   205   182
#4 809.5 292.5 749354   168   181   187


#facciamo una tabella con il numero di banda, poi con uso del suolo (foresta o acqua) e utilizzeremo questo dataframe per creare l'output

#definiamo le colonne del dataset
band<-c(1,2,3)
foresta<-c(183,185,172)
prateria<-c(198,201,180)
boh<-c(207,205,182)
acqua<-c(168,181,187)


#ora mettiamo tutto in una tabella con la funzione
spectrals<-data.frame(band,foresta,prateria,boh,acqua)

#plottiamo la firma spettrale
ggplot(spectrals,aes(x=band))+ 
       geom_line(aes(y=foresta), color="green")+ 
       geom_line(aes(y=prateria),color="yellow")+
       geom_line(aes(y=boh),color="black")+
       geom_line(aes(y=acqua),color="blue")+
       labs(x="band",y="reflectance")


#ALBEDO

albedo19<-raster("albedo19.nc") 
albedo19<-raster::reclassify(albedo19,cbind(252,255,NA),right=TRUE)
cl <- colorRampPalette(c('yellow','dark green','red','brown'))(100)
plot(albedo19, col=cl)


#------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# DIFFERENZA NDVI 

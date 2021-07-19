#R_code_australia.r

# ANALISI DELLO STATO VEGETATIVO DELLA COSTA SUD-EST DELLO STATO DEL NUOVO GALLES DEL SUD, AUSTRALIA, PRIMA E DOPO GLI INCENDI DEL 2020 

library(rasterVis)
library(rasterdiv)
library(gridExtra)
library(RStoolbox)
library(ggplot2)
library(raster)
library(ncdf4)

#---------------------------------------------------------------------------------------------------------------------------------------
# DIFFERENZA NDVI 

# NDVI
#(NIR-RED)/(NIR+RED)
# B1=NIR, B2=red, B3=green

#NDVI: normalizza il DVI, fa la standardizzazione del DVI sulla somma tra NIR e RED, in modo da ottenere numeri bassi e si possono confrontare immagini con risoluzione radiometrica differente
#il range dell'NDVI è [-1 , 1]

setwd("C:/lab/project/australia/all")

#IMG01

img01_19 <- brick("01_2019.jpeg")
img01_20 <- brick("01_2020.jpeg")

B101_19<-img01_19$X01_2019.1
B201_19<-img01_19$X01_2019.2

ndvi01_19<-(B101_19-B201_19)/(B101_19+B201_19)
cls <- colorRampPalette(c('red','white','blue'))(100)
plot(ndvi01_19,col=cls)

#------------------------------------------------------

B101_20<-img01_20$X01_2020.1
B201_20<-img01_20$X01_2020.2

ndvi01_20<-(B101_20-B201_20)/(B101_20+B201_20)
cls <- colorRampPalette(c('red','white','blue'))(100)
plot(ndvi01_20,col=cls)

#--------------------------------------------------

difndvi_01<-ndvi01_19-ndvi01_20
cld <- colorRampPalette(c('dark green','red','purple','yellow','brown','black'))(100)
plot(difndvi_01,col=cld)


#-------------------------------------------------------------------------------------------

#IMG02

img02_19 <- brick("02_2019.jpeg")
img02_20 <- brick("02_2020.jpeg")

B102_19<-img02_19$X02_2019.1
B202_19<-img02_19$X02_2019.2

ndvi02_19<-(B102_19-B202_19)/(B102_19+B202_19)
cls <- colorRampPalette(c('red','white','blue'))(100)
plot(ndvi02_19,col=cls)

#------------------------------------------------------

B102_20<-img02_20$X02_2020.1
B202_20<-img02_20$X02_2020.2

ndvi02_20<-(B102_20-B202_20)/(B102_20+B202_20)
cls <- colorRampPalette(c('red','white','blue'))(100)
plot(ndvi02_20,col=cls)

#--------------------------------------------------

difndvi_02<-ndvi02_19-ndvi02_20
cld <- colorRampPalette(c('dark green','red','purple','yellow','brown','black'))(100)
plot(difndvi_02,col=cld)


#-------------------------------------------------------------------------------------------

#IMG03

img03_19 <- brick("03_2019.jpeg")
img03_20 <- brick("03_2020.jpeg")

B103_19<-img03_19$X03_2019.1
B203_19<-img03_19$X03_2019.2

ndvi03_19<-(B103_19-B203_19)/(B103_19+B203_19)
cls <- colorRampPalette(c('red','white','blue'))(100)
plot(ndvi03_19,col=cls)

#------------------------------------------------------

B103_20<-img03_20$X03_2020.1
B203_20<-img03_20$X03_2020.2

ndvi03_20<-(B103_20-B203_20)/(B103_20+B203_20)
cls <- colorRampPalette(c('red','white','blue'))(100)
plot(ndvi03_20,col=cls)

#--------------------------------------------------

difndvi_03<-ndvi03_19-ndvi03_20
cld <- colorRampPalette(c('dark green','red','purple','yellow','brown','black'))(100)
plot(difndvi_03,col=cld)

#--------------------------------------------------

# in RStoolbox esistono tantissimi indici da poter calcolare con una funzione "spectralIndices", con un solo comando posso calcolare una moltitudine di indici

Indici01_19<-spectralIndices(img01_19 ,green=3,red=2,nir=1)
plot(Indici01_19 , col=cls)

Indici02_19<-spectralIndices(img02_19 ,green=3,red=2,nir=1)
plot(Indici02_19 , col=cls)

Indici03_19<-spectralIndices(img03_19 ,green=3,red=2,nir=1)
plot(Indici03_19 , col=cls)

Indici01_20<-spectralIndices(img01_20 ,green=3,red=2,nir=1)
plot(Indici01_19 , col=cls)

Indici02_20<-spectralIndices(img02_20 ,green=3,red=2,nir=1)
plot(Indici02_20 , col=cls)

Indici03_20<-spectralIndices(img03_20 ,green=3,red=2,nir=1)
plot(Indici03_20 , col=cls)

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# FIRMA SPETTRALE

plotRGB(img01_19,r=1,g=2,b=3,stretch="lin")
click(img01_19, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")


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

#--------------------------------------------------
plotRGB(img02_19,r=1,g=2,b=3,stretch="lin")
click(img02_19, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")



















#--------------------------------------------------
plotRGB(img03_19,r=1,g=2,b=3,stretch="lin")
click(img03_19, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")















#--------------------------------------------------
plotRGB(img01_20,r=1,g=2,b=3,stretch="lin")
click(img01_20, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")


plotRGB(img02_20,r=1,g=2,b=3,stretch="lin")
click(img02_20, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")


plotRGB(img03_20,r=1,g=2,b=3,stretch="lin")
click(img03_20, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")


#------------------------------------------------------------------------------------------------------------------------------------------------------------------------


#ALBEDO

albedo20<-raster("albedo20.nc") 
albedo20<-raster::reclassify(albedo20,cbind(252,255,NA),right=TRUE)
cl <- colorRampPalette(c('yellow','dark green','red','brown'))(100)
plot(albedo20, col=cl)



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


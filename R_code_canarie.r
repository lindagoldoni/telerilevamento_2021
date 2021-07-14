# CARATTERIZZAZIONE MINERALOGICA/VEGETAZIONALE DELLE ISOLE CANARIE TRAMITE UNSUPERVISORED CLASSIFICATION E NDVI

library(rasterVis)
library(rasterdiv)
library(gridExtra)
library(RStoolbox)
library(ggplot2)
library(raster)
library(ncdf4)

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# TENERIFE
setwd("C:/lab/project/landsat/tenerife")

# NDVI
#(NIR-RED)/(NIR+RED)
# B1=NIR, B2=red, B3=green

#NDVI: normalizza il DVI, fa la standardizzazione del DVI sulla somma tra NIR e RED, in modo da ottenere numeri bassi e si possono confrontare immagini con risoluzione radiometrica differente
#il range dell'NDVI è [-1 , 1]
B1<-raster("B1.TIF")
B2<-raster("B2.TIF")

ndvitenerife<-(B1-B2)/(B1+B2)
cl <- colorRampPalette(c('blue','red','yellow'))(100) 
plot(ndvitenerife,col=cl) 
# si può scrivere anche:
#ndvi1<-dvi1/(defor1$defor1.1+defor1$defor1.2)
# in quanto il numeratore era già associato ad una variabile
# in RStoolbox esistono tantissimi indici da poter calcolare con una funzione "spectralIndices", con un solo comando posso calcolare una moltitudine di indici

ndvi2<-dvi2/(defor2$defor2.1+defor2$defor2.2)
plot(ndvi2,col=cl) # anche in questo caso viene visualizzata molto bene la differenza di vegetazione

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

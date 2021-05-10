#R_code_land_cover.r

setwd("C:/lab/cover/")
library(raster)
library(RStoolbox)
install.packages("ggplot2")
library(ggplot2)

#NIR 1, RED 2, GREEN 3

defor1<-brick("defor1.jpg") #carichiamo l'immagine 
plotRGB(defor1, r=1, g=2, b=3, stretch="lin") # in questo modo plottiamo l'immagine con i colori reali

# con la funzione "ggRGB" raggruppa le varie bande in una sola e le discretizza su assi x e y
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")

#fcciamo la stessa cosa con la seconda immagine
defor2<-brick("defor2.jpg") 
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#multiframe with ggplot2 and gridExtra
install.packages("gridExtra")
library(gridExtra)
# con la funzione contenuta in questo pacchetto "grid.arrange" possiamo inserire diverse immagini in un plot
# mette insieme vari pezzi all'interno del grafico

p1<- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2<- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2)

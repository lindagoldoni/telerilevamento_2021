# my first code in R for remote sensing

install.packages("raster") #installa il pacchetto "raster"
library(raster) #richiama il pacchetto e ci permette di utilizzarlo

setwd("C:/lab/") #carica la working directory 

p224r63_2011 <- brick("p224r63_2011_masked.grd") #richiama un'immagine dall'esterno di R e l'assegna ad una variabile

p224r63_2011 #posso richiamare la variabile per vedere se me l'ha caricata, si aprono gli attributi di dato raster (dimensioni, sorgente, classe, ecc.)
#mi ha caricato un raster brick  (una serie di bande sovrapposte)

plot(p224r63_2011) #mi visualizza le immagini di bande di riflettanza

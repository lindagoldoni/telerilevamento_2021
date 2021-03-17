# my first code in R for remote sensing

install.packages("raster") #installa il pacchetto "raster"
library(raster) #richiama il pacchetto e ci permette di utilizzarlo

setwd("C:/lab/") #carica la working directory 

p224r63_2011 <- brick("p224r63_2011_masked.grd") #richiama un'immagine dall'esterno di R e l'assegna ad una variabile

p224r63_2011 #posso richiamare la variabile per vedere se me l'ha caricata, si aprono gli attributi di dato raster (dimensioni, sorgente, classe, ecc.)
#mi ha caricato un raster brick  (una serie di bande sovrapposte)

plot(p224r63_2011) #mi visualizza le immagini di bande di riflettanza

#vogliamo visualizzare una diversa scala di colore e stabiliamo noi una diversa scala di colori
#che restituiscono i valori di riflettanza per una determinata lunghezza d'onda

#B1 mostra la banda blu, B2 la banda verde, B3 la banda rossa, B4 il vicino infrarosso, B5 il medio infrarosso , B6 l'infrarosso termico e B7 nuovamente l'infrarosso medio

#color change
color<-colorRampPalette(c("black","grey","light grey"))(100) #dobbiamo racchiuderli in un vettore per dirgli che fanno parte della stessa caratteristica, ovvero il colore, 
#sono diversi elementi per lo stesso argomento
#con (100) gli diciamo quanti livelli di colore inserire nella scala

> plot(p224r63_2011, col=color) #con questo comando plottiamo il raster con la nuova colorazione

cl<-colorRampPalette(c("blue","sky blue","purple","pink"))(100)
plot(p224r63_2011, col=cl) #proviamo un'altra scala di colori

# Visualizing Copernicus data
# R_code_copernicus.r
# possiamo scaricare i dati di interesse dal sito "VITO" dopo la registrazione, i dati sono suddivisi in gruppi per variabile e ogni variabile divisa in sottogruppi

#dobbiamo caricare dei pacchetti
library(raster)
install.packages("ncdf4") # installliamo questo pacchetto che permette la lettura dei dati scaricati da copernicus
library(ncdf4) # richiamiamo il pacchetto

setwd("C:/lab/") # impostiamo la working directory

QualityW<-raster("QualityW.nc")
QualityW # guardiamo da cosa è formato il nostro dato e tutti i suoi attributi

cl <- colorRampPalette(c('light blue','green','pink','orange'))(100) # cambiamo i colori all'immagine
plot(QualityW, col=cl) # si plotta l'immagine con i colori da noi selezionati

# avendo selezionato un dataset della qualità dell'acqua negli specchi d'acqua continentali l'informazione che otteng attraverso il plot è molto puntuale e poco visibile

# possiamo ora utilizzare la funzione "aggregate" per aggregare i nostri pixel, inizialmente abbiamo un'immagine con una certa quantita di pixel, maggiore è il loro numero e più grande è il peso dell'immagine
# posso quindi raggruppare i pixel in un pixel più grande, RESAMPLE <- diminuisco di 20 volte il numero dei pixel in questo modo (fact=10) è il fattore di riduzione

QualityWres<-aggregate(QualityW,fact=100) # fase di RESAMPLING= ricampionamento bilineare, fa la media di tutti i valori tra le celle, per aggregare le celle aumenta la tempistica aumentando il fattore di riduzione
plot(QualityWres, col=cl) # il fattore 100 è molto aggressivo e si ottiene un output più grezzo, ma serve a risparmiare tempo nelle analisi

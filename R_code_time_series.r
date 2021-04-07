# Time series analysis
# Greenland increase of temperature
# Data and code from Emanuela Cosma

install.packages("rasterVis")
library(rasterVis)
library(raster) #richiamiamo il pacchetto raster
setwd("C:/lab/greenland") #settiamo la cartella di lavoro 

#########################################################

# DAY 6
# abbiamo 4 strati separati che rappresenta la stima della temperatura derivante da "copernicus", ovvero un sito all'interno del quale si possono trovare diverse informazioni inerenti a diverse tipologie di applicazioni
# abbiamo un file LST ricavato ogni 10 giorni nel 2015, 2010, 2005, 2000 stiamta tramite satellite MODIS che ha alta risoluzione temporale (4 immagini al giorno)
# LST: Land Surface Temperature

#dobbiamo caricare il primo file 
lst_2000<-raster("lst_2000.tif") #la funzione per caricare i singoli strati del pacchetto, usciamo da R con la funzione "raster" e carichaimo l'immagine e l'assegnamo ad una variabile
plot(lst_2000) # plottiamo il dataset

lst_2005<-raster("lst_2005.tif")
plot(lst_2005)
#per visualizzare le estensioni .tif è necessario avere l'estensione "rgdal" del pacchetto "gdal"
#la scala graduata rappresenta i bit, a seconda della quantità utilizzata si possono discretizzare un numero di valori diverso
# gran parte delle immagini sono ad 8 bit ovvero con 256 valori possibili (0-255)
# l'immagine utilizzata è stata ridimensionata a 16 bit perché molte componenti si ripetono e si possono compattare in un numero minore di valori
# maggiore è il valore del digital number e maggiore è il valore di temperatura

lst_2010<-raster("lst_2010.tif")
lst_2015<-raster("lst_2015.tif") # importiamo anche le altre immagini

# facciamo una finestra in cui plottiamo le 4 immagini a confronto, in questo modo si possono fare le time series
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

# inserire le immagini una per una diventa un procedimento lento perciò si utilizza una funzione per plottare tutte le immagini insieme "lapply"
#"laplly"   : #applico una certa funzione ad una lista di raster che sono selezionate per caratteristica
# si fa una lista di file "lst" e su questa viene applicata la funzione raster con "lapply"

#prima di tutto faccio una lista: crea la lista di file che R usa per applicare la funzione "lapply"
#LIST OF FILES

rlist<-list.files(pattern="lst") #pattern: spiega al software i file che ci interessano attraverso il loro nome che devono contenere un oggetto in comune (i file utilizzati hanno in comune "lst_" nel nome)
import<-lapply(rlist,raster) # apllichiamo la funzione raster alla lista appena creata con la funzione "lapply", lapply(x, fun), in questo modo importiamo le immagini 
# abbiamo preso i singoli file, abbiamo fatto la lista, l'abbiamo importata in R, possiamo compattarli in un unico file, raggruppandoli dandogli un nome attraverso una funzione
#"stack": da una lista di file singoli genera un singolo file con all'interno i precedenti raggruppati (fa parte del pacchetto raster)
TGr<-stack(import) # genero un unico file, in questo modo posso plottare il singolo file
plot(TGr) #plottando il singolo file carica direttamente le 4 immagini caricate nella lista 

# la volta scorsa avevamo l'immagine satellitare e abbiamo portato i livelli
# in questo caso avevamo i livelli e con lo stack creiamo la condizione con tante bande
plotRGB(TGr, 1,2,3, stretch="Lin") # in questo modo vediamo la sovrapposizione di 3 immagini diverse, l'immagine del 2000 corrisponde al livello rosso, quindi se visualizziamo il rosso abbiamo i valori più alti del 2000 e la stessa cosa vale per gli altri valori e colori
# è molto blu al centro quindi si avranno valori di LST nel 2010
# dove c'è la mappa blu ci sono i valori di LST più alti e corrispondono agli anni più recenti 

#"colorist package" permette di variare la colorazione per visualizzare meglio specie di altre

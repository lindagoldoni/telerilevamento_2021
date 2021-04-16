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

#########################################################################################

#DAY 7

#installiamo il pacchetto "rasterVis"
# per utililizzare la funzione "levelplot"
install.packages("rasterVis")
library(rasterVis) #richiamiamo il pacchetto, deriva da un vecchio pacchetto chiamato "lattice"
library(raster)
setwd("C:/lab/greenland")

#generiamo la lista di file che sono denominati con "lst" , a questa applichiamo la funzione raster, con "stack" li racchiudiamo insieme in TGr
rlist<-list.files(pattern="lst") 
import<-lapply(rlist,raster)  
TGr<-stack(import)

#ora applichiamo la funzione "levelplot" che plotta i diversi file con una singola legenda per tutti e 4 e non 4 distinti
levelplot(TGr)
# con il "par" questa funzione diventa più difficile da gestire, ma si può fare direttamente sulle singole immagini
levelplot(TGr$lst_2000) # in questo modo selezioniamo solo un'immagine per cui fare il "levelplot" e si visualizza solo una singola mappa
# il file visualizzato è un singolo strato in cui i valori sono registrati in bit (questa è un'immagine a 16 bit) che indicano i valori di temperatura
# di una colonna di sommano tutti i valori e si dividono per il numero di valori, si ottiene così una media che può essere plottata su un grafico sopra la mappa
# sulla parte ghiacciata della Groenlandia ci aspettiamo dei valori di LST bassi e quindi una media bassa, che viene plottata a sua volta sul grafico, in questo modo per tutte le altre colonne
# in corrispondenza del bianco abbiamo dei "non valori"

# pacchetto "rasterdiv" che mostra ogni variabilità possibile

#il nostro levelplot mostra la variazione della temperatura su tutta l'area

cl<-colorRampPalette(c("blue","light blue", "pink","red"))(100)
levelplot(TGr,col.regions=cl)# in questo modo plottiamo le regioni con colori differenti e si vede multitemporalmente il cambiamento
# BLU SCURO: temperatura minore, con il tempo si degrada verso un celeste, ovvero una temperatura maggiore, da un anno all'altro
# levelplot vs. plot <- il primo è più compatto e mostra meglio l'eterogeneità dei valori, si visualizzano meglio le differenze

# le singole immagini di uno "stack" si chiamano attributi: in questo caso ne abbiamo 4 e possiamo cambiargli il nome:
levelplot(TGr, col.regions=cl, main="Summer land surface temperature", names.attr=c("July 2000","July 2005","July 2010","July 2015")) # in questo modo nominiamo i singoli attributi: abbiamo messo i nomi alle 4 mappe
# con un levelplot si possono aggiungere diversi oggetti nei nostri output
# con "main" indichiamo il titolo del nostro grafico

# MELT GREENLAND
# contiene i dati dal 1979 al 2007, abbiamo tantissimi dati e non possiamo fare un raster per ogni file ma facciamo la lista
melt.list<-list.files(pattern="melt") #gli warnings si possono trascurare, sono probabilmente piccoli errori nei files
melt.import<-lapply(melt.list, raster)
MeltGreenland<-stack(melt.import) # in questo modo faccio la lista con tutti i files e ad ognuno applico la funzione raster e infine li raggruppo con lo stack in "MeltGreenland"
levelplot(MeltGreenland) # ci indica il valore dello scioglimento dei ghiacci, più alto è il valore e maggiore è lo scioglimento, ci mostra lo scioglimento effettivo dei ghiacci
# vediamo molto bene la differenza tra il primo file del 1979 e quello del 2007: possiamo applicare la MATRIX ALGEBRA: abbiamo una matrice di pixel con valori di scioglimento basati sui bit
# possiamo fare un immagine-l'altra: mi da la differenza tra le due matrici e quindi tra i due valori di scioglimenti: PIU E ALTO IL VALORE E MAGGIOR GHIACCIO SI SARA SCIOLTO

melt_amount<-MeltGreenland$X2007annual_melt - MeltGreenland$X1979annual_melt #facciamo la sottrazione tra matrici e gli associamo un nome, dobbiamo prendere i file dal file più grande (dallo stack)
#visualizzando la lista vediamo i nomi dei vari layers, anche in questo caso l'immagine è a 16 bit

clb<-colorRampPalette(c("blue","white","red"))(100)
plot(melt_amount, col=clb) # le zone rosse sono quelle che dal 1979 al 2007 hanno subito uno scioglimento maggiore
melt_amount # si va da un valore di -87 a 92
levelplot(melt_amount, col.regions=clb)
# possiamo fare di tante immagini un unico plot o la differenza fra loro



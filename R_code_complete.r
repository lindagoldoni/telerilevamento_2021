# R_code_complete - Telerilevamento Geo-Ecologico

#-------------------------------------------------------------------------

# Summary:

# 1. Remote sensing first code
# 2. R code time series
# 3. R code Copernicus
# 4. R code knitr
# 5. Multivariate analysis
# 6. R-code classification
# 7. R-code ggplot2
# 8. R-code vegetation indices
# 9. R-code land cover
# 10. R-code variability
# 11. R-code spectral sigatures

#-------------------------------------------------------------------------

# 1. Remote sensing first code

# my first code in R for remote sensing

install.packages("raster") #installa il pacchetto "raster", utile a lavorare su file in formato raster appunto
library(raster) #richiama il pacchetto e ci permette di utilizzarlo

setwd("C:/lab/") #carica la working directory (comando per windows), dice al sistema dove acquisire i dati all'interno del PC

p224r63_2011 <- brick("p224r63_2011_masked.grd") #richiama un'immagine dall'esterno di R e l'assegna ad una variabile, importando l'immagine
#"masked" significa che l'immagine è già stata parzialmente elaborata
#le "" vengono usate per richiamare qualcosa dall'esterno di R

p224r63_2011 #posso richiamare la variabile per vedere se me l'ha caricata, si aprono gli attributi di dato raster (dimensioni, sorgente, classe, ecc.)
#mi ha caricato un raster brick -> (una serie di bande sovrapposte)

plot(p224r63_2011) #mi visualizza le immagini di bande di riflettanza
#vogliamo visualizzare una diversa scala di colore e stabiliamo noi una diversa scala di colori
#che restituiscono i valori di riflettanza per una determinata lunghezza d'onda

#color change
color<-colorRampPalette(c("black","grey","light grey"))(100) #dobbiamo racchiuderli in un vettore per dirgli che fanno parte della stessa caratteristica, ovvero il colore, 
#sono diversi elementi per lo stesso argomento
#con (100) gli diciamo quanti livelli di colore inserire nella scala

plot(p224r63_2011, col=color) #con questo comando plottiamo il raster con la nuova colorazione, "col" serve per definire i colori

cl<-colorRampPalette(c("orange","red","purple","pink"))(100)
plot(p224r63_2011, col=cl) #proviamo un'altra scala di colori nel plot, le bande indicano i diversi valori di riflettanza

##################################################################################
# DAY 3

#dobbiamo settare la cartella in cui abbiamo inserito tutti i dati e richiamare il pacchetto raster con il comando "library" (installa anche il pacchetto "sp" che serve per gestire tutti i dati all'interno del software)

# bande di landsat
#B1: blu
#B2: verde
#B3: rosso 
#B4: vicino infrarosso
#B5: medio infrarosso
#B6: infrarosso termico
#B7: infrarosso medio

#vogliamo plottare la banda del blu
dev.off() #prima di tutto ripuliamo la finestra grafica in modo da partire da 0, con detto comando, altrimenti si chiude la finestra manualmente

#il nome del file che contiene tutte le bande è "p224r63_2011"
#il nome della banda del blu è "B1_sre"
#dobbiamo legare la banda all'immagine attraverso il comando "$", questo simbolo viene utilizzato in R per legare due "blocchi"

plot(p224r63_2011$B1_sre)#plotta l'immagine legata alla banda B1, con la scala di colori dei default

#plot della B1 con la scala di colori decisa da noi
cl<-colorRampPalette(c("sky blue","blue","purple","yellow"))(200)
plot(p224r63_2011$B1_sre, col=cl) #proviamo un'altra scala di colori
dev.off()#chiudiamo l'interfaccia grafica

par(mfrow=c(1,2)) #serve per settare i parametri grafici di un grafico che vogliamo creare
# plottare accanto alla B1 anche la B2, una accanto all'altra facendo così un MULTIFRAME "mf", con una riga "row" e due colonne (salvate in un vettore c), se non facessimo questo una volta plottata la B2 ci cancella il plot precedente di B1
par(mfrow=c(2,1)) #in questo modo plottiamo le due immagini su 2 righe e 1 colonna
par(mfcol=c(2,1))#in questo modo utilizzando "col" il primo numero agisce sulle colonne e in questo modo farà 2 colonne e 1 riga

#vogliamo fare 4 righe e 1 colonna delle bande : B1, B2, B3, B4
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)
#vogliamo fare 2 righe e 2 colonna delle bande : B1, B2, B3, B4
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)
#ora per ogni colorRampPalette richiamiamo una specifica banda
par(mfrow=c(2,2))
clb<-colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(p224r63_2011$B1_sre,col=clb) #in questo modo richiamo la banda blu
clg<-colorRampPalette(c("dark green","green","light green"))(100)
plot(p224r63_2011$B2_sre,col=clg) #in questo modo richiamo la banda verde
clr<-colorRampPalette(c("dark red","red","pink"))(100)
plot(p224r63_2011$B3_sre,col=clr) #in questo modo richiamo la banda rossa
clnir<-colorRampPalette(c("red","orange","yellow"))(100)
plot(p224r63_2011$B4_sre,col=clnir) #in questo modo richiamo la banda infrarossa

############################################################################
# DAY 4

#plottiamo tutte le bande insieme con un plot RGB del dato
#prima di tutto richarichiamo nuovamente il pacchetto e il file

# bande di landsat
#B1: blu
#B2: verde
#B3: rosso 
#B4: vicino infrarosso
#B5: medio infrarosso
#B6: infrarosso termico
#B7: infrarosso medio

# schema RGB: ogni schermo utilizza il rosso, il verde e il blu, che mischiandosi generano tutti gli altri colori per generare le immagini con colori "naturali".
#nello schema RGB posso utilizzare tre bande per volta
# prendo la banda del rosso e la monto sulla banda B3, la banda del verde nella B2 e la banda del blu e la metto sul B1, con questo schema possiamo visualizzare le immagini con colori naturali
# la funzione per l'applicazione è
plotRGB(p224r63_2011, r=3,g=2,b=1, stretch="Lin") # dobbiamo spiegargli quali bande associare alle componenti, con "stretch" prendiamo le bande e le allunghiamo in modo da non visualizzare meglio una banda a discapito di un'altra, in modo da schiacciare i valori
# con questo formato di colori risulta difficile distinguere forme da altre
# Non mettiamo "B1_sre" perché la funzione è progettata per usare direttamente il numero del layer invece del nome della banda, quindi mettiamo direttamente in che punto del nostro pacchetto è la banda corrispondente

# vogliamo provare con altre bande
plotRGB(p224r63_2011, r=4,g=3,b=2, stretch="Lin") #in questo modo scorriamo le bande di 1 e togliamo il blu: infrarosso, rosso, verde. 
# siccome nella componente "red" abbiamo montato l'infrarosso, la vegetazione ha altissima riflettanza in questa banda (in questo modo la vegetazione diventa rossa)

plotRGB(p224r63_2011, r=3,g=4,b=2, stretch="Lin") #spostiamo la banda infrarosso sul "green", la vegetazione in questo modo diventa verde
#si vedono pattern che prima non erano visibili all'interno della foresta, il viola invece rappresenta sempre suolo nudo visualizzando bene la componente agricola

plotRGB(p224r63_2011, r=3,g=2,b=4, stretch="Lin") #monta l'infrarosso nella componente blu

#montiamo le 4 immagini nello stesso plot con "par" 2x2
# esiste una funzione per salvare l'immagine come pdf nella nostra cartella
pdf("il_mio_primo_pdf.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3,g=2,b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4,g=3,b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3,g=4,b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3,g=2,b=4, stretch="Lin")
dev.off()

# da questo grafico si vede molto bene che utilizzando i colori naturali gran parte delle sfumature del paesaggio vengono perse, perché in quella lunghezza d'onda il fatto che la vegetazione abbia più o meno umidità NON VIENE VISUALIZZATO
#esiste un altro tipo di stretch che è l'"histogram", invece di fare il profilo lineare, questa funzione allunga ancora di più la banda, ha una potenza media più alta
plotRGB(p224r63_2011, r=3,g=4,b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3,g=4,b=2, stretch="hist") # all'interno della foresta vediamo una grande differenziazione rispetto alle immagini precedenti, probabilmente dovuto alle zone più umide
# grazie alla modifica dell'immagine si vedono quindi forme che altrimenti ad occhio nudo non avremmo mai visto, perché la pendenza è molto più ampia e si possono vedere meglio le forme, ottimo nell'analisi delle forme geologiche

# par con colori naturali, con colori falsati e con colori falsati dati dall'histogram stretch
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3,g=2,b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3,g=4,b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3,g=4,b=2, stretch="hist")
# si vedono notevoli differenze tra le diverse immagini a dimostrare la potenza della modifica delle bande su immagini satellitari

#per le immagini RGB non c'è la legenda perché non decidiamo noi i colori ma "giochiamo" con i colori presenti nell'immagine, decide il programma come miscelare i colori
# colorist R package: è un pacchetto che serve per montare l'RGB in tanti modi, serve a fare plot nello spazio e nel tempo in RGB mostrando le caratteristiche di distribuzione di una certa specie

########################################################################
# DAY 5
# dobbiamo installare un pacchetti RStoolbox

# 1988 image
# p224r63_1988_masked
install.packages("RStoolbox")
library(raster)
library(RStoolbox)
p224r63_2011 <- brick("p224r63_2011_masked.grd") # immagine del 2011, con l'intero blocco di bande tramite la funzione "brick"
p224r63_2011

#Sequenza multitemporale
p224r63_1988 <- brick("p224r63_1988_masked.grd") # richiamo l'immagine del 1988 dalla cartella "lab" e la associamo ad una variabile
p224r63_1988 # in questo modo vediamo le informazioni del raster, che sono identiche al raster precedente, cambia solo l'anno di acquisizione

plot(p224r63_1988) # plottiamo prima la sola 1988
plotRGB(p224r63_1988, r=3,g=2,b=1, stretch="Lin")  #plottiamo mostrando le bande RGB
plotRGB(p224r63_1988, r=4,g=3,b=2, stretch="Lin") # associamo la banda rossa B3 al verde in RGB

# facciamo uno schema con 2 righe e una colonna con immagini al naturale del 1988 e 2011, in modo da mostrare una sequenza multitemporale
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4,g=3,b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4,g=3,b=2, stretch="Lin")

# plottiamo in una finestra 4 immagini: in una riga la sequenza temporale con stretch "lineare", nella seconda riga la sequenza temporale con stretch "histogram"
pdf("sequenza_multitemporale_foresta_pluviale.pdf") #generiamo il file pdf nella cartella "lab"
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4,g=3,b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4,g=3,b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4,g=3,b=2, stretch="hist")
plotRGB(p224r63_2011, r=4,g=3,b=2, stretch="hist")
dev.off()
# immagine 1988: si vede molto bene che c'era la transizione graduale dalla foresta alla zona antropizzata
# immagine 2011: si vede il passaggio netto tra foresta e paesaggio antropico
# con l"histogram" si genera molto rumore che non fa apprezzare benissimo le forme 

#-------------------------------------------------------------------------

# 2. R code time series


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

#-------------------------------------------------------------------------

# 3. R code Copernicus

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

#-------------------------------------------------------------------------

# 4. R code knitr

#R_code_knitr.r

#DAY 9

install.packages("knitr") # nkitr è la funzione che permette di generare un report automatico
require(knitr) # analogo al comando library che richiama il pacchetto

setwd("C:/lab/greenland/") # settiamo la working directory

#il pacchetto "knitr" interno ad R esce e prende il codice esterno, lo importa in R dentro cui genera un report che viene salvato nella stessa cartella dov'è presente il codice
# prendiamo un codice già scritto lo copiamo e lo incolliamo in un programma di testo (preferibilmente non Word perché utilizza un codice suo)
# siamo andati a mettere il codice nella cartella di riferimento, knitr lo prende, lo mette in R e genera il report

tinytex::install_tinytex()
tinytex::tlmgr_update()
# sono stati installati il pacchetto "tinytex" e il rispettivo aggiornamento per implementare la conversione del file tex, generato con la funzione "stitch", in pdf
#questo procedimento non veniva eseguito per mancanza di librerie interne al computer 

stitch("C:/lab/greenland/R_code_greenland.r.txt" , template=system.file("misc", "knitr-template.Rnw", package="knitr"))
# la funzione "stitch" serve a implementare il pacchetto knitr per produrre il report
#diamo un nome al nostro codice e lo utilizzaremo per fare il file finale

# salva anche le singole figure come pdf in una cartella


# con software di testo possiamo compilare i file latex
# il fil etex generato con R che non riusciamo a leggere lo andiamo a leggere con OverLeaf generando il Latex

#-------------------------------------------------------------------------

# 5. Multivariate analysis

#R_code_multivariate_analysis.r

#cariachiamo i pacchetti prima di tutto
library(raster)
library(RStoolbox)

setwd("C:/lab/") #settiamo la working directory
#il satellite landsat ha diverse bande e in questo caso le utilizziamo tutte e 7: se l'immagine ha 7 bande USIAMO LA FUNZIONE "brick" per caricare un set completo di raster

p224r63_2011<-brick("p224r63_2011_masked.grd") # salviamo l'immagine in una variabile e l'apriamo con la funzione "brick"
plot(p224r63_2011) # vedremo diverse immagini plottate alle varie bande
p224r63_2011 # leggiamo le informazioni dell'immagine
plot(p224r63_2011$B1_sre,p224r63_2011$B2_sre, col="red", pch=19, cex=2) # plottiamo le bande 1 e la banda 2 della nostra immagine escludendo tutte le altre, "pch" serve ad indicare il simbolo che vogliamo plottare, "cex" aumenta la dimensione dei puntoi

# compare un "warnings" dicendo che: ha plottato il 2% dei pixel che in realtà formavano il raster
# vediamo però informazioni molto correlate tra loro, infatti la banda 1 e 2 solitamente sono fra loro molto correlate: l'informazione di un punto su una banda è molto simile all'informazione del punto sull'altra banda
# spesso questa informazione è utilizzata a scopo causale: LA CAUSALITA è PERICOLOSA bisogna essere sicuri che una cosa sia causa di un'altra
# la distribuzione dipende dall'ordine con cui inseriamo le bande
plot(p224r63_2011$B2_sre,p224r63_2011$B1_sre, col="red", pch=19, cex=2)

# funzione "pairs": per plottare tutte le correlazioni possibili di tutte le variabili di un dataset
# METTE IN CORRELAZIONE TUTTE LE VARIABILI DI UN CERTO DATASET: ovvero le bande
# sulla diagonale abbiamo tutte le bande, si incrociano fra di loro mostrando la correlazione
# sulla parte alta viene mostrato un indice: indice di correlazione, varia tra -1 e 1, se siamo positivamente correlati (perfetto)  l'indice va a 1
# se siamo negativamente correlati l'indice va a -1: ci restituisce la dimensione del carattere in funzione dell'indice di correlazione

pairs(p224r63_2011)
# in questo modo posso verificare quale variabile si correla meglio
# vediamo come in molti casi le bande siano molto correlate

# possiamo quindi compattare un numero superiore di bande mantenendo invariate le informazioni al loro interno

###################################################################################
 # richiamiamo i vari pacchetti e settiamo la working directory
library(raster)
library(RStoolbox)

setwd("C:/lab/") 
p224r63_2011<-brick("p224r63_2011_masked.grd")
p224r63_2011 # immagine formata da 7 bande in cui i pixel di una banda sono correlati ad un altra banda
pairs(p224r63_2011) # viene visualizzato anche il coefficiente di correlazione di Pearson che va da -1 a 1 che indicano il grado di correlazione, banda 1 e 2 sono correlate fortemente
# ogni banda spiega un certo grado di variabilità, anziché usare ogni singola spiegazione di variabilità ne usiamo 2 PC1 e PC2 che passano rispettivamente per i gradiente più alto e più basso
# la PCA è un'analisi piuttosto impattante: una soluzione è quella di compattare il dato e generarne uno più leggero
# per farlo possiamo utilizzare la funzione "aggregate" 
# abbiamo pixel di 30m x 30m e possiamo aggregarla e rimpicciolirli di 10 volte
# in origine ci sono circa 31 mln di pixel

#aggregate cells: resampling (ricampionamento)
p224r63_2011res<-aggregate(p224r63_2011, fact=10) # ricampioniamo i pixel aumentandoli di 10 volte  linearmente e diventa 300x300 diminuiamo la risoluzione
p224r63_2011res # la risoluzione è diminuita linearmente e il pixel è 300mx300m, aumentare la dimensione dei pixel diminuisce la risoluzione

par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4,g=3,b=2, stretch="lin") 
plotRGB(p224r63_2011res, r=4,g=3,b=2, stretch="lin") # confrontiamo l'immagine con risoluzione originale con risoluzione diminuita
# abbiamo svolto questa trasformazione in quanto l'analisi è molto pesante e in questo modo si velocizza

# facciamo la PCA: prendiamo i dati originali e plottiamo variabilità maggiore e minore
# utilizziamo la funzione "rasterPCA" che compatta la variabilità delle bande
p224r63_2011res_pca<-rasterPCA(p224r63_2011res)
# il PCA è composto da diversi output come modello e mappa, noi vogliamo visualizzare solo il modello e lo estrapoliamo con il $
summary(p224r63_2011res_pca$model)
# il risultato ci fa vedere che con le prime 3 bande il modello ci spiega il 99,998 % di variabilità
plot(p224r63_2011res_pca$map) # ci aspettiamo di vedere tanta variabilità nella prima componenete e poca nell'ultima che mostra solo un piccolo residuo
# nella prima componente riusciamo a distinguere bene tutte le variazioni spaziali, nella componente 7 diventa molto difficile distinguere le forme, la prima componente è quella che spiega più variabilità
plotRGB(p224r63_2011res_pca$map, r=1,g=2,b=3, stretch="lin")
# i colori sono legati alle tre componenti, risulta quindi un'analisi delle componenti principali, questa è la PCA dell'immagine originale
# data cube: immagine iperspettrale con numerose bande che possono essere compattate attraverso la PCA

str(p224r63_2011res_pca) # ci mostra la struttura del file

# all'interno della PCA abbiamo generato delle nuove componenti che diminuiscono la forte correlazione iniziale da tutte le bande, con un numero minori di componenti possiamo spiegare l'immagine
# è importante applicare l'analisi multivariata per diminuire la correlazione tra le variabili se viene fatto un modello lineare il cui assunto è che non ci siano variabili molto correlate
# se ci sono aumenta la potenza del modello

#-------------------------------------------------------------------------

# 6. R-code classification

# R_code_classification.r


#SOLAR ORBITER

library(raster) #carichiamo il pacchetto che ci permette di utilizzare la funzione "brick"
library(RStoolbox) #dovremo utilizzare delle funzioni di questo pacchetto
setwd("C:/lab/solar_orbiter/") # settiamo la cartella "solar_orbiter" come working directory
so<-brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") #carichiamo dentro ad R la nostra immagine e la salviamo in una variabile, la funzione brick permettedi recuperare un immagine esterna ad R con tutto il pacchetto RGB dei dati, la funzione si trova nel pacchetto "raster"
#l'immagine rappresenta con immagine ultravioletti diverse situazioni energetiche del sole (esplosioni, ecc)
so # richiamiamo l'immagine per visualizzare i suoi attributi

#visualizziamo il plot in RGB
plotRGB(so,1,2,3,stretch="lin") # in questo modo vediamo l'immagine con i colori originali, dove le esplosion sono più forti l'immagine è più luminosa
#dobbiamo classificare l'immagine per determinare le diverse classi energetiche
# nella nostra immagine montata in RGB, ogni pixel ha un determinato valore nelle rispettive bande e interpolando su uno spazio 3D ricaviamo la posizione del pixel
#il valore del colore nelle rispettive bande dipende dalla riflettanza di ciascuna banda
# SPAZIO MULTISPETTRALE: discretizza le bande come assi e si genera un set di controllo con cui fare la classificazione

#MAXIMUM LIKELYHOOD: ad ogni pixel viene associata una classe sulla base dell'interpolazione dei valori degli assi delle bande

#facciamo la classificazione
#il training set li ricava direttamente il software e determina una CLASSIFICAZIONE NON SUPERVISIONATA, si lascia definire le classi dal software autonomamente

#"unsuperClass": unsupervised classification, funzione che applica la classificazione non supervisionata
#unsuperClass(img, numero di pixel, quanti classi vogliamo fare,...) <- parametri da inserire nella funzione

set.seed(42)
soc<-unsuperClass(so, nClasses=3) # mettiamo solo nome dell'immagine e il numero di classi che vogliamo creare e la salviamo in una variabile, siamo partiti da punti random
#plottiamo ora l'immagine risultato
#unsuperlClass<- ha creato il modello e la mappa in uscita, quando plottiamo l'immagine ha diverse parti, NOI DOBBIAMO PLOTTARE LA MAPPA
plot(soc$map) # del file soc prendiamo solo la mpa con il simbolo $
# abbiamo il software che divide le 3 classi e le associa a piacere 
#può essere che le mappe tra i colleghi siano diverse perché ognuno di noi ha selezionato un "training set" diverso
# si può soluzionare con la funzione "set.seed" prima della funzione

# possiamo provare a plottare con 20 classi differenti
set.seed(42)
soe<-unsuperClass(so, nClasses=20) 
plot(soe$map)
# andiamo a discriminare ogni singola parte dell'immagine una classe rispetto ad un altra (qui le immagini tra di noi possono essere davvero diverse)

# c'è anche un altro tipo di classificazione che è SUPERVISIONATA ma si selezionano ogni singolo pixel e il procedimento sarebbe troppo lungo da applicare al momento
#la classificazione potrebbe fallire nella classificazione di un volto PERCHE SI BASANO SULLA RIFLETTANZA  e il volto non varia molto
# esistono però algoritmi che classificano sulla base della forma, PIU L'ALGORITMO COMPLESSO PIU L'IMMAGINE E DETTAGLIATA

#Download image from ESA
sun<-brick("Sun.png")
set.seed(42)
sunc<-unsuperClass(sun, nClasses=3) 
plot(sunc$map)
#siccome c'è un livello esterno (spazio) viene accorpata ai livelli intermedi perché hanno lo stesso valore di riflettanza e si vedono bene i livelli più esterni più energetici
#più aumentiamo i dettagli più aumenta il rumore dato da ombre o nuvole
# più si aumentano i livelli più ci si avvicina all'immagine originale

#GRAND CANYON
# https://landsat.visibleearth.nasa.gov/view.php?id=80948

#le nuvole possono essere tolte con funzioni creando un file "masked" oppure uyilizziamo un altro tipo di sensore
#le immagini ad ora utilizzate sono state acquisite con sensori passivi
# la mineralogia delle rocce determina vari valori di riflettanza di una certa zona
# utilizziamo un'immagine landsat con colori del visibile

#carichiamo le librerie dei pacchetti
library(raster)
library(RStoolbox)
setwd("C:/lab/canyon/") # settiamo la cartella come working directory

canyon<-brick("dolansprings_oli_2013088_canyon_lrg.jpg") #carichiamo l'immagine RGB con la funzione "brick" che carica tutti i livelli
plotRGB(canyon,1 ,2 ,3, stretch="lin") #lo stretch serve per aumentare la risoluzione dei colori, l'immagine landsat ha una risoluzione dei pixel 30x30, estendiamo la visione dei colori
plotRGB(canyon,1 ,2 ,3, stretch="hist") # facciamo il plot visualizzando i colori ancora più dettagliati e catturando più colori
# per fare la classificazione guidata dal computer utilizziamo unsuperClass function

canyonc<-unsuperClass(canyon,nClasses=2)# applichiamo la classificazione e la salviamo in una variabile e applichiamo il numero di classi che vogliamo visualizzare
canyonc #visualizziamo gli attributi dell'immagine
plot(canyonc$map) #del nostro output vogliamo visualizzare soltanto la mappa

# la differenziazione maggiore la vediamo nella macchia centrale che può essere data da una differenza di mineralogia
# ovviamente utilizza la classificazione attraverso la differenza di riflettanza

#aumentiamo le classi
canyonc4<-unsuperClass(canyon,nClasses=4)
canyonc4
plot(canyonc4$map)
# l'acqua assorbe molto l'infrarosso quindi appare nera in questa banda (se la usassimo) ora siamo nel visibile in RGB
# con le 4 classificazioni ovviamente vediamo maggiore dettaglio, per appurare le classificazioni bisognerebbe andare  a terra e verificare come mai ci sono differenze nella riflettanza

# analisi multivariata: vogliamo compattare le informazioni tra loro correlate, misura la varianza tra la riflettanza su due bande
# dobbiamo compattare un sistema a due bande: partendo dall'origine si traccia un asse e lo chiamiamo "Componente principale 1" PC! e il secondo asse lo facciamo passare perpendicolare al primo e lo chiamiamo PC2
# il sistema ha sempre due bande  MA LA VARIABILITA E DI CIRCA IL 90% PER PC1 E 10 % PC2: invece di usare tutti e due gli assi ne uso solo uno (PC1 ad esempia che interessa già il 90%)
# la componente principale è quella meglio visualizzata e le altre rappresentano il rumore

#-------------------------------------------------------------------------

# 7. R-code ggplot2

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
setwd("~/lab/")
p224r63 <- brick("p224r63_2011_masked.grd")
ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")
p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")
grid.arrange(p1, p2, nrow = 2) # this needs gridExtra

#-------------------------------------------------------------------------

# 8. R-code vegetation indices

#R_code_vegetation_indices.r

library(raster)

setwd("C:/lab/deforest/")

defor1<-brick("defor1.jpg")
defor2<-brick("defor2.jpg")

# B1=NIR, B2=red, B3=green

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

par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")
# le mettiamo in un'unica finetsra per confrontarle e successivamente facciamo il calcolo

difdvi<- dvi1-dvi2 # facciamo la differenza tra le due mappe e compare un messaggio ( Raster objects have different extents. Result for their intersection is returned)
# ci dice che l'estenzione delle due mappe non è la stessa, molto probabilmente ci sono alcuni pixel in piu in una rispetto all'altra

cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi,col=cld)
# dove ho valori di differenza più marcata la mappa è rossa, dove la differenza è bassa abbiamo il bianco e il celeste
# ci dice dove c'è stata della sofferenza vegetativa nell nostra area

#NDVI: normalizza il DVI, fa la standardizzazione del DVI sulla somma tra NIR e RED, in modo da ottenere numeri bassi e si possono confrontare immagini con risoluzione radiometrica differente
#il range dell'NDVI è [-1 , 1]

#NDVI
#(NIR-RED)/(NIR+RED)
ndvi1<-(defor1$defor1.1-defor1$defor1.2)/(defor1$defor1.1+defor1$defor1.2)
plot(ndvi1,col=cl) #vediamo che il range della legenda va da -1 a 1
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

#############################################################################################

#worldwide NDVI

#il pacchetto "rasterdiv" contiene un dataset di copernicus

install.packages("rasterdiv") # significa raster diversity
library(rasterdiv) # carichiamo il pacchetto rasterdiv
library(raster)
library(RStoolbox)
library(rasterVis)

#possiamo utilizzare il dataset "copNDVI" contenuto nel pacchetto

plot(copNDVI)
# vogliamo poi togliere tutta la parte che riguarda l'acqua tramite la funzione "cbinc" che cambia dei valori
# i pixel 253,254,255 (che riguardano l'acqua) possono essere trasformati in non valori NA
copNDVI<-raster::reclassify(copNDVI,cbind(252,255,NA),right=TRUE) #usiamo la funzione reclassify che si lega al pacchetto con i ::
# riclassifichiamo l'immagine originale e diciamo che i valori scritti (range) devono diventare NA
plot(copNDVI)

#facciamo il levelplot con il pacchetto rasterVis
levelplot(copNDVI) # si visualizzano i valori gradati per valore di NDVI nel mondo
#nella zona dell'equatore c'è il valore massimo di massa percé c'è massima luce e le piante che hanno molta sete di luce si accavallano l'una sull'altra per catturare quanta più luce possibile, atteggiamento tipico delle foreste tropicali
# a 23° Nord ci sono i deserti, tutti posti sulla stessa linea, perché li l'evapotraspirazione è elevatissima, si generano moti convettivi che fanno risalire aria umida e discendere aria secchissima

#-------------------------------------------------------------------------

# 9. R-code land cover

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

#############################################
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
setwd("C:/lab/cover/")
defor1<-brick("defor1.jpg") 
defor2<-brick("defor2.jpg")
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

#con unsuperClass facciamo la classificazione non supervisionata da noi e fa tutto il sistema 
d1c<- unsuperClass(defor1,nClasses=2) # è case sensitive prciò dobbiamo stare sepre attenti alle maiuscole
d1c # vediamo gli attributi della classificazione appena fatta
plot(d1c$map) # in questo modo plotto la mappa della classificazione e scegli il sistema a cosa assegnare le classi
#class1: forest
#class2: agricolture

d2c<- unsuperClass(defor2,nClasses=2)
d2c
plot(d2c$map)
#class1: forest
#class2: agricolture

#con 3 classi
d2c3<- unsuperClass(defor2,nClasses=3)
plot(d2c3$map)

#ognuno parte da campioni random iniziali differenti e i risultati possono venire diversi
#vogliamo calcolare la frequenza dei pixel di una certa classe (quante volte ho i pixel della classe di "foresta"?) ovvero calcoliamo la FREQUENZA
# la funzione da usare è "freq": che calcola la frequenza

#frequences
freq(d1c$map)
#     value  count
#[1,]     1 306208
#[2,]     2  35084
#i numeri tra di noi sono diversi leggermente
#calcoliamo la proporzione o percentuale

s1<-306208+35084 #sommiamo per trovare il numero totale di pixel
prop1<-freq(d1c$map)/s1  #in questo modo ricaviamo le proporzioni, anche qui i numeri tra di noi risultano leggermente differenti
# prop forest: 0.8972024
# prop agricolture: 0.1027976

#defor2 ha un numero di pixel diverso rispetto defor1 perché contornati in maniera diversa
s2<-342726
prop2<-freq(d2c$map)/s2
#prop forest: 0.5209847
#prop agricolture: 0.4790153

# si possono fare le percentuali moltiplicando semplicemente per 100

#build a dataframe
cover<- c("Forest","Agricolture")
percent_1992<-c(89.72, 10.16)
percent_2006<-c(52.09, 47.90)
#usando la funzione "data.frame" genera il dataframe

percentages<-data.frame(cover,percent_1992,percent_2006)
percentages
# si genera un dataset da poter utilizzare quando è possibile
# con ggplot2 possiamo poi generare il grafico
# la funzione ggplot plotta un dataset definendo colonne e i colori a piacimento

p1<-ggplot(percentages,aes(x=cover,percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
# vediamo su un grafico la percentuale di campo per agricoltura e la percentuale di foresta
# la legenda è stata definita con "color=cover"
p2<-ggplot(percentages,aes(x=cover,percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
#nel 2006 si vede come le percentuali si avvicinano nettamente in quanto diminuisce drasticamente la foresta e aumenta la porzione coltivata

grid.arrange(p1,p2,nrow=1) # in questo modo mettiamo i plot insieme in uno solo

#-------------------------------------------------------------------------

# 10. R-code variability

#R_code_variability.r

#dobbiamo caricare le diverse librerie dei pacchetti
library(raster)
library(RStoolbox)
library(ggplot2) #per il plot ggplot
library(gridExtra)

setwd("C:/lab/similaun/")

sent<-brick("sentinel.png") #richiamiamo l'immagine dalla cartella e successivamente facciamo un plotRGB
plotRGB(sent, stretch="lin") #il default dovrebbe farci vedere l'immagine con i colori cosi come sono ovvero NIR=1,RED=2,GREEN=3
#noi vogliamo fare quindi r=1, g=2, b=3
plotRGB(sent, r=2, g=1, b=3, stretch="lin") #in questo modo vediamo molto bene la componente dell'acqua che diventa nera
#per fare il calcolo della deviazione standard possiamo utilizzare una sola banda utilizzando la moving window e facciamo la media delle celle
#maggiore è la diversità tra le celle e maggiore è la deviazione standard
# lo stesso calcolo lo faccio muovendo la finestra il che calcola dei nuovi pixel 
# dobbiamo compattare tutto il set di dati in una sola banda perché possiamo usarne solo una
# facciamo perciò il layer NDVI su cui poi calcolare la finestra mobile

#dobbiamo prima di tutto sapere come si chiamano le bande nel file sentinel e per farlo basta visualizzare la tabella degli attributi dell'immagine
sent
nir<-sent$sentinel.1 #in questo modo associamo la prima banda dell'immagine alla variabile nir
red<-sent$sentinel.2

ndvi<-(nir-red)/(nir+red) #in questo modo facciamo l'NDVI
plot(ndvi) #un solo indice di vegetazione che dice che dove abbiamo il bianco non c'è vegetazione (acqua, crepacci, ecc)
# bosco =giallino 
# praterie= verde
#possiamo cambiare colorRampPalette
cl <- colorRampPalette(c('black','white','red','magenta','green'))(100)  
plot(ndvi,col=cl)
# da questo singolo strato utilizziamo la moving window e calcoliamo la deviazione standard

#utiliziamo la funzione "focal": nell'intorno dell amoving window calcoliamo la statistica che ci piace
ndvi_devst<-focal(ndvi,w=matrix(1/9,nrow=3,ncol=3),fun=sd)
#mettiamo prima l'oggetto su cui calcolare la dev. standard, si inserisce poi la finestra su cui fare il calcolo (solitamente è quadrata)
#più grande è la finestra e più lungo è il calcolo, alla fine si mette la funzione da utilizzare ovvero "deviazione standard"
plot(ndvi_devst)

clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # cambiamo la colorramppalette
plot(ndvi_devst, col=clsd)
# dove ci sono colori tendenti al rosso e al giallo abbiamo una deviazione standard più alta
#le porzioni rosino corrispondono ai crepacci
#possiamo anche calcolare la media della biomassa nell'immagine (media della deviazione standard)
ndvi_mean<-focal(ndvi,w=matrix(1/9,nrow=3,ncol=3),fun=mean)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # cambiamo la colorramppalette
plot(ndvi_mean, col=clsd)
# la media porta a valori molto alti nella prateria ad alta quota, valori alti per le porzioni boschive e valori molto bassi pe rla roccia nuda

#adesso andiamo a cambiare la grandezza della moving window: deve avere un numero dispari
ndvi_devst13<-focal(ndvi,w=matrix(1/169,nrow=13,ncol=13),fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # cambiamo la colorramppalette
plot(ndvi_devst13, col=clsd)
# vengono accopparti maggiormente i pixel perché sto usando dei pixel più grandi
# una finestra di 5x5 potrebbe essere la più adeguata

#facciamo nuovamente il calcolo con 5x5
ndvi_devst5<-focal(ndvi,w=matrix(1/25,nrow=5,ncol=5),fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # cambiamo la colorramppalette
plot(ndvi_devst5, col=clsd)
# determina la situazione ideale con cui studiare quest'area

#esiste un'altra tecnica per compattare i dati ovvero con l'analisi multivariata e da questa prendiamo solo la banda PC1 e su questa ci facciamo passare la moving window per creare la mappa di deviazione standard derivata da una sola variabile

#dobbiamo utilizzare la funzone "rasterPCA" contenuta in RStoolbox, facciamo la PCA dell'immagine originale
sentpca<-rasterPCA(sent)
plot(sentpca$map) #la prima componente mantiene il range di informazione più alta e mantiene in miglior modo le informazioni originali
#via a via l'informazione diminuisce
sentpca # visualizziamo in questo modo gli attributi e le componenti dell'output appena ottenuto
#facciamo poi un summary
summary(sentpca$model)
# si vede anche una proporzione di variabilità
# la prima PC mostra il 67.36804% dell'informazione originale, a partire da quest'immagine calcoleremo la variabilità

#####################################################################################

#richiamiamo i pacchetti utili e selezioniamo la working directory
# dopodiché richiamiamo l'immagine caricata la scorsa volta
# infine richiamiamo la pca fatta la scorsa volta

pc1<-sentpca$map$PC1
sd_pc1<-focal(pc1, w=matrix(1/25,nrow=5,ncol=5),fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # cambiamo la colorramppalette
plot(sd_pc1, col=clsd)      
# siamo ancora interessati a capire come variano i valori su una singola banda
# sul similaun abbiamo una grande varietà geomorfologica

# funzione "source" : ci permette di richiamare un pezzo di codice esterno
source("source_test_lezione.r") # in questo modo richiamiamo l'intero codice senza doverlo aprire su R

# dobbiamo installare un altro pacchetto e richiamare pacchetti per riuscire a fare il ggplot
install.packages("viridis")
library(viridis) # serve per i colori dei ggplot

source("source_ggplot.r")
# il ggplot ci permette di fare dei plot molto più belli
# i file richiamati devono essere all'interno della cartella della working directory

ggplot() + #crea una finestra vuota e il pacchetto mano a mano aggiunge dei blocchi semplicemente con il + e si va a capo
geom_raster(sd_pc1, mapping=aes(x=x,y=y,fill=layer))+ #dobbiamo definire la geometria da inserire nel ggplot: nel nostro caso stiamo usando una mappa e quindi un raster con pixel
# successivamente si inseriscono le estetiche (x,y) e il valore, è ciò che vogliamo mappare (aesthetics)
# con il ggplot la porzione con i crepaci si vede molto bene
scale_fill_viridis()+ # fa una colorRampPalette senza farla realmente
ggtitle("Standard deviation of PC1 by viridis colour scale")

# utilizziamo la legenda MAGMA: prima non avevamo selezionato una legenda precisa
p1<-ggplot() + 
geom_raster(sd_pc1, mapping=aes(x=x,y=y,fill=layer))+ 
scale_fill_viridis(option="magma")+ 
ggtitle("Standard deviation of PC1 by magma colour scale")

#utilizziamo la legenda INFERNO
p2<-ggplot() + 
geom_raster(sd_pc1, mapping=aes(x=x,y=y,fill=layer))+ 
scale_fill_viridis(option="inferno")+ 
ggtitle("Standard deviation of PC1 by inferno colour scale")

#utilizziamo la legenda TURBO
p3<-ggplot() + 
geom_raster(sd_pc1, mapping=aes(x=x,y=y,fill=layer))+ 
scale_fill_viridis(option="turbo")+ 
ggtitle("Standard deviation of PC1 by turbo colour scale")

#ora possiamo metterle tutte insieme
#associo un nome ad ogni scala di colori : ogni plot precedente viene associato ad un oggetto

grid.arrange(p1,p2,p3, nrow=1) # la color ramp rainbow è molt discussa che mette il giallo nei valori medi, il nostro occhio lo percepisce come un valore alto anche se in legenda non è cosi
# la funzione grid.arrange è contenuta nel pacchetto gridExtra

#-------------------------------------------------------------------------

# 11. R-code spectral signatures

# R_code_spectral_signatures.r

# ogni roccia e minerale o viva ha una propria firma spettrale

library(raster)
setwd("C:/lab/cover")

#lavoriamo su defor2.jpg

defor2<-brick("defor2.jpg")

# defor2.1, defor2.2, defor2.3
# NIR, red, green

plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="hist")

#usiamo questo dataset per visualizzare delle firme spettrali con la funzione "click" contenuto nel pacchetto "rgdal"

library(rgdal)

click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")
#dobbiamo dire su quale mappa vogliamo cliccare e definire come vogliamo fare il click ovvero un punto "p" , definiamo dimensione e colore

#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 150.5 270.5 148570      200        9       24
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 155.5 237.5 172236      195       14       19
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 612.5 231.5 176995      101      143      159
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 632.5 268.5 150486       49       94      136


#facciamo una tabella con il numero di banda, poi con uso del suolo (foresta o acqua) e utilizzeremo questo dataframe per creare l'output

#definiamo le colonne del dataset
band<-c(1,2,3)
forest<-c(200,9,24)
water<-c(49,94,136)
#ora mettiamo tutto in una tabella con la funzione
spectrals<-data.frame(band,forest,water)

library(ggplot2)

#plottiamo la firma spettrale
ggplot(spectrals,aes(x=band))+ #nel grafico in x ci va la banda e in y in una mettiamo l'acqua e in una la foresta
       geom_line(aes(y=forest), color="green")+ #inserisce le geometrie delle linee di interesse
       geom_line(aes(y=water),color="blue", linetype="dotted")+
       labs(x="band",y="reflectance")
       
###################################################################
       
#multitemporal
defor1<-brick("defor1.jpg")
plotRGB(defor1, r=1,g=2,b=3, stretch="lin")
       
#firme spettrali di defor1 
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")
#      x     y   cell defor1.1 defor1.2 defor1.3
#1  52.5 349.5  91445      151       57       58
#2  57.5 377.5  71458      153       24       29
#3 100.5 381.5  68645      217       23       47
#4 105.5 345.5  94354      224       49       64
#5  81.5 334.5 102184      217       20       37
       
#facciamo la stessa cosa con defor2
plotRGB(defor2, r=1,g=2,b=3, stretch="lin")
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")   
#      x     y   cell defor2.1 defor2.2 defor2.3
#1  66.5 341.5  97579      200      202      191
#2  77.5 368.5  78231      211       15       37
#3 116.5 368.5  78270      172      149      131
#4 116.5 334.5 102648      200       15       31
#5  90.5 310.5 119830      173      167      153
       
#definiamo le colonne del dataset
band<-c(1,2,3)
time1<-c(151,57,58)
time1p2<-c(153,24,29)
time2<-c(200,202,191)
time2p2<-c(211,15,37)
       
spectralst<-data.frame(band,time1,time1p2,time2,time2p2)
       
ggplot(spectralst,aes(x=band)) + 
       geom_line(aes(y=time1), color="red",linetype="dotted") + 
       geom_line(aes(y=time1p2),color="red",linetype="dotted") +
       geom_line(aes(y=time2),color="green",linetype="dotted") +
       geom_line(aes(y=time2p2),color="green",linetype="dotted") + #in questo modo si genera la linea puntinata anziché quella continua
       labs(x="band",y="reflectance")

#esiste una funzione che estrae direttamente i valori delle bande sui pixel che vengono selezionati a random tramite un altra funzione e su quelli si fa il grafico (in modo da fare il confronto su più dati)

#facciamo una prova con una immagine presa da earth observatory
prova<-brick("prova.jpg")
plotRGB(prova, r=1, g=2, b=3, stretch="lin")
click(prova, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")
#    x     y   cell prova.1 prova.2 prova.3
#1 293.5 779.5 216294     247     247     247
#2 557.5 526.5 398718      17     107     118
#3 667.5 239.5 605468     146     127     110

band<-c(1,2,3)
snow<-c(247,247,247)
water<-c(17,107,118)
earth<-c(146,127,110)

spectralsg<-data.frame(band,snow,water,earth)
ggplot(spectralsg,aes(x=band)) + 
       geom_line(aes(y=snow), color="blue") + 
       geom_line(aes(y=water),color="red") +
       geom_line(aes(y=earth),color="green") +
       labs(x="band",y="reflectance")

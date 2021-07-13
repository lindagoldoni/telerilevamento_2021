# R_code_complete - Telerilevamento Geo-Ecologico

#-------------------------------------------------------------------------

# Summary:

#1. Remote sensing

#-------------------------------------------------------------------------

# my first code in R for remote sensing

install.packages("raster") #installa il pacchetto "raster"
library(raster) #richiama il pacchetto e ci permette di utilizzarlo

setwd("C:/lab/") #carica la working directory (comando per windows), dice al sistema dove acquisire i dati all'interno del PC

p224r63_2011 <- brick("p224r63_2011_masked.grd") #richiama un'immagine dall'esterno di R e l'assegna ad una variabile, importando l'immagine
#"masked" significa che l'immagine è già stata parzialmente elaborata
#le "" vengono usate per richiamare qualcosa dall'esterno di R

p224r63_2011 #posso richiamare la variabile per vedere se me l'ha caricata, si aprono gli attributi di dato raster (dimensioni, sorgente, classe, ecc.)
#mi ha caricato un raster brick  (una serie di bande sovrapposte)

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
plot(p224r63_2011, col=cl) #proviamo un'altra scala di colori
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
p224r63_2011 <- brick("p224r63_2011_masked.grd") # immagine del 2011, con l'intero blocca di bande tramite la funzione "brick"
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

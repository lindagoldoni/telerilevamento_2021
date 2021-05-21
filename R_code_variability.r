#R_code_variability.r

#dobbiamo caricare le diverse librerie dei pacchetti
library(raster)
library(RStoolbox)

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
sentpca # visualizziamo in questo modo gli attributi dell'output appena ottenuto
#facciamo poi un summary
summary(sentpca$model)
# si vede anche una proporzione di variabilità
# la prima PC mostra il 67.36804% dell'informazione originale, a partire da quest'immagine calcoleremo la variabilità

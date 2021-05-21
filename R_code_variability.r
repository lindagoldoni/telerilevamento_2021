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


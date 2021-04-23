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

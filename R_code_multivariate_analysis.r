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

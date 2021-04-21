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

#GRAN CANYON

#le nuvole possono essere tolte con funzioni creando un file "masked" oppure uyilizziamo un altro tipo di sensore
#le immagini ad ora utilizzate sono state acquisite con sensori passivi

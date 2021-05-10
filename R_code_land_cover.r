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

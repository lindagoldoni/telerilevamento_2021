# R_code_PROJECT.r

#This is the project for the exam of remote sensing 2020-2021

library(raster)
library(ncdf4)
setwd("C:/lab/project")

#VEGETATION

#NDVI . differenza fra l'infrarosso e il rosso assorbito dalla vegetazione (infrarosso viene riflesso e rosso viene assorbito) i valori di riflettanza sono più alti nell'infrarosso e più bassi nel rosso 
# facendo la differenza ottengo la quantità di biomassa presente come vegetazione, questa differenza può essere poi normalizzata sulla loro somma

# Soil Water Index . Indice del contenuto d'acqua nel suolo, misura la condizione di umidità nel suolo in un certo strato di suolo (abbastanza spesso)

#ENERGY

# Albedo . quantità di luce riflessa dal suolo

#Land Surface Temperature . temperatura al suolo 

#WATER

#Lake Water Quality . eutrofizzazione che si riperquote sugli organismi al loro interno

#Lake Water Temperature . 

#Water level . 

#CRYOSPHERE

#Snow cover . molto importante perché indice di cambiamento climatico e soprattutto è una condizione importante per mantenere l'ecosistema montano e tutti i suoi abitanti

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# CODICE DATI COPERNICUS

SnowC<-raster("copertura_nevosa_may.nc")
SnowC 
cl <- colorRampPalette(c('light blue','green','pink','orange'))(100) 
plot(SnowC col=cl) 


SnowCres<-aggregate(SnowC,fact=100) 
plot(SnowCres, col=cl) 


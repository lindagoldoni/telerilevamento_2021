# R_code_spectral_signatures.r

# ogni roccia e minerale o viva ha una propria firma spettrale

library(raster)
setwd("C:/lab/cover")

#lavoriamo su defor2.jpg

defor2<-brick("defor2.jpg")

# defor2.1, defor2.2, defor2.3
# NIR, red, green

plotRGB(defor2, r=1, g=2, b=3, stertch="lin")
plotRGB(defor2, r=1, g=2, b=3, stertch="hist")

#usiamo questo dataset per visualizzare delle firme spettrali con la funzione "click" contenuto nel pacchetto "rgdal"

library(rgdal)

click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")
#dobbiamo dire su quale mappa vogliamo cliccare e definire come vogliamo fare il click ovvero un punto "p" , definiamo dimensione e colore

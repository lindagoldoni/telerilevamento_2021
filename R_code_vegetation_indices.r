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

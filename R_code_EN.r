# R_code_EN.r

#1: settare la working directory

setwd("C:/lab/EN")

#2: caricare la singola immagine 

EN01<- raster("EN_0001.png")

#3: plottare con una color ramp palette diversa l'immagine

cls<-colorRampPalette(c("red","pink","blue","yellow"))(200)
plot(EN01, col=cls)
#zone a gennaio con NO2 più alta

#4: importare l'ultima immagine con la color ramp palette usata precedentemente

EN13<- raster("EN_0013.png")
cls<-colorRampPalette(c("red","pink","blue","yellow"))(200)
plot(EN13, col=cls)

#5: fare la differenza tra le due immagini e plottarle insieme

ENdif<-EN13-EN01
plot(ENdif, col=cls)

#6: plottare le 3 immagini insieme

par(mfrow=c(3,1))
plot(EN01, col=cls, main="NO2 in January")
plot(EN13, col=cls, main="NO2 in March")
plot(ENdif, col=cls, main="Difference (January - March)")

#7: importare tutto il set

# list of files:
rlist <- list.files(pattern="EN")
rlist

import <- lapply(rlist,raster)
import

EN <- stack(import)
plot(EN, col=cls)

# 8: plottare img 1 e 13 dallo stack appena fatto

par(mfrow=c(2,1))
plot(EN$EN_0001, col=cls)
plot(EN$EN_0013, col=cls)

# 9: fare una PCA sulle 13 immagini

library(RStoolbox)

ENpca<-rasterPCA(EN)
summary(EN$model)
plotRGB(ENpca$map, r=1, g=2, b=3, stretch="lin")

# 10: calcolare la variabilità (deviazione standard) della prima componente pca

PC1sd<-focal(ENpca$map$PC1, w=matrix(1/9,nrow=3,ncol=3),fun=sd)
plot(PC1sd,col=cls)

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

#7: 

#R_code_knitr.r

#DAY 9

install.packages("knitr") # nkitr è la funzione che permette di generare un report automatico
require(knitr) # analogo al comando library che richiama il pacchetto

setwd("C:/lab/") # settiamo la working directory

#il pacchetto "knitr" interno ad R esce e prende il codice esterno, lo importa in R dentro cui genera un report che viene salvato nella stessa cartella dov'è presente il codice
# prendiamo un codice già scritto lo copiamo e lo incolliamo in un programma di testo (preferibilmente non Word perché utilizza un codice suo)
# siamo andati a mettere il codice nella cartella di riferimento




stitch("C:/lab/codice.r" #diamo un nome al nostro codice e lo utilizzaremo per fare il file finale
       , template=system.file("misc", "knitr-template.Rnw", package="knitr"))
# la funzione "stitch" serve a implementare il pacchetto knitr per produrre il report

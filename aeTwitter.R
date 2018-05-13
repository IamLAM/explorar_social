library(twitteR)
#recuperamos claves de acceso
source("config.R")

#nos autentificaremos

setup_twitter_oauth(consumer_key,consumer_secret,access_token,access_secret)
getCurRateLimitInfo(c('users','followers','account'))

#obtener tweets
tdf<-twListToDF(searchTwitter("Merca20",n=100,lang="es"))
names(tdf)
summary(tdf)
unique(tdf$screenName)
#contabilizaremos el numero de caracteres enviados
numC<-nchar(tdf$text)

#añadiremos al dataframe la columna de numero de caracteres

tdf<-data.frame(tdf,caracteres=numC)

#clasificaremos los tweets de acuerdo al numero de retweets y favoritos

tdf$tipo[tdf$isRetweet&tdf$favoriteCount>0]<-'A'
tdf$tipo[tdf$isRetweet&tdf$favoriteCount==0]<-'B'
tdf$tipo[!tdf$isRetweet&tdf$favoriteCount>0]<-'C'
tdf$tipo[!tdf$isRetweet&tdf$favoriteCount==0]<-'D'

tdf$tipo<-as.factor(tdf$tipo)

#comenzaremos a trabajar con la frecuencias de apariciones
table(toupper(substr(tdf$screenName,1,1)))

#frecuencia por porcentaje
dim(tdf)[1]
table(toupper(substr(tdf$screenName,1,1)))/dim(tdf)[1]
#determinaremos la moda

"
moda <- function(var){
  
  frec.var <- table(var)
  v <- which(frec.var == max(frec.var))
  name(v)
  
}

moda(tdf$caracteres)
"

#media

mean(tdf$caracteres)
#media truncada: 

caracteres2<-tdf$caracteres
caracteres2[1]<-5000
mean(caracteres2)


#mediana 
median(tdf$caracteres)


#cuartiles percentiles

quantile(tdf$caracteres,0.4)
#calcular varios percentil
quantile(tdf$caracteres,c(0,0.25,0.5,0.75,1))

#rangos
rango<-max(tdf$caracteres)-min(tdf$caracteres)

#varianza

var<-var(tdf$caracteres)

#desviación estandar

sd<-sd(tdf$caracteres)

#covarianza: cuanto se parecen dos variables

c1<-tdf$caracteres[1:50]
c2<-tdf$caracteres[51:100]

cov(c1,c2)

#correlaciones
cor(c1,c2)


#desplegando graficos por histograma

hist(tdf$caracteres)
hist(tdf$caracteres,breaks=20)

#desplegando graficos por densidad

plot(density(tdf$caracteres))

#desplegando graficos por scatterplot

plot(tdf$caracteres,tdf$retweetCount,col=tdf$tipo,pch=as.numeric(tdf$tipo))
legend('topleft',levels(tdf$tipo),lty=1,col=1:4,bty='n',cex=0.75)

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



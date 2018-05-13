library(twitteR)
#recuperamos claves de acceso
source("config.R")

#nos autentificaremos

setup_twitter_oauth(consumer_key,consumer_secret,access_token,access_secret)
getCurRateLimitInfo(c('users','followers','account'))

#obtener informacion del usuario

user<-getUser('ingenioteka')
udf<-as.data.frame(user)

#buscamos coincidencias por palabra
t<-searchTwitter("ingenioteka",n=20,lang="es")
#convertimos a un data frame
tdf<-twListToDF(t)

#Buscaremos los trending topics en mx
getTrends(23424900)

# obtenemos los seguidores de la cuenta webcams
user<-getUser('webcamsdemexico')
user$getFollowers()

library(twitteR)
#recuperamos claves de acceso
source("config.R")

#nos autentificaremos

setup_twitter_oauth(consumer_key,consumer_secret,access_token,access_secret)
getCurRateLimitInfo(c('users','followers','account'))

#obtener tweets
tdf<-twListToDF(searchTwitter("Merca20",n=100,lang="es"))
names(tdf)

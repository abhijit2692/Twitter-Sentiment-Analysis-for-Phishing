library(RCurl)
library(ROAuth)
library(twitteR)
library(plyr)
library(stringr)
library(e1071)
library(RTextTools)

# Set SSL certs globally
options(RCurlOptions = list(cainfo = system.file("CurlSSL","cacert.pem", package = "RCurl")))
reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"

consumerKey <- "UVvPpl5xTgCJqwjXbWE4XtSiw" #if you dont have this values, you can get them in twitter developer page  create an API (it doesnt cost anything and you get the values pretty easy)
consumerSecret <- "Lo02BsLyaYzEcr3E0fgRgi8Q8dJ5NHdRpLnu0BauEV6QVeV0wW"
access_token_secret = "Qs5qrXfJno10lhZDZkCBQyPQcPAcw6NbAobQcPmeK8VMW" #your access_token_secret
access_token="1239513152-g8KTOjNgxj3xDvD9xjf0aZzyb0Jp95lv4FLVjbv"
twitCred <- OAuthFactory$new(consumerKey=consumerKey,
                             consumerSecret=consumerSecret,
                             requestURL=reqURL,
                             accessURL=accessURL,
                             authURL=authURL)
twitCred$handshake() # the program will ask you for a PIN this is obtained by Authorising the App in your browser.
setup_twitter_oauth(consumerKey,consumerSecret,access_token,access_token_secret)
tweets=searchTwitter("#amazongo", n=1000,lang = 'en') #keyword to fetch tweets related to
length(tweets) #it tells you how many tweets do you download
df <- do.call("rbind", lapply(tweets, as.data.frame))
write.csv(df,"C:/ABHIJIT/Studies/MIT/SEM 1/Analytics Business Intelligence/Project/Project/ProjectServer/LiveTweets.csv")

# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(twitteR)
library(plyr)
library(ggplot2)
library(base64enc)
library(ROAuth)
library(dplyr)
library(RCurl)
library(ROAuth)
library(twitteR)
library(plyr)
library(stringr)

shinyServer(function(input, output) 
  {
  
#Twitter URL for access
  
options(RCurlOptions = list(cainfo = system.file("CurlSSL","cacert.pem", package = "RCurl")))
reqURL <- "https://api.twitter.com/oauth/request_token" 
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"

#Insert My Twitter Credentials

consumerKey <- "UVvPpl5xTgCJqwjXbWE4XtSiw" 
consumerSecret <- "Lo02BsLyaYzEcr3E0fgRgi8Q8dJ5NHdRpLnu0BauEV6QVeV0wW"
access_token_secret = "Qs5qrXfJno10lhZDZkCBQyPQcPAcw6NbAobQcPmeK8VMW" 
access_token="1239513152-g8KTOjNgxj3xDvD9xjf0aZzyb0Jp95lv4FLVjbv"
  
twitCred <- OAuthFactory$new(consumerKey=consumerKey,
                               consumerSecret=consumerSecret,
                               requestURL=reqURL,
                               accessURL=accessURL,
                               authURL=authURL)
#After assigning all the credentials and we can now create our handshake  
twitCred$handshake() 
#We will recieve a PIN which is 7 numbers long and has to be entered in the console
setup_twitter_oauth(consumerKey,consumerSecret,access_token,access_token_secret)
  
output$distPlot <- renderPlot({
    
#Our code for performing Sentiment Analysis    
tweets=searchTwitter(input$txtKeyword, n=input$sliderInput1,lang = 'en') 
#This states the keyword through which we will search twitter for the sentiment analysis
length(tweets) 
#It will tell us the length of the tweets    
    
#Data Manipulation and Algorithm Implementation
tweets.text = laply(tweets, function(t)t$getText())
score.sentiment = function(sentences, pos.words, neg.words, .progress="none")
{
#Now we have obtained ,we will use .plyr
require(plyr)
require(stringr)
    
#Since we want a simple array of scores back(Split list,apply function and return results in an array)
      
scores = laply(sentences, function(sentence, pos.words, neg.words) {
#We need to clean up sentences with R's regex-driven global substitute, gsub():
sentence = gsub('[[:punct:]]','', sentence)
sentence = gsub('[[:cntrl:]]','', sentence)
#We also perform for lower case:
sentence = tolower(sentence)
        
#We now split into words. str_split is in the stringr package
word.list = str_split(sentence, '\\s+')
#Sometimes a list() is one level of hierarchy too much
words = unlist(word.list)
        
#We now compare our words to the dictionaries of positive & negative terms
pos.matches = match(words, pos.words)
neg.matches = match(words, neg.words)
#We match() returns the position of the matched term or NA
#We just want a TRUE/FALSE:
pos.matches = !is.na(pos.matches)
neg.matches = !is.na(neg.matches)
        
# TRUE/FALSE will be treated as 1/0 by sum():
score = sum(pos.matches)- sum(neg.matches)
  
return(score)
},
pos.words, neg.words, .progress=.progress )

scores.df = data.frame(score=scores, text=sentences)
return(scores.df)
}
    
#These is the list of the  positive and negative words
pos = scan('positive-words.txt', what='character',comment.char=';')
neg = scan('negative-words.txt', what='character',comment.char=';')
    
    
#Now we Analyse the results
analysis = score.sentiment(tweets.text, pos, neg, .progress='none')
twit_analysis <- analysis$score
table(twit_analysis)
mean(twit_analysis)
median(twit_analysis)
hist(twit_analysis,xlab = "Score of Sentiment",ylab="Number of Tweets",main = "Histogram of Twitter Sentiment Analysis",col = 5)

    
  })
  
})

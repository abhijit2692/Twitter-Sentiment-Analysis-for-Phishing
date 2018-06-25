library(rpart)
require('devtools')
require('sentR')
# Create small vectors for happy and sad words (useful in aggregate(...) function)
positive = scan('C:/ABHIJIT/Studies/MIT/SEM 1/Analytics Business Intelligence/Project/Project/ProjectServer/positive-words.txt', what='character',comment.char=';')
negative = scan('C:/ABHIJIT/Studies/MIT/SEM 1/Analytics Business Intelligence/Project/Project/ProjectServer/negative-words.txt', what='character',comment.char=';')

# Words to test sentiment
test <- read.csv("C:/ABHIJIT/Studies/MIT/SEM 1/Analytics Business Intelligence/Project/Project/ProjectServer/LiveTweets.csv")

# 1. Simple Summation
out <- classify.aggregate(test,positive, negative)
out

# 2. Naive Bayes

out <- classify.naivebayes(test)
out
write.csv(out,"C:/ABHIJIT/Studies/MIT/SEM 1/Analytics Business Intelligence/Project/Project/ProjectServer/LiveTweetsNaive.csv")
conmat <- read.csv(file = "C:/ABHIJIT/Studies/MIT/SEM 1/Analytics Business Intelligence/Project/Project/ProjectServer/LiveTweetsNaive.csv")
conmat

#Plotting the Cofusion Matrix:

plotconfmat = rpart(conmat$SENT ~ ., data=conmat, method="class")
plotconfmat
predicttweet = predict(plotconfmat, newdata=conmat, type="class")
predicttweet
#Now we will be computing the confusion matrix from the predictions

cmat_tweet<-table(conmat$SENT, predicttweet)
cmat_tweet
#Compute accuracy
accu_tweet <- (cmat_tweet[1,1] + cmat_tweet[2,2] + cmat_tweet[3,3])/sum(cmat_tweet)
accu_tweet

out <- read.csv(file = "C:/ABHIJIT/Studies/MIT/SEM 1/Analytics Business Intelligence/Project/Project/ProjectServer/LiveTweetsNaive.csv", sep = ",")[ ,5]
out
out <- gsub(",", "",out)   # remove comma
out
counts <- table(out)
barplot(counts, main="Sentimental Analysis", horiz=TRUE,
        names.arg=c("Negative", "Neutral", "Positive"),col=c("darkblue","red","green"))

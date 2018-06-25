require('devtools')
require('sentR')
# Create small vectors for happy and sad words (useful in aggregate(...) function)
positive = scan('C:/ABHIJIT/Studies/MIT/SEM 1/Analytics Business Intelligence/Project/Project/positive-words.txt', what='character',comment.char=';')
negative = scan('C:/ABHIJIT/Studies/MIT/SEM 1/Analytics Business Intelligence/Project/Project/negative-words.txt', what='character',comment.char=';')

# Words to test sentiment
test <- dataset<-read.csv("LiveTweets.csv")

# 1. Simple Summation
out <- classify.aggregate(test, positive, negative)
out

# 2. Naive Bayes
out <- classify.naivebayes(test)
out
write.csv(out,"C:/ABHIJIT/Studies/MIT/SEM 1/Analytics Business Intelligence/Project/Project/LiveTweetsNaive.csv")

library(e1071)
library(psych)
library(fmsb)


dataset<-read.csv("LiveTweets.csv")

training <- read.csv("C:/ABHIJIT/Studies/MIT/SEM 1/Analytics Business Intelligence/Project/Project/LiveTweetsNaive.csv")

index<-1:nrow(dataset)
testset<-sample(index,trunc(length(index)*30/100))
summary(testset)
summary(training)
model <- svm(training$SENT ~ .,data=training,probability=T,kernel="linear")
plot(model,dataset,training$SENT ~ .)
model <- svm(training$SENT ~.,data=training)
plot(model,training)
prediction <- predict(model,testset[-1,])
tab <- table(pred=prediction,true=testset[,1])
tab

#Formula for accuracy
#AC=a+d/a+b+c+d

#working code
model <- svm(classifiednaive$SENT ~.,data=classifiednaive)
x <- subset(classifiednaive,select = -SENT)
y <- classifiednaive$SENT
model <- svm(x,y,data=classifiednaive$POS.NEG,probability = T,kernel = "linear") 
print(model)
summary(model)
pred <- predict(model,x)
#same as:
pred <- fitted(model)
table(pred,y)
# compute decision values and probabilities:
pred <- predict(model, x, decision.values = TRUE)
attr(pred, "decision.values")[1:4,]
attr(pred, "decision.values")[1:100,]
#visualize
plot(cmdscale(dist(classifiednaive$POS.NEG)),
     col = as.integer(classifiednaive$POS.NEG),
     pch = c("o","+")[1:100 %in% model$index + 1])

## try regression mode on two dimensions

# create data
x <- seq(0.1, 5, by = 0.05)
y <- log(x) + rnorm(x, sd = 0.2)

# estimate model and predict input values
m   <- svm(x, y)
new <- predict(m, x)
new
# visualize
plot(x, y)
points(x, log(x), col = 2)
points(x, new, col = 4)

rater1 = c(1,2,3,4,5,6,7,8,9) # rater one's ratings
rater2 = c(1,3,1,6,1,5,5,6,7) # rater one's ratings
cohen.kappa(x=cbind(rater1,rater2))

m1 = c(classifiednaive$POS)
m2 = c(classifiednaive$NEG)
cohen.kappa(x=cbind(m1,m2))

m1 = c(classifiednaive$POS.NEG)
m2 = c(classifiednaive$POS)
cohen.kappa(x=cbind(m1,m2))

m1 = c(classifiednaive$POS.NEG)
m2 = c(classifiednaive$NEG)
cohen.kappa(x=cbind(m1,m2))


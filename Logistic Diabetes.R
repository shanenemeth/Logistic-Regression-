install.packages("MASS")
install.packages("caTools")
library(MASS)
library(caTools)
getwd()
data <- read.csv("C:/Users/shane/OneDrive/Documents/R Projects/diabetes.csv")
print(head(data))

split <- sample.split(data,SplitRatio = 0.8)
training <- subset(data, split=="TRUE")
testing <- subset(data, split=="FALSE")
attach(data)
model <- glm(Outcome~., training, family = "binomial")
summary(model)
pred <- predict(model, training, type = "response")
pred

(table(ActualValue=training$Outcome, PredictedValue=pred>.5))

ROCRPred = prediction(pred, training$Outcome)
ROCRPref <- performance(ROCRPred,"tpr","fpr")  
plot(ROCRPref, colorize="TRUE", print.cutoffs.at=seq(0.1, by=0.1))

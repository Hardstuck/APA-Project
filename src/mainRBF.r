library(e1071)
library(caret)

source("plot.r")
load("../data/LOLdatanormalized.Rdata")
data <- data.normalized
 
set.seed(5)
N <- nrow(data) 
learn <- sample(1:N, round(2*N/3))
load("../models/training/modelRBF.regul")

bestC <- model$bestTune[,2]
bestSigma <- model$bestTune[,1]

RBF.model <- svm(winner ~ ., data = data, subset = learn, cost = bestC, sigma = bestSigma, type ='C-classification', kernel = 'radial', scale = FALSE)

RBF.predActual <- predict(RBF.model, data[learn,])
 
RBF.tab2 <- table(predActual, data[learn,]$winner)
 
RBF.errorLearn <- 1 - sum(diag(RBF.tab2))/sum(RBF.tab2)

print('RBF model learning error is:')
print(RBF.errorLearn)
 
RBF.pred <- predict(RBF.model, data[-learn, ])
 
RBF.tab <- table(RBF.pred, data[-learn,]$winner)
 
RBF.errorTest <- 1 - sum(diag(RBF.tab))/sum(RBF.tab)

print('RBF model testing error is:')
print(RBF.errorTest)

RBF.cm <- confusionMatrix(data = data[-learn, ]$winner, reference = RBF.pred)
draw_confusion_matrix(RBF.cm)
dev.copy(png, '../images/RBFplot.png')
dev.off()


library(e1071)
library(caret)
library(nnet)

source("plot.r")
load("../data/LOLdatanormalized.Rdata")
data <- data.normalized
 
set.seed(5)
N <- nrow(data) 
learn <- sample(1:N, round(2*N/3))
load("../models/training/modelRBF.regul")

bestSize <- model$bestTune[,1]
bestDecay <- model$bestTune[,2]

MLP.model <- nnet(winner~., data=data,subset=learn, size = bestSize, decay = bestDecay, linout = FALSE)

MLP.predActual <- as.factor(predict(MLP.model, data[learn,], type = 'class'))
 
MLP.tab2 <- table(MLP.predActual, data[learn,]$winner)
 
MLP.errorLearn <- 1 - sum(diag(MLP.tab2))/sum(MLP.tab2)

print('MLP learning error is:')
print(MLP.errorLearn)
 
MLP.pred <- as.factor(predict(MLP.model, data[-learn,], type= 'class'))

MLP.tab <- table(MLP.pred, data[-learn,]$winner)
 
MLP.errorTest <- 1 - sum(diag(MLP.tab))/sum(MLP.tab)

print('MLP testing error is:')
print(MLP.errorTest)

MLP.cm <- confusionMatrix(data = data[-learn, ]$winner, reference = MLP.pred)
draw_confusion_matrix(MLP.cm)
dev.copy(png, '../images/MLPplot.png')
dev.off()

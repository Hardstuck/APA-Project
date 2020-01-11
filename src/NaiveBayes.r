library(e1071)
library(caret)

load("../data/LOLdatanormalized.Rdata")
data <- data.normalized
 
#15 minutes
set.seed(5)
N <- nrow(data) 
trc <- trainControl(method = "repeatedcv", number = 10, repeats = 10)
learn <- sample(1:N, round(2*N/3))
nlearn <- length(learn)
ntest <- N - nlearn

model <- train(winner ~ ., data = data,  subset = learn, method = 'nb',trControl=trc)

predActual <- predict(model, data[learn,])

tab2 <- table(predActual, data[learn,]$winner)

errorLearn <- 1 - sum(diag(tab2))/sum(tab2)

pred <- predict(model, data[-learn, ])

tab <- table(pred, data[-learn,]$winner)

errorTest <- 1 - sum(diag(tab))/sum(tab)

save(model, file = "modelNB.regul")

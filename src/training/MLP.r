library(nnet)
library(caret)
set.seed(5)

load("../data/LOLdatanormalized.Rdata")
data <- data.normalized

#If you don't want to wait 4 hours do not run it!

N <- nrow(data) 
learn <- sample(1:N, round(2*N/3))
nlearn <- length(learn)
ntest <- N - nlearn
sizes <- seq(2,16,by=2)
decays <- 10^seq(-3, 0 , by = 0.5)
trc <- trainControl(method = "repeatedcv", number = 10, repeats = 5, verboseIter = TRUE)
#modelSize <- train(winner~., data = data, subset=learn, method = 'nnet', maxit = 500, trace = FALSE, tuneGrid = expand.grid(.size=sizes ,.decay = 0.5), trControl = trc)

# save(modelSize, file = "../models/MLPsizeTraningMLP.regul")
# 
# nsize <- modelSize$bestTune

modelDecay <- train(winner~., data = data, subset=learn, method = 'nnet', maxit = 500, trace = FALSE, tuneGrid = expand.grid(.size=14 ,.decay = decays), trControl = trc)

# bestDecay <- modelSize$bestTune

# #resulted model in model.10x10CVF.regul
# 
# learn <- sample(1:nrow(data), round(2*nrow(data)/3))
# #model <- nnet(V36~., data = data, size = size, maxit = 5000, decay = decay)
# model.nnet <- nnet(V36~., data = data, subset=learn, size = 10, maxit = 5000, decay = decay)
# 
# #p2 <- as.factor(predict(model.nnet, newdata=test[c(1:nrow(test),], type = "class"))
# nlearn <- nrow(data[learn,])
# p1 <- as.factor(predict(model.nnet, type = "class"))
# t1 <- table(p1, data$V36[learn])
# error_rate.train <- 100*(1-sum(diag(t1))/nlearn)
# 
# ntest <- nrow(data[-learn,])
# p2 <- as.factor(predict(model.nnet, newdata=data[-learn,], type = "class"))
# t2 <- table(p2, data$V36[-learn])
# error_rate.test <- 100*(1-sum(diag(t2))/ntest)

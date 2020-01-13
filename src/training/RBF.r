library(e1071)
library(caret)

load("../data/LOLdatanormalized.Rdata")
data <- data.normalized
 
set.seed(5)
N <- nrow(data) 
trc <- trainControl(method = "repeatedcv", number = 10, repeats = 2, verboseIter = TRUE)
learn <- sample(1:N, round(2*N/3))
nlearn <- length(learn)
ntest <- N - nlearn
sigma <-  seq(0.1, 1, by = 0.2)
C <- 2 ** seq(1, 9, by = 2)

 
model <- train(winner~., data = data, subset=learn, method = 'svmRadial', maxit = 500, trace = FALSE, tuneGrid = expand.grid(.C= C, .sigma = 0.1), trControl = trc)

bestC <- model$bestTune[,2]

model <- train(winner~., data = data, subset=learn, method = 'svmRadial', maxit = 500, trace = FALSE, tuneGrid = expand.grid(.C= bestC, .sigma = sigma), trControl = trc)

save(model, file = "../../models/modelRBF.regul")

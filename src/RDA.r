library(caret)
library(klaR)
set.seed(825)

load("../data/LOLdatanormalized.Rdata")
data <- data.normalized

                
N <- nrow(data) 
learn <- sample(1:N, round(2*N/3))
nlearn <- length(learn)
ntest <- N - nlearn
decays <- 10^seq(-3, 0 , by = 0.1)
trc <- trainControl(method = "repeatedcv", number = 10, repeats = 5, verboseIter = TRUE)
modelParameters <- train(winner~., data = data, subset=learn, method = 'rda', maxit = 500, trace = FALSE, tuneGrid = expand.grid(.gamma = decays, .lambda = decays), trControl = trc)

save(modelParameters, file = "modelRDAParameters.regul")

sink("../results/RDAresultsParameters.txt")

gammaFinal <- modelParameters$bestTune[,1]
lambdaFinal <- modelParameters$bestTune[,2]

cat("Final gamma")
cat(gammaFinal)
cat("Final lambda")
cat(lambdaFinal)


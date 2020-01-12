library(caret)
library(klaR)
set.seed(825)

f <- file.choose()

load(f)
data <- data.normalized

#N <- nrow(data) 
#learn <- sample(1:N, round(2*N/3))
#nlearn <- length(learn)
#ntest <- N - nlearn
#sizes <- seq(1,20,by=2)
#decays <- 10^seq(-3, 0 , by = 0.01)
trc <- trainControl(method = "rda", number = 10, repeats = 10,classProbs = TRUE)
rdaFit <- train(winner ~ ., data = data,
                method = "rda",
                trControl = trc,
                gamma = 0, lambda = 1,
                tuneLength = 4,
                metric = "ROC")
rdaFit

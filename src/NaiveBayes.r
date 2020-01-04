library(e1071)

load("../data/LOLdatanormalized.Rdata")
data <- data.normalized
 
set.seed(5)

N <- nrow(data) 

learn <- sample(1:N, round(2*N/3))
nlearn <- length(learn)
ntest <- N - nlearn

model <- naiveBayes(winner ~ ., data = data, subset = learn)

pred <- predict(model, data[-learn, ])

tab <- table(pred, data[-learn,]$winner)

error <- 1 - sum(diag(tab))/sum(tab)

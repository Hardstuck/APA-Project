library(e1071)
library(caret)
library(klaR)
library(randomForest)
library(nnet)

source("plot.r")
load("../data/LOLdatanormalized.Rdata")
data <- data.normalized
 
set.seed(5)
N <- nrow(data) 
learn <- sample(1:N, round(2*N/3))
load("../models/training/modelRBF.regul")


source('plot.r')
source('mainMLP.r')
source('mainRF.r')
source('mainNB.r')
source('mainRBF.r')
source('mainRDA.r')

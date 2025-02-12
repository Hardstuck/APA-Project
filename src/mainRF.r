bestnTree <- 256

RF.model <- randomForest(winner ~ ., data = data, subset = learn, ntree = bestnTree, proximity = FALSE)

RF.predActual <- predict(RF.model, data[learn,])
 
RF.tab2 <- table(RF.predActual, data[learn,]$winner)
 
RF.errorLearn <- 1 - sum(diag(RF.tab2))/sum(RF.tab2)

print('Random forest model learning error is:')
print(RF.errorLearn)
 
RF.pred <- predict(RF.model, data[-learn, ])
 
RF.tab <- table(RF.pred, data[-learn,]$winner)
 
RF.errorTest <- 1 - sum(diag(RF.tab))/sum(RF.tab)

print('Random forest model testing error is:')
print(RF.errorTest)

# Uncomment if want to draw the confusion Matrix
# RF.cm <- confusionMatrix(data = data[-learn, ]$winner, reference = RF.pred)
# draw_confusion_matrix(RF.cm)
# dev.copy(png, '../images/RFplot.png')
# dev.off()

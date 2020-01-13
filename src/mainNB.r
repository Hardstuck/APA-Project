NB.model <- naiveBayes(winner ~ ., data = data, subset = learn, lapace = 1)

NB.predActual <- predict(NB.model, data[learn,])
 
NB.tab2 <- table(NB.predActual, data[learn,]$winner)
 
NB.errorLearn <- 1 - sum(diag(NB.tab2))/sum(NB.tab2)

print('Naive Bayes model learning error is:')
print(NB.errorLearn)
 
NB.pred <- predict(NB.model, data[-learn, ])

NB.cm <- confusionMatrix(data = data[-learn, ]$winner, reference = NB.pred)
 
NB.tab <- table(NB.pred, data[-learn,]$winner)
 
NB.errorTest <- 1 - sum(diag(NB.tab))/sum(NB.tab)

print('Naive Bayes model testing error is:')
print(NB.errorTest)

# Uncomment if want to draw the confusion Matri
# NB.cm <- confusionMatrix(data = data[-learn, ]$winner, reference = NB.pred)
# draw_confusion_matrix(NB.cm)
# dev.copy(png, '../images/NBplot.png')
# dev.off()

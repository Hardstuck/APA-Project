RDA.model <- rda(winner ~ ., data = data, subset = learn, gamma = 0.001, lambda = 1)

RDA.predActual <- predict(RDA.model, data[learn,])

RDA.tab2 <- table(RDA.predActual$class, data[learn,]$winner)

RDA.errorLearn <- 1 - sum(diag(RDA.tab2))/sum(RDA.tab2)

print('RDA model learning error is:')
print(RDA.errorLearn)

RDA.pred <- predict(RDA.model, data[-learn, ])
 
RDA.tab <- table(RDA.pred$class, data[-learn, ]$winner)
 
RDA.errorTest <- 1 - sum(diag(RDA.tab))/sum(RDA.tab)

print('RDA model testing error is:')
print(RDA.errorTest)

# Uncomment if want to draw the confusion Matri
# RDA.cm <- confusionMatrix(data = data[-learn, ]$winner, reference = RDA.pred$class)
# draw_confusion_matrix(RDA.cm)
# dev.copy(png, '../images/RDApplot.png')
# dev.off()

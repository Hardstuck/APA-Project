library(ggplot2)
#Leemos nuestro conjunto de datos
data <- read.csv("../data/games.csv", header = True)

#Nos quedamos con los datos relevantes
data <- data[ ,c('gameDuration', 'winner', 'firstBlood', 'firstTower', 'firstInhibitor', 'firstBaron', 'firstDragon', 'firstRiftHerald', 't1_towerKills', 't1_inhibitorKills', 't1_baronKills', 't1_dragonKills', 't1_riftHeraldKills', 't2_towerKills', 't2_inhibitorKills', 't2_baronKills', 't2_dragonKills', 't2_riftHeraldKills')]

#Gráfica 
#hist(data$gameDuration/60, breaks = 50, main = "Histograma de la duración de las partidas", xlab="Duración partida en minutos", ylab = "Frecuencias", col = 'green')

data <- data[data$gameDuration >= 300, ]

data$winner[data$winner == 2] <- 0
data$firstTower[data$firstTower == 2] <- 0 
data$firstBlood[data$firstBlood == 2] <- 0
data$firstDragon[data$firstDragon == 2] <- 0
data$firstInhibitor[data$firstInhibitor == 2] <- 0
data$firstRiftHerald[data$firstRiftHerald == 2] <- 0 
data$firstBaron[data$firstBaron == 2] <- 0



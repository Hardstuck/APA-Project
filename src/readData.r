normalize <- function(x) {
    return ((x - min(x)) / (max(x) - min(x)))
}

library(ggplot2)
#Leemos nuestro conjunto de datos
data <- read.csv("../data/games.csv", header = TRUE)

#Nos quedamos con los datos relevantes
data <- data[ ,c('gameDuration', 'winner', 'firstBlood', 'firstTower', 'firstInhibitor', 'firstBaron', 'firstDragon', 'firstRiftHerald', 't1_towerKills', 't1_inhibitorKills', 't1_baronKills', 't1_dragonKills', 't1_riftHeraldKills', 't2_towerKills', 't2_inhibitorKills', 't2_baronKills', 't2_dragonKills', 't2_riftHeraldKills')]

#Gráfica 
#hist(data$gameDuration/60, breaks = 50, main = "Histograma de la duración de las partidas", xlab="Duración partida en minutos", ylab = "Frecuencias", col = 'green')

data <- data[data$gameDuration >= 300, ]

data$winner[data$winner == 2] <- 0
data$firstBlood[data$firstBlood == 2] <- 0

data$firstTower[data$firstTower == 0] <- -1 
data$firstTower[data$firstTower == 2] <- 0 

data$firstDragon[data$firstDragon == 0] <- -1
data$firstDragon[data$firstDragon == 2] <- 0

data$firstInhibitor[data$firstInhibitor == 0] <- -1
data$firstInhibitor[data$firstInhibitor == 2] <- 0

data$firstRiftHerald[data$firstRiftHerald == 0] <- -1
data$firstRiftHerald[data$firstRiftHerald == 2] <- 0 

data$firstBaron[data$firstBaron == 0] <- -1
data$firstBaron[data$firstBaron == 2] <- 0

data$winner <- as.factor(data$winner)
data$firstBaron <- as.factor(data$firstBaron)
data$firstBlood <- as.factor(data$firstBlood)
data$firstTower <- as.factor(data$firstTower)
data$firstInhibitor <- as.factor(data$firstInhibitor)
data$firstDragon <- as.factor(data$firstDragon)
data$firstRiftHerald <- as.factor(data$firstRiftHerald)

data.normalized <- data

data.normalized$gameDuration <- normalize(data$gameDuration)
data.normalized$t1_towerKills <- normalize(data$t1_towerKills)
data.normalized$t2_towerKills <- normalize(data$t2_towerKills)
data.normalized$t1_inhibitorKills <- normalize(data$t1_inhibitorKills)
data.normalized$t2_inhibitorKills <- normalize(data$t2_inhibitorKills)
data.normalized$t1_dragonKills <- normalize(data$t1_dragonKills)
data.normalized$t2_dragonKills <- normalize(data$t2_dragonKills)
data.normalized$t1_baronKills <- normalize(data$t1_baronKills)
data.normalized$t2_baronKills <- normalize(data$t2_baronKills)

save(data, file = "../data/LOLdata.Rdata") 
save(data.normalized, file = "../data/LOLdatanormalized.Rdata") 

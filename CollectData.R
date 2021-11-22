
#Read in Lahman data and create a simple dataframe for predicting
#career trajectory for hitters OPS

library(Lahman)

hitters <- Batting
fielding  <- Fielding

head(hitters)
hitters <- hitters[hitters$yearID > 1990,]
summary(hitters)

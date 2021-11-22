
#Read in Lahman data and create a simple dataframe for predicting
#career trajectory for hitters OPS

library(Lahman)
library(Lahman)

source("Code/Functions.R")

hitters <- Batting
fielding  <- Fielding

head(hitters)
hitters <- hitters[hitters$yearID > 1990,]
summary(hitters)

#find.position("aardsda01")

AB.totals <- ddply(Batting, .(playerID), summarize, Career.AB = sum(AB, na.rm = TRUE))
hitters <- merge(hitters, AB.totals)
#Drop hitters with less than 200 AB
hitters <- hitters[hitters$Career.AB > 200, ]
head(hitters)

#Get position for each player in hitters data.  Throw away pitchers
hitters$POS <- sapply(hitters$playerID, find.position)
hitters <- hitters[hitters$pos != "p",]
head(hitters, n = 20)

#Combine the stints for players within each season
hitters <- ddply(hitters, .(playerID, yearID), collapse.stint)

#Total number of seasons
SSN.totals <- ddply(Batting, .(playerID), summarize, Career.SSNs = length(AB))
hitters <- merge(hitters, SSN.totals)

head(hitters)





#Get birth year for each player in hitters data.  Takes about a minute
hitters$birthYR <- sapply(hitters$playerID, get.birthyear)
head(hitters, n = 20)

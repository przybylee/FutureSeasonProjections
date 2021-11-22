#Write functions used for shaping data for analysis

library(plyr)

#find the position of a player based on playerid
find.position <- function(p){
  positions <- c("OF", "1B", "2B", "SS", "3B", "C", "P", "DH")
  d <- subset(Fielding, playerID == p)
  count.games <- function(po)
      sum(subset(d, POS == po)$G)
  FLD <- sapply(positions, count.games)
  positions[FLD == max(FLD)][1]
}


#Find the birth year of a player based on playerid
get.birthyear <- function(p){
  playerline <- subset(Master, playerID == p)
  birthyear <- playerline$birthYear
  #Rounding by months
  birthmonth <- playerline$birthMonth
  ifelse(birthmonth >= 7, birthyear + 1, birthyear)
}

#Combine stints for a hitter accross a single season
collapse.stint <- function(d){
  G <- sum(d$G); AB <- sum(d$AB); R <- sum(d$R)
  H <- sum(d$H); X2B <- sum(X2B) <- sum(d$X2B); X3B <- sum(d$X3B)
  HR <-sum(d$HR); RBI <- sum(d$RBI); SB <- sum(d$SB)
  CS <- sum(d$CS); BB <- sum(d$BB); SH <- sum(d$SH)
  SF <- sum(d$SF); HBP <- sum(d$HBP)
  SLG <- (H- X2B - X3B - HR + 2*X2B + 3*X3B + 4*HR)/AB
  OBP <- (H + BB+HBP)/(AB + BB + HBP + SF)
  OPS <- SLG + OBP
  data.frame(G = G, AB=AB, R= R, H= H, X2B= X2B, X3B = X3B, HR= HR, RBI = RBI, SB = SB, 
             CS = CS, BB= BB, HBP = HBP, SH= SH, SF= SF, SLG = SLG, OBP = OBP, OPS= OPS,
             Career.AB = d$Career.AB[1], POS = d$POS[1])
}

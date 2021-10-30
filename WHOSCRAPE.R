rm(list = ls())

install.packages("RSelenium")
install.packages("dplyr")
install.packages("tidyverse")
install.packages("rvest")

library(RSelenium)
library(rvest)
library(dplyr)
library(tidyverse)

#java -Dwebdriver.chrome.driver="C:\Users\naqib\Downloads\chromedriver_win32\chromedriver_win32\chromedriver.exe" -jar selenium-server-standalone-3.141.59.jar
#java -Dwebdriver.chrome.driver="C:\Users\naqib\OneDrive\Documents\chromedriver_win32\chromedriver.exe" -jar selenium-server-standalone-3.141.59.jar

URL_List <- c("https://www.whoscored.com/Regions/252/Tournaments/2/Seasons/7811/England-Premier-League",
              "https://www.whoscored.com/Regions/252/Tournaments/2/Seasons/7361/England-Premier-League",
              "https://www.whoscored.com/Regions/252/Tournaments/2/Seasons/6829/England-Premier-League",
              "https://www.whoscored.com/Regions/252/Tournaments/2/Seasons/6335/England-Premier-League",
              "https://www.whoscored.com/Regions/252/Tournaments/2/Seasons/5826/England-Premier-League",
              "https://www.whoscored.com/Regions/252/Tournaments/2/Seasons/4311/England-Premier-League")

#start RSelenium
remDr <- remoteDriver(remoteServerAddr = "localhost",
                      port = 4444 ,
                      browserName = "chrome")
remDr$open()
remDr$navigate("https://www.whoscored.com/Regions/252/Tournaments/2/Seasons/8228/England-Premier-League")
Sys.sleep(4)

link_element <- remDr$findElements("css selector", ".grid-abs .team-link")
Scrape_link <- function(link_element){
  club_link <- as.character(link_element$getElementAttribute("href"))
}
list <- lapply(link_element, Scrape_link)
CompleteEPLURL <- data.frame(matrix(unlist(list),
                                    byrow=TRUE),stringsAsFactors=FALSE)

## scrape EPL Club URLs
for(url in URL_List){
  remDr$navigate(url)
  Sys.sleep(4)
  
  #scrape club links of the season
  link_element <- remDr$findElements("css selector", ".grid-abs .team-link")
  Scrape_link <- function(linkelement){
    club_link <- as.character(linkelement$getElementAttribute("href"))
  }
  list <- lapply(link_element, Scrape_link)
  df <- data.frame(matrix(unlist(list),
                          byrow=TRUE),stringsAsFactors=FALSE)
  CompleteEPLURL <- cbind(CompleteEPLURL, df)
}

colnames(CompleteEPLURL) <- c('20-21','19-20','18-19','17-18','16-17','15-16','14-15')

CompleteEPLURL$`14-15` <- gsub("Show","Archive", as.character(CompleteEPLURL$`14-15`))
CompleteEPLURL$`15-16` <- gsub("Show","Archive", as.character(CompleteEPLURL$`15-16`))
CompleteEPLURL$`16-17` <- gsub("Show","Archive", as.character(CompleteEPLURL$`16-17`))
CompleteEPLURL$`17-18` <- gsub("Show","Archive", as.character(CompleteEPLURL$`17-18`))
CompleteEPLURL$`18-19` <- gsub("Show","Archive", as.character(CompleteEPLURL$`18-19`))
CompleteEPLURL$`19-20` <- gsub("Show","Archive", as.character(CompleteEPLURL$`19-20`))
CompleteEPLURL$`20-21` <- gsub("Show","Archive", as.character(CompleteEPLURL$`20-21`))

CompleteEPLURL$`14-15` <- paste(CompleteEPLURL$`14-15`, "stageId=9155", sep = "?")
CompleteEPLURL$`15-16` <- paste(CompleteEPLURL$`15-16`, "stageId=12496", sep = "?")
CompleteEPLURL$`16-17` <- paste(CompleteEPLURL$`16-17`, "stageId=13796", sep = "?")
CompleteEPLURL$`17-18` <- paste(CompleteEPLURL$`17-18`, "stageId=15151", sep = "?")
CompleteEPLURL$`18-19` <- paste(CompleteEPLURL$`18-19`, "stageId=16368", sep = "?")
CompleteEPLURL$`19-20` <- paste(CompleteEPLURL$`19-20`, "stageId=17590", sep = "?")
CompleteEPLURL$`20-21` <- paste(CompleteEPLURL$`20-21`,"stageId=18685", sep="?")

CompleteEPLURL <- c(CompleteEPLURL$`14-15`,CompleteEPLURL$`15-16`,
                    CompleteEPLURL$`16-17`,CompleteEPLURL$`17-18`,CompleteEPLURL$`18-19`,
                    CompleteEPLURL$`19-20`,CompleteEPLURL$`20-21`)
## scrape bundes URL
URL_List <- c("https://www.whoscored.com/Regions/81/Tournaments/3/Seasons/8279/Germany-Bundesliga",
              "https://www.whoscored.com/Regions/81/Tournaments/3/Seasons/7872/Germany-Bundesliga",
              "https://www.whoscored.com/Regions/81/Tournaments/3/Seasons/7405/Germany-Bundesliga",
              "https://www.whoscored.com/Regions/81/Tournaments/3/Seasons/6902/Germany-Bundesliga",
              "https://www.whoscored.com/Regions/81/Tournaments/3/Seasons/6392/Germany-Bundesliga",
              "https://www.whoscored.com/Regions/81/Tournaments/3/Seasons/5870/Germany-Bundesliga",
              "https://www.whoscored.com/Regions/81/Tournaments/3/Seasons/4336/Germany-Bundesliga")

CompleteBundesURL <- data.frame(matrix(nrow = 18))
for(url in URL_List){
  remDr$navigate(url)
  Sys.sleep(4)
  
  #scrape club links of the season
  link_element <- remDr$findElements("css selector", ".grid-abs .team-link")
  Scrape_link <- function(linkelement){
    club_link <- as.character(linkelement$getElementAttribute("href"))
  }
  list <- lapply(link_element, Scrape_link)
  df <- data.frame(matrix(unlist(list),
                          byrow=TRUE),stringsAsFactors=FALSE)
  CompleteBundesURL <- cbind(CompleteBundesURL, df)
}
CompleteBundesURL <- CompleteBundesURL[2:8]
colnames(CompleteBundesURL) <- c('20-21','19-20','18-19','17-18','16-17','15-16','14-15')

CompleteBundesURL$`14-15` <- gsub("Show","Archive", as.character(CompleteBundesURL$`14-15`))
CompleteBundesURL$`15-16` <- gsub("Show","Archive", as.character(CompleteBundesURL$`15-16`))
CompleteBundesURL$`16-17` <- gsub("Show","Archive", as.character(CompleteBundesURL$`16-17`))
CompleteBundesURL$`17-18` <- gsub("Show","Archive", as.character(CompleteBundesURL$`17-18`))
CompleteBundesURL$`18-19` <- gsub("Show","Archive", as.character(CompleteBundesURL$`18-19`))
CompleteBundesURL$`19-20` <- gsub("Show","Archive", as.character(CompleteBundesURL$`19-20`))
CompleteBundesURL$`20-21` <- gsub("Show","Archive", as.character(CompleteBundesURL$`20-21`))

CompleteBundesURL$`14-15` <- paste(CompleteBundesURL$`14-15`, "stageId=9192", sep = "?")
CompleteBundesURL$`15-16` <- paste(CompleteBundesURL$`15-16`, "stageId=12559", sep = "?")
CompleteBundesURL$`16-17` <- paste(CompleteBundesURL$`16-17`, "stageId=13872", sep = "?")
CompleteBundesURL$`17-18` <- paste(CompleteBundesURL$`17-18`, "stageId=15243", sep = "?")
CompleteBundesURL$`18-19` <- paste(CompleteBundesURL$`18-19`, "stageId=16427", sep = "?")
CompleteBundesURL$`19-20` <- paste(CompleteBundesURL$`19-20`, "stageId=17682", sep = "?")
CompleteBundesURL$`20-21` <- paste(CompleteBundesURL$`20-21`,"stageId=18762", sep="?")

CompleteBundesURL <- c(CompleteBundesURL$`20-21`,CompleteBundesURL$`19-20`,
                       CompleteBundesURL$`18-19`,CompleteBundesURL$`17-18`,
                       CompleteBundesURL$`16-17`,CompleteBundesURL$`15-16`,
                       CompleteBundesURL$`14-15`)

# scrape EPL Data

CompleteEPLData <- tibble()

for (url in CompleteEPLURL){
  remDr$navigate(url)
  Sys.sleep(2)
  
  Data <- tibble()
  
  webElem <- remDr$findElements("css", ".in-squad-detailed-view:nth-child(5) a")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  Sys.sleep(3)
  
  webElem <- remDr$findElements("xpath", "//*[(@id = 'statsAccumulationType')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='statsAccumulationType']/option[@value='2']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  
  webElem <- remDr$findElement("css", ".search-button")
  webElem$clickElement()
  Sys.sleep(3)
  
  ##Name Data
  Name <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .iconize-icon-left")
  for (i in seq(from = 1, to= length(link_element), by = 2)){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(Name = Word)
    
    Name <- rbind(Name, df)
  }
  Name <- data.frame(Name = Name[!apply(Name == "", 1, all),])
  
  ##General Data
  Appearance <- tibble()
  link_element <- remDr$findElements("css", "td:nth-child(5)")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(Appearance = Word)
    
    Appearance <- rbind(Appearance, df)
  }
  Appearance <- data.frame(Appearance = Appearance[!apply(Appearance == "", 1, all),])
  
  MinutesPlayed <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .minsPlayed")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(MinutesPlayed = Word)
    
    MinutesPlayed <- rbind(MinutesPlayed, df)
  }
  MinutesPlayed <- data.frame(MinutesPlayed = MinutesPlayed[!apply(MinutesPlayed == "", 1, all),])
  
  Height <- tibble()
  link_element <- remDr$findElements("css", ".grid-ghost-cell+ td")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(Height = Word)
    
    Height <- rbind(Height, df)
  }
  Height <- data.frame(Height = Height[!apply(Height == "", 1, all),])
  
  
  Weight <- tibble()
  link_element <- remDr$findElements("css", "td:nth-child(4)")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(Weight = Word)
    
    Weight <- rbind(Weight, df)
  }
  Weight <- data.frame(Weight = Weight[!apply(Weight == "", 1, all),])
  
  Rating <- tibble()
  link_element <- remDr$findElements("css", ".sorted")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(Rating = Word)
    
    Rating <- rbind(Rating, df)
  }
  Rating <- data.frame(Rating = Rating[!apply(Rating == "", 1, all),])
  
  ## Offensive stat
  ## Total Shot Data
  TotalShots <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .shotsTotal")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalShots = Word)
    
    TotalShots <- rbind(TotalShots, df)
  }
  OutsideBoxShot <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .shotOboxTotal")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(OutsideBoxShot = Word)
    
    OutsideBoxShot <- rbind(OutsideBoxShot, df)
  }
  
  SixYardShot <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .shotSixYardBox")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(SixYardShot = Word)
    
    SixYardShot <- rbind(SixYardShot, df)
  }
  
  PenaltyYardShot <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .shotPenaltyArea")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(PenaltyYardShot = Word)
    
    PenaltyYardShot <- rbind(PenaltyYardShot, df)
  }
  
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Offensive']//option[@value='goals']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  ## Total Goal Data
  TotalGoal <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .goalTotal")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalGoal = Word)
    
    TotalGoal <- rbind(TotalGoal, df)
  }
  
  OutsideBoxGoal <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .goalObox")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(OutsideBoxGoal = Word)
    
    OutsideBoxGoal <- rbind(OutsideBoxGoal, df)
  }
  
  SixYardGoal <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .goalSixYardBox")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(SixYardGoal = Word)
    
    SixYardGoal <- rbind(SixYardGoal, df)
  }
  
  PenaltyYardGoal <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .goalPenaltyArea")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(PenaltyYardGoal = Word)
    
    PenaltyYardGoal <- rbind(PenaltyYardGoal, df)
  }
  
  # total dribble stats
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Offensive']//option[@value='dribbles']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  TotalDribble <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .dribbleTotal")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalDribble = Word)
    
    TotalDribble <- rbind(TotalDribble, df)
  }
  
  DribbleLost <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .dribbleLost")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(DribbleLost = Word)
    
    DribbleLost <- rbind(DribbleLost, df)
  }
  
  DribbleWon <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .dribbleWon")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(DribbleWon = Word)
    
    DribbleWon <- rbind(DribbleWon, df)
  }
  
  #total possession loss stat
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Offensive']//option[@value='possession-loss']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  Turnovers <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .turnover")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(Turnovers = Word)
    
    Turnovers <- rbind(Turnovers, df)
  }
  
  Dispossessed <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .dispossessed")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(Dispossessed = Word)
    
    Dispossessed <- rbind(Dispossessed, df)
  }
  
  #total aerial stat
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Offensive']//option[@value='aerial']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  TotalAerialDuel <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .duelAerialTotal")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalAerialDuel = Word)
    
    TotalAerialDuel <- rbind(TotalAerialDuel, df)
  }
  
  AerialWon <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .duelAerialWon")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(AerialWon = Word)
    
    AerialWon <- rbind(AerialWon, df)
  }
  
  AerialLost <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .duelAerialLost")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(AerialLost = Word)
    
    AerialLost <- rbind(AerialLost, df)
  }
  
  ## Defensive Stat
  #total tackle stat
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Defensive']//option[@value='tackles']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  TotalTackleWon <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .tackleWonTotal")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalTackleWon = Word)
    
    TotalTackleWon <- rbind(TotalTackleWon, df)
  }
  
  DribbledPast <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .challengeLost")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(DribbledPast = Word)
    
    DribbledPast <- rbind(DribbledPast, df)
  }
  
  TotalTackleAttempt <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .tackleTotalAttempted")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalTackleAttempt = Word)
    
    TotalTackleAttempt <- rbind(TotalTackleAttempt, df)
  }
  
  #total interception stat
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Defensive']//option[@value='interception']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  TotalInterception <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .interceptionAll")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalInterception = Word)
    
    TotalInterception <- rbind(TotalInterception, df)
  }
  
  #total fouls
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Defensive']//option[@value='fouls']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  FoulAgainst <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .foulGiven")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(FoulAgainst = Word)
    
    FoulAgainst <- rbind(FoulAgainst, df)
  }
  
  FoulCommitted <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .foulCommitted")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(FoulCommitted = Word)
    
    FoulCommitted <- rbind(FoulCommitted, df)
  }
  
  #total cards
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Defensive']//option[@value='cards']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  YellowCard <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .yellowCard")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(YellowCard = Word)
    
    YellowCard <- rbind(YellowCard, df)
  }
  YellowCard <- data.frame(YellowCard = YellowCard[!apply(YellowCard == "", 1, all),])
  
  RedCard <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .redCard")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(RedCard = Word)
    
    RedCard <- rbind(RedCard, df)
  }
  RedCard <- data.frame(RedCard = RedCard[!apply(RedCard == "", 1, all),])
  
  #total offsides
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Defensive']//option[@value='offsides']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  Offside <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .offsideGiven")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(Offside = Word)
    
    Offside <- rbind(Offside, df)
  }
  
  #total clearances
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Defensive']//option[@value='clearances']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  TotalClearance <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .clearanceTotal")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalClearance = Word)
    
    TotalClearance <- rbind(TotalClearance, df)
  }
  
  #total blocks
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Defensive']//option[@value='blocks']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  ShotsBlocked <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .outfielderBlock")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(ShotsBlocked = Word)
    
    ShotsBlocked <- rbind(ShotsBlocked, df)
  }
  
  CrossesBlocked <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .passCrossBlockedDefensive")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(CrossesBlocked = Word)
    
    CrossesBlocked <- rbind(CrossesBlocked, df)
  }
  
  PassesBlocked <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .outfielderBlockedPass")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(PassesBlocked = Word)
    
    PassesBlocked <- rbind(PassesBlocked, df)
  }
  
  #total saves
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Defensive']//option[@value='saves']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  TotalSaves <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .saveTotal")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalSaves = Word)
    
    TotalSaves <- rbind(TotalSaves, df)
  }
  
  SixYardSave <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .saveSixYardBox")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(SixYardSave = Word)
    
    SixYardSave <- rbind(SixYardSave, df)
  }
  
  PenaltyAreaSave <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .savePenaltyArea")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(PenaltyAreaSave = Word)
    
    PenaltyAreaSave <- rbind(PenaltyAreaSave, df)
  }
  
  OutsideBoxSave <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .saveObox")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(OutsideBoxSave = Word)
    
    OutsideBoxSave <- rbind(OutsideBoxSave, df)
  }
  
  ## Passing Stats
  #total passes stat
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Passing']//option[@value='passes']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  TotalPass <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .passTotal")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalPass = Word)
    
    TotalPass <- rbind(TotalPass, df)
  }
  
  AccLongBall <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .passLongBallAccurate")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(AccLongBall = Word)
    
    AccLongBall <- rbind(AccLongBall, df)
  }
  
  InaccLongBall <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .passLongBallInaccurate")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(InaccLongBall = Word)
    
    InaccLongBall <- rbind(InaccLongBall, df)
  }
  
  AccShortPass <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .shortPassAccurate")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(AccShortPass = Word)
    
    AccShortPass <- rbind(AccShortPass, df)
  }
  
  InaccShortPass <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .shortPassInaccurate")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(InaccShortPass = Word)
    
    InaccShortPass <- rbind(InaccShortPass, df)
  }
  
  #total key passes stat
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Passing']//option[@value='key-passes']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  TotalKeyPass <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .keyPassesTotal")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalKeyPass = Word)
    
    TotalKeyPass <- rbind(TotalKeyPass, df)
  }
  
  LongKeyPass <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .keyPassLong")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(LongKeyPass = Word)
    
    LongKeyPass <- rbind(LongKeyPass, df)
  }
  
  ShortKeyPass <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .keyPassShort")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(ShortKeyPass = Word)
    
    ShortKeyPass <- rbind(ShortKeyPass, df)
  }
  
  #total assists stat
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Passing']//option[@value='assists']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  TotalAssist <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .assist")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalAssist = Word)
    
    TotalAssist <- rbind(TotalAssist, df)
  }
  
  CrossAssist <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .assistCross")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(CrossAssist = Word)
    
    CrossAssist <- rbind(CrossAssist, df)
  }
  
  CornerAssist <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .assistCorner")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(CornerAssist = Word)
    
    CornerAssist <- rbind(CornerAssist, df)
  }
  
  ThroughBallAssist <-tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .assistThroughball")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(ThroughBallAssist = Word)
    
    ThroughBallAssist <- rbind(ThroughBallAssist, df)
  }
  
  FKAssist <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .assistFreekick")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(FKAssist = Word)
    
    FKAssist <- rbind(FKAssist, df)
  }
  
  ThrowInAssist <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .assistThrowin")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(ThrowInAssist = Word)
    
    ThrowInAssist <- rbind(ThrowInAssist, df)
  }
  
  OtherAssist <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .assistOther")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(OtherAssist = Word)
    
    OtherAssist <- rbind(OtherAssist, df)
  }
  
  #PassingTab
  webElem <- remDr$findElements("css", ".in-squad-detailed-view:nth-child(4) a")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem <- remDr$findElements("css", "#player-table-statistics-head .rating")
  web_elem <- webElem[[2]]
  web_elem$clickElement()
  Sys.sleep(3)
  
  TotalAccCrosses <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .accurateCrossesPerGame")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalAccCrosses = Word)
    
    TotalAccCrosses <- rbind(TotalAccCrosses, df)
  }  
  
  TotalAccThroughBall <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .accurateThroughBallPerGame")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalAccThroughBall = Word)
    
    TotalAccThroughBall <- rbind(TotalAccThroughBall, df)
  }
  
  #DefensiveTab
  webElem <- remDr$findElements("css", ".in-squad-detailed-view:nth-child(2) a")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem <- remDr$findElements("css", "#player-table-statistics-head .rating")
  web_elem <- webElem[[2]]
  web_elem$clickElement()
  Sys.sleep(3)
  
  #Own Goal Stat
  OwnGoal <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .goalOwn")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(OwnGoal = Word)
    
    OwnGoal <- rbind(OwnGoal, df)
  }
  
  Data <- cbind(Name, Appearance, MinutesPlayed, Height, Weight, Rating,
                TotalShots, OutsideBoxShot, SixYardShot, PenaltyYardShot, 
                TotalGoal, OutsideBoxGoal, SixYardGoal, PenaltyYardGoal,
                TotalDribble, DribbleLost, DribbleWon, Turnovers, Dispossessed,
                TotalAerialDuel, AerialWon, AerialLost, TotalTackleWon,
                TotalTackleAttempt, DribbledPast, TotalInterception, FoulAgainst,
                FoulCommitted, YellowCard, RedCard, Offside, TotalClearance,
                ShotsBlocked, CrossesBlocked, PassesBlocked, TotalSaves, SixYardSave,
                PenaltyAreaSave, OutsideBoxSave, TotalPass, AccLongBall, InaccLongBall,
                AccShortPass, InaccShortPass, TotalKeyPass,LongKeyPass, ShortKeyPass,
                TotalAssist, CrossAssist, CornerAssist, ThroughBallAssist, FKAssist,
                ThrowInAssist, OtherAssist, TotalAccCrosses, TotalAccThroughBall, OwnGoal)
  
  CompleteEPLData <- rbind(CompleteEPLData, Data)
}

# scrape EPL positions from all players
EPLClubTransfermarkt <- c("https://www.transfermarkt.com/premier-league/startseite/wettbewerb/GB1/plus/?saison_id=2014",
                          "https://www.transfermarkt.com/premier-league/startseite/wettbewerb/GB1/plus/?saison_id=2015",
                          "https://www.transfermarkt.com/premier-league/startseite/wettbewerb/GB1/plus/?saison_id=2016",
                          "https://www.transfermarkt.com/premier-league/startseite/wettbewerb/GB1/plus/?saison_id=2017",
                          "https://www.transfermarkt.com/premier-league/startseite/wettbewerb/GB1/plus/?saison_id=2018",
                          "https://www.transfermarkt.com/premier-league/startseite/wettbewerb/GB1/plus/?saison_id=2019",
                          "https://www.transfermarkt.com/premier-league/startseite/wettbewerb/GB1/plus/?saison_id=2020")

TransferMarktEPLURL <- data.frame(matrix(nrow=20))
for (url in EPLClubTransfermarkt){
  remDr$navigate(url)
  Sys.sleep(3)
  link_element <- remDr$findElements("css", ".show-for-pad .tooltipstered")
  Scrape_link <- function(linkelement){
    club_link <- as.character(linkelement$getElementAttribute("href"))
  }
  list <- lapply(link_element, Scrape_link)
  df <- data.frame(matrix(unlist(list),
                          byrow=TRUE),stringsAsFactors=FALSE)
  TransferMarktEPLURL <- cbind(TransferMarktEPLURL, df)
}
TransferMarktEPLURL <- TransferMarktEPLURL[2:8]
colnames(TransferMarktEPLURL) <- c('14-15','15-16','16-17','17-18','18-19','19-20','20-21')
EPLClubTransfermarkt <- c(TransferMarktEPLURL$`14-15`, TransferMarktEPLURL$`15-16`, TransferMarktEPLURL$`16-17`,
                          TransferMarktEPLURL$`17-18`,TransferMarktEPLURL$`18-19`,TransferMarktEPLURL$`19-20`,
                          TransferMarktEPLURL$`20-21`)
NamePosition <- tibble()
for (url in EPLClubTransfermarkt){
  remDr$navigate(url)
  Name <- tibble()
  Position <-tibble()
  link_element <- remDr$findElements("css", ".spielprofil_tooltip")
  for (i in seq(from = 1,to = length(link_element), by = 2)){
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(Name = Word)
    Name <- rbind(Name, df)
  }
  
  link_element <- remDr$findElements("css", ".inline-table tr+ tr td")
  for (i in seq(from = 1,to = length(link_element))){
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(Position = Word)
    Position <- rbind(Position, df)
  }
  
  Data <- cbind(Name, Position)
  
  NamePosition <- rbind(NamePosition, Data)
}
###############
NamePosition$Name <- gsub("Izzy Brown", "Isaiah Brown", NamePosition$Name)
NamePosition$Name <- gsub("Ahmed El Mohamedy", "Ahmed El Mohamady", NamePosition$Name)
NamePosition$Name <- gsub("Ahmed Hegazy", "Ahmed Hegazi", NamePosition$Name)
NamePosition$Name <- gsub("Alejandro Faurlín","Alejandro Faurlin", NamePosition$Name)
NamePosition$Name <- gsub("Alex Oxlade-Chamberlain", "Alex Oxlade Chamberlain", NamePosition$Name)
NamePosition$Name <- gsub("Alexander Sörloth", "Alexander Sørloth", NamePosition$Name)
NamePosition$Name <- gsub("Alex Song", "Alexandre Song", NamePosition$Name)
NamePosition$Name <- gsub("Allan Nyom","Allan-Roméo Nyom", NamePosition$Name)
NamePosition$Name <- gsub("André Zambo Anguissa", "André-Frank Zambo Anguissa", NamePosition$Name)
NamePosition$Name <- gsub("Ángel Rangel", "Angel Rangel", NamePosition$Name)
NamePosition$Name <- gsub("Anthony Réveillère", "Anthony Réveillere", NamePosition$Name)
NamePosition$Name <- gsub("Armand Traoré", "Armand Traore", NamePosition$Name)
NamePosition$Name <- gsub("Abdul-Rahman Baba", "Baba Rahman", NamePosition$Name)

NamePosition$Name <- gsub("Bobby Reid", "Bobby De Cordova-Reid", NamePosition$Name)
NamePosition$Name <- gsub("Bojan Krkic", "Bojan", NamePosition$Name)
NamePosition$Name <- gsub("Brad Guzan","Bradley Guzan", NamePosition$Name)
NamePosition$Name <- gsub("Caglar Söyüncü", "Çaglar Söyüncü", NamePosition$Name)
NamePosition$Name <- gsub("Chancel Chancel Mbemba", "Chancel Mbemba", NamePosition$Name)
NamePosition$Name <- gsub("Charly Musonda Jr.", "Charly Musonda", NamePosition$Name)
NamePosition$Name <- gsub("Ché Adams","Che Adams", NamePosition$Name)
NamePosition$Name <- gsub("Cheik Tioté", "Cheick Tioté", NamePosition$Name)
NamePosition$Name <- gsub("Dan Agyei", "Daniel Agyei", NamePosition$Name)
NamePosition$Name <- gsub("Danny Lafferty", "Daniel Lafferty", NamePosition$Name)
NamePosition$Name <- gsub("Dan N'Lundulu", "Daniel N'Lundulu", NamePosition$Name)
NamePosition$Name <- gsub("David David Junior Hoilett", "David Junior Hoilett", NamePosition$Name)

NamePosition$Name <- gsub("Edouard Mendy", "Édouard Mendy", NamePosition$Name)
NamePosition$Name <- gsub("Étienne Capoue", "Etienne Capoue", NamePosition$Name)
NamePosition$Name <- gsub("Zeki Fryers","Ezekiel Fryers", NamePosition$Name)
NamePosition$Name <- gsub("Fábio Carvalho", "Fabio Carvalho", NamePosition$Name)
NamePosition$Name <- gsub("Tino Anjorin", "Faustino Anjorin", NamePosition$Name)
NamePosition$Name <- gsub("Fernando Reges", "Fernando", NamePosition$Name)
NamePosition$Name <- gsub("Gabriel Magalhães Magalhães","Gabriel Magalhães", NamePosition$Name)
NamePosition$Name <- gsub("Georges-Kevin N'Koudou", "Georges-Kévin Nkoudou", NamePosition$Name)
NamePosition$Name <- gsub("Havard Nordtveit", "Håvard Nordtveit", NamePosition$Name)
NamePosition$Name <- gsub("Ian Poveda-Ocampo-Ocampo", "Ian Poveda-Ocampo", NamePosition$Name)
NamePosition$Name <- gsub("Ismaïla Sarr", "Ismaila Sarr", NamePosition$Name)
NamePosition$Name <- gsub("Jay Rodríguez", "Jay Rodriguez", NamePosition$Name)

NamePosition$Name <- gsub("Jean Michaël Seri", "Jean Michael Seri", NamePosition$Name)
NamePosition$Name <- gsub("Jérémie Boga", "Jeremie Boga", NamePosition$Name)
NamePosition$Name <- gsub("Tyias Browning","Jiang Guangtai", NamePosition$Name)
NamePosition$Name <- gsub("João Carlos Teixeira", "João Teixeira", NamePosition$Name)
NamePosition$Name <- gsub("Jóhann Berg Gudmundsson", "Jóhann Gudmundsson", NamePosition$Name)
NamePosition$Name <- gsub("John Mikel Obi", "John Obi Mikel", NamePosition$Name)
NamePosition$Name <- gsub("Jonny Otto","Jonny", NamePosition$Name)
NamePosition$Name <- gsub("Jonathan Howson", "Jonny Howson", NamePosition$Name)
NamePosition$Name <- gsub("Jose Cholevas", "José Holebas", NamePosition$Name)
NamePosition$Name <- gsub("Joe Dodoo", "Joseph Dodoo", NamePosition$Name)
NamePosition$Name <- gsub("Joey O'Brien", "Joseph O'Brien", NamePosition$Name)
NamePosition$Name <- gsub("Joe Willock", "Joseph Willock", NamePosition$Name)

NamePosition$Name <- gsub("Jota Peleteiro", "Jota", NamePosition$Name)
NamePosition$Name <- gsub("Camilo Zúñiga", "Juan Camilo Zuñiga", NamePosition$Name)
NamePosition$Name <- gsub("Kell Watts","Kelland Watts", NamePosition$Name)
NamePosition$Name <- gsub("Sung-yueng Ki", "Ki Sung-Yueng", NamePosition$Name)
NamePosition$Name <- gsub("Lasse Sörensen", "Lasse Sørensen", NamePosition$Name)
NamePosition$Name <- gsub("Chung-yong Lee", "Lee Chung-Yong", NamePosition$Name)
NamePosition$Name <- gsub("Luis Hernández", "Luis Hernandez", NamePosition$Name)
NamePosition$Name <- gsub("Mame Diouf", "Mame Biram Diouf", NamePosition$Name)
NamePosition$Name <- gsub("Marek Rodak", "Marek Rodák", NamePosition$Name)
NamePosition$Name <- gsub("Martin Dubravka", "Martin Dúbravka", NamePosition$Name)
NamePosition$Name <- gsub("Massadio Haidara", "Massadio Haïdara", NamePosition$Name)

NamePosition$Name <- gsub("Mathew Ryan", "Mat Ryan", NamePosition$Name)
NamePosition$Name <- gsub("Matthew Upson", "Matt Upson", NamePosition$Name)
NamePosition$Name <- gsub("Matty Cash","Matthew Cash", NamePosition$Name)
NamePosition$Name <- gsub("Matt Jarvis", "Matthew Jarvis", NamePosition$Name)
NamePosition$Name <- gsub("Matty Longstaff", "Matthew Longstaff", NamePosition$Name)
NamePosition$Name <- gsub("Matt Worthington", "Matthew Worthington", NamePosition$Name)
NamePosition$Name <- gsub("Max Gradel","Max-Alain Gradel", NamePosition$Name)
NamePosition$Name <- gsub("Max Kilman", "Maximilian Kilman", NamePosition$Name)
NamePosition$Name <- gsub("Ally Samatta", "Mbwana Samatta", NamePosition$Name)
NamePosition$Name <- gsub("Modibo Maïga", "Modibo Maiga", NamePosition$Name)
NamePosition$Name <- gsub("Obbi Oulare", "Obbi Oularé", NamePosition$Name)
NamePosition$Name <- gsub("Örjan Nyland", "Ørjan Nyland", NamePosition$Name)

NamePosition$Name <- gsub("Paddy McNair", "Patrick McNair", NamePosition$Name)
NamePosition$Name <- gsub("Pierre-Emile Höjbjerg", "Pierre-Emile Højbjerg", NamePosition$Name)
NamePosition$Name <- gsub("Rayan Aït Nouri","Rayan Aït-Nouri", NamePosition$Name)
NamePosition$Name <- gsub("Rhys Healey", "Rhys Evitt-Healey", NamePosition$Name)
NamePosition$Name <- gsub("Rob Elliot", "Robert Elliot", NamePosition$Name)
NamePosition$Name <- gsub("Rob Green","Robert Green", NamePosition$Name)
NamePosition$Name <- gsub("Roberto Jiménez Jiménez", "Roberto Jiménez", NamePosition$Name)
NamePosition$Name <- gsub("Seamus Coleman", "Séamus Coleman", NamePosition$Name)
NamePosition$Name <- gsub("Sébastien Bassong", "Sebastien Bassong", NamePosition$Name)
NamePosition$Name <- gsub("Heung-min Son", "Son Heung-Min", NamePosition$Name)
NamePosition$Name <- gsub("Stéphane Sessègnon", "Stéphane Sessegnon", NamePosition$Name)

NamePosition$Name <- gsub("Tanguy Ndombélé", "Tanguy Ndombele", NamePosition$Name)
NamePosition$Name <- gsub("Khanya Leshabela", "Thakgalo Leshabela", NamePosition$Name)
NamePosition$Name <- gsub("Tom Edwards","Thomas Edwards", NamePosition$Name)
NamePosition$Name <- gsub("Trezeguet", "Trézéguet", NamePosition$Name)
NamePosition$Name <- gsub("Will Buckley", "William Buckley", NamePosition$Name)
NamePosition$Name <- gsub("Will Smallbone", "William Smallbone", NamePosition$Name)
NamePosition$Name <- gsub("Younès Kaboul", "Younes Kaboul", NamePosition$Name)
NamePosition$Name <- gsub("Seok-yeong Yun", "Yun Suk-Young", NamePosition$Name)

NamePosition$Name <- gsub("Gabriel Magalhães Agbonlahor", "Gabriel Agbonlahor", NamePosition$Name)
NamePosition$Name <- gsub("Gabriel Magalhães Jesus","Gabriel Jesus", NamePosition$Name)
NamePosition$Name <- gsub("Gabriel Magalhães Martinelli", "Gabriel Martinelli", NamePosition$Name)
NamePosition$Name <- gsub("Gabriel Magalhães Obertan", "Gabriel Obertan", NamePosition$Name)
NamePosition$Name <- gsub("Gabriel Magalhães Paulista", "Gabriel Paulista", NamePosition$Name)
NamePosition$Name <- gsub("Julián Speroni","Julian Speroni", NamePosition$Name)
NamePosition$Name <- gsub("Roberto Jiménez Jiménez Firmino", "Roberto Firmino", NamePosition$Name)
NamePosition$Name <- gsub("Roberto Jiménez Jiménez Pereyra", "Roberto Pereyra", NamePosition$Name)
NamePosition$Name <- gsub("Roberto Jiménez Jiménez Soldado","Roberto Soldado", NamePosition$Name)
NamePosition$Name <- gsub("Tommy Robson", "Thomas Robson", NamePosition$Name)
NamePosition$Name <- gsub("Will Fish", "William Fish", NamePosition$Name)

NamePosition$Name <- gsub("Libor Kozak", "Libor Kozák", NamePosition$Name)
NamePosition$Name <- gsub("Zivkovic", "Zivkovic", NamePosition$Name)

NamePosition$Position <- gsub("attack", "Attacking Midfield", NamePosition$Position)

##############

NamePosition <- NamePosition[!duplicated(NamePosition$Name),]

CompleteEPLData1 <- merge(CompleteEPLData, NamePosition, by='Name', all = TRUE)
CompleteEPLData1 <- CompleteEPLData2 %>% select("Position", everything())
CompleteEPLData1$Position[is.na(CompleteEPLData1$Position)] <- "Centre-Forward"

excluded <- subset(CompleteEPLData1, is.na(CompleteEPLData1$Appearance))
CompleteEPLData1 <- CompleteEPLData1[complete.cases(CompleteEPLData1$Appearance),]

# scrape Bundes Data
CompleteBundesData <- tibble()

for (url in CompleteBundesURL){
  remDr$navigate(url)
  Sys.sleep(2)
  
  Data <- tibble()
  
  webElem <- remDr$findElements("css", ".in-squad-detailed-view:nth-child(5) a")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  Sys.sleep(3)
  
  webElem <- remDr$findElements("xpath", "//*[(@id = 'statsAccumulationType')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='statsAccumulationType']/option[@value='2']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  
  webElem <- remDr$findElement("css", ".search-button")
  webElem$clickElement()
  Sys.sleep(3)
  
  ##Name Data
  Name <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .iconize-icon-left")
  for (i in seq(from = 1, to= length(link_element), by = 2)){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(Name = Word)
    
    Name <- rbind(Name, df)
  }
  Name <- data.frame(Name = Name[!apply(Name == "", 1, all),])
  
  ##General Data
  Appearance <- tibble()
  link_element <- remDr$findElements("css", "td:nth-child(5)")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(Appearance = Word)
    
    Appearance <- rbind(Appearance, df)
  }
  Appearance <- data.frame(Appearance = Appearance[!apply(Appearance == "", 1, all),])
  
  MinutesPlayed <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .minsPlayed")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(MinutesPlayed = Word)
    
    MinutesPlayed <- rbind(MinutesPlayed, df)
  }
  MinutesPlayed <- data.frame(MinutesPlayed = MinutesPlayed[!apply(MinutesPlayed == "", 1, all),])
  
  Height <- tibble()
  link_element <- remDr$findElements("css", ".grid-ghost-cell+ td")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(Height = Word)
    
    Height <- rbind(Height, df)
  }
  Height <- data.frame(Height = Height[!apply(Height == "", 1, all),])
  
  
  Weight <- tibble()
  link_element <- remDr$findElements("css", "td:nth-child(4)")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(Weight = Word)
    
    Weight <- rbind(Weight, df)
  }
  Weight <- data.frame(Weight = Weight[!apply(Weight == "", 1, all),])
  
  Rating <- tibble()
  link_element <- remDr$findElements("css", ".sorted")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(Rating = Word)
    
    Rating <- rbind(Rating, df)
  }
  Rating <- data.frame(Rating = Rating[!apply(Rating == "", 1, all),])
  
  ## Offensive stat
  ## Total Shot Data
  TotalShots <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .shotsTotal")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalShots = Word)
    
    TotalShots <- rbind(TotalShots, df)
  }
  OutsideBoxShot <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .shotOboxTotal")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(OutsideBoxShot = Word)
    
    OutsideBoxShot <- rbind(OutsideBoxShot, df)
  }
  
  SixYardShot <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .shotSixYardBox")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(SixYardShot = Word)
    
    SixYardShot <- rbind(SixYardShot, df)
  }
  
  PenaltyYardShot <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .shotPenaltyArea")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(PenaltyYardShot = Word)
    
    PenaltyYardShot <- rbind(PenaltyYardShot, df)
  }
  
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Offensive']//option[@value='goals']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  ## Total Goal Data
  TotalGoal <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .goalTotal")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalGoal = Word)
    
    TotalGoal <- rbind(TotalGoal, df)
  }
  
  OutsideBoxGoal <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .goalObox")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(OutsideBoxGoal = Word)
    
    OutsideBoxGoal <- rbind(OutsideBoxGoal, df)
  }
  
  SixYardGoal <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .goalSixYardBox")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(SixYardGoal = Word)
    
    SixYardGoal <- rbind(SixYardGoal, df)
  }
  
  PenaltyYardGoal <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .goalPenaltyArea")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(PenaltyYardGoal = Word)
    
    PenaltyYardGoal <- rbind(PenaltyYardGoal, df)
  }
  
  # total dribble stats
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Offensive']//option[@value='dribbles']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  TotalDribble <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .dribbleTotal")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalDribble = Word)
    
    TotalDribble <- rbind(TotalDribble, df)
  }
  
  DribbleLost <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .dribbleLost")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(DribbleLost = Word)
    
    DribbleLost <- rbind(DribbleLost, df)
  }
  
  DribbleWon <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .dribbleWon")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(DribbleWon = Word)
    
    DribbleWon <- rbind(DribbleWon, df)
  }
  
  #total possession loss stat
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Offensive']//option[@value='possession-loss']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  Turnovers <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .turnover")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(Turnovers = Word)
    
    Turnovers <- rbind(Turnovers, df)
  }
  
  Dispossessed <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .dispossessed")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(Dispossessed = Word)
    
    Dispossessed <- rbind(Dispossessed, df)
  }
  
  #total aerial stat
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Offensive']//option[@value='aerial']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  TotalAerialDuel <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .duelAerialTotal")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalAerialDuel = Word)
    
    TotalAerialDuel <- rbind(TotalAerialDuel, df)
  }
  
  AerialWon <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .duelAerialWon")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(AerialWon = Word)
    
    AerialWon <- rbind(AerialWon, df)
  }
  
  AerialLost <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .duelAerialLost")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(AerialLost = Word)
    
    AerialLost <- rbind(AerialLost, df)
  }
  
  ## Defensive Stat
  #total tackle stat
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Defensive']//option[@value='tackles']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  TotalTackleWon <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .tackleWonTotal")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalTackleWon = Word)
    
    TotalTackleWon <- rbind(TotalTackleWon, df)
  }
  
  DribbledPast <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .challengeLost")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(DribbledPast = Word)
    
    DribbledPast <- rbind(DribbledPast, df)
  }
  
  TotalTackleAttempt <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .tackleTotalAttempted")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalTackleAttempt = Word)
    
    TotalTackleAttempt <- rbind(TotalTackleAttempt, df)
  }
  
  #total interception stat
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Defensive']//option[@value='interception']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  TotalInterception <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .interceptionAll")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalInterception = Word)
    
    TotalInterception <- rbind(TotalInterception, df)
  }
  
  #total fouls
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Defensive']//option[@value='fouls']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  FoulAgainst <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .foulGiven")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(FoulAgainst = Word)
    
    FoulAgainst <- rbind(FoulAgainst, df)
  }
  
  FoulCommitted <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .foulCommitted")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(FoulCommitted = Word)
    
    FoulCommitted <- rbind(FoulCommitted, df)
  }
  
  #total cards
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Defensive']//option[@value='cards']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  YellowCard <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .yellowCard")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(YellowCard = Word)
    
    YellowCard <- rbind(YellowCard, df)
  }
  YellowCard <- data.frame(YellowCard = YellowCard[!apply(YellowCard == "", 1, all),])
  
  RedCard <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .redCard")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(RedCard = Word)
    
    RedCard <- rbind(RedCard, df)
  }
  RedCard <- data.frame(RedCard = RedCard[!apply(RedCard == "", 1, all),])
  
  #total offsides
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Defensive']//option[@value='offsides']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  Offside <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .offsideGiven")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(Offside = Word)
    
    Offside <- rbind(Offside, df)
  }
  
  #total clearances
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Defensive']//option[@value='clearances']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  TotalClearance <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .clearanceTotal")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalClearance = Word)
    
    TotalClearance <- rbind(TotalClearance, df)
  }
  
  #total blocks
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Defensive']//option[@value='blocks']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  ShotsBlocked <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .outfielderBlock")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(ShotsBlocked = Word)
    
    ShotsBlocked <- rbind(ShotsBlocked, df)
  }
  
  CrossesBlocked <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .passCrossBlockedDefensive")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(CrossesBlocked = Word)
    
    CrossesBlocked <- rbind(CrossesBlocked, df)
  }
  
  PassesBlocked <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .outfielderBlockedPass")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(PassesBlocked = Word)
    
    PassesBlocked <- rbind(PassesBlocked, df)
  }
  
  #total saves
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Defensive']//option[@value='saves']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  TotalSaves <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .saveTotal")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalSaves = Word)
    
    TotalSaves <- rbind(TotalSaves, df)
  }
  
  SixYardSave <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .saveSixYardBox")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(SixYardSave = Word)
    
    SixYardSave <- rbind(SixYardSave, df)
  }
  
  PenaltyAreaSave <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .savePenaltyArea")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(PenaltyAreaSave = Word)
    
    PenaltyAreaSave <- rbind(PenaltyAreaSave, df)
  }
  
  OutsideBoxSave <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .saveObox")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(OutsideBoxSave = Word)
    
    OutsideBoxSave <- rbind(OutsideBoxSave, df)
  }
  
  ## Passing Stats
  #total passes stat
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Passing']//option[@value='passes']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  TotalPass <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .passTotal")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalPass = Word)
    
    TotalPass <- rbind(TotalPass, df)
  }
  
  AccLongBall <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .passLongBallAccurate")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(AccLongBall = Word)
    
    AccLongBall <- rbind(AccLongBall, df)
  }
  
  InaccLongBall <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .passLongBallInaccurate")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(InaccLongBall = Word)
    
    InaccLongBall <- rbind(InaccLongBall, df)
  }
  
  AccShortPass <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .shortPassAccurate")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(AccShortPass = Word)
    
    AccShortPass <- rbind(AccShortPass, df)
  }
  
  InaccShortPass <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .shortPassInaccurate")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(InaccShortPass = Word)
    
    InaccShortPass <- rbind(InaccShortPass, df)
  }
  
  #total key passes stat
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Passing']//option[@value='key-passes']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  TotalKeyPass <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .keyPassesTotal")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalKeyPass = Word)
    
    TotalKeyPass <- rbind(TotalKeyPass, df)
  }
  
  LongKeyPass <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .keyPassLong")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(LongKeyPass = Word)
    
    LongKeyPass <- rbind(LongKeyPass, df)
  }
  
  ShortKeyPass <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .keyPassShort")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(ShortKeyPass = Word)
    
    ShortKeyPass <- rbind(ShortKeyPass, df)
  }
  
  #total assists stat
  webElem <- remDr$findElements("xpath", "//*[(@id = 'category')]")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem1 <- remDr$findElements("xpath", "//select[@id='category']/optgroup[@label='Passing']//option[@value='assists']")
  web_elem1 <- webElem1[[1]]
  web_elem1$clickElement()
  Sys.sleep(3)
  
  TotalAssist <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .assist")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalAssist = Word)
    
    TotalAssist <- rbind(TotalAssist, df)
  }
  
  CrossAssist <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .assistCross")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(CrossAssist = Word)
    
    CrossAssist <- rbind(CrossAssist, df)
  }
  
  CornerAssist <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .assistCorner")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(CornerAssist = Word)
    
    CornerAssist <- rbind(CornerAssist, df)
  }
  
  ThroughBallAssist <-tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .assistThroughball")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(ThroughBallAssist = Word)
    
    ThroughBallAssist <- rbind(ThroughBallAssist, df)
  }
  
  FKAssist <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .assistFreekick")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(FKAssist = Word)
    
    FKAssist <- rbind(FKAssist, df)
  }
  
  ThrowInAssist <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .assistThrowin")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(ThrowInAssist = Word)
    
    ThrowInAssist <- rbind(ThrowInAssist, df)
  }
  
  OtherAssist <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .assistOther")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(OtherAssist = Word)
    
    OtherAssist <- rbind(OtherAssist, df)
  }
  
  #PassingTab
  webElem <- remDr$findElements("css", ".in-squad-detailed-view:nth-child(4) a")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem <- remDr$findElements("css", "#player-table-statistics-head .rating")
  web_elem <- webElem[[2]]
  web_elem$clickElement()
  Sys.sleep(3)
  
  TotalAccCrosses <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .accurateCrossesPerGame")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalAccCrosses = Word)
    
    TotalAccCrosses <- rbind(TotalAccCrosses, df)
  }  
  
  TotalAccThroughBall <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .accurateThroughBallPerGame")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(TotalAccThroughBall = Word)
    
    TotalAccThroughBall <- rbind(TotalAccThroughBall, df)
  }
  
  #DefensiveTab
  webElem <- remDr$findElements("css", ".in-squad-detailed-view:nth-child(2) a")
  web_elem <- webElem[[1]]
  web_elem$clickElement()
  
  webElem <- remDr$findElements("css", "#player-table-statistics-head .rating")
  web_elem <- webElem[[2]]
  web_elem$clickElement()
  Sys.sleep(3)
  
  #Own Goal Stat
  OwnGoal <- tibble()
  link_element <- remDr$findElements("css", "#player-table-statistics-body .goalOwn")
  for (i in seq(from=1, to=length(link_element))){
    
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(OwnGoal = Word)
    
    OwnGoal <- rbind(OwnGoal, df)
  }
  
  Data <- cbind(Name, Appearance, MinutesPlayed, Height, Weight, Rating,
                TotalShots, OutsideBoxShot, SixYardShot, PenaltyYardShot, 
                TotalGoal, OutsideBoxGoal, SixYardGoal, PenaltyYardGoal,
                TotalDribble, DribbleLost, DribbleWon, Turnovers, Dispossessed,
                TotalAerialDuel, AerialWon, AerialLost, TotalTackleWon,
                TotalTackleAttempt, DribbledPast, TotalInterception, FoulAgainst,
                FoulCommitted, YellowCard, RedCard, Offside, TotalClearance,
                ShotsBlocked, CrossesBlocked, PassesBlocked, TotalSaves, SixYardSave,
                PenaltyAreaSave, OutsideBoxSave, TotalPass, AccLongBall, InaccLongBall,
                AccShortPass, InaccShortPass, TotalKeyPass,LongKeyPass, ShortKeyPass,
                TotalAssist, CrossAssist, CornerAssist, ThroughBallAssist, FKAssist,
                ThrowInAssist, OtherAssist, TotalAccCrosses, TotalAccThroughBall, OwnGoal)
  
  CompleteBundesData <- rbind(CompleteBundesData, Data)
}

BundesClubTransfermarkt <- c("https://www.transfermarkt.com/bundesliga/startseite/wettbewerb/L1/saison_id/2020",
                             "https://www.transfermarkt.com/bundesliga/startseite/wettbewerb/L1/plus/?saison_id=2019",
                             "https://www.transfermarkt.com/bundesliga/startseite/wettbewerb/L1/plus/?saison_id=2018",
                             "https://www.transfermarkt.com/bundesliga/startseite/wettbewerb/L1/plus/?saison_id=2017",
                             "https://www.transfermarkt.com/bundesliga/startseite/wettbewerb/L1/plus/?saison_id=2016",
                             "https://www.transfermarkt.com/bundesliga/startseite/wettbewerb/L1/plus/?saison_id=2015",
                             "https://www.transfermarkt.com/bundesliga/startseite/wettbewerb/L1/plus/?saison_id=2014")

TransferMarktBundesURL <- data.frame(matrix(nrow=18))
for (url in BundesClubTransfermarkt){
  remDr$navigate(url)
  Sys.sleep(3)
  link_element <- remDr$findElements("css", ".show-for-pad .tooltipstered")
  Scrape_link <- function(linkelement){
    club_link <- as.character(linkelement$getElementAttribute("href"))
  }
  list <- lapply(link_element, Scrape_link)
  df <- data.frame(matrix(unlist(list),
                          byrow=TRUE),stringsAsFactors=FALSE)
  TransferMarktBundesURL <- cbind(TransferMarktBundesURL, df)
}

TransferMarktBundesURL <- TransferMarktBundesURL[2:8]
colnames(TransferMarktBundesURL) <- c('14-15','15-16','16-17','17-18','18-19','19-20','20-21')
BundesClubTransfermarkt <- c(TransferMarktBundesURL$`14-15`, TransferMarktBundesURL$`15-16`, TransferMarktBundesURL$`16-17`,
                             TransferMarktBundesURL$`17-18`,TransferMarktBundesURL$`18-19`,TransferMarktBundesURL$`19-20`,
                             TransferMarktBundesURL$`20-21`)
NamePosition1 <- tibble()
for (url in BundesClubTransfermarkt){
  remDr$navigate(url)
  Name <- tibble()
  Position <-tibble()
  link_element <- remDr$findElements("css", ".spielprofil_tooltip")
  for (i in seq(from = 1,to = length(link_element), by = 2)){
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(Name = Word)
    Name <- rbind(Name, df)
  }
  
  link_element <- remDr$findElements("css", ".inline-table tr+ tr td")
  for (i in seq(from = 1,to = length(link_element))){
    linkelement <- link_element[[i]]
    Word <- as.character(linkelement$getElementText())
    
    df <- data.frame(Position = Word)
    Position <- rbind(Position, df)
  }
  
  Data <- cbind(Name, Position)
  
  NamePosition1 <- rbind(NamePosition1, Data)
}
NamePosition1 <- NamePosition1[!duplicated(NamePosition1$Name),]
#####
NamePosition1$Name <- gsub("Adam Matuszczyk", "Adam Matuschyk", NamePosition1$Name)
NamePosition1$Name <- gsub("Adam Zrelak", "Adam Zrelák", NamePosition1$Name)
NamePosition1$Name <- gsub("Aílton", "Ailton", NamePosition1$Name)
NamePosition1$Name <- gsub("Alejandro Gálvez","Álex Gálvez", NamePosition1$Name)
NamePosition1$Name <- gsub("Momo Cissé", "Alkhaly Momo Cissé", NamePosition1$Name)
NamePosition1$Name <- gsub("Alexander Sörloth", "Alexander Sørloth", NamePosition1$Name)
NamePosition1$Name <- gsub("Bamba Anderson", "Anderson", NamePosition1$Name)
NamePosition1$Name <- gsub("Andre Hoffmann","André Hoffmann", NamePosition1$Name)
NamePosition1$Name <- gsub("Antonio Colak", "Antonio-Mirko Colak", NamePosition1$Name)
NamePosition1$Name <- gsub("Artem Fedetskyi", "Artem Fedetskyy", NamePosition1$Name)
NamePosition1$Name <- gsub("Baptiste Santamaria", "Baptiste Santamaría", NamePosition1$Name)
NamePosition1$Name <- gsub("Bard Finne", "Bård Finne", NamePosition1$Name)
NamePosition1$Name <- gsub("Abdul-Rahman Baba", "Baba Rahman", NamePosition1$Name)

NamePosition1$Name <- gsub("Baris Atik", "Baris-Fahri Atik", NamePosition1$Name)
NamePosition1$Name <- gsub("Bojan Krkic", "Bojan", NamePosition1$Name)
NamePosition1$Name <- gsub("Cédric Makiadi","Cedrick Makiadi", NamePosition1$Name)
NamePosition1$Name <- gsub("Caglar Söyüncü", "Çaglar Söyüncü", NamePosition1$Name)
NamePosition1$Name <- gsub("Denys Oliynyk", "Denys Oliinyk", NamePosition1$Name)
NamePosition1$Name <- gsub("Diadié Samassékou", "Diadie Samassékou", NamePosition1$Name)
NamePosition1$Name <- gsub("Dimitrios Limnios","Dimitris Limnios", NamePosition1$Name)
NamePosition1$Name <- gsub("Edgar Salli", "Edgar Nicaise Constant Salli", NamePosition1$Name)
NamePosition1$Name <- gsub("Eren Dinkci", "Eren Sami Dinkci", NamePosition1$Name)
NamePosition1$Name <- gsub("Luca Itter", "Gian-Luca Itter", NamePosition1$Name)
NamePosition1$Name <- gsub("Luca Waldschmidt", "Gian-Luca Waldschmidt", NamePosition1$Name)
NamePosition1$Name <- gsub("Nunoo Sarpei", "Hans Nunoo Sarpei", NamePosition1$Name)

NamePosition1$Name <- gsub("Jeong-ho Hong", "Hong Jeong-Ho", NamePosition1$Name)
NamePosition1$Name <- gsub("Hee-chan Hwang", "Hwang Hee-Chan", NamePosition1$Name)
NamePosition1$Name <- gsub("Isaac Kiese Thelin", "Isaac Thelin", NamePosition1$Name)
NamePosition1$Name <- gsub("Jacob Barrett Laursen", "Jacob Laursen", NamePosition1$Name)
NamePosition1$Name <- gsub("Luca Schuler", "Jan-Luca Schuler", NamePosition1$Name)
NamePosition1$Name <- gsub("Fiete Arp", "Jann-Fiete Arp", NamePosition1$Name)
NamePosition1$Name <- gsub("Jean Manuel Mbom","Jean-Manuel Mbom", NamePosition1$Name)
NamePosition1$Name <- gsub("Woo-yeong Jeong", "Jeong Woo-Yeong", NamePosition1$Name)
NamePosition1$Name <- gsub("Havard Nordtveit", "Håvard Nordtveit", NamePosition1$Name)
NamePosition1$Name <- gsub("Dong-won Ji", "Ji Dong-Won", NamePosition1$Name)
NamePosition1$Name <- gsub("Jiri Pavlenka", "Jirí Pavlenka", NamePosition1$Name)
NamePosition1$Name <- gsub("João Victor", "Joao Victor", NamePosition1$Name)

NamePosition1$Name <- gsub("John Anthony Brooks", "John Brooks", NamePosition1$Name)
NamePosition1$Name <- gsub("Johnny Heitinga", "John Heitinga", NamePosition1$Name)
NamePosition1$Name <- gsub("Jonas Dirkner","Jonas Michel Dirkner", NamePosition1$Name)
NamePosition1$Name <- gsub("Josh Sargent", "Joshua Sargent", NamePosition1$Name)
NamePosition1$Name <- gsub("Kerim Calhanoglu", "Kerim Çalhanoglu", NamePosition1$Name)
NamePosition1$Name <- gsub("Kevin Kuranyi", "Kevin Kurányi", NamePosition1$Name)
NamePosition1$Name <- gsub("Jin-su Kim","Kim Jin-Su", NamePosition1$Name)
NamePosition1$Name <- gsub("Klaas-Jan Huntelaar", "Klaas Jan Huntelaar", NamePosition1$Name)
NamePosition1$Name <- gsub("João Klauss", "Klauss", NamePosition1$Name)
NamePosition1$Name <- gsub("Ja-cheol Koo", "Koo Ja-Cheol", NamePosition1$Name)
NamePosition1$Name <- gsub("Kwasi Wriedt", "Kwasi Okyere Wriedt", NamePosition1$Name)
NamePosition1$Name <- gsub("Chang-hoon Kwon", "Kwon Chang-Hoon", NamePosition1$Name)
NamePosition1$Name <- gsub("Jimmy Kaparos", "Jimmy Adrian Kaparos", NamePosition1$Name)

NamePosition1$Name <- gsub("Lászlo Bénes", "László Bénes", NamePosition1$Name)
NamePosition1$Name <- gsub("Leandro Barreiro", "Leandro Barreiro Martins", NamePosition1$Name)
NamePosition1$Name <- gsub("Levent Aycicek","Levent Ayçiçek", NamePosition1$Name)
NamePosition1$Name <- gsub("Jordan Beyer", "Louis Jordan Beyer", NamePosition1$Name)
NamePosition1$Name <- gsub("Luca Zander", "Luca-Milan Zander", NamePosition1$Name)
NamePosition1$Name <- gsub("Lukas Hradecky", "Lukás Hrádecky", NamePosition1$Name)
NamePosition1$Name <- gsub("Mario Gómez", "Mario Gomez", NamePosition1$Name)
NamePosition1$Name <- gsub("Mateu Morey Bauzà", "Mateu Morey", NamePosition1$Name)
NamePosition1$Name <- gsub("Moritz Hartmann", "Moritz Hartmann", NamePosition1$Name)
NamePosition1$Name <- gsub("Mats Möller Daehli", "Mats Møller Dæhli", NamePosition1$Name)
NamePosition1$Name <- gsub("Mehmet Aydin", "Mehmet Can Aydin", NamePosition1$Name)

NamePosition1$Name <- gsub("Mevlüt Erdinc", "Mevlüt Erdinç", NamePosition1$Name)
NamePosition1$Name <- gsub("Mike Bähre", "Mike-Steven Bähre", NamePosition1$Name)
NamePosition1$Name <- gsub("Nelson Valdez","Nelson Haedo Valdez", NamePosition1$Name)
NamePosition1$Name <- gsub("Noah Joel Sarenren Bazee", "Noah Sarenren Bazee", NamePosition1$Name)
NamePosition1$Name <- gsub("Evan N'Dicka", "Obite Evan Ndicka", NamePosition1$Name)
NamePosition1$Name <- gsub("Ondrej Petrak", "Ondrej Petrák", NamePosition1$Name)
NamePosition1$Name <- gsub("Pablo de Blasis","Pablo De Blasis", NamePosition1$Name)
NamePosition1$Name <- gsub("Pablo Insua", "Pablo Ínsua", NamePosition1$Name)
NamePosition1$Name <- gsub("Palkó Dárdai", "Pál Dárdai", NamePosition1$Name)
NamePosition1$Name <- gsub("Ju-ho Park", "Park Joo-Ho", NamePosition1$Name)
NamePosition1$Name <- gsub("Pavel Kaderabek", "Pavel Kaderábek", NamePosition1$Name)
NamePosition1$Name <- gsub("Örjan Nyland", "Ørjan Nyland", NamePosition1$Name)

NamePosition1$Name <- gsub("Peter Pekarik", "Peter Pekarík", NamePosition1$Name)
NamePosition1$Name <- gsub("Pierre-Emile Höjbjerg", "Pierre-Emile Højbjerg", NamePosition1$Name)
NamePosition1$Name <- gsub("Petr Jiracek","Petr Jirácek", NamePosition1$Name)
NamePosition1$Name <- gsub("Phillipp Mwene", "Philipp Mwene", NamePosition1$Name)
NamePosition1$Name <- gsub("Pierre Kunde", "Pierre Kunde Malong", NamePosition1$Name)
NamePosition1$Name <- gsub("Rafa López","Rafa", NamePosition1$Name)
NamePosition1$Name <- gsub("Raphaël Guerreiro", "Raphael Guerreiro", NamePosition1$Name)
NamePosition1$Name <- gsub("Roger", "Roger Bernardo", NamePosition1$Name)
NamePosition1$Name <- gsub("Rubén Vargas", "Ruben Vargas", NamePosition1$Name)
NamePosition1$Name <- gsub("Heung-min Son", "Son Heung-Min", NamePosition1$Name)
NamePosition1$Name <- gsub("Samúel Fridjónsson", "Samúel Kári Fridjónsson", NamePosition1$Name)
NamePosition1$Name <- gsub("Santiago Ascacíbar", "Santiago Ascacibar", NamePosition1$Name)

NamePosition1$Name <- gsub("Geoffroy Serey Dié", "Serey Dié", NamePosition1$Name)
NamePosition1$Name <- gsub("Silas Katompa Mvumpa", "Silas", NamePosition1$Name)
NamePosition1$Name <- gsub("Stefan Ortega", "Stefan Ortega Moreno", NamePosition1$Name)
NamePosition1$Name <- gsub("Tolu Arokodare","Toluwalase Emmanuel Arokodare", NamePosition1$Name)
NamePosition1$Name <- gsub("Tomas Koubek", "Tomás Koubek", NamePosition1$Name)
NamePosition1$Name <- gsub("Ulisses Garcia", "Ulisses García", NamePosition1$Name)
NamePosition1$Name <- gsub("Vasilios Pavlidis", "Vasilis Pavlidis", NamePosition1$Name)
NamePosition1$Name <- gsub("Vladimir Darida","Vladimír Darida", NamePosition1$Name)
NamePosition1$Name <- gsub("Yann Aurel Bisseck", "Yann Bisseck", NamePosition1$Name)
NamePosition1$Name <- gsub("Yevgen Konoplyanka","Yevhen Konoplyanka", NamePosition1$Name)

NamePosition1$Position <- gsub("attack", "Right Midfield", NamePosition1$Position)
#####
CompleteBundesData2 <- merge(CompleteBundesData, NamePosition1, by='Name', all = TRUE)
CompleteBundesData2 <- CompleteBundesData2 %>% select("Position", everything())
excluded2 <- subset(CompleteBundesData2, is.na(CompleteBundesData2$Appearance))
CompleteBundesData2 <- CompleteBundesData2[complete.cases(CompleteBundesData2),]

CompleteBundesData <- read.csv("C:\\Users\\naqib\\Desktop\\FYP Plans\\Data\\CompleteBundesData.csv")
CompleteEPLData <- read.csv("C:\\Users\\naqib\\Desktop\\FYP Plans\\Data\\CompleteEPLData.csv")

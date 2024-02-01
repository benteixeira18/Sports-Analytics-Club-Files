# loading packages
library(tidyverse)
library(tidyr)
library(readxl)

# loading dataset and mutate into factors
season_pitchers <- read_csv('fangraphs_season_level.csv') |>
  mutate(across(everything(),as_factor()))
View(season_pitchers)

# filtering for low era and high games played (+20)
low_era <- season_pitchers |> filter(ERA < 4)
high_games <- low_era |> filter(G >= 20) |>
  arrange(desc(G))

# selecting young relief players and creating data frame
high_relief <- high_games |> filter(Role == 'RP' & Age < 30)
high_relief <- data.frame(high_relief)

# determining means for cut-offs
round(mean(high_relief$G),0) # mean games: 48
round(mean(high_relief$IP),2) # mean innings pitched: 51.28
round(mean(high_relief$W),2) # mean wins: 3.49 
good_relief <- high_relief |> filter(G > 48 & IP > 51.28 & W > 3.49)

# filtering and counting missing data
good_relief[good_relief == '- - -'] = NA
table(is.na(good_relief$Team))

# removing NA data
relief <- good_relief[!is.na(good_relief$Team),] |>
  arrange(desc(WAR)) |> head(5,relief)

# selecting important stats for starting pitchers to find crossover
starting_stats <- season_pitchers |> 
  select(Name,ERA,GS,Role,Age,IP,W,WAR)
round(mean(starting_stats$WAR),2)

starters <- starting_stats |> filter(Role == 'SP' & Age < 30 &
                        GS > 30 & IP > 80 & W > 8 & WAR > 0.39) |>
  arrange(desc(WAR))
head(starters,10)

# Conclusion: With the right training, you can get relief pitchers to 
# perform like the starting pithcers, as the potential is similar
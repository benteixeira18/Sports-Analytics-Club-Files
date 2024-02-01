# R Workshop 11.02.23

# Data types: Vector
numeric_vector <- c(1,2,3,4)
char_vector <- c('apple','banana','mango')
logic_vector <- c(2>1,2>4)  

# Operators: Arithmetic
vector_1 <- c(1,2,3)
vector_2 <- c(4,5,6)

# basic arithmetic
add_vector <- vector_1 + vector_2
sub_vector <- vector_1 - vector_2
mul_vector <- vector_1 * vector_2
div_vector <- vector_1 / vector_2

# integer division
remainder_vector <- vector_2 %% vector_1
quotient_vector <- vector_2 %/% vector_1

# Matrices
a1 <- matrix(vector_1,nrow=3,ncol=3,byrow = TRUE)

# Relation
5 > 4
5 <= 4
33 == 22
33 != 22

# Logic
(5 > 6) | (2 < 3)
(5 > 6) & (2 < 3)
!(5 > 6) & (2 < 3)

# Sequence
1:5
5:1
-1:-5
-1:5

# Practice
vector_1 <- c(3,4,5)
vector_2 <- c(6,7,8)
vector_3 <- c('Ben','Connor','Alex','Clarke','Barrett','Ben','Jack')
vector_4 <- c(length(vector_1) == length(vector_2), 3 != 3)
vector_5 <- c((5>6) | (5<6), (5>6) & (5<6))

math_vectors <- c(vector_1 + vector_2, vector_1 - vector_2, vector_1 * vector_2,
vector_1 / vector_2, vector_1 %% vector_2, vector_1 %/% vector_2)
math_vectors_mx <- matrix(math_vectors,nrow=2,ncol=9,byrow=FALSE)

1:20
20:1

# reading csv files
nba <- read.csv('nba_2019_player_stats.csv',header=TRUE)
mlb <- read.csv('mlb_teams_data.csv',header=TRUE)
View(nba)
View(mlb)

# Dataframe -- HTML Workshop
first_6_rows <- head(nba) 
tail_3_rows <- head(mlb,3)
dimensions <- c('NBA:',dim(nba),'MLB:',dim(mlb))
nba_summary_stats <- summary(nba)
nba_data_structure <- str(nba)

# Data Manipulation
library(tidyverse)

# Selecting columns
mlb_wins <- select(mlb,team_name,wins,year)
nba_games <- select(nba,player,games,position,age)
all_but_ws <- select(mlb, -win_world_series)
range_col <- select(nba,player:age)

# matching columns
col_start <- head(select(nba, starts_with('three')))
col_end <- head(select(mlb, ends_with('allowed')))

col_contain <- head(select(nba, contains('started')))
col_match <- head(select(mlb, matches('three_pointers')))

# filters
good_passers <- filter(nba, assists > 100)
good_bos_scorers <- filter(nba, field_goals > 200, team %in% 'BOS',
                           player != 'Kyrie Irving')

# Pipe Operator
nba %>% select(player,games) %>% head

# Arrange or Re-order Rows
worst_scorers <- head(arrange(nba,field_goals))
best_scorers <- head(arrange(nba,-field_goals))

# Arranging Complex Code
mlb %>% select(team_name,wins,losses,year) %>% arrange(losses) %>% filter(wins>60) %>% head

# Mutate
nba %>% select(player,team,three_pointers,three_point_attempts) %>% 
  mutate(threes_percentage = three_pointers/three_point_attempts) %>% 
  arrange(-threes_percentage) %>% filter(three_point_attempts>100)

# Summaries
nba %>% summarize(avg_assist = mean(assists),
                  min_assist = min(assists),
                  max_assist = max(assists))

# Group Operators
nba %>% group_by(position) %>% summarize(avg_assist = mean(assists),
                                         min_assist = min(assists),
                                         max_assist = max(assists))

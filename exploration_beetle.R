
library(tidyverse)
library(here) 
library(tidylog) 
library(summarytools) 
library(knitr)
library(performance)
library(effects)


## Data 
beetle <- read_csv(here("datos/rawdata_bet.csv"))
glimpse(beetle)

beetle$YEAR<-as.factor(beetle$YEAR)


levels(factor(beetle$YEAR)) # 4 años
levels(factor(beetle$PLOT)) 
levels(factor(beetle$GENUS_SPECIES)) 


bet_sum<-beetle %>%
  group_by(PLOT, YEAR) %>%
  summarise(n_species = n(),
            ABUNDANCE = sum(ABUNDANCE))

bet_sum=bet_sum  %>%
  rename(plot=PLOT, year=YEAR, abundance= ABUNDANCE)
glimpse(bet_sum)
  
#write.csv(bet_sum, "C:/Users/estef/git/Beetles_MPM_ETT/data_clean/beetle_richness.csv")




library(tidyverse)
library(here) 
library(tidylog) 
library(summarytools) 
library(knitr)
library(performance)
library(effects)
library(ggplot2)
library(RColorBrewer)


## Data 
beetle <- read_csv(here("datos/rawdata_bet.csv"))
glimpse(beetle)

beetle$YEAR<-as.factor(beetle$YEAR)


levels(factor(beetle$YEAR)) # 4 años
levels(factor(beetle$PLOT)) 
levels(factor(beetle$GENUS_SPECIES)) 


bet_sum<-beetle %>%
  group_by(PLOT, YEAR) %>%
  summarise(n_species = n(),ABUNDANCE = sum(ABUNDANCE))%>%
  rename(plot=PLOT, year=YEAR, abundance= ABUNDANCE)


glimpse(bet_sum)
  
#write.csv(bet_sum, "C:/Users/estef/git/Beetles_MPM_ETT/data_clean/beetle_richness.csv")


# ¿cambia la riqueza de especies a lo largo del tiempo?
ggplot(bet_sum, aes(x = year,y = n_species)) +
  geom_point(color="blue")

mod_richness = lm(n_species ~ year, data = bet_sum)
summary(mod_richness)

modelbased::estimate_contrasts(mod_richness)
plot(allEffects(mod_richness))

performance::check_model(mod_richness)



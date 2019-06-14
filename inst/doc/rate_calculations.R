## ----include = FALSE-----------------------------------------------------
library(expstudies)
library(dplyr)
library(magrittr)
library(pander)

exposures <- addExposures(records)
head(exposures)

exposures_mod <- exposures %>% 
  inner_join(select(records, key, issue_age, gender), by = "key") %>%
  mutate(attained_age = issue_age + duration - 1)

## ---- results = "hide"---------------------------------------------------
head(exposures_mod)

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(head(exposures_mod), split.table = Inf)

## ---- results = "hide"---------------------------------------------------
exposures_mort <- exposures_mod %>% 
  group_by(key) %>% 
  mutate(exposure_mod = if_else(duration == max(duration), 1, exposure), 
         death_cnt = if_else(duration == max(duration), 1, 0)) 

tail(exposures_mort, 4)

## ---- results = "asis", echo = FALSE-------------------------------------
exposures_mort <- exposures_mort %>% ungroup() %>% select(-exposure, -issue_age)
pander::pandoc.table(tail(exposures_mort, 4), split.table = Inf)

## ---- results = "hide"---------------------------------------------------
duration_rate <- exposures_mort %>% 
  group_by(duration) %>% 
  summarise(q = sum(death_cnt)/sum(exposure_mod))

duration_rate

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(duration_rate)

## ---- results = "hide"---------------------------------------------------
attained_age_gender_rates <- exposures_mort %>% 
  group_by(attained_age, gender) %>% 
  summarise(q = sum(death_cnt)/sum(exposure_mod))

tail(attained_age_gender_rates)

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(tail(attained_age_gender_rates))

## ------------------------------------------------------------------------
summary(expstudies::mortality_tables)

## ---- results = "hide"---------------------------------------------------
head(mortality_tables$AM92$AM92_Ultimate)

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(head(mortality_tables$AM92$AM92_Ultimate))

## ---- results = "hide"---------------------------------------------------
head(left_join(exposures_mort, mortality_tables$AM92$AM92_Ultimate, by = "attained_age"))

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(head(left_join(exposures_mort, select(mortality_tables$AM92$AM92_Ultimate, -table), by = "attained_age")), split.table = Inf)


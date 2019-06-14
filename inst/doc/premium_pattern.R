## ----include = FALSE-----------------------------------------------------
library(expstudies)
library(dplyr)
library(magrittr)
library(pander)
library(tidyr)

## ---- results = "hide"---------------------------------------------------
exposures_PM <- addExposures(records, type = "PM")
head(exposures_PM)

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(head(exposures_PM))

## ---- results = "hide"---------------------------------------------------
head(trans)

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(head(trans))

## ---- results = "hide"---------------------------------------------------
trans_with_interval <- addStart(trans, exposures_PM)
head(trans_with_interval)

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(head(trans_with_interval))

## ---- results = "hide"---------------------------------------------------
trans_to_join <- trans_with_interval %>% group_by(start_int, key) %>% summarise(premium = sum(amt))
head(trans_to_join)

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(head(trans_to_join))

## ---- results = "hide"---------------------------------------------------
premium_study <- exposures_PM %>% left_join(trans_to_join, by = c("key", "start_int"))
head(premium_study, 10)

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(head(premium_study, 10))

## ---- results = "hide"---------------------------------------------------
premium_study <- premium_study %>% mutate(premium = if_else(is.na(premium), 0, premium))
head(premium_study, 10)

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(head(premium_study, 10))

## ---- results = "hide"---------------------------------------------------
premium_study %>% filter(policy_month %in% c(1,2)) %>% group_by(policy_month) %>% summarise(avg_premium = mean(premium))

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(premium_study %>% filter(policy_month %in% c(1,2)) %>% group_by(policy_month) %>% summarise(avg_premium = mean(premium)))

## ---- results = "hide"---------------------------------------------------
previous_premium_unfilled <- exposures_PM %>% left_join(trans_to_join, by = c("key", "start_int"))
head(previous_premium_unfilled)

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(head(previous_premium_unfilled))

## ---- results = "hide"---------------------------------------------------
previous_premium <- previous_premium_unfilled %>%
tidyr::fill(premium, .direction = "down")

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(head(previous_premium))


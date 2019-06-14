## ----include = FALSE-----------------------------------------------------
library(expstudies)
library(dplyr)
library(magrittr)
library(pander)

## ---- results = "hide"---------------------------------------------------
expstudies::records

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(records)

## ---- results = "hide"---------------------------------------------------
exposures <- addExposures(records)
head(exposures)

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(head(exposures))

## ---- results = "hide"---------------------------------------------------
exposures_PM <- addExposures(records, type = "PM")
head(exposures_PM)

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(head(exposures_PM))

## ---- results = "hide"---------------------------------------------------
exposures_PYCY <- addExposures(records, type = "PYCY")
head(exposures_PYCY)

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(head(exposures_PYCY))

## ---- results = "hide"---------------------------------------------------
exposures_PYCM <- addExposures(records, type = "PYCM")
head(exposures_PYCM, n = 15)

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(head(exposures_PYCM, n = 15))

## ---- results = "hide"---------------------------------------------------
exposures_PYCM <- addExposures(records, type = "PMCY")
head(exposures_PYCM, n = 11)

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(head(exposures_PYCM, n = 11))

## ---- results = "hide"---------------------------------------------------
exposures_PMCM <- addExposures(records, type = "PMCM")
head(exposures_PMCM)

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(head(exposures_PMCM))

## ---- results = "hide"---------------------------------------------------
exposures_PY_2016_to_2018 <- addExposures(records, type = "PY", lower_year = 2016, upper_year = 2018)
exposures_PY_2016_to_2018

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(exposures_PY_2016_to_2018)

## ---- results = "hide"---------------------------------------------------
exposures_PYCM_2019 <- addExposures(records, type = "PYCM", lower_year = 2019)
exposures_PYCM_2019

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(exposures_PYCM_2019)

## ------------------------------------------------------------------------
expSize(records, type = "PY")

## ------------------------------------------------------------------------
expSize(records, type = "PMCM", lower_year = 2015, upper_year = 2017)

## ---- results = "hide"---------------------------------------------------
exposures_mod <- exposures %>% inner_join(select(records, key, issue_age, gender), by = "key") %>%
  mutate(attained_age = issue_age + duration - 1)
head(exposures_mod)

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(head(exposures_mod), split.table = Inf)

## ---- results = "hide"---------------------------------------------------
head(addDays(records))

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(head(addDays(records)))

## ---- results = "hide"---------------------------------------------------
addDays(records, min_date = as.Date("2018-10-10"), max_date = as.Date("2018-10-12"))

## ---- results = "asis", echo = FALSE-------------------------------------
pander::pandoc.table(addDays(records, min_date = as.Date("2018-10-10"), max_date = as.Date("2018-10-12")))

## ------------------------------------------------------------------------
daySize(records, min_date = as.Date("2018-10-10"), max_date = as.Date("2018-10-12"))


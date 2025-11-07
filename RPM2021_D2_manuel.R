rm(list = ls())
library(tidyverse)
library(data.table)
library(readxl)
library(curl)

# niv_agreg_naf_rev_2 --------
RPM2021_D2_manuel <- read_xlsx("RPM2021_D2_manuel.xlsx", sheet = 1)

save(RPM2021_D2_manuel, file = "RPM2021_D2_manuel.RData")



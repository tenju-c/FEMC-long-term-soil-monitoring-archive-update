#####Forward--------------------------------------------------------
#Project: FEMC Long-Term Soil Monitoring Archive Update
#Task: Fix 2002 P_oxal and Mn_oxal zeroes
#Author: Tenju Cuddihy
#Date: 3/25/2026

###File Paths (Paths may need to be updated on other machines)------------------------------------------------------------------------------------
base <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Data/"
out  <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Output Data/"

###Load packages--------------------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr, readxl, readr)

###Read in dataframes--------------------------------------------------------
  chem <- read.csv(paste0(base, "tblCoreSoilChemistry.csv"))
  soil <- read_excel(paste0(base, "tblSoilSample.xlsx"), sheet = "final")
  

###Join dataframes for year data--------------------------------------------------------
chem_full <- chem %>%
  left_join(soil, by = c("fkSoilSampleID" = "pkSoilSampleID"))

###Find 2002 zeroes--------------------------------------------------------
p_zero_2002 <- chem_full %>%
  filter(fldYear == 2002, P_oxal == 0)

mn_zero_2002 <- chem_full %>%
  filter(fldYear == 2002, Mn_oxal == 0)

###Check for 2012 mn_oxal zeroes--------------------------------------------------------
mn_zero_2012 <- chem_full %>%
  filter(fldYear == 2012, Mn_oxal == 0)

###Combine into summary table--------------------------------------------------------
summary <- bind_rows(
  p_zero_2002 %>%
    mutate(field = "P_oxal", value = P_oxal),
  
  mn_zero_2002 %>%
    mutate(field = "Mn_oxal", value = Mn_oxal),
  
  mn_zero_2012 %>%
    mutate(field = "Mn_oxal", value = Mn_oxal)
) %>%
  select(fkSoilSampleID, enuLab, fldYear, field, value)

###Export summary as CSV--------------------------------------------------------
write.csv(summary, paste0(out, "review_oxalate_zeroes.csv"), row.names = FALSE)

###Create fix file (WAIT FOR APPROVAL)--------------------------------------------------------
fixes <- summary %>%
  mutate(
    old_value = value,
    new_value = -999
  ) %>%
  select(fkSoilSampleID, enuLab, field, old_value, new_value)

###Export fix file as CSV--------------------------------------------------------
write.csv(fixes, paste0(out, "fix_oxalate_zeroes.csv"), row.names = FALSE)


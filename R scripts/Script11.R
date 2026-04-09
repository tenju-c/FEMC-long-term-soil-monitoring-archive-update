#Project: FEMC Long-Term Soil Monitoring Archive Update
#Task: fldCollector backfill, make fix_fldCollector.csv 
#Author: Tenju Cuddihy
#Date: 4/6/2026

###File Paths (Paths may need to be updated on other machines)------------------------------------------------------------------------------------
base <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Data/"
out  <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Output Data/"

###Load packages--------------------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr, readxl)


###Read in dataframes--------------------------------------------------------
soil_sample <- read.csv(paste0(out, "insert_tblSoilSample.csv"))
plot_visit <- read.csv(paste0(out, "insert_tblPlotVisit.csv"))



###Join 2022 soil samples to 2022 plot visits to get fldCollector--------------------------------------------------------
fix_fldCollector <- soil_sample %>%
  left_join(
    plot_visit %>%
      select(fkSiteID, fkPlotID, fldYear, enuPurpose, fldCrew),
    by = c("fkSiteID", "fkPlotID", "fldYear", "enuPurpose")
  ) %>%
  mutate(
    fldCollector = ifelse(!is.na(fldCrew), fldCrew, fldCollector)
  ) %>%
  select(-fldCrew)  # drop plot_visit fldCrew after populating



###Export as a csv--------------------------------------------------------
write.csv(fix_fldCollector, paste0(out, "fix_fldCollector.csv"), row.names = FALSE)






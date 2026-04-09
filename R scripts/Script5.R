#####Forward------------------------------------------------------------------------------------
#Project: FEMC Long-Term Soil Monitoring Archive Update
#Task: Make New table for the citrate-dithionite extraction data from 2022 NRCS lab
#Author: Tenju Cuddihy
#Date: 3/25/2026


###File Paths (Paths may need to be updated on other machines)------------------------------------------------------------------------------------
base <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Data/"
out  <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Output Data/"

###Load packages------------------------------------------------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr, readxl, readr)

###Read in excel file
cd <- read_excel(paste0(base, "New Table for Citrate-Dithionite.xlsx"), sheet = "Sheet1")


###Check column names------------------------------------------------------------------------------------
names(cd)

###Drop helper columns------------------------------------------------------------------------------------
cd <- cd %>%
  select(
    -FldNRCSlbl, -`...7`, -lay_field_label1, -lay_field_label2,
    -`...10`, -Year, -Site, -Plot, -Quadrant, -FldBagID
  )

###Rename columns------------------------------------------------------------------------------------
cd <- cd %>%
  select(
    fkSoilSampleID,
    enuLab,
    `Dithionite-Citrate Fe %`,
    `Dithionite-Citrate Al %`,
    `Dithionite-Citrate Mn %`
  ) %>%
  rename(
    fldFe_pct = `Dithionite-Citrate Fe %`,
    fldAl_pct = `Dithionite-Citrate Al %`,
    fldMn_pct = `Dithionite-Citrate Mn %`
  )


###FK validation------------------------------------------------------------------------------------
insert <- read.csv(paste0(out, "insert_tblSoilSample.csv"))


invalid_ids <- cd %>%
  filter(!fkSoilSampleID %in% insert$pkSoilSampleID)

nrow(invalid_ids)      # should be 0
invalid_ids



###Validate enuLab------------------------------------------------------------------------------------
unique(cd$enuLab)


###Confirm row count------------------------------------------------------------------------------------
nrow(cd)

###Export as a CSV------------------------------------------------------------------------------------
write.csv(cd, paste0(out, "insert_tblSoilCitrateDithionite.csv"), row.names = FALSE)







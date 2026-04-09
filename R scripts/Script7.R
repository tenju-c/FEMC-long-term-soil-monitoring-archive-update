#####Forward--------------------------------------------------------
#Project: FEMC Long-Term Soil Monitoring Archive Update
#Task: Fix existing horizon labels (Samples 1756-1782)
#Author: Tenju Cuddihy
#Date: 3/25/2026


###File Paths (Paths may need to be updated on other machines)------------------------------------------------------------------------------------
base <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Data/"
out  <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Output Data/"

###Load packages---------------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr, readxl, readr)


###Read in soil sample dataframe-------------------------------------
soil <- read_excel(paste0(base, "tblSoilSample.xlsx"), sheet = "final")


###Define affected IDs-----------------------------------------------
oa_ids <- c(1756, 1759, 1762, 1765, 1768, 1772, 1774, 1776, 1779, 1782)
oe_id  <- 1781

###Pull affected rows------------------------------------------------
subset_rows <- soil %>%
  filter(pkSoilSampleID %in% c(oa_ids, oe_id))

###Check for incorrect pulled rows-----------------------------------
subset_rows %>%
  select(pkSoilSampleID, fkSiteID, fldYear, enuSampleType, fldBagID)

###Create before and after values------------------------------------
fixes <- subset_rows %>%
  mutate(
    fldBagID_old = fldBagID,
    
    fldBagID_new = case_when(
      # Oa → Oa/A fixes
      pkSoilSampleID %in% oa_ids ~ sub("-Oa$", "-Oa/A", fldBagID),
      
      # Oe → Oi/Oe fix
      pkSoilSampleID == oe_id ~ sub("-Oe$", "-Oi/Oe", fldBagID),
      
      TRUE ~ fldBagID
    )
  ) %>%
  select(pkSoilSampleID, fldBagID_old, fldBagID_new)


###See changes-------------------------------------------------------
fixes

###Export review file as a CSV---------------------------------------
write.csv(fixes, paste0(out, "fix_tblSoilSample_FH_2017.csv"), row.names = FALSE)



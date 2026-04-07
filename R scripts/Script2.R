#####Forward------------------------------------------------------------------------------------
#Project: FEMC Long-Term Soil Monitoring Archive Update
#Task: Make tblCoreSoilChemistry 2022 insert 
#Author: Tenju Cuddihy
#Date: 3/24/2026


###File Paths------------------------------------------------------------------------------------
base <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Data/"
out  <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Output Data/"

###Load packages------------------------------------------------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr, readxl, readr)

###Import dataframes------------------------------------------------------------------------------------
chem2022 <- read_excel(paste0(base, "TblCoreSoilChemistry2022(updated1-21-26).xlsx"), sheet = "final")
soil_insert <- read.csv(paste0(out, "insert_tblSoilSample.csv"))

###Drop helper columns------------------------------------------------------------------------------------
chem2022 <- chem2022 %>%
  select(-Year, -Site, -Plot, -Quadrant, -FldBagID, -FldNRCSlbl)

###Confirm fkSoilSampleIDs in 2022 chemistry data exist in soil insert------------------------------------------------------------------------------------
missing_ids <- setdiff(chem2022$fkSoilSampleID, soil_insert$pkSoilSampleID)

  # To see # of missing IDs: 
      length(missing_ids)  
  # Shows any missing IDs: 
      missing_ids         

###Validate enuLab values------------------------------------------------------------------------------------
unique(chem2022$enuLab)

  #To see which invalid lab values: 
    invalid_lab <- chem2022 %>%
    filter(!enuLab %in% c("NRCS", "USFS"))
  
  # To see number of rows with invalid lab: 
    invalid_lab  # Should be 0 rows


###Reorder lab IDs in chronological order------------------------------------------------------------------------------------
chem2022 <- chem2022 %>%
  arrange(fkSoilSampleID, enuLab)


###Make sure columns are in the correct order------------------------------------------------------------------------------------
chem2022_clean <- chem2022 %>%
  select(
    fkSoilSampleID, enuLab, TotalC, TotalN, TOtalS, ODOE, Fe_oxal, Al_oxal, Mn_oxal, Si_oxal, P_oxal,
    Fe_pyro, Al_pyro, Mn_pyro, Ca_exch, Mg_exch, K_exch, Na_exch, Al_exch, Fe_exch, Mn_exch,
    CEC_nh4, pH_salt, pH_water, Hg
  )


###Export as a CSV------------------------------------------------------------------------------------
write.csv(chem2022_clean, paste0(out, "insert_tblCoreSoilChemistry.csv"), row.names = FALSE)   



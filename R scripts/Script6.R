#####Forward------------------------------------------------------------------------------------
#Project: FEMC Long-Term Soil Monitoring Archive Update
#Task: Make tblLabMethods insert
#Author: Tenju Cuddihy
#Date: 3/25/2026


###File Paths------------------------------------------------------------------------------------
base <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Data/"
out  <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Output Data/"

###Load packages------------------------------------------------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr, tibble)

###Build dataframe------------------------------------------------------------------------------------
lab_methods <- tibble(
  enuLab = c(
    "NRCS",
    "NRCS",
    "NRCS",
    "NRCS",
    "UVM",
    "NRCS",
    "USFS",
    "USFS"
  ),
  
  fldYear = c(
    "2022",
    "2022",
    "2022",
    "all",
    "2002",
    "all",
    "all",
    "2022"
  ),
  
  fldAnalyte = c(
    "Fe_pyro / Al_pyro / Mn_pyro",
    "Fe_cd / Al_cd / Mn_cd",
    "CEC_nh4",
    "pH_salt",
    "pH_water",
    "Hg_NRCS",
    "Hg_USFS",
    "Ca_exch / Mg_exch / K_exch / Na_exch / Al_exch / Fe_exch / Mn_exch"
  ),
  
  fldMethodDescription = c(
    "Pyrophosphate extraction discontinued by NRCS lab after 2017. Replaced by citrate-dithionite (see tblSoilCitrateDithionite). Results are not comparable.",
    
    "Citrate-dithionite extraction introduced 2022 as NRCS replacement for pyrophosphate. Stronger extractant - values not comparable to Fe_pyro/Al_pyro/Mn_pyro or oxalate fractions. Stored in tblSoilCitrateDithionite.",
    
    "Ammonium acetate CEC method. Only run on 2002 samples. Considered archaic; no plans to continue. Values in prior years should not be compared to other CEC methods.",
    
    "KCl salt pH. Never run on any samples. Column retained in schema for completeness.",
    
    "Water pH run on 2002 UVM samples only. Inconsistent results across years noted; Don recommends running all archived samples simultaneously if ever revisited.",
    
    "Mercury data removed from tblCoreSoilChemistry. Hg measured on one horizon per pit (Oa or A) only; stored in standalone Mercury dataset in archive.",
    
    "Mercury data removed from tblCoreSoilChemistry. Hg measured on one horizon per pit (Oa or A) only; stored in standalone Mercury dataset in archive.",
    
    "Exchangeable cations in 2022 analyzed by USFS lab. Prior years used UVM lab. Methods confirmed comparable via cross-validation; values can be used in time series."
  ),
  
  fldQuantificationLevel = NA
)

###Export as a CSV------------------------------------------------------------------------------------
write.csv(lab_methods, paste0(out, "insert_tblLabMethods.csv"), row.names = FALSE)



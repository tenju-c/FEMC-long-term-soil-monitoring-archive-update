#Project: FEMC Long-Term Soil Monitoring Archive Update
#Task: Backfill historical tbsSoilSample 
#Author: Tenju Cuddihy
#Date: 4/8/2026

###File Paths (Paths may need to be updated on other machines)------------------------------------------------------------------------------------
base <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Data/"
out  <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Output Data/"

### Load packages --------------------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr, readxl, writexl)

### Read in dataframe ----------------------------------------------------
historicalSoil <- read_excel(paste0(base, "tblSoilSample.xlsx"), sheet = "final")

### Backfill horizon codes in historical soils dataframe ----------------
# Clean historical tblSoil by removing last 3 columns
historicalSoil <- historicalSoil[, 1:(ncol(historicalSoil) - 4)]

# Populate horizon column using fldBagID for D samples
extract_horizon <- function(bagid) {
  if (is.na(bagid)) return(NA)
  parts <- unlist(strsplit(as.character(bagid), "-"))
  if (length(parts) <= 4) return(NA)  # nothing after 4th dash
  paste(parts[5:length(parts)], collapse = "-")
}

# Apply to all samples
historicalSoil$fldLayerType <- sapply(historicalSoil$fldBagID, extract_horizon)

### Save back to Excel ----------------------------------------
write_xlsx(historicalSoil, paste0(out, "tblSoilSample_updated.xlsx"))
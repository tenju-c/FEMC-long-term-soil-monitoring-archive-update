#####Forward------------------------------------------------------------------------------------
#Project: FEMC Long-Term Soil Monitoring Archive Update
#Task: Make tblSoilSample 2022 insert
#Author: Tenju Cuddihy
#Date: 3/24/2026


###File Paths (Paths may need to be updated on other machines)------------------------------------------------------------------------------------
base <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Data/"
out  <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Output Data/"

###Load in packages------------------------------------------------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr, readxl, readr)

###Import dataframes------------------------------------------------------------------------------------
soil2022 <- read_excel(paste0(base, "tblSoilSample2022.xlsx"), sheet = "for database")
soilDB <- read_excel(paste0(base, "tblSoilSample.xlsx"), sheet = "final")

###Check data------------------------------------------------------------------------------------
  #Check range
  range(soil2022$pkSoilSampleID, na.rm = TRUE)
  
  #Check for duplicates
  any(duplicated(soil2022$pkSoilSampleID))
  
  #Confirm number of rows
  nrow(soil2022)
  
  #Check for overlaps between new and old data (soilDB)
  overlap <- intersect(soil2022$pkSoilSampleID, soilDB$pkSoilSampleID)

###Validate fkQuadrantID------------------------------------------------------------------------------------
  #Show existing quadrant IDs
    unique(soil2022$fkQuadrantID)
    
  #Show which values are invalid
    invalid_quadrants <- soil2022 %>%
      filter(!fkQuadrantID %in% c("NE", "NW", "SE", "SW"))
    
    invalid_quadrants

###Manipulate dataframe------------------------------------------------------------------------------------  
  #Clean historical tblSoilSample
  soilDB <- soilDB[, 1:(ncol(soilDB) - 3)]
    
  #Clean 2022 tblSoilSample
  soil2022 <- soil2022[, 1:(ncol(soil2022) - 1)]
  
  #Make sure to set fldCollector to NA
  soil2022$fldCollector <- NA
    
  #Populate horizon column
    extract_horizon <- function(bagid) {
      if (is.na(bagid)) return(NA)
      parts <- unlist(strsplit(as.character(bagid), "-"))
      if (length(parts) <= 4) return(NA)  # nothing after 4th dash
      paste(parts[5:length(parts)], collapse = "-")
    }
    
    # Apply to all D samples, leave H samples as N/A
    soil2022$fldLayerType <- sapply(soil2022$fldBagID, extract_horizon)

  #Make sure columns are in the correct order
  soil2022_clean <- soil2022 %>%
    select(
      pkSoilSampleID,
      fkSiteID,
      fkPlotID,
      fkQuadrantID,
      fldYear,
      enuPurpose,
      enuSampleType,
      fldBagID,
      fldUVMLabID,
      fldNRCSLabID,
      fldUSFSLabID,
      fldCollector,
      NRCSNASISPhiid,
      fldLayerType
    )

###Export as a CSV------------------------------------------------------------------------------------
write.csv(soil2022_clean, paste0(out, "insert_tblSoilSample.csv"), row.names = FALSE)


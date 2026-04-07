#####Forward------------------------------------------------------------------------------------
#Project: FEMC Long-Term Soil Monitoring Archive Update
#Task: Make tblSoilSample 2022 insert
#Author: Tenju Cuddihy
#Date: 3/24/2026


###File Paths------------------------------------------------------------------------------------
base <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Data/"
out  <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Output Data/"

###Load in packages------------------------------------------------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr, readxl, readr)

###Import dataframes------------------------------------------------------------------------------------
soil2022 <- read_excel(paste0(base, "tblSoilSample2022.xlsx"), sheet = "for database")
soilDB <- read.csv(paste0(base, "tblSoilSample.csv"))

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
  #Make sure to set fldCollector to NA
  soil2022$fldCollector <- NA
    
  #Add horizon column
    extract_horizon <- function(bagid, sample_type) {
      if (sample_type != "D") return(NA)
      parts <- strsplit(bagid, "-")[[1]]
      if (length(parts) < 5) return(NA)
      paste(parts[5:length(parts)], collapse = "-")
    }
    
    soil2022$Horizon <- mapply(extract_horizon, soil2022$fldBagID, soil2022$enuSampleType)
  
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
      fldNRCSLabID,
      fldUSFSLabID,
      fldCollector, 
      Horizon
    )

###Export as a CSV------------------------------------------------------------------------------------
write.csv(soil2022_clean, paste0(out, "insert_tblSoilSample.csv"), row.names = FALSE)



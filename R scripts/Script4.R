#####Forward------------------------------------------------------------------------------------
#Project: FEMC Long-Term Soil Monitoring Archive Update
#Task: Make New tblSoilParticleSize table
#Author: Tenju Cuddihy
#Date: 3/25/2026


###File Paths------------------------------------------------------------------------------------
base <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Data/"
out  <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Output Data/"

###Load packages------------------------------------------------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr, readxl, readr)

###read in excel file------------------------------------------------------------------------------------
psize <- read_excel(paste0(base, "New_Table_for_Particle_Size.xlsx"), sheet = "for database")

###Make sure columns match DDL------------------------------------------------------------------------------------
psize <- psize %>%
  rename(
    fkSoilSampleID = pkSoilSampleID,
    fldClay = Clay,
    fldSilt = Silt,
    fldSand = Sand,
    fldFineSilt = `Fine-silt`,
    fldCoarseSilt = `Coarse-silt`,
    fldVeryFineSand = `very-fine-sand`,
    fldFineSand = `fine-sand`,
    fldMediumSand = `medium-sand`,
    fldCoarseSand = `coarse-sand`,
    fldVeryCoarseSand = `very-coarse-sand`
  )

###Fk Validation------------------------------------------------------------------------------------
  #read in sources
  existing <- read.csv(paste0(base, "tblSoilSample(in).csv"))
  insert <- read.csv(paste0(out, "insert_tblSoilSample.csv"))
  
  
  #Check where IDs exist
  in_existing <- psize$fkSoilSampleID %in% existing$pkSoilSampleID
  in_insert   <- psize$fkSoilSampleID %in% insert$pkSoilSampleID
  
  table(in_existing, in_insert)
  

  #Flag bad IDs
  invalid_ids <- psize %>%
    filter(!fkSoilSampleID %in% c(existing$pkSoilSampleID,
                                  insert$pkSoilSampleID))
  
  invalid_ids
  
  
###Ensure correct column order------------------------------------------------------------------------------------
  psize_clean <- psize %>%
    select(
      fkSoilSampleID,
      fldClay,
      fldSilt,
      fldSand,
      fldFineSilt,
      fldCoarseSilt,
      fldVeryFineSand,
      fldFineSand,
      fldMediumSand,
      fldCoarseSand,
      fldVeryCoarseSand
    )

  ###Export as a CSV------------------------------------------------------------------------------------
  write.csv(psize_clean, paste0(out, "insert_tblSoilParticleSize.csv"), row.names = FALSE)



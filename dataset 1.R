#The purpose of this script is to deliver dataset 1, which comprises of all 2022 soils data

#Load in packages
library(tidyverse)
library(dplyr)    # for joins
library(readr)    # for reading/writing CSVs
library(janitor)  # for cleaning column names


#Read in files that include 2022 data
ParticleSizeFull <- read_csv("Input Data/New Table for Particle Size(with plot identifiers).csv")
CoreSoilChemistry2022 <- read_csv("Input Data/TblCoreSoilChemistry2022(updated1-21-26)(final).csv")
SoilSampleForDatabase2022 <- read_csv("Input Data/tblSoilSample2022(for database).csv")


#View column names for the above dataframes
names(ParticleSizeFull)
names(CoreSoilChemistry2022)
names(SoilSampleForDatabase2022)


#Make ParticleSize2022 from ParticleSizeFull
ParticleSizeFull <- ParticleSizeFull %>%     #Rename column 1 to year
  rename(Year = 1)
ParticleSize2022 <- ParticleSizeFull %>%     #Make new dataframe with only 2022 data for particle size
  filter(Year == 2022)
ParticleSize2022 <- ParticleSize2022 %>%     #Removing empty columns in this dataframe
  select(where(~ !all(is.na(.))))

#Use soil sample IDs to join all of the 2022 dataframes
    #Starting by standardizing name for soil sample ID across the three dataframes
    
    ParticleSize2022 <- ParticleSize2022 %>% rename(soil_sample_ID = pkSoilSampleID...7)
    SoilSampleForDatabase2022 <- SoilSampleForDatabase2022 %>% rename(soil_sample_ID = pkSoilSampleID)
    CoreSoilChemistry2022 <- CoreSoilChemistry2022 %>% rename(soil_sample_ID = fkSoilSampleID)
    
    #Next, left join the three dataframes
    soil2022_full <- SoilSampleForDatabase2022 %>%
      left_join(ParticleSize2022, by = "soil_sample_ID") %>%
      left_join(CoreSoilChemistry2022, by = "soil_sample_ID")
    
    names(soil2022_full)














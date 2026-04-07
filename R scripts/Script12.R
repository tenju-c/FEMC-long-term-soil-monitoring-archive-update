#Project: FEMC Long-Term Soil Monitoring Archive Update
#Task: Make tblHorizonCodes 
#Author: Tenju Cuddihy
#Date: 4/6/2026

###File Paths------------------------------------------------------------------------------------
base <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Data/"
out  <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Output Data/"


# Create dataframe with DDL-specified columns
tblHorizonCodes <- data.frame(
  fldHorizonCode = c("Oi/Oe", "Oa/A", "top10cmB", "60/70cm", "E"),  # code
  fldSampleType  = c("D", "D", "D", "D", "D"),                        # H or D
  fldDescription = c(
    "Litter and fermentation layer (placeholder)", 
    "Combined organic/mineral top layer (placeholder)", 
    "Top 10 cm of B horizon (placeholder)", 
    "60-70 cm deep sample (placeholder)", 
    "E horizon (placeholder)"
  ),
  fldNotes       = c("", "", "", "", "")  # leave notes empty for now
)

# Optional: preview the table
tblHorizonCodes

# Save as CSV to populate later when Don's definitions arrive
write.csv(tblHorizonCodes, paste0(out, "tblHorizonCodes_lookup.csv"), row.names = FALSE)


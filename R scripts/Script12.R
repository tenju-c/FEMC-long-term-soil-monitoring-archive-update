#Project: FEMC Long-Term Soil Monitoring Archive Update
#Task: Make tblHorizonCodes 
#Author: Tenju Cuddihy
#Date: 4/6/2026

###File Paths (Paths may need to be updated on other machines)------------------------------------------------------------------------------------
base <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Data/"
out  <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Output Data/"


# Create dataframe with DDL-specified columns
tblHorizonCodes <- data.frame(
  fldBagID_suffix = c(
    "Oi/Oe","Oi","Oe",
    "Oa/A","Oa","A","Oa1/Oa2",
    "top10cmB","top 10 cm B",
    "60/70cm","60-70 cm Cd","60-70 cm Bw2","60-70 cm Bw/Cd",
    "60-70 cm Bw2/Bw3","60-70 cm Bw3","60-70 cm C",
    "60-70 cm Bw2/C","60-70 cm Bw2/Cd","60-70 cm Bw3/C",
    "60-70 cm Bwb2","60-70 cm Bwb3/Cd","60-70 cm Cd2",
    "60-70 cm Bs2/Cd","60-70 cm",
    "E","E1","E2",
    "7cm"
  ),
  
  fldLayerType = c(
    "Oi/Oe","Oi/Oe","Oi/Oe",
    "Oa/A","Oa/A","Oa/A","Oa/A",
    "top10cmB","top10cmB",
    "60-70cm","60-70cm","60-70cm","60-70cm",
    "60-70cm","60-70cm","60-70cm",
    "60-70cm","60-70cm","60-70cm",
    "60-70cm","60-70cm","60-70cm",
    "60-70cm","60-70cm",
    "E","E","E",
    NA
  ),
  
  fldSampleType = rep("D", 28),
  
  fldDescription = c(
    "Combined Oi and Oe organic horizons",
    "Oi only; maps to Oi/Oe",
    "Oe only; maps to Oi/Oe",
    
    "Combined Oa and A horizons",
    "Oa only; maps to Oa/A",
    "A only; maps to Oa/A",
    "Multiple Oa sub-horizons; maps to Oa/A",
    
    "Top 10 cm of B horizon",
    "Top 10 cm of B horizon (format variant)",
    
    "60-70 cm depth sample",
    "60-70 cm depth; Cd horizon",
    "60-70 cm depth; Bw2 horizon",
    "60-70 cm depth; Bw/Cd transitional",
    "60-70 cm depth; Bw2/Bw3 transitional",
    "60-70 cm depth; Bw3 horizon",
    "60-70 cm depth; C horizon",
    "60-70 cm depth; Bw2/C transitional",
    "60-70 cm depth; Bw2/Cd transitional",
    "60-70 cm depth; Bw3/C transitional",
    "60-70 cm depth; buried Bw2",
    "60-70 cm depth; buried Bw3/Cd",
    "60-70 cm depth; Cd2 horizon",
    "60-70 cm depth; Bs2/Cd transitional",
    "60-70 cm depth; no horizon designation",
    
    "E horizon",
    "E1 sub-horizon; maps to E",
    "E2 sub-horizon; maps to E",
    
    "Unresolved depth sample (likely typo; needs review)"
  ),
  
  fldNotes = c(
    "Confirmed","Proposed","Proposed",
    "Confirmed","Needs Don","Needs Don","Proposed",
    "Confirmed","Confirmed",
    "Confirmed","Confirmed","Confirmed","Confirmed",
    "Confirmed","Confirmed","Confirmed",
    "Confirmed","Confirmed","Confirmed",
    "Confirmed","Confirmed","Confirmed",
    "Confirmed","Confirmed",
    "Confirmed","Confirmed","Confirmed",
    "Needs Don: likely typo (Don says maps to top10cmB)"
  )
)

# Optional: preview the table
tblHorizonCodes

# Save as CSV to populate later when Don's definitions arrive
write.csv(tblHorizonCodes, paste0(out, "tblHorizonCodes_lookup.csv"), row.names = FALSE)


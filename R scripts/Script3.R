#####Forward------------------------------------------------------------------------------------
#Project: FEMC Long-Term Soil Monitoring Archive Update
#Task: Make tblSamplingSchedule 2017 + 2022 insert
#Author: Tenju Cuddihy
#Date: 3/24/2026


###Load packages------------------------------------------------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr, readxl, readr)

###Import dataframes------------------------------------------------------------------------------------
schedule <- read_excel("TblSamplingSchedule2017-2022.xlsx", sheet = "2017-2022")
existing <- read.csv("tblSamplingSchedule.csv")


###Confirm columns match DB schema------------------------------------------------------------------------------------
expected_cols <- c("fkSiteID", "fkPlotID", "fkQuadrantID", "fldSampleYear", "fldNotes")

setdiff(expected_cols, names(schedule))   # should be empty
setdiff(names(schedule), expected_cols)   # should be empty

###Confirm no overlap with existing data------------------------------------------------------------------------------------
overlap <- inner_join(
  schedule,
  existing,
  by = c("fkSiteID", "fkPlotID", "fkQuadrantID", "fldSampleYear")
)

nrow(overlap)   # should be 0
overlap         # to see which overlap exists

###export as a CSV------------------------------------------------------------------------------------
write.csv(schedule, "insert_tblSamplingSchedule.csv", row.names = FALSE)



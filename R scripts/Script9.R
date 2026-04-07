#####Forward--------------------------------------------------------
#Project: FEMC Long-Term Soil Monitoring Archive Update
#Task: Make tblSiteVisit insert
#Author: Tenju Cuddihy
#Date: 4/6/2026

###File Paths------------------------------------------------------------------------------------
base <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Data/"
out  <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Output Data/"

###Load packages--------------------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr, readxl, stringr)

###Read in dataframes--------------------------------------------------------
visits <- read_excel(paste0(base, "TblSiteVisit-revised2026.xlsx"))

###Check column names--------------------------------------------------------
names(visits)

###Filter to 2022 only--------------------------------------------------------
visits_2022 <- visits %>%
  filter(fldYear == 2022, enuPurpose == "soil")

###Identify target sites--------------------------------------------------------
target_sites <- c("LR", "LT", "PD", "RB", "FH")

###Clean text fields--------------------------------------------------------
visits_2022 <- visits_2022 %>%
  mutate(
    fldCrew = str_trim(fldCrew),
    fldComments = str_trim(fldComments),
    fldCrew = na_if(fldCrew, ""),
    fldComments = na_if(fldComments, "")
  )

###Format dates--------------------------------------------------------
visits_2022 <- visits_2022 %>%
  mutate(
    fldStartDate = as.character(as.Date(fldStartDate)),
    fldEndDate   = as.character(as.Date(fldEndDate))
  )

###Assign and validate--------------------------------------------------------
visits_final <- visits_2022


  # row count
  if (nrow(visits_final) != 5) {
    stop("ERROR: Must have exactly 5 rows")
  }
  
  # unique sites
  if (any(duplicated(visits_final$fkSiteID))) {
    stop("ERROR: Duplicate site IDs found")
  }
  
  # correct sites
  expected_sites <- c("FH","LR","LT","PD","RB")
  if (!all(sort(visits_final$fkSiteID) == expected_sites)) {
    stop("ERROR: Site IDs do not match expected set")
  }
  
  # year check
  if (!all(visits_final$fldYear == 2022)) {
    stop("ERROR: Non-2022 rows detected")
  }
  
  # purpose check
  if (!all(visits_final$enuPurpose == "soil")) {
    stop("ERROR: Non-soil rows detected")
  }

###Export as csv--------------------------------------------------------
write.csv(visits_final, paste0(out, "insert_tblSiteVisit.csv"), row.names = FALSE)

write.csv(visits_final,"insert_tblSiteVisit.csv", row.names = FALSE)



#####Forward--------------------------------------------------------
#Project: FEMC Long-Term Soil Monitoring Archive Update
#Task: Make tblPlotVisit insert
#Author: Tenju Cuddihy
#Date: 4/6/2026

###File Paths (Paths may need to be updated on other machines)------------------------------------------------------------------------------------
base <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Data/"
out  <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/Output Data/"

###Load packages--------------------------------------------------------
if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr, readxl)

###Read in dataframes--------------------------------------------------------
soil_sample <- read.csv(paste0(out, "insert_tblSoilSample.csv"))


###Extract unique site+plot combinations--------------------------------------------------------
  unique_combos <- soil_sample %>%
    distinct(fkSiteID, fkPlotID)

###Set constant columns for 2022 soil visits--------------------------------------------------------
  plot_visit_2022 <- unique_combos %>%
    mutate(
      fkQuadrantID = NA,  # no quadrant info
      fldYear = 2022,
      enuPurpose = "soil"
    )


###Join crew info from tblSiteVisit--------------------------------------------------------
  site_visit <- read.csv(paste0(out, "insert_tblSiteVisit.csv")) 

  #remove duplicate columns before joining, then join
  site_visit_clean <- site_visit %>%
    select(-fldYear, -enuPurpose)
  
  plot_visit_2022 <- plot_visit_2022 %>%
    left_join(site_visit_clean, by = "fkSiteID")

###Reorder the columns--------------------------------------------------------
  final_order <- c("fkSiteID", "fkPlotID", "fldYear", "enuPurpose",
                   "fkQuadrantID", "fldStartDate", "fldEndDate",
                   "fldComments", "fldCrew")
  
  plot_visit_2022 <- plot_visit_2022 %>%
    select(all_of(final_order))


###Check the result--------------------------------------------------------
  nrow(plot_visit_2022)      # should be 50
  head(plot_visit_2022)
  
  #Check to see if schema matches the historical version
  historical_plot_visit <- read.csv(paste0(base, "tblPlotVisit.csv"))

  all(names(plot_visit_2022) == names(historical_plot_visit))
  
###Export as a csv--------------------------------------------------------
write.csv(plot_visit_2022, paste0(out, "insert_tblPlotVisit.csv"), row.names = FALSE)
  
  










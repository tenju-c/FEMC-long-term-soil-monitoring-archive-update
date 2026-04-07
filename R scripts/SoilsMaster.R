#####Forward------------------------------------------------------------------------------------
#Project: FEMC Long-Term Soil Monitoring Archive Update
#Task: Runs all project scripts in sequential order
#Author: Tenju Cuddihy
#Date: 3/25/2026


###File Path------------------------------------------------------------------------------------
project <- "J:/Projects/Sprint Projects/FEMC-long-term-soil-monitoring-archive-update/"

###Configuration -----------------------------------------------------------

n_scripts <- 12  # to be updated


###Run Scripts -------------------------------------------------------------

for (i in 1:n_scripts) {
  
  script_name <- paste0(project, "R scripts/Script", i, ".R")
  message("Running ", script_name, " ...")
  
  source(script_name)
  
  message(script_name, " complete.")
  
}


###Done --------------------------------------------------------------------

message("All scripts complete.")

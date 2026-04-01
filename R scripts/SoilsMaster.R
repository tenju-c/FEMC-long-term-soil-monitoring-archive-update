#####Forward------------------------------------------------------------------------------------
#Project: FEMC Long-Term Soil Monitoring Archive Update
#Task: Runs all project scripts in sequential order
#Author: Tenju Cuddihy
#Date: 3/25/2026

###Configuration -----------------------------------------------------------

n_scripts <- 7  # to be updated


###Run Scripts -------------------------------------------------------------

for (i in 1:n_scripts) {
  
  script_name <- paste0("R scripts/Script", i, ".R")
  message("Running ", script_name, " ...")
  
  source(script_name)
  
  message(script_name, " complete.")
  
}


###Done --------------------------------------------------------------------

message("All scripts complete.")

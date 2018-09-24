library(tidyverse)
library(readxl)

# importing lifetime heroin use data for 2010/11 - 2015/16

lt_heroin_1011_data <- read_excel("C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/data/raw/LifetimeHeroin_state_2010-16.xlsx", 
                             sheet = "HeroinLT_state1011")

lt_heroin_1213_data <- read_excel("C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/data/raw/LifetimeHeroin_state_2010-16.xlsx", 
                                  sheet = "HeroinLT_state1213")

lt_heroin_1415_data <- read_excel("C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/data/raw/LifetimeHeroin_state_2010-16.xlsx", 
                                  sheet = "HeroinLT_state1415")

lt_heroin_1516_data <- read_excel("C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/data/raw/LifetimeHeroin_state_2010-16.xlsx", 
                                  sheet = "HeroinLT_state1516")

heroin_list <- list(lt_heroin_1011_data, lt_heroin_1213_data, lt_heroin_1415_data, lt_heroin_1516_data)


for (i in 1:length(heroin_list)) {
  heroin_list[[i]] <- janitor::clean_names(heroin_list[[i]])
}

 

lt_heroin_2011_data <- lt_heroin_2011_data %>%
  filter(!state_fips_code_numeric %in% c("Overall", "11 - District of Columbia"),
         heroin_ever_used == "Overall") %>%
  separate(state_fips_code_numeric, c("fips_code", "state"),
           sep = "-") %>%
  select(fips_code, state, use_est = row_percent, use_se = row_percent_se)

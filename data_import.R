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

# changing heroin ever use names for 1415 and 1516 data

lt_heroin_1415_data <- lt_heroin_1415_data %>% rename("HEROIN EVER USED" = "EVER USED HEROIN")
lt_heroin_1516_data <- lt_heroin_1516_data %>% rename("HEROIN EVER USED" = "EVER USED HEROIN")

# creating year variable

lt_heroin_1011_data <- lt_heroin_1011_data %>% 
  mutate(year = "2011")
lt_heroin_1213_data <- lt_heroin_1213_data %>% 
  mutate(year = "2013")
lt_heroin_1415_data <- lt_heroin_1415_data %>% 
  mutate(year = "2015")
lt_heroin_1516_data <- lt_heroin_1516_data %>% 
  mutate(year = "2016")

# putting datasets into a list called heroin_list

heroin_list <- list(lt_heroin_1011_data, lt_heroin_1213_data, lt_heroin_1415_data, lt_heroin_1516_data)

# cleaning names

for (i in 1:length(heroin_list)) {
  heroin_list[[i]] <- janitor::clean_names(heroin_list[[i]])
}

# cleaning data

for (i in 1:length(heroin_list)) {
  heroin_list[[i]] <- heroin_list[[i]] %>% 
    filter(!state_fips_code_numeric %in% c("Overall", "11 - District of Columbia"),
           heroin_ever_used == "Overall") %>%
    separate(state_fips_code_numeric, c("fips_code", "state"),
             sep = "-") %>%
    select(fips_code, state, use_est = row_percent, use_se = row_percent_se, year)
}



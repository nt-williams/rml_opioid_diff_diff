
library(tidyverse)

# CLEANING LIFETIME HEROIN USE
# changing heroin ever use names for 1415 and 1516 data

lt_heroin_1415_data <- lt_heroin_1415_data %>% rename("HEROIN EVER USED" = "EVER USED HEROIN")
lt_heroin_1516_data <- lt_heroin_1516_data %>% rename("HEROIN EVER USED" = "EVER USED HEROIN")

# stacking data frames

lt_heroin_data <- bind_rows(lt_heroin_1011_data, 
                            lt_heroin_1213_data, 
                            lt_heroin_1415_data, 
                            lt_heroin_1516_data)

# cleaning names

lt_heroin_data <- janitor::clean_names(lt_heroin_data)

# cleaning data

lt_heroin_data <- lt_heroin_data %>%
  filter(
    !state_fips_code_numeric %in% c("Overall", "11 - District of Columbia"),
    heroin_ever_used == "Overall"
  ) %>%
  separate(state_fips_code_numeric, c("fips_code", "state"),
           sep = "-") %>%
  select(fips_code, state, use_est = row_percent, use_se = row_percent_se, year)

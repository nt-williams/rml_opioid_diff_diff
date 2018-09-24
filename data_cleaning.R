
library(tidyverse)

# CLEANING LIFETIME HEROIN USE
# changing heroin ever use names for 1415 and 1516 data

lt_heroin_1415_data <- lt_heroin_1415_data %>% rename("HEROIN - EVER USED" = "EVER USED HEROIN")
lt_heroin_1516_data <- lt_heroin_1516_data %>% rename("HEROIN - EVER USED" = "EVER USED HEROIN")

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

# CLEANING PAST YEAR OPIOID USE
# changing variable name for 2015-2016 data

py_oud_1516_data <- py_oud_1516_data %>% rename(
  "PAIN RELIEVER ABUSE OR DEPENDENCE - PAST YEAR" = "RC-PAIN RELIEVER DEPENDENCE OR ABUSE - PAST YEAR"
  )

# stacking data

py_oud_data <- bind_rows(py_oud_1011_data, 
                         py_oud_1213_data, 
                         py_oud_1516_data)

# cleaning names

py_oud_data <- janitor::clean_names(py_oud_data)

# cleaning data

py_oud_data <- py_oud_data %>%
  filter(
    !state_fips_code_numeric %in% c("Overall", "11 - District of Columbia"),
    pain_reliever_abuse_or_dependence_past_year == "Overall"
  ) %>%
  separate(state_fips_code_numeric, c("fips_code", "state"),
           sep = "-") %>%
  select(fips_code, state, use_est = row_percent, use_se = row_percent_se, year)


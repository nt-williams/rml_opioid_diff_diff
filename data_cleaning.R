
# Nick T. Williams
# Columbia University
# Mailman School of Public Health 
# Department of Biostatistics

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
    !state_fips_code_numeric %in% c("11 - District of Columbia"),
    heroin_ever_used != "Overall"
  ) %>%
  separate(state_fips_code_numeric, c("fips_code", "state"),
           sep = "-") %>%
  separate(heroin_ever_used,
           c("ever_used_recode", "ever_used_answ"),
           sep = "-") %>%
  filter(ever_used_recode == "1 ") %>%
  select(
    fips_code,
    state,
    ever_used_recode,
    ever_used_answ,
    use_est = column_percent,
    use_se = column_percent_se,
    year
  ) 

# removing white space padding around state names

lt_heroin_data$state <- gsub(" ", "", lt_heroin_data$state, fixed = TRUE)


# CLEANING PAST YEAR OPIOID ABUSE
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
    !state_fips_code_numeric %in% c("11 - District of Columbia"),
    pain_reliever_abuse_or_dependence_past_year != "Overall"
  ) %>%
  separate(
    pain_reliever_abuse_or_dependence_past_year,
    c("abuse_recode", "abuse_answ"),
    sep = "-"
  ) %>%
  separate(state_fips_code_numeric, c("fips_code", "state"),
           sep = "-") %>%
  filter(abuse_recode == "1 ") %>%
  select(
    fips_code,
    state,
    abuse_recode,
    abuse_answ,
    use_est = column_percent,
    use_se = column_percent_se,
    year
  )

# removing white space padding around state names

py_oud_data$state <- gsub(" ", "", py_oud_data$state, fixed = TRUE)


# CLEANING PRESCRIPTION NON-MEDICAL MISUSE (NO SEX/AGE)
#changing variable name for 2015-2016 data

nmpou_1516_data <- nmpou_1516_data %>% rename("PAIN RELIEVERS - PAST YEAR USE" = "RC-OPIOIDS - PAST YEAR MISUSE")

# stacking data

nmpou_data <- bind_rows(nmpou_1011_data, 
                        nmpou_1213_data, 
                        nmpou_1516_data)

# cleaning names

nmpou_data <- janitor::clean_names(nmpou_data)

# cleaning data

nmpou_data <- nmpou_data %>%
  filter(
    !state_fips_code_numeric %in% c("11 - District of Columbia"),
    pain_relievers_past_year_use != "Overall"
  ) %>%
  separate(pain_relievers_past_year_use,
           c("use_recode", "use_answ"),
           sep = "-") %>%
  separate(state_fips_code_numeric, c("fips_code", "state"),
           sep = "-") %>%
  filter(use_recode == "1 ") %>%
  select(fips_code,
         state,
         use_recode,
         use_answ,
         use_est = column_percent,
         use_se = column_percent_se,
         year)

# removing white space padding around state names

nmpou_data$state <- gsub(" ", "", nmpou_data$state, fixed = TRUE)

# EXPORTING DATA TO CSV

write_csv(lt_heroin_data, 
          "C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/data/clean/lt_heroin_10_16.csv")

write_csv(py_oud_data, 
          "C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/data/clean/py_oud_10_16.csv")

write_csv(nmpou_data, 
          "C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/data/clean/nmpou_nosex_noage_10_16.csv")

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
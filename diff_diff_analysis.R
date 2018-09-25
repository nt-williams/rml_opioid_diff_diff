
# Nick T. Williams
# Columbia University
# Mailman School of Public Health 
# Department of Biostatistics

library(tidyverse)

# importing cleaned datasets

lt_heroin_data <- read_csv(
  "C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/data/clean/lt_heroin_10_16.csv",
  col_types = 'ccccddi'
  )

py_oud_data <-
  read_csv(
    "C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/data/clean/py_oud_10_16.csv",
    col_types = 'ccccddi'
  )

nmpou_data <-
  read_csv(
    "C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/data/clean/nmpou_nosex_noage_10_16.csv",
    col_types = 'ccccddi'
  )

# diff-in-diff function

diffdiff <- function(df, s, y1, y2) {
  
  est_1 <- df %>% filter(state == s, 
                         year == y1)
  est_2 <- df %>% filter(state == s, 
                         year == y2)
  us_1  <- df %>% filter(state == "Overall", 
                         year == y1)
  us_2  <- df %>% filter(state == "Overall", 
                         year == y2)
  
  set.seed(10)
  s1 <- rnorm(n = 10000,
              mean = est_1$use_est,
              sd = est_1$use_se)
  set.seed(20)
  s2 <- rnorm(n = 10000, 
              mean = est_2$use_est, 
              sd = est_2$use_se)
  set.seed(30)
  s3 <- rnorm(n = 10000, 
              mean = us_1$use_est, 
              sd = us_1$use_se)
  set.seed(40)
  s4 <- rnorm(n = 10000, 
              mean = us_2$use_est, 
              sd = us_2$use_se)
  
  simulated_data <- tibble(s1, s2, s3, s4)
  simulated_diff <- simulated_data %>%
    mutate(difference1 = s1 - s2,
           difference2 = s3 - s4) %>% 
    select(difference1,
           difference2)
  diff_in_diff <- simulated_diff %>% 
    mutate(diff_diff = difference1 - difference2) %>%
    select(diff_diff)
  
  ci_state <- quantile(simulated_diff$difference1, c(0.025, 0.975))*100
  ci_us <- quantile(simulated_diff$difference2, c(0.025, 0.975))*100
  ci <- quantile(diff_in_diff$diff_diff, c(0.025, 0.975))*100
  delta <- mean(diff_in_diff$diff_diff)*100
  se <- sd(diff_in_diff$diff_diff)*100
  
  results <- list(
    "State difference" = (est_1$use_est - est_2$use_est) * 100,
    "State difference CI" = ci_state,
    "US difference CI" = ci_us,
    "diff-in-diff" = delta,
    "diff-in-diff SE" = se,
    "diff-in-diff CI" = ci
  )
  
  return(print(results))
}

# Example

diffdiff(lt_heroin_data, "Colorado", 2016, 2011)


# CONDUCTING ANALYSES
# states to be used for analyses

state_names <- c("Alaska", "Colorado", "Oregon", "Washington")

# LIFETIME HEROIN USE ANALYSIS

heroin_results <- list()

for (i in state_names) {
  heroin_results[[i]] <- diffdiff(lt_heroin_data, i, "2016", "2011")
}

capture.output(heroin_results, 
               file = "C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/reports/lt_heroin.txt")
  
# PAST YEAR OPIOID ABUSE/DEPENDENCE ANALYSIS

opioid_depend_results <- list()

for (i in state_names) {
  opioid_depend_results[[i]] <- diffdiff(py_oud_data, i, "2016", "2011")
}  

capture.output(opioid_depend_results, 
               file = "C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/reports/opioid_dependence.txt")  

# PRESCRIPTION NON-MEDICAL MISUSE (NO SEX/AGE) ANALYSIS

opioid_misuse_results <- list()

for (i in state_names) {
  opioid_misuse_results[[i]] <- diffdiff(nmpou_data, i, "2016", "2011")
}

capture.output(opioid_misuse_results, 
               file = "C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/reports/opioid_misuse.txt")

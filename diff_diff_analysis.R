
# Nick T. Williams
# Columbia University
# Mailman School of Public Health 
# Department of Biostatistics

library(tidyverse)

# importing cleaned datasets

lt_heroin_data <- read_csv("C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/data/clean/lt_heroin_10_16.csv", 
                           col_types = 'ccddi')

py_oud_data <- read_csv("C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/data/clean/py_oud_10_16.csv", 
                        col_types = 'ccddi')

nmpou_data <- read_csv("C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/data/clean/nmpou_nosex_noage_10_16.csv", 
                       col_types = 'ccddi')

# diff-in-diff function

diffdiff <- function(df, state, year_1, year_2) {
  est_1 <- df %>% filter(state == state, 
                         year == year_1)
  est_2 <- df %>% filter(state == state, 
                         year == year_2)
  us_1  <- df %>% filter(state == "Overall", 
                         year = year_1)
  us_2  <- df %>% filter(state == "Overall", 
                         year == year_2)
  
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
    mutate(diffdiff = difference1 - difference2) %>%
    select(diff_diff)
  
  ci_state <- quantile(simulated_diff$difference1, c(0.025, 0.975))
  
  ci_US <- quantile(simulated_diff$difference2, c(0.025, 0.975))
  
  ci <- quantile(diff_in_diff$diff_diff, c(0.025, 0.975))
  
  delta <- mean(diff_in_diff$diff_diff)
  
  se <- sd(diff_in_diff$diff_diff) 
  
  values <- list("State difference CI" = ci_state, 
                 "US difference CI" = ci_US,
                 "diff-in-diff" = delta, 
                 "diff-in-diff SE" = se, 
                 "diff-in-diff CI" = ci)
  
  return(print(values))
}
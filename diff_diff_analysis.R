
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

library(tidyverse)
library(readxl)

# LIFETIME HEROIN USE FILES
# importing lifetime heroin use data for 2010/11 - 2015/16

lt_heroin_1011_data <- read_excel("C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/data/raw/LifetimeHeroin_state_2010-16.xlsx", 
                                  sheet = "HeroinLT_state1011")

lt_heroin_1213_data <- read_excel("C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/data/raw/LifetimeHeroin_state_2010-16.xlsx", 
                                  sheet = "HeroinLT_state1213")

lt_heroin_1415_data <- read_excel("C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/data/raw/LifetimeHeroin_state_2010-16.xlsx", 
                                  sheet = "HeroinLT_state1415")

lt_heroin_1516_data <- read_excel("C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/data/raw/LifetimeHeroin_state_2010-16.xlsx", 
                                  sheet = "HeroinLT_state1516")

# creating year variable

lt_heroin_1011_data <- lt_heroin_1011_data %>% 
  mutate(year = "2011")
lt_heroin_1213_data <- lt_heroin_1213_data %>% 
  mutate(year = "2013")
lt_heroin_1415_data <- lt_heroin_1415_data %>% 
  mutate(year = "2015")
lt_heroin_1516_data <- lt_heroin_1516_data %>% 
  mutate(year = "2016")

# putting datasets into a list

heroin_list <- list(lt_heroin_1011_data, lt_heroin_1213_data, lt_heroin_1415_data, lt_heroin_1516_data)

# PAST YEAR OPIOID USE DISORDER FILES
# importing past year opioid use disorder data for 2010-2016

py_oud_1011_data <- read_excel("C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/data/raw/PY_OUD_state_2010-16.xlsx", 
                               sheet = "NMPO_ABDEPpy_State_1011")

py_oud_1213_data <- read_excel("C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/data/raw/PY_OUD_state_2010-16.xlsx", 
                               sheet = "NMPO_ABDEPpy_State_1213")

py_oud_1516_data <- read_excel("C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/data/raw/PY_OUD_state_2010-16.xlsx", 
                               sheet = "NMPO_ABDEPpy_State_1516")

# creating year variable for past year oud datasets

py_oud_1011_data <- py_oud_1011_data %>% 
  mutate(year = "2011")
py_oud_1213_data <- py_oud_1213_data %>% 
  mutate(year = "2013")
py_oud_1516_data <- py_oud_1516_data %>% 
  mutate(year = "2016")

# putting datasets into a list

py_oud_list <- list(py_oud_1011_data, py_oud_1213_data, py_oud_1516_data)

# PRESCRIPTION NON-MEDICAL USE (NO SEX/AGE) DATASETS
# importing prescription non-medical use (no sex/age) data for 2010-2016

nmpou_1011_data <- read_excel("C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/data/raw/PYNUMPO_state_2010-16.xlsx", 
                              sheet = "PainRelieverPY_State1011")

nmpou_1213_data <- read_excel("C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/data/raw/PYNUMPO_state_2010-16.xlsx", 
                              sheet = "PainRelieverPY_State1213")

nmpou_1516_data <- read_excel("C:/Users/niwi8/OneDrive - cumc.columbia.edu/Practicum/mj_opioid_d_in_d/data/raw/PYNUMPO_state_2010-16.xlsx", 
                              sheet = "PainRelieverPY_State1516")

# creating year variables for nmpou datasets

nmpou_1011_data <- nmpou_1011_data %>% 
  mutate(year = "2011")
nmpou_1213_data <- nmpou_1213_data %>% 
  mutate(year = "2013")
nmpou_1516_data <- nmpou_1516_data %>% 
  mutate(year = "2016")

# putting datasets into a list

nmpou_list <- list(nmpou_1011_data, nmpou_1213_data, nmpou_1516_data)

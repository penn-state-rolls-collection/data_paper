# This script was upadted/written by Alaina Pearce in Winter 2026
# to process, currate and de-identify data for the Rolls Collection
#
#     Copyright (C) 2026 Alaina L Pearce
#
#     This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
#
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with this program.  If not, see <https://www.gnu.org/licenses/>.

############ Basic Data Load/Setup ############

library(readxl)
library(RJSONIO)
library(ids)
library(reshape2)

# load
intakecalc_data <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1990 Sociofeed/Data - Excel from SPSS/SocIDin 1995-04-13.xls')

intake_data <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1990 Sociofeed/Data - Excel from SPSS/SociFeed 1994-11-30.xls')

vas_data <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1990 Sociofeed/Data - Excel from SPSS/SociVAS 1992-04-27A.xls')

# pull out key demo data
demo_data <- intake_data[c('id', 'friend', 'sex', 'rest')]

# remove columns with fully missing data
intakecalc_data <- intakecalc_data[, !grepl('zung|eat|epi|hrs|cr|td|ph', names(intakecalc_data))]
intake_data <- intake_data[, !grepl('zung|eat|epi|hrs|cr$|td|ph', names(intake_data))]
vas_data <- vas_data[, !grepl('zung|eat|epi|hrs|cr|td|ph', names(vas_data))]


# merge data into single dataframe
sociofeed_data <- merge(demo_data, vas_data[!grepl('friend|sex|rest', names(vas_data))], by = 'id', all = TRUE)

sociofeed_data <- merge(sociofeed_data, intake_data[!grepl('friend|sex|rest|sesi|sess', names(intake_data))], by = 'id', all = TRUE)

sociofeed_data <- merge(sociofeed_data, intakecalc_data[!grepl('friend|sex|rest|timei|times', names(intakecalc_data))], by = 'id', all = TRUE)

# fix variable names to be more readable
names(sociofeed_data) <- gsub('alert', 'alert_', names(sociofeed_data))
names(sociofeed_data) <- gsub('hunger', 'hunger_', names(sociofeed_data))
names(sociofeed_data) <- gsub('anx', 'anxiety_', names(sociofeed_data))
names(sociofeed_data) <- gsub('full', 'fullness_', names(sociofeed_data))
names(sociofeed_data) <- gsub('relax', 'relaxed_', names(sociofeed_data))
names(sociofeed_data) <- gsub('thirst', 'thirst_', names(sociofeed_data))
names(sociofeed_data) <- gsub('tense', 'tense_', names(sociofeed_data))
names(sociofeed_data) <- gsub('cons', 'prosp_cons_', names(sociofeed_data))
names(sociofeed_data) <- gsub('sleepy', 'sleepy_', names(sociofeed_data))
names(sociofeed_data) <- gsub('nausea', 'nauseous_', names(sociofeed_data))

names(sociofeed_data) <- gsub('time', 'time_', names(sociofeed_data))
names(sociofeed_data) <- gsub('sess', 'sesnum_', names(sociofeed_data))


names(sociofeed_data) <- gsub('spag', 'spag_', names(sociofeed_data))
names(sociofeed_data) <- gsub('sauc', 'sauce_', names(sociofeed_data))
names(sociofeed_data) <- gsub('lettuce|let', 'lettuce_', names(sociofeed_data))
names(sociofeed_data) <- gsub('tomato|toma|tom', 'tomato_', names(sociofeed_data))
names(sociofeed_data) <- gsub('cucumb|cucm', 'cucumber_', names(sociofeed_data))
names(sociofeed_data) <- gsub('lcdres|lcdr', 'lowcal_dressing_', names(sociofeed_data))
names(sociofeed_data) <- gsub('crmdres|cdrs', 'dressing_', names(sociofeed_data))
names(sociofeed_data) <- gsub('dinroll|roll', 'roll_', names(sociofeed_data))
names(sociofeed_data) <- gsub('marg', 'margarine_', names(sociofeed_data))
names(sociofeed_data) <- gsub('cookies|cook', 'cookie_', names(sociofeed_data))
names(sociofeed_data) <- gsub('chocicm|icem', 'icecream_', names(sociofeed_data))
names(sociofeed_data) <- gsub('raspsor|sort', 'sorbet_', names(sociofeed_data))
names(sociofeed_data) <- gsub('water', 'water_', names(sociofeed_data))

names(sociofeed_data) <- gsub('_cal|_al|cal', '_cal_', names(sociofeed_data))
names(sociofeed_data) <- gsub('_fat|fat', '_fat_', names(sociofeed_data))
names(sociofeed_data) <- gsub('_cho|_ho|cho', '_cho_', names(sociofeed_data))
names(sociofeed_data) <- gsub('_pro|pro', '_pro_', names(sociofeed_data))

names(sociofeed_data) <- gsub('sauf', 'sauce_f', names(sociofeed_data))
names(sociofeed_data) <- gsub('saup', 'sauce_p', names(sociofeed_data))


names(sociofeed_data) <- gsub('_pro_sp_cons', 'prosp_cons', names(sociofeed_data))

names(sociofeed_data) <- gsub('^d_', '', names(sociofeed_data))
names(sociofeed_data) <- gsub('desperc', 'dsrt_perc_din_', names(sociofeed_data))
names(sociofeed_data) <- gsub('k_cal_min', 'kcal_min', names(sociofeed_data))
names(sociofeed_data) <- gsub('meank_cal_', 'mean_kcal', names(sociofeed_data))
names(sociofeed_data) <- gsub('cho_clp', 'cho_perc_cal_', names(sociofeed_data))
names(sociofeed_data) <- gsub('fat_clp', 'fat_perc_cal_', names(sociofeed_data))
names(sociofeed_data) <- gsub('pro_clp', 'pro_perc_cal_', names(sociofeed_data))


names(sociofeed_data) <- gsub('__', '_', names(sociofeed_data))

names(sociofeed_data) <- sapply(names(sociofeed_data), function(x) ifelse(grepl('_s|_s_', x), paste0('soc_', x), ifelse(grepl('_i|_i_', x), paste0('ind_', x), x)))

names(sociofeed_data) <- gsub('_s|_s_|_i|_i_', '', names(sociofeed_data))

names(sociofeed_data) <- gsub('socesnum', 'soc_sesnum', names(sociofeed_data))
names(sociofeed_data) <- gsub('indesnum', 'ind_sesnum', names(sociofeed_data))
names(sociofeed_data) <- gsub('socleepy', 'soc_sleepy', names(sociofeed_data))
names(sociofeed_data) <- gsub('indleepy', 'ind_sleepy', names(sociofeed_data))
names(sociofeed_data) <- gsub('socpag', 'soc_spag', names(sociofeed_data))
names(sociofeed_data) <- gsub('indpag', 'ind_spag', names(sociofeed_data))
names(sociofeed_data) <- gsub('soccecream', 'soc_icecream', names(sociofeed_data))
names(sociofeed_data) <- gsub('indcecream', 'ind_icecream', names(sociofeed_data))
names(sociofeed_data) <- gsub('socorbet', 'soc_sorbet', names(sociofeed_data))
names(sociofeed_data) <- gsub('indorbet', 'ind_sorbet', names(sociofeed_data))
names(sociofeed_data) <- gsub('low_cal', 'lowcal', names(sociofeed_data))

names(sociofeed_data) <- gsub('msau|msauce', 'meat_sauce', names(sociofeed_data))
names(sociofeed_data) <- gsub('psau|psauce', 'veg_sauce', names(sociofeed_data))
names(sociofeed_data) <- gsub('sauce_e', 'sauce', names(sociofeed_data))

names(sociofeed_data) <- gsub('spag', 'spaghetti', names(sociofeed_data))

names(sociofeed_data) <- gsub('1', '_pre', names(sociofeed_data))
names(sociofeed_data) <- gsub('2', '_post', names(sociofeed_data))

# replace ids with randomly generated values
set.seed(1990)
random_ids <- random_id(n = length(unique(sociofeed_data[['id']])), bytes = 2)

sociofeed_data['id'] <- random_ids

# make a long dataset
sociofeed_data_soc =  sociofeed_data[c('id', 'friend', 'sex', 'rest', names(sociofeed_data)[grepl('soc_', names(sociofeed_data))])]

sociofeed_data_soc['cond'] <- 'soc'

names(sociofeed_data_soc) <- gsub('soc_', '', names(sociofeed_data_soc))  


sociofeed_data_ind =  sociofeed_data[c('id', 'friend', 'sex', 'rest', names(sociofeed_data)[grepl('ind_', names(sociofeed_data))])]

sociofeed_data_ind['cond'] <- 'ind'
names(sociofeed_data_ind) <- gsub('ind_', '', names(sociofeed_data_ind))  

sociofeed_data_ind <- sociofeed_data_ind[names(sociofeed_data_soc)]

sociofeed_data_long <- rbind.data.frame(sociofeed_data_soc, sociofeed_data_ind)

# reorder by id
sociofeed_data_long <- sociofeed_data_long[order(sociofeed_data_long[['id']]), ]

# reorder columns
food_names <- c('spaghetti', 'meat_sauce', 'veg_sauce', 'lettuce', 'tomato', 'cucumber', 'lowcal_dressing', '^dressing', 'roll', 'margarine', 'cookie', 'sorbet', 'icecream')

name_order = unlist(sapply(food_names, function(x) names(sociofeed_data_long)[grepl(x, names(sociofeed_data_long))], USE.NAMES = FALSE))

sociofeed_data_long <- sociofeed_data_long[c('id', 'sex', 'rest', 'friend', 'cond', 'sesnum', 'time', names(sociofeed_data_long)[grepl('pre|post', names(sociofeed_data_long))], name_order, 'water', 'cal', 'fat', 'fat_cal', 'fat_perc_cal', 'cho', 'cho_cal', 'cho_perc_cal', 'pro', 'pro_cal', 'pro_perc_cal', 'dsrt_cal', 'dsrt_fat', 'dsrt_cho', 'dsrt_pro', 'dsrt_perc_din')]

# a few more name changes
names(sociofeed_data_long)[names(sociofeed_data_long) == 'cal'] <- 'total_cal'
names(sociofeed_data_long)[names(sociofeed_data_long) == 'fat'] <- 'total_fat'
names(sociofeed_data_long)[names(sociofeed_data_long) == 'cho'] <- 'total_cho'
names(sociofeed_data_long)[names(sociofeed_data_long) == 'pro'] <- 'total_pro'


names(sociofeed_data_long)[names(sociofeed_data_long) == 'fat_cal'] <- 'total_fat_cal'
names(sociofeed_data_long)[names(sociofeed_data_long) == 'cho_cal'] <- 'total_cho_cal'
names(sociofeed_data_long)[names(sociofeed_data_long) == 'pro_cal'] <- 'total_pro_cal'

# change from proportion to percent to match naming
sociofeed_data_long['fat_perc_cal'] <- sociofeed_data_long['fat_perc_cal']*100
sociofeed_data_long['cho_perc_cal'] <- sociofeed_data_long['cho_perc_cal']*100
sociofeed_data_long['pro_perc_cal'] <- sociofeed_data_long['pro_perc_cal']*100

# set base value to 0 for condition variables

sociofeed_data_long['sex'] <- ifelse(sociofeed_data_long[['sex']] == 1, 0, 1)
sociofeed_data_long['rest'] <- ifelse(sociofeed_data_long[['rest']] == 1, 0, 1)


# write data dictionary
source('study_scripts/1990_sociofeed_dannysdiner/json_dataset_description.R')



# convert formatting to JSON
dataset_json <- RJSONIO::toJSON(dataset_list, pretty = TRUE)

# double check
isValidJSON(dataset_json, asText = TRUE)



# write out curated data and json
write.table(sociofeed_data_long, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1990_sociofeed_dannys_dinner/data/study-sociofeed_date-1990_data.csv', quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')


write(dataset_json, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1990_sociofeed_dannys_dinner/dataset_description.json')



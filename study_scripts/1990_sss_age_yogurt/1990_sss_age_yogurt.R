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
uneat_data <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1990 SSS Age Groups Yogurt/Data - SPSS & Excel VAS for N=96/AgeUneat.xls')

upsit_data <- read.csv('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1990 SSS Age Groups Yogurt/Data - Lotus123/AGEUPSI1.csv')

foodpref_data <- read.csv('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1990 SSS Age Groups Yogurt/Data - Lotus123/AGE_F_PREF.csv')


## uneat data org ####
# fix variable names to be more readable
names(uneat_data) <- gsub('app', 'appearance', names(uneat_data))
names(uneat_data) <- gsub('odo', 'odor', names(uneat_data))
names(uneat_data) <- gsub('tex', 'texture', names(uneat_data))
names(uneat_data) <- gsub('tas', 'taste', names(uneat_data))
names(uneat_data) <- gsub('des', 'desire', names(uneat_data))
names(uneat_data) <- gsub('odorr', 'odor', names(uneat_data))

names(uneat_data) <- gsub('t1', '_pre', names(uneat_data))
names(uneat_data) <- gsub('t2', '_post', names(uneat_data))

names(uneat_data) <- gsub('hun1', 'hunger_pre', names(uneat_data))
names(uneat_data) <- gsub('hun2', 'hunger_post', names(uneat_data))
names(uneat_data) <- gsub('ful1', 'fullness_pre', names(uneat_data))
names(uneat_data) <- gsub('ful2', 'fullness_post', names(uneat_data))
names(uneat_data) <- gsub('th1', 'thirst_pre', names(uneat_data))
names(uneat_data) <- gsub('th2', 'thirst_post', names(uneat_data))
names(uneat_data) <- gsub('naus1', 'nauseous_pre', names(uneat_data))
names(uneat_data) <- gsub('naus2', 'nauseous_post', names(uneat_data))
names(uneat_data) <- gsub('mdry1', 'mouthdry_pre', names(uneat_data))
names(uneat_data) <- gsub('mdry2', 'mouthdry_post', names(uneat_data))
names(uneat_data) <- gsub('desiree1', 'desire_eat_pre', names(uneat_data))
names(uneat_data) <- gsub('desiree2', 'desire_eat_post', names(uneat_data))

names(uneat_data) <- gsub('diffhun', 'dif_hunger', names(uneat_data))
names(uneat_data) <- gsub('diffful', 'dif_fullness', names(uneat_data))
names(uneat_data) <- gsub('diffth', 'dif_thirst', names(uneat_data))
names(uneat_data) <- gsub('diffnaus', 'dif_nauseous', names(uneat_data))
names(uneat_data) <- gsub('diffmdry', 'dif_mouthdry', names(uneat_data))
names(uneat_data) <- gsub('diffdesiree', 'dif_desire_eat', names(uneat_data))


names(uneat_data) <- gsub('uneat', 'uneat_', names(uneat_data))
names(uneat_data) <- gsub('base', 'base_', names(uneat_data))
names(uneat_data) <- gsub('end', 'end_', names(uneat_data))

names(uneat_data) <- gsub('gend_er', 'gender', names(uneat_data))

names(uneat_data) <- gsub('f1', '_tuna', names(uneat_data))
names(uneat_data) <- gsub('f2', '_cracker', names(uneat_data))
names(uneat_data) <- gsub('f3', '_yogurt', names(uneat_data))
names(uneat_data) <- gsub('f4', '_carrot', names(uneat_data))
names(uneat_data) <- gsub('f5', '_pretzel', names(uneat_data))

names(uneat_data) <- gsub('diff', 'dif_', names(uneat_data))
names(uneat_data) <- gsub('dif', 'dif_', names(uneat_data))
names(uneat_data) <- gsub('__', '_', names(uneat_data))


names(uneat_data) <- gsub('1', '_tuna', names(uneat_data))
names(uneat_data) <- gsub('2', '_cracker', names(uneat_data))
names(uneat_data) <- gsub('3', '_yogurt', names(uneat_data))
names(uneat_data) <- gsub('4', '_carrot', names(uneat_data))
names(uneat_data) <- gsub('5', '_pretzel', names(uneat_data))


names(uneat_data) <- gsub('amtyogur', 'amtyogurt', names(uneat_data))

# remove unnecesary/unclear computed variables
uneat_data <- uneat_data[!grepl('base|end', names(uneat_data))]
uneat_data <- uneat_data[!grepl('unapp|unodor|untext|untast|undesi', names(uneat_data))]

# remove duplicate information
uneat_data <- uneat_data[!grepl('agegp|agegrp|sess$', names(uneat_data))]

# reorder columns
sss_names <- c('appearance', 'odor', 'texture', 'taste', 'desire')

sss_name_order <- unlist(sapply(sss_names, function(x) names(uneat_data)[grepl(x, names(uneat_data))], USE.NAMES = FALSE))

sss_name_order <- sss_name_order[!grepl('desire_eat', sss_name_order)]

sss_name_order <- c(sss_name_order[!grepl('dif', sss_name_order)], sss_name_order[grepl('dif', sss_name_order)])
sss_name_order <- c(sss_name_order[!grepl('uneat', sss_name_order)], sss_name_order[grepl('uneat', sss_name_order)])


vas_names <- c('hunger', 'fullness', 'nauseous', 'mouthdry', 'thirst', 'desire_eat')
vas_name_order <- unlist(sapply(vas_names, function(x) names(uneat_data)[grepl(x, names(uneat_data))], simplify = FALSE, USE.NAMES = FALSE))

vas_name_order <- c(vas_name_order[grepl('pre', vas_name_order)], vas_name_order[grepl('post', vas_name_order)], vas_name_order[grepl('dif', vas_name_order)])

uneat_data <- uneat_data[c('id', 'session', 'agegroup', 'sex', 'expt', 'age', 'upsitsc', 'zung', 'eat', 'lsi', 'eisc', 'ei', 'ht', 'wt', 'bmi',  'dentures', 'meds', 'bcp', 'hbp', 'allergy', 'chol', 'hormones', 'aspirin', 'nitrates', 'convul', 'asthma', 'narcotic', 'lanoxin', 'dep', 'amtyogurt', 'time', vas_name_order, sss_name_order)]

# set base value to 0 for condition variables
demo_var <- c('ei', 'sex', 'dentures', 'meds', 'bcp', 'hbp', 'allergy', 'chol', 'hormones', 'aspirin', 'nitrates', 'convul', 'asthma', 'narcotic', 'lanoxin', 'dep')

uneat_data[c(demo_var)] <- sapply(demo_var, function(x)ifelse(uneat_data[[x]] == 1, 0, 1))

uneat_data['agegroup'] <- uneat_data[['agegroup']]-1

uneat_data['expt'] <- uneat_data[['expt']]-2

# replace ids with randomly generated values ####
uneat_data['id'] <- as.character(uneat_data[['id']])
uneat_data['id_rand'] <- uneat_data['id']

set.seed(1990.1)
random_ids <- random_id(n = length(unique(uneat_data[['id']])), bytes = 2)

id_count = 0

for (id_val in unique(uneat_data[['id']])){
  id_count <- id_count + 1
  
  uneat_data[uneat_data['id'] == id_val, 'id_rand'] <- random_ids[id_count]
}

## split data Uneat data ####
demo_data <- uneat_data[c('id', 'id_rand', 'session', 'agegroup', 'sex', 'upsitsc', 'zung', 'eat', 'lsi', 'ei', 'eisc', 'bmi', demo_var[!grepl('sex|ei', demo_var)])]

sss_data <- uneat_data[c('id_rand', 'session', 'agegroup', 'sex', 'expt', 'amtyogurt', 'time', vas_name_order, sss_name_order)]

names(sss_data)[names(sss_data) == 'id_rand'] <- 'id'

# fix missing data indicators
sss_data['time'] <- ifelse(sss_data[['time']] == 99, NA, sss_data[['time']])

sss_data[grepl('_pre$|_post$', names(sss_data))] <- sapply(names(sss_data[grepl('_pre$|_post$', names(sss_data))]), function(x) ifelse(sss_data[[x]] == 999, NA, sss_data[[x]]))

sss_data[grepl('dif', names(sss_data))] <- sapply(names(sss_data[grepl('dif', names(sss_data))]), function(x) round(sss_data[[x]], digits = 2))


# UPSIT Data ####

# merge with demo to get ids to match up
# update names

names(upsit_data) <- gsub('sm', 'smell_', names(upsit_data))

# fix NA documentation
upsit_data[grepl('smell', names(upsit_data))] <- sapply(names(upsit_data[grepl('smell', names(upsit_data))]), function(x) ifelse(upsit_data[[x]] == 999, NA, upsit_data[[x]]))

upsit_data['sex'] <- ifelse(upsit_data[['sex']] == 'm', 0, 1)

# Food Pref Data ####

# update names

names(foodpref_data) <- gsub('1', '_taste', names(foodpref_data))
names(foodpref_data) <- gsub('2', '_like_change', names(foodpref_data))
names(foodpref_data) <- gsub('3', '_freq_eat', names(foodpref_data))
names(foodpref_data) <- gsub('4', '_perc_cal', names(foodpref_data))

names(foodpref_data) <- gsub('ww', 'wheat_bread', names(foodpref_data))
names(foodpref_data) <- gsub('piz', 'pizza', names(foodpref_data))
names(foodpref_data) <- gsub('cola', 'diet_cola', names(foodpref_data))
names(foodpref_data) <- gsub('lmpie', 'lemon_pie', names(foodpref_data))
names(foodpref_data) <- gsub('chpie', 'cherry_pie', names(foodpref_data))
names(foodpref_data) <- gsub('jel', 'jello', names(foodpref_data))
names(foodpref_data) <- gsub('chburg', 'cheeseburger', names(foodpref_data))
names(foodpref_data) <- gsub('dill', 'pickle', names(foodpref_data))
names(foodpref_data) <- gsub('cuc', 'cucumber', names(foodpref_data))
names(foodpref_data) <- gsub('ff', 'fries', names(foodpref_data))
names(foodpref_data) <- gsub('sal', 'salad', names(foodpref_data))
names(foodpref_data) <- gsub('bolo', 'bologna', names(foodpref_data))
names(foodpref_data) <- gsub('wmel', 'watermelon', names(foodpref_data))
names(foodpref_data) <- gsub('tbone', 'tbone_steak', names(foodpref_data))
names(foodpref_data) <- gsub('strw', 'strawberry', names(foodpref_data))
names(foodpref_data) <- gsub('cinn', 'cinn_roll', names(foodpref_data))
names(foodpref_data) <- gsub('broc', 'broccoli', names(foodpref_data))
names(foodpref_data) <- gsub('chch', 'cheddar', names(foodpref_data))
names(foodpref_data) <- gsub('skim', 'skim_milk', names(foodpref_data))
names(foodpref_data) <- gsub('onion', 'onion_ring', names(foodpref_data))
names(foodpref_data) <- gsub('gjuic', 'grapefruit_juice', names(foodpref_data))
names(foodpref_data) <- gsub('chip', 'potato_chip', names(foodpref_data))
names(foodpref_data) <- gsub('oran', 'orange', names(foodpref_data))
names(foodpref_data) <- gsub('nut', 'peanut', names(foodpref_data))
names(foodpref_data) <- gsub('pine', 'pineapple', names(foodpref_data))
names(foodpref_data) <- gsub('choc', 'choc_icecream', names(foodpref_data))
names(foodpref_data) <- gsub('cott', 'lowf_cotcheese', names(foodpref_data))
names(foodpref_data) <- gsub('grap', 'grape', names(foodpref_data))
names(foodpref_data) <- gsub('ging', 'gingerbread', names(foodpref_data))
names(foodpref_data) <- gsub('bann', 'banana', names(foodpref_data))
names(foodpref_data) <- gsub('grapee', 'grape', names(foodpref_data))

names(foodpref_data) <- gsub('agegp', 'agegroup', names(foodpref_data))
names(foodpref_data) <- gsub('sess', 'session', names(foodpref_data))

# organize/remove unneeded
foodpref_data <- foodpref_data[!grepl('expt', names(foodpref_data))]

# fix missing value indicators
foodpref_data[!grepl('id|agegroup|sex|session', names(foodpref_data))] <- sapply(names(foodpref_data[!grepl('id|agegroup|sex|session', names(foodpref_data))]), function(x) ifelse(foodpref_data[[x]] == 999, NA, foodpref_data[[x]]))

# make factor variables base zero
foodpref_data['session'] <- ifelse(foodpref_data[['session']] == 0, NA, foodpref_data[['session']])

foodpref_data['session'] <- foodpref_data['session'] - 1
foodpref_data['agegroup'] <- foodpref_data['agegroup'] - 1

foodpref_data['sex'] <- ifelse(foodpref_data[['sex']] == 'm', 0, 1)

# split and de-identify demo data ####

# cvd risk factor variable
demo_data['cvd_risk'] <- rowSums(demo_data[c('hbp', 'chol', 'aspirin', 'nitrates', 'lanoxin')], na.rm = TRUE)

# remove low frequency data
demo_data <- demo_data[!grepl('hbp|chol|aspirin|nitrates|lanoxin|bcp|hormones|asthma|narcotic|allergy|dep|convul', names(demo_data))]

# split so only 1 row
demo_data['id_rep'] <- unlist(sapply(unique(demo_data[['id']]), function(x) seq(1, nrow(demo_data[demo_data['id'] == x, 'id']), 1), USE.NAMES = FALSE, simplify = FALSE))

demo_data <- demo_data[demo_data['id_rep'] == 1, ]

demo_data <- demo_data[!grepl('id_rep', names(demo_data))]

# match up random IDs and remove orig IDs ####
upsit_data <- merge(upsit_data, demo_data[c('id', 'id_rand')], by = 'id')
upsit_data['id'] <- upsit_data['id_rand']
upsit_data <- upsit_data[!grepl('id_rand', names(upsit_data))]

foodpref_data <- merge(foodpref_data, demo_data[c('id', 'id_rand')], by = 'id')
foodpref_data['id'] <- foodpref_data['id_rand']
foodpref_data <- foodpref_data[!grepl('id_rand', names(foodpref_data))]

demo_data['id'] <- demo_data['id_rand']
demo_data <- demo_data[!grepl('id_rand', names(demo_data))]

## particpant.json ####

source('study_scripts/1990_sss_age_yogurt/json_participant.R')

# convert formatting to JSON
participant_json <- RJSONIO::toJSON(participant_list, pretty = TRUE)

# double check
isValidJSON(participant_json, asText = TRUE)

## sss.json ####

source('study_scripts/1990_sss_age_yogurt/json_sss.R')

# convert formatting to JSON
sss_json <- RJSONIO::toJSON(sss_list, pretty = TRUE)

# double check
isValidJSON(sss_json, asText = TRUE)

## upsit.json ####

source('study_scripts/1990_sss_age_yogurt/json_upsit.R')

# convert formatting to JSON
upsit_json <- RJSONIO::toJSON(upsit_list, pretty = TRUE)

# double check
isValidJSON(upsit_json, asText = TRUE)

## foodpref.json ####

source('study_scripts/1990_sss_age_yogurt/json_foodpref.R')

# convert formatting to JSON
foodpref_json <- RJSONIO::toJSON(foodpref_list, pretty = TRUE)

# double check
isValidJSON(foodpref_json, asText = TRUE)

## dataset_description.json ####

source('study_scripts/1990_sss_age_yogurt/json_dataset_description.R')

# convert formatting to JSON
dataset_json <- RJSONIO::toJSON(dataset_list, pretty = TRUE)

# double check
isValidJSON(dataset_json, asText = TRUE)

# write out files ####

# write out json
write(dataset_json, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1990_sss_age_yogurt/dataset_description.json')

write(participant_json, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1990_sss_age_yogurt/data/assay-demo_data.json')

write(sss_json, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1990_sss_age_yogurt/data/assay-sss_data.json')

write(upsit_json, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1990_sss_age_yogurt/data/assay-upsit_data.json')

write(foodpref_json, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1990_sss_age_yogurt/data/assay-foodpref_data.json')

# write out curated data
write.table(demo_data, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1990_sss_age_yogurt/data/assay-demo_data.csv', quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')

write.table(sss_data, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1990_sss_age_yogurt/data/assay-sss_data.csv', quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')

write.table(upsit_data, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1990_sss_age_yogurt/data/assay-upsit_data.csv', quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')

write.table(foodpref_data, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1990_sss_age_yogurt/data/assay-foodpref_data.csv', quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')
# This script was upadted/written by Alaina Pearce in Winter 2026
# to process, curate and de-identify data for the Rolls Collection
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

curated_wd <- '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1991_eatdis/'
script_wd <- 'study_scripts/1991_eatdis/'

# load data and set up demo/participant data
source(file.path(script_wd,'1991_eatdis-merge_demo.R'))


# cafeteria intake data ####
caf_long_data <- caf_long_data[!grepl('^eat$|ideal_bw', names(caf_long_data))]

# add rand_id
caf_long_data <- merge(caf_long_data, demo_merge[c('id', 'id_rand', 'timepoint')], by = c('id', 'timepoint'), all.x = TRUE, all.y = FALSE)

#remove old id and rename id_rand
caf_long_data <- caf_long_data[!grepl('^id$', names(caf_long_data))]
names(caf_long_data)[names(caf_long_data) == 'id_rand'] <- 'id'

# fix order
caf_long_data <- caf_long_data[c('id', 'timepoint', 'group', names(caf_long_data[!grepl('^id$|timepoint|group', names(caf_long_data))]))]

# cafeteria time difference data ####
# add rand_id
caf_tdif_data <- merge(caf_tdif_data, demo_merge[demo_merge['timepoint'] == 0, c('id', 'id_rand')], by = 'id', all.x = TRUE, all.y = FALSE)

# fix up variables
caf_tdif_data <- caf_tdif_data[!grepl('^id$', names(caf_tdif_data))]
names(caf_tdif_data)[names(caf_tdif_data) == 'id_rand'] <- 'id'

# fix order
caf_tdif_data <- caf_tdif_data[c('id', 'group', names(caf_tdif_data[!grepl('^id$|group', names(caf_tdif_data))]))]

# food preference rating data ####
# add rand_id
rate_long_data <- merge(rate_long_data, demo_merge[c('id', 'id_rand', 'timepoint')], by = c('id', 'timepoint'), all.x = TRUE, all.y = FALSE)

# fix up variables
rate_long_data <- rate_long_data[!grepl('^id$', names(rate_long_data))]
names(rate_long_data)[names(rate_long_data) == 'id_rand'] <- 'id'

# fix order
rate_long_data <- rate_long_data[c('id', 'timepoint', 'group', names(rate_long_data[!grepl('^id$|group|timepoint', names(rate_long_data))]))]

# food preference calculated data ####
# add rand_id
food_pref_calc <- merge(food_pref_calc, demo_merge[c('id', 'id_rand', 'timepoint')], by = c('id', 'timepoint'), all.x = TRUE, all.y = FALSE)

# fix up variables
food_pref_calc <- food_pref_calc[!grepl('^id$', names(food_pref_calc))]
names(food_pref_calc)[names(food_pref_calc) == 'id_rand'] <- 'id'

# fix order
food_pref_calc <- food_pref_calc[c('id', 'timepoint', 'group', names(food_pref_calc[!grepl('^id$|group|timepoint', names(food_pref_calc))]))]

# smell data ####
# add rand_id
long_smell_data <- merge(long_smell_data, demo_merge[c('id', 'id_rand', 'timepoint')], by = c('id', 'timepoint'), all.x = TRUE, all.y = FALSE)

# fix up variables
long_smell_data <- long_smell_data[!grepl('^id$', names(long_smell_data))]
names(long_smell_data)[names(long_smell_data) == 'id_rand'] <- 'id'

# fix order
long_smell_data <- long_smell_data[c('id', 'timepoint', 'group_anr_split', 'age', 'illness_dur', 'perc_ideal_bw', 'smoke', 'years_smoked', 'cigs_day', 'odor_threshold', 'upsit')]

# organize demo data ####
demo_merge <- demo_merge[!grepl('^id$', names(demo_merge))]
names(demo_merge)[names(demo_merge) == 'id_rand'] <- 'id'

demo_merge <- demo_merge[c('id', 'cafeteria_study', 'foodpref_study', 'smell_study', 'timepoint', 'group', 'group_anr_split', names(demo_merge[!grepl('^id$|group|timepoint|_study$', names(demo_merge))]))]

## get json files and write data ####

# write dataset_description.json ####
source(file.path(script_wd,'json_dataset_description.R'))

# convert formatting to JSON
dataset_json <- RJSONIO::toJSON(dataset_list, pretty = TRUE)

# double check
isValidJSON(dataset_json, asText = TRUE)

write(dataset_json, file.path(curated_wd, 'dataset_description.json'))


# write demo data and .json ####
source(file.path(script_wd, 'json_participant.R'))

# convert formatting to JSON
participant_json <- RJSONIO::toJSON(participant_list, pretty = TRUE)

# double check
isValidJSON(participant_json, asText = TRUE)

write(participant_json, file.path(curated_wd, 'data/assay-demo_data.json'))

# write out curated data
write.table(demo_merge, file.path(curated_wd, 'data/assay-demo_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')


# write eat beh questionnaire data and .json ####
source(file.path(script_wd, 'json_eat_qs.R'))

# convert formatting to JSON
eat_qs_json <- RJSONIO::toJSON(eat_qs_list, pretty = TRUE)

# double check
isValidJSON(eat_qs_json, asText = TRUE)

write(eat_qs_json, file.path(curated_wd, 'data/assay-questionnaire_data.json'))

# write out curated data
write.table(eat_qs, file.path(curated_wd, 'data/assay-questionnaire_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')


# write cafeteria data and .json ####
source(file.path(script_wd, 'json_caf_intake.R'))

# convert formatting to JSON
caf_intake_json <- RJSONIO::toJSON(caf_intake_list, pretty = TRUE)

# double check
isValidJSON(caf_intake_json, asText = TRUE)

write(caf_intake_json, file.path(curated_wd, 'data/study-cafeteria_assay-intake_data.json'))

write.table(caf_long_data, file.path(curated_wd, 'data/study-cafeteria_assay-intake_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')


# write cafeteria tdif data and .json ####
source(file.path(script_wd, 'json_caf_tdif.R'))

# convert formatting to JSON
caf_tdif_json <- RJSONIO::toJSON(caf_tdif_list, pretty = TRUE)

# double check
isValidJSON(caf_tdif_json, asText = TRUE)

write(caf_tdif_json, file.path(curated_wd, 'data/study-cafeteria_calc-timedif_data.json'))

## write out curated data
write.table(caf_tdif_data, file.path(curated_wd, 'data/study-cafeteria_calc-timedif_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')


# write food rating data and .json ####
source(file.path(script_wd, 'json_food_rating.R'))

# convert formatting to JSON
food_rate_json <- RJSONIO::toJSON(food_rate_list, pretty = TRUE)

# double check
isValidJSON(food_rate_json, asText = TRUE)

write(food_rate_json, file.path(curated_wd, 'data/study-foodpref_assay-foodq_data.json'))

## write out curated data
write.table(rate_long_data, file.path(curated_wd, 'data/study-foodpref_assay-foodq_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')


# write food rating data and .json ####
source(file.path(script_wd, 'json_foodpref_calc.R'))

# convert formatting to JSON
foodpref_calc_json <- RJSONIO::toJSON(foodpref_calc_list, pretty = TRUE)

# double check
isValidJSON(foodpref_calc_json, asText = TRUE)

write(foodpref_calc_json, file.path(curated_wd, 'data/study-foodpref_calc-preference_data.json'))

## write out curated data
write.table(food_pref_calc, file.path(curated_wd, 'data/study-foodpref_calc-preference_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')


# write food preference questionnaire attributes data and .json ####
source(file.path(script_wd, 'json_foodpref_foodinfo.R'))

# convert formatting to JSON
foodpref_foodinfo_json <- RJSONIO::toJSON(foodpref_foodinfo_list, pretty = TRUE)

# double check
isValidJSON(foodpref_calc_json, asText = TRUE)

write(foodpref_foodinfo_json, file.path(curated_wd, 'data/study-foodpref_calc-foodinfo_data.json'))

## write out curated data
write.table(food_tab, file.path(curated_wd, 'data/study-foodpref_calc-foodinfo_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')

# write smell study data and .json ####
source(file.path(script_wd, 'json_smell.R'))

# convert formatting to JSON
smell_json <- RJSONIO::toJSON(smell_list, pretty = TRUE)

# double check
isValidJSON(smell_json, asText = TRUE)

write(smell_json, file.path(curated_wd, 'data/study-smell_data.json'))

## write out curated data
write.table(long_smell_data, file.path(curated_wd, 'data/study-smell_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')






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

# load data and set up demo/participant data
source('study_scripts/1991_eatdis/1991_eatdis-merge_demo.R')


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

# VAS hourly data ####
# add rand_id
vas_hourly <- merge(vas_hourly, demo_merge[is.na(demo_merge['timepoint']) | demo_merge['timepoint'] == 0, c('id', 'id_rand')], by = c('id'), all.x = TRUE, all.y = FALSE)

# fix up variables
vas_hourly <- vas_hourly[!grepl('^id$', names(vas_hourly))]
names(vas_hourly)[names(vas_hourly) == 'id_rand'] <- 'id'

# fix order
vas_hourly <- vas_hourly[c('id', names(vas_hourly)[!grepl('id|min_week|vas_hourly_study', names(vas_hourly))])]


# yogurt preload intake data ####
# add rand_id
yogurt_long <- merge(yogurt_long, demo_merge[is.na(demo_merge['timepoint']) | demo_merge['timepoint'] == 0, c('id', 'id_rand')], by = c('id'), all.x = TRUE, all.y = FALSE)


# fix up variables
yogurt_long <- yogurt_long[!grepl('^id$', names(yogurt_long))]
names(yogurt_long)[names(yogurt_long) == 'id_rand'] <- 'id'


# fix order
yogurt_long <- yogurt_long[c('id', names(yogurt_long)[!grepl('id', names(yogurt_long))])]



# yogurt preload vas data ####
# add rand_id
yogurt_vas_long <- merge(yogurt_vas_long, demo_merge[is.na(demo_merge['timepoint']) | demo_merge['timepoint'] == 0, c('id', 'id_rand')], by = c('id'), all.x = TRUE, all.y = FALSE)

# fix up variables
yogurt_vas_long <- yogurt_vas_long[!grepl('^id$', names(yogurt_vas_long))]
names(yogurt_vas_long)[names(yogurt_vas_long) == 'id_rand'] <- 'id'

# fix order
yogurt_vas_long <- yogurt_vas_long[c('id', names(yogurt_vas_long)[!grepl('id', names(yogurt_vas_long))])]

# salad preload diff data ####
# add rand_id
salad_diff_data <- merge(diff_data, demo_merge[c('id', 'id_rand', 'timepoint')], by = c('id', 'timepoint'), all.x = TRUE, all.y = FALSE)


# fix up variables
salad_diff_data <- salad_diff_data[!grepl('^id$', names(salad_diff_data))]
names(salad_diff_data)[names(salad_diff_data) == 'id_rand'] <- 'id'


# fix order
salad_diff_data <- salad_diff_data[c('id', names(salad_diff_data)[!grepl('id', names(salad_diff_data))])]

salad_diff_data <- salad_diff_data[!grepl('timepoint|_study', names(salad_diff_data))]

# salad preload hunger data ####
# add rand_id
hunger_dat_long <- merge(hunger_dat_long, demo_merge[demo_merge['timepoint'] == 0, c('id', 'id_rand')], by = c('id'), all.x = TRUE, all.y = FALSE)

# fix up variables
hunger_dat_long <- hunger_dat_long[!grepl('^id$', names(hunger_dat_long))]
names(hunger_dat_long)[names(hunger_dat_long) == 'id_rand'] <- 'id'

# fix order
hunger_dat_long <- hunger_dat_long[c('id', names(hunger_dat_long)[!grepl('id', names(hunger_dat_long))])]

# salad preload cond 3 data ####
# add rand_id
sss3_rate_long <- merge(sss3_rate_long, demo_merge[demo_merge['timepoint'] == 0, c('id', 'id_rand')], by = c('id'), all.x = TRUE, all.y = FALSE)

# fix up variables
sss3_rate_long <- sss3_rate_long[!grepl('^id$', names(sss3_rate_long))]
names(sss3_rate_long)[names(sss3_rate_long) == 'id_rand'] <- 'id'

# fix order
sss3_rate_long <- sss3_rate_long[c('id', names(sss3_rate_long)[!grepl('id', names(sss3_rate_long))])]

# deprivation study data ####

# add rand_id
dep_long <- merge(dep_long, demo_merge[is.na(demo_merge['timepoint']) | demo_merge['timepoint'] == 0, c('id', 'id_rand')], by = c('id'), all.x = TRUE, all.y = FALSE)

# match up ids for individual video coding files
source('study_scripts/1991_eatdis/1992_eatdis-dep_video.R')
dep_id_list$id <- as.numeric(dep_id_list$id)
dep_id_list <- merge(dep_id_list, dep_long[dep_long['dep_cond'] == 1, c('id', 'id_rand')], by = c('id'), all.x = TRUE, all.y = FALSE)

# copy and save individual files
mapply(parse_vid_records, file_path = dep_id_list[['file_path']], id = dep_id_list[['id']], cond = dep_id_list[['cond']], id_rand = dep_id_list[['id_rand']], MoreArgs = list(curated_wd = curated_wd))

# export json for individual files
source('study_scripts/1991_eatdis/json_video_ind.R')
vid_json <- RJSONIO::toJSON(video_list, pretty = TRUE)

# double check
isValidJSON(vid_json, asText = TRUE)

write(vid_json, file.path(curated_wd, 'data/raw/assay-microstructure_study-dep.json'))

# fix up variables
dep_long <- dep_long[!grepl('^id$', names(dep_long))]
names(dep_long)[names(dep_long) == 'id_rand'] <- 'id'

# fix order
dep_long <- dep_long[c('id', names(dep_long)[!grepl('id', names(dep_long))])]


# mealtime camera study data ####

# match up ids for individual video coding files
source('study_scripts/1991_eatdis/1992_eatdis-lunch_video.R')

# add rand_id
lunch_id_list <- merge(lunch_id_list, demo_merge[!is.na(demo_merge['timepoint']), c('id', 'id_rand', 'timepoint')], by = c('id', 'timepoint'), all.x = TRUE, all.y = FALSE)

# copy and save individual files
mapply(parse_lunchvid_records, file_path = lunch_id_list[['file_path']], id = lunch_id_list[['id']], cond = lunch_id_list[['timepoint']], id_rand = lunch_id_list[['id_rand']], group = lunch_id_list[['group']], MoreArgs = list(curated_wd = curated_wd))

# export json for individual files
source('study_scripts/1991_eatdis/json_video_lunch.R')
vid_lunch_json <- RJSONIO::toJSON(video_list_lunch, pretty = TRUE)

# double check
isValidJSON(vid_lunch_json, asText = TRUE)

write(vid_lunch_json, file.path(curated_wd, 'data/raw/assay-microstructure_study-lunch.json'))

# organize demo data ####
demo_merge <- demo_merge[!grepl('^id$', names(demo_merge))]
names(demo_merge)[names(demo_merge) == 'id_rand'] <- 'id'

demo_merge <- demo_merge[c('id', 'cafeteria_study', 'foodpref_study', 'smell_study', 'vas_hourly_study', 'yogurt_preload_study', 'deprivation_study', 'timepoint', 'group', 'group_anr_split', 'group_control_split', names(demo_merge[!grepl('^id$|group|timepoint|_study$', names(demo_merge))]))]

## get json files and write data ####

# write dataset_description.json ####
source('study_scripts/1991_eatdis/json_dataset_description.R')

# convert formatting to JSON
dataset_json <- RJSONIO::toJSON(dataset_list, pretty = TRUE)

# double check
isValidJSON(dataset_json, asText = TRUE)

write(dataset_json, file.path(curated_wd, 'dataset_description.json'))


# write demo data and .json ####
source('study_scripts/1991_eatdis/json_participant.R')

# convert formatting to JSON
participant_json <- RJSONIO::toJSON(participant_list, pretty = TRUE)

# double check
isValidJSON(participant_json, asText = TRUE)

write(participant_json, file.path(curated_wd, 'data/assay-demo_data.json'))

# write out curated data
write.table(demo_merge, file.path(curated_wd, 'data/assay-demo_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')


# write eat beh questionnaire data and .json ####
source('study_scripts/1991_eatdis/json_eat_qs.R')

# convert formatting to JSON
eat_qs_json <- RJSONIO::toJSON(eat_qs_list, pretty = TRUE)

# double check
isValidJSON(eat_qs_json, asText = TRUE)

write(eat_qs_json, file.path(curated_wd, 'data/assay-questionnaire_data.json'))

# write out curated data
write.table(eat_qs, file.path(curated_wd, 'data/assay-questionnaire_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')


# write cafeteria data and .json ####
source('study_scripts/1991_eatdis/json_caf_intake.R')

# convert formatting to JSON
caf_intake_json <- RJSONIO::toJSON(caf_intake_list, pretty = TRUE)

# double check
isValidJSON(caf_intake_json, asText = TRUE)

write(caf_intake_json, file.path(curated_wd, 'data/study-cafeteria_assay-intake_data.json'))

write.table(caf_long_data, file.path(curated_wd, 'data/study-cafeteria_assay-intake_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')


# write cafeteria tdif data and .json ####
source('study_scripts/1991_eatdis/json_caf_tdif.R')

# convert formatting to JSON
caf_tdif_json <- RJSONIO::toJSON(caf_tdif_list, pretty = TRUE)

# double check
isValidJSON(caf_tdif_json, asText = TRUE)

write(caf_tdif_json, file.path(curated_wd, 'data/study-cafeteria_calc-timedif_data.json'))

## write out curated data
write.table(caf_tdif_data, file.path(curated_wd, 'data/study-cafeteria_calc-timedif_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')


# write food rating data and .json ####
source('study_scripts/1991_eatdis/json_food_rating.R')

# convert formatting to JSON
food_rate_json <- RJSONIO::toJSON(food_rate_list, pretty = TRUE)

# double check
isValidJSON(food_rate_json, asText = TRUE)

write(food_rate_json, file.path(curated_wd, 'data/study-foodpref_assay-foodq_data.json'))

## write out curated data
write.table(rate_long_data, file.path(curated_wd, 'data/study-foodpref_assay-foodq_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')


# write food rating data and .json ####
source('study_scripts/1991_eatdis/json_foodpref_calc.R')

# convert formatting to JSON
foodpref_calc_json <- RJSONIO::toJSON(foodpref_calc_list, pretty = TRUE)

# double check
isValidJSON(foodpref_calc_json, asText = TRUE)

write(foodpref_calc_json, file.path(curated_wd, 'data/study-foodpref_calc-preference_data.json'))

## write out curated data
write.table(food_pref_calc, file.path(curated_wd, 'data/study-foodpref_calc-preference_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')


# write food preference questionnaire attributes data and .json ####
source('study_scripts/1991_eatdis/json_foodpref_foodinfo.R')

# convert formatting to JSON
foodpref_foodinfo_json <- RJSONIO::toJSON(foodpref_foodinfo_list, pretty = TRUE)

# double check
isValidJSON(foodpref_calc_json, asText = TRUE)

write(foodpref_foodinfo_json, file.path(curated_wd, 'data/study-foodpref_calc-foodinfo_data.json'))

## write out curated data
write.table(food_tab, file.path(curated_wd, 'data/study-foodpref_calc-foodinfo_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')

# write smell study data and .json ####
source('study_scripts/1991_eatdis/json_smell.R')

# convert formatting to JSON
smell_json <- RJSONIO::toJSON(smell_list, pretty = TRUE)

# double check
isValidJSON(smell_json, asText = TRUE)

write(smell_json, file.path(curated_wd, 'data/study-smell_data.json'))

## write out curated data
write.table(long_smell_data, file.path(curated_wd, 'data/study-smell_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')

# write vas hourly study data and .json ####
source('study_scripts/1991_eatdis/json_vas_hourly.R')

# convert formatting to JSON
vas_hourly_json <- RJSONIO::toJSON(vas_hourly_list, pretty = TRUE)

# double check
isValidJSON(vas_hourly_json, asText = TRUE)

write(vas_hourly_json, file.path(curated_wd, 'data/study-hourly_assay-vas_data.json'))

## write out curated data
write.table(vas_hourly, file.path(curated_wd, 'data/study-hourly_assay-vas_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')


# write yogurt preload intake data and .json ####
source('study_scripts/1991_eatdis/json_yogurt_sum.R')

# convert formatting to JSON
yogurt_sum_json <- RJSONIO::toJSON(yogurt_sum_list, pretty = TRUE)

# double check
isValidJSON(yogurt_sum_json, asText = TRUE)

write(yogurt_sum_json, file.path(curated_wd, 'data/study-yogurt_assay-food_data.json'))

# write out curated data
write.table(yogurt_long, file.path(curated_wd, 'data/study-yogurt_assay-food_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')

# write yogurt preload data and .json ####
source('study_scripts/1991_eatdis/json_yogurt_vas.R')

# convert formatting to JSON
yogurt_vas_json <- RJSONIO::toJSON(yogurt_vas_list, pretty = TRUE)

# double check
isValidJSON(yogurt_vas_json, asText = TRUE)

write(yogurt_vas_json, file.path(curated_wd, 'data/study-yogurt_assay-vas_data.json'))

# write out curated data
write.table(yogurt_vas_long, file.path(curated_wd, 'data/study-yogurt_assay-vas_dat.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')

# write salad preload difference data and .json ####
source('study_scripts/1991_eatdis/json_preload-salad_dif.R')

# convert formatting to JSON
salad_dif_json <- RJSONIO::toJSON(salad_dif_list, pretty = TRUE)

# double check
isValidJSON(salad_dif_json, asText = TRUE)

write(salad_dif_json, file.path(curated_wd, 'data/study-salad_calc-vasdiff_data.json'))

# write out curated data
write.table(salad_diff_data, file.path(curated_wd, 'data/study-salad_calc-vasdiff_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')

# write salad preload hunger data and .json ####
source('study_scripts/1991_eatdis/json_preload-salad_hunger.R')

# convert formatting to JSON
salad_hunger_json <- RJSONIO::toJSON(salad_hunger_list, pretty = TRUE)

# double check
isValidJSON(salad_hunger_json, asText = TRUE)

write(salad_hunger_json, file.path(curated_wd, 'data/study-salad_assay-hunger_data.json'))

# write out curated data
write.table(hunger_dat_long, file.path(curated_wd, 'data/study-salad_assay-hunger_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')

# write salad preload cond 3 data and .json ####
source('study_scripts/1991_eatdis/json_preload-salad_cond3.R')

# convert formatting to JSON
salad_cond3_json <- RJSONIO::toJSON(salad_cond3_list, pretty = TRUE)

# double check
isValidJSON(salad_cond3_json, asText = TRUE)

write(salad_cond3_json, file.path(curated_wd, 'data/study-salad_cond-highcal_data.json'))

# write out curated data
write.table(sss3_rate_long, file.path(curated_wd, 'data/study-salad_cond-highcal_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')

# write food deprivation intake data and .json ####
source('study_scripts/1991_eatdis/json_dep_intake.R')

# convert formatting to JSON
dep_intake_json <- RJSONIO::toJSON(dep_intake_list, pretty = TRUE)

# double check
isValidJSON(dep_intake_json, asText = TRUE)

write(dep_intake_json, file.path(curated_wd, 'data/study-deprivation_assay-food_data.json'))

# write out curated data
write.table(dep_long, file.path(curated_wd, 'data/study-deprivation_assay-food_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')
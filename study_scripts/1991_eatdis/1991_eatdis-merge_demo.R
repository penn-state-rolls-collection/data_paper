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

source('study_scripts/1991_eatdis/1991_eatdis-cafeteria.R')
source('study_scripts/1991_eatdis/1991_eatdis-foodpref.R')
source('study_scripts/1991_eatdis/1991_eatdis-smell.R')
source('study_scripts/1991_eatdis/1991_eatdis-vas_hourly.R')
source('study_scripts/1991_eatdis/1991_eatdis-yogurt_preload.R')
source('study_scripts/1991_eatdis/1992_eatdis-dep.R')
source('study_scripts/1991_eatdis/1992_eatdis-lunch_video.R')
source('study_scripts/1991_eatdis/1990_eatdis-salad_preload.R')

# participant data ####

# add timepoint/make long to make even for edi_discharge and time 1 only measures
caf_demo_data1 <- caf_demo_data
caf_demo_data1['timepoint'] <- 0
caf_demo_data1['edi_discharge'] <- NA

caf_demo_data2 <- caf_demo_data
caf_demo_data2['timepoint'] <- 1

caf_demo_data2[grepl('ei', names(caf_demo_data2))] <- NA
caf_demo_data2[c('bmi_admit', 'edi_thinness', 'edi_bulimia', 'edi_body_dissat', 'edi_ineffectiveness', 'edi_perfectionism', 'edi_distrust', 'edi_intero_aware', 'edi_mature_fears')] <- NA

caf_demo_data <- rbind.data.frame(caf_demo_data1, caf_demo_data2)
names(caf_demo_data) <- gsub('_admit|_discharge', '', names(caf_demo_data))

# merge with other long demo ####
caf_demo_data['cafeteria_study'] <- 1
pref_demo_data['foodpref_study'] <- 1

demo_merge <- merge(caf_demo_data[c('id', 'timepoint', 'group', 'cafeteria_study', 'age', 'race', 'illness_dur', 'hospital_stay_wks', 'bmi')], pref_demo_data[c('id', 'timepoint', 'group', 'age', 'illness_dur', 'perc_ideal_bw', 'foodpref_study')], by = c('id', 'timepoint'), all = TRUE)

# add more perc_ideal_weight
demo_merge <- merge(demo_merge, caf_long_data[c('id', 'timepoint', 'perc_ideal_bw')], by = c('id', 'timepoint'), all = TRUE)

# fill in ages and group if missing from one 
demo_merge['group.x'] <- ifelse(is.na(demo_merge[['group.x']]), demo_merge[['group.y']], demo_merge[['group.x']])

demo_merge['age.x'] <- ifelse(is.na(demo_merge[['age.x']]), demo_merge[['age.y']], demo_merge[['age.x']])

demo_merge['illness_dur.x'] <- ifelse(is.na(demo_merge[['illness_dur.x']]), demo_merge[['illness_dur.y']], demo_merge[['illness_dur.x']])

demo_merge['perc_ideal_bw.x'] <- ifelse(is.na(demo_merge[['perc_ideal_bw.x']]), demo_merge[['perc_ideal_bw.y']], demo_merge[['perc_ideal_bw.x']])

# clean up vars
demo_merge <- demo_merge[!grepl('[.]y', names(demo_merge))]
names(demo_merge) <- gsub('[.]x', '', names(demo_merge))

# double check smell data cannot fill in missing values ####
long_smell_data['smell_study'] <- 1
names(long_smell_data)[names(long_smell_data) == 'group'] <- 'group_anr_split'

demo_merge <- merge(demo_merge, long_smell_data[c('id', 'timepoint', 'group_anr_split', 'age', 'perc_ideal_bw', 'illness_dur', 'smell_study')], by = c('id', 'timepoint'), all = TRUE)

# fill in group - need to unsplit ANR from smell data to allign with the 'group' var 
demo_merge['group'] <- ifelse(is.na(demo_merge[['group']]) & !is.na(demo_merge[['group_anr_split']]), ifelse(demo_merge[['group_anr_split']] >= 3, demo_merge[['group_anr_split']] - 1, demo_merge[['group_anr_split']]), demo_merge[['group']])

demo_merge['age.x'] <- ifelse(is.na(demo_merge[['age.x']]), demo_merge[['age.y']], demo_merge[['age.x']])

demo_merge['illness_dur.x'] <- ifelse(is.na(demo_merge[['illness_dur.x']]), demo_merge[['illness_dur.y']], demo_merge[['illness_dur.x']])

demo_merge['perc_ideal_bw.x'] <- ifelse(is.na(demo_merge[['perc_ideal_bw.x']]), demo_merge[['perc_ideal_bw.y']], demo_merge[['perc_ideal_bw.x']])

# clean up vars
demo_merge <- demo_merge[!grepl('[.]y', names(demo_merge))]
names(demo_merge) <- gsub('[.]x', '', names(demo_merge))

# double check vas hourly IDs
vas_hourly['vas_hourly_study'] <- 1

# need to get the first row for each ID
vas_hourly['min_week'] <- sapply(vas_hourly[['id']], function(x) min(vas_hourly[vas_hourly['id'] == x, 'week']))

demo_merge <- merge(demo_merge, vas_hourly[vas_hourly['week'] == vas_hourly['min_week'], c('id', 'group', 'vas_hourly_study')], by = c('id'), all = TRUE)

demo_merge['group.x'] <- ifelse(is.na(demo_merge[['group.x']]), demo_merge[['group.y']], demo_merge[['group.x']])

# clean up vars
demo_merge <- demo_merge[!grepl('[.]y', names(demo_merge))]
names(demo_merge) <- gsub('[.]x', '', names(demo_merge))

# double check yogurt preload IDs ####
yogurt_q_data['yogurt_preload_study'] <- 1
yogurt_q_data['timepoint'] <- 0

demo_merge <- merge(demo_merge, yogurt_q_data[c('id', 'group', 'age', 'bmi', 'illness_dur', 'yogurt_preload_study')], by = c('id'), all = TRUE)

demo_merge['group.x'] <- ifelse(is.na(demo_merge[['group.x']]) & is.na(demo_merge[['timepoint']]), demo_merge[['group.y']], demo_merge[['group.x']])

demo_merge['age.x'] <- ifelse(is.na(demo_merge[['age.x']]) & demo_merge[['timepoint']] == 0, demo_merge[['age.y']], demo_merge[['age.x']])

demo_merge['illness_dur.x'] <- ifelse(is.na(demo_merge[['illness_dur.x']]) & demo_merge[['timepoint']] == 0, demo_merge[['illness_dur.y']], demo_merge[['illness_dur.x']])

demo_merge['bmi.x'] <- ifelse(is.na(demo_merge[['bmi.x']]) & demo_merge[['timepoint']] == 0, demo_merge[['bmi.y']], demo_merge[['bmi.x']])

# clean up vars
demo_merge <- demo_merge[!grepl('[.]y', names(demo_merge))]
names(demo_merge) <- gsub('[.]x', '', names(demo_merge))

# double check deprivation study ####
dep_q_data['deprivation_study'] <- 1

demo_merge <- merge(demo_merge, dep_q_data[c('id', 'group', 'restrict_cond', 'age', 'perc_ideal_bw', 'illness_dur', 'deprivation_study')], by = c('id'), all = TRUE)

names(demo_merge)[names(demo_merge) == 'restrict_cond'] <- 'group_control_split'

demo_merge['group.x'] <- ifelse(is.na(demo_merge[['group.x']]) & is.na(demo_merge[['timepoint']]), demo_merge[['group.y']], demo_merge[['group.x']])

demo_merge['age.x'] <- ifelse(is.na(demo_merge[['age.x']]) & demo_merge[['timepoint']] == 0, demo_merge[['age.y']], demo_merge[['age.x']])

demo_merge['illness_dur.x'] <- ifelse(is.na(demo_merge[['illness_dur.x']]) & demo_merge[['timepoint']] == 0, demo_merge[['illness_dur.y']], demo_merge[['illness_dur.x']])

demo_merge['perc_ideal_bw.x'] <- ifelse(is.na(demo_merge[['perc_ideal_bw.x']]) & demo_merge[['timepoint']] == 0, demo_merge[['perc_ideal_bw.y']], demo_merge[['perc_ideal_bw.x']])

# clean up vars
demo_merge <- demo_merge[!grepl('[.]y', names(demo_merge))]
names(demo_merge) <- gsub('[.]x', '', names(demo_merge))

# fix illness duration and hospital stay to be NA for controls
demo_merge['illness_dur'] <- ifelse(demo_merge[['group']] == 3, NA, demo_merge[['illness_dur']])

demo_merge['hospital_stay_wks'] <- ifelse(demo_merge[['hospital_stay_wks']] == 3, NA, demo_merge[['hospital_stay_wks']])

# double check lunch video study ####
lunch_id_list['lunch_video_study'] <- 1

demo_merge <- merge(demo_merge, lunch_id_list[c('id', 'lunch_video_study', 'group', 'timepoint')], by = c('id', 'timepoint'), all = TRUE)

demo_merge['group.x'] <- ifelse(is.na(demo_merge[['group.x']]), demo_merge[['group.y']], demo_merge[['group.x']])

# fix illness duration and hospital stay to be NA for controls
demo_merge['illness_dur'] <- ifelse(demo_merge[['group']] == 3, NA, demo_merge[['illness_dur']])

demo_merge['hospital_stay_wks'] <- ifelse(demo_merge[['hospital_stay_wks']] == 3, NA, demo_merge[['hospital_stay_wks']])

# double check salad preload study ####
diff_data['salad_preload_study'] <- 1
diff_data['timepoint'] <- 0

demo_merge <- merge(demo_merge, diff_data[diff_data['cond'] == 0, c('id', 'salad_preload_study', 'group', 'timepoint')], by = c('id', 'timepoint'), all = TRUE)

demo_merge['group.x'] <- ifelse(is.na(demo_merge[['group.x']]), demo_merge[['group.y']], demo_merge[['group.x']])

# fix illness duration and hospital stay to be NA for controls
demo_merge['illness_dur'] <- ifelse(demo_merge[['group']] == 3, NA, demo_merge[['illness_dur']])

demo_merge['hospital_stay_wks'] <- ifelse(demo_merge[['hospital_stay_wks']] == 3, NA, demo_merge[['hospital_stay_wks']])


# clean up vars
demo_merge <- demo_merge[!grepl('[.]y', names(demo_merge))]
names(demo_merge) <- gsub('[.]x', '', names(demo_merge))

set.seed(1991)

random_ids <- random_id(n = length(unique(demo_merge[['id']])), bytes = 2)

id_count = 0

for (id_val in unique(demo_merge[['id']])){
  id_count <- id_count + 1
  
  demo_merge[demo_merge['id'] == id_val, 'id_rand'] <- random_ids[id_count]
}

# re-order
demo_merge <- demo_merge[c('id', 'id_rand', 'timepoint', 'group', 'group_anr_split', 'group_control_split', 'cafeteria_study', 'foodpref_study', 'smell_study', 'vas_hourly_study', 'yogurt_preload_study', 'deprivation_study', 'lunch_video_study', 'age', 'race', 'illness_dur', 'hospital_stay_wks', 'bmi', 'perc_ideal_bw')]

# eating behavior questionnaires ####
eat_qs <- merge(caf_demo_data[grepl('id|timepoint|edi|ei', names(caf_demo_data))], caf_long_data[c('id', 'timepoint', 'eat')], by = c('id', 'timepoint'), all = TRUE)

# merge in yogurt preload data ####
yogurt_q_data['timepoint'] <- 0

eat_qs <- merge(eat_qs, yogurt_q_data[c('id', 'timepoint', 'ei', 'eat', 'zung', 'bsq', 'edi')], by = c('id', 'timepoint'), all = TRUE)

eat_qs['edi.x'] <- ifelse(is.na(eat_qs[['edi.x']]), eat_qs[['edi.y']], eat_qs[['edi.x']])

eat_qs['eat.x'] <- ifelse(is.na(eat_qs[['eat.x']]), eat_qs[['eat.y']], eat_qs[['eat.x']])

# clean up vars
eat_qs <- eat_qs[!grepl('[.]y', names(eat_qs))]
names(eat_qs) <- gsub('[.]x', '', names(eat_qs))

# merge in deprivaiton data ####
dep_q_data['timepoint'] <- 0

eat_qs <- merge(eat_qs, dep_q_data[c('id', 'timepoint', 'eat', 'zung', 'bsq', 'edi_body_dissat', 'ei_cog_restraint', 'ei_hunger', 'ei_disinhibit')], by = c('id', 'timepoint'), all = TRUE)

eat_qs['edi_body_dissat.x'] <- ifelse(is.na(eat_qs[['edi_body_dissat.x']]), eat_qs[['edi_body_dissat.y']], eat_qs[['edi_body_dissat.x']])

eat_qs['eat.x'] <- ifelse(is.na(eat_qs[['eat.x']]), eat_qs[['eat.y']], eat_qs[['eat.x']])

eat_qs['zung.x'] <- ifelse(is.na(eat_qs[['zung.x']]), eat_qs[['zung.y']], eat_qs[['zung.x']])

eat_qs['ei_cog_restraint.x'] <- ifelse(is.na(eat_qs[['ei_cog_restraint.x']]), eat_qs[['ei_cog_restraint.y']], eat_qs[['ei_cog_restraint.x']])

eat_qs['ei_disinhibit.x'] <- ifelse(is.na(eat_qs[['ei_disinhibit.x']]), eat_qs[['ei_disinhibit.y']], eat_qs[['ei_disinhibit.x']])

eat_qs['ei_hunger.x'] <- ifelse(is.na(eat_qs[['ei_hunger.x']]), eat_qs[['ei_hunger.y']], eat_qs[['ei_hunger.x']])

# clean up vars
eat_qs <- eat_qs[!grepl('[.]y', names(eat_qs))]
names(eat_qs) <- gsub('[.]x', '', names(eat_qs))

# merge with rand ids
eat_qs <- merge(demo_merge[c('id', 'id_rand', 'group')], eat_qs, by = c('id'), all.x = FALSE, all.y = TRUE)

# remove old id and rename id_rand
eat_qs <- eat_qs[!grepl('^id$', names(eat_qs))]
names(eat_qs)[names(eat_qs) == 'id_rand'] <- 'id'

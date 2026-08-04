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
library(data.table)

# load
dep_data <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1992 EatDis Deprivation/Data - SASv9 & Excel from SPSS/Master 1993-10-14 multivar.xls')

dep_food_data <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1992 EatDis Deprivation/Data - SASv9 & Excel from SPSS/FoodVals 1993-11-12 multivar.xls')

dep_foodg_data <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1992 EatDis Deprivation/Data - SASv9 & Excel from SPSS/DepInt 1993-10-14.xls')

## Summary Data ####
# fix names to be more readable and consistent
names(dep_data)[names(dep_data) == 'edi_dt'] <- 'edi_body_dissat'
names(dep_data)[names(dep_data) == 'ei_cr'] <- 'ei_cog_restraint'
names(dep_data)[names(dep_data) == 'ei_dis'] <- 'ei_disinhibit'
names(dep_data)[names(dep_data) == 'ei_hung'] <- 'ei_hunger'
names(dep_data)[names(dep_data) == 'loi'] <- 'illness_dur'
names(dep_data)[names(dep_data) == 'ad_ibw'] <- 'perc_ideal_bw'

names(dep_data)[names(dep_data) == 'gp'] <- 'group'
names(dep_data)[names(dep_data) == 'category'] <- 'restrict_cond'
names(dep_data) <- gsub('timeeat', 'time', names(dep_data))

names(dep_data) <- gsub('sess', 'session', names(dep_data))
names(dep_data) <- gsub('h2o', 'water_g', names(dep_data))

names(dep_data) <- gsub('^hung', 'hunger', names(dep_data))
names(dep_data) <- gsub('thir', 'thirst', names(dep_data))
names(dep_data) <- gsub('desi', 'desire', names(dep_data))
names(dep_data) <- gsub('full', 'fullness', names(dep_data))
names(dep_data) <- gsub('much', 'much_eat', names(dep_data))
names(dep_data) <- gsub('bloa', 'bloated', names(dep_data))
names(dep_data) <- gsub('fear', 'fear_fat', names(dep_data))
names(dep_data) <- gsub('bing', 'binge_desire', names(dep_data))
names(dep_data) <- gsub('purg', 'purge_desire', names(dep_data))
names(dep_data) <- gsub('aler', 'alert', names(dep_data))
names(dep_data) <- gsub('guil', 'guilt', names(dep_data))
names(dep_data) <- gsub('depr', 'depressed', names(dep_data))
names(dep_data) <- gsub('cont', 'content', names(dep_data))
names(dep_data) <- gsub('naus', 'nausea', names(dep_data))


# fix names to be more readable and consistent
names(dep_data) <- gsub('^tot', 'total_', names(dep_data))

names(dep_data) <- gsub('fcal', 'fat_cal', names(dep_data))
names(dep_data) <- gsub('pcal', 'pro_cal', names(dep_data))
names(dep_data) <- gsub('ccal', 'cho_cal', names(dep_data))

names(dep_data) <- gsub('fatg', 'fat_g', names(dep_data))
names(dep_data) <- gsub('prog', 'pro_g', names(dep_data))
names(dep_data) <- gsub('chog', 'cho_g', names(dep_data))

names(dep_data) <- ifelse(grepl('per1|per2', names(dep_data)), paste0('perc_', names(dep_data)), names(dep_data))

names(dep_data) <- gsub('gper', 'g', names(dep_data))
names(dep_data) <- gsub('calper', 'cal', names(dep_data))

names(dep_data) <- gsub('gram', 'g', names(dep_data))

# individual foods
names(dep_food_data) <- gsub('kcal', '_cal', names(dep_food_data))
names(dep_food_data) <- gsub('^tot', 'total_', names(dep_food_data))
names(dep_food_data) <- gsub('timeeat', 'time', names(dep_food_data))
names(dep_food_data) <- gsub('sess', 'session', names(dep_food_data))

names(dep_food_data) <- gsub('h2o', 'water', names(dep_food_data))
names(dep_food_data) <- gsub('gwater', 'water_g', names(dep_food_data))
names(dep_food_data) <- gsub('^water', 'water_g', names(dep_food_data))

names(dep_food_data) <- gsub('fcal', 'fat_cal', names(dep_food_data))
names(dep_food_data) <- gsub('pcal', 'pro_cal', names(dep_food_data))
names(dep_food_data) <- gsub('ccal', 'cho_cal', names(dep_food_data))

names(dep_food_data) <- gsub('fatg', 'fat_g', names(dep_food_data))
names(dep_food_data) <- gsub('prog', 'pro_g', names(dep_food_data))
names(dep_food_data) <- gsub('chog', 'cho_g', names(dep_food_data))

names(dep_food_data) <- gsub('__', '_', names(dep_food_data))

names(dep_food_data) <- ifelse(grepl('per1|per2', names(dep_food_data)), paste0('perc_', names(dep_food_data)), names(dep_food_data))

names(dep_food_data) <- gsub('gper', 'g', names(dep_food_data))
names(dep_food_data) <- gsub('calper', 'cal', names(dep_food_data))

names(dep_food_data) <- gsub('gp', 'group', names(dep_food_data))

names(dep_food_data) <- gsub('pas', 'pasta', names(dep_food_data))
names(dep_food_data) <- gsub('mrn', 'marinara', names(dep_food_data))
names(dep_food_data) <- gsub('alf', 'alfredo', names(dep_food_data))
names(dep_food_data) <- gsub('tur', 'turkey', names(dep_food_data))
names(dep_food_data) <- gsub('chs', 'cheese', names(dep_food_data))
names(dep_food_data) <- gsub('let', 'lettuce', names(dep_food_data))
names(dep_food_data) <- gsub('cuc', 'cucumber', names(dep_food_data))
names(dep_food_data) <- gsub('tom', 'tomato', names(dep_food_data))
names(dep_food_data) <- gsub('chp', 'chips', names(dep_food_data))
names(dep_food_data) <- gsub('app', 'apple', names(dep_food_data))
names(dep_food_data) <- gsub('ice', 'icecream', names(dep_food_data))
names(dep_food_data) <- gsub('brw', 'brownie', names(dep_food_data))
names(dep_food_data) <- gsub('coo', 'cookies', names(dep_food_data))
names(dep_food_data) <- gsub('cak', 'cake', names(dep_food_data))
names(dep_food_data) <- gsub('snc', 'snickers', names(dep_food_data))
names(dep_food_data) <- gsub('her', 'hershey_kiss', names(dep_food_data))
names(dep_food_data) <- gsub('brd', 'bread', names(dep_food_data))
names(dep_food_data) <- gsub('mrg', 'margarine', names(dep_food_data))
names(dep_food_data) <- gsub('may', 'mayo', names(dep_food_data))
names(dep_food_data) <- gsub('mus', 'mustard', names(dep_food_data))
names(dep_food_data) <- gsub('par', 'parm_cheese', names(dep_food_data))

names(dep_food_data)[names(dep_food_data) == 'total_cal'] <- 'total_kcal'
names(dep_food_data)[names(dep_food_data) == 'total_gram'] <- 'total_g'


# g foods
names(dep_foodg_data) <- gsub('cond', 'dep_cond', names(dep_foodg_data))
names(dep_foodg_data) <- gsub('sess', 'session', names(dep_foodg_data))
names(dep_foodg_data) <- gsub('timeeat', 'time', names(dep_foodg_data))
names(dep_foodg_data) <- gsub('h2o', 'water', names(dep_foodg_data))

names(dep_foodg_data) <- gsub('marin', 'marinara', names(dep_foodg_data))
names(dep_foodg_data) <- gsub('alf', 'alfredo', names(dep_foodg_data))
names(dep_foodg_data) <- gsub('turk', 'turkey', names(dep_foodg_data))
names(dep_foodg_data) <- gsub('achs', 'cheese', names(dep_foodg_data))
names(dep_foodg_data) <- gsub('lett', 'lettuce', names(dep_foodg_data))
names(dep_foodg_data) <- gsub('cuc', 'cucumber', names(dep_foodg_data))
names(dep_foodg_data) <- gsub('tom', 'tomato', names(dep_foodg_data))
names(dep_foodg_data) <- gsub('pchip', 'chips', names(dep_foodg_data))
names(dep_foodg_data) <- gsub('icream', 'icecream', names(dep_foodg_data))
names(dep_foodg_data) <- gsub('brow', 'brownie', names(dep_foodg_data))
names(dep_foodg_data) <- gsub('cook', 'cookies', names(dep_foodg_data))
names(dep_foodg_data) <- gsub('ccake', 'cake', names(dep_foodg_data))
names(dep_foodg_data) <- gsub('snick', 'snickers', names(dep_foodg_data))
names(dep_foodg_data) <- gsub('hers', 'hershey_kiss', names(dep_foodg_data))
names(dep_foodg_data) <- gsub('marg', 'margarine', names(dep_foodg_data))
names(dep_foodg_data) <- gsub('must', 'mustard', names(dep_foodg_data))
names(dep_foodg_data) <- gsub('parm', 'parm_cheese', names(dep_foodg_data))

names(dep_foodg_data) <- gsub('gp', 'group', names(dep_foodg_data))

names(dep_foodg_data)[!grepl('id|group|cond|sess|time', names(dep_foodg_data))] <- paste0(names(dep_foodg_data)[!grepl('id|group|cond|sess|time', names(dep_foodg_data))], '_g')

# organize data into long format ####

# fix zero base
dep_data['restrict_cond'] <- dep_data['restrict_cond'] - 1

dep_foodg_data['dep_cond'] <- dep_foodg_data['dep_cond'] - 1
dep_foodg_data['group'] <- dep_foodg_data['group'] - 1

dep_foodg_data['group'] <- ifelse(dep_foodg_data[['group']] >= 4, 3, dep_foodg_data[['group']])


# vas data
cond1_vas <- dep_data[grepl('^id|group|session1|1a|1b|^perc.*1$|^total.*1$', names(dep_data))]

names(cond1_vas) <- gsub('1a', '_pre', names(cond1_vas))
names(cond1_vas) <- gsub('1b', '_post', names(cond1_vas))
names(cond1_vas) <- gsub('1$', '', names(cond1_vas))
cond1_vas['dep_cond'] <- '0'

cond2_vas <- dep_data[grepl('^id|group|session2|2a|2b|^perc.*2$|^total.*2$', names(dep_data))]

names(cond2_vas) <- gsub('2a', '_pre', names(cond2_vas))
names(cond2_vas) <- gsub('2b', '_post', names(cond2_vas))
names(cond2_vas) <- gsub('2$', '', names(cond2_vas))
cond2_vas['dep_cond'] <- '1'

dep_vas_long <- rbind.data.frame(cond1_vas, cond2_vas)

# foods data
cond1_foods <- dep_food_data[grepl('^id|group|1', names(dep_food_data))]

names(cond1_foods) <- gsub('1', '', names(cond1_foods))
cond1_foods['dep_cond'] <- '0'

cond2_foods <- dep_food_data[grepl('^id|group|2', names(dep_food_data))]

names(cond2_foods) <- gsub('2', '', names(cond2_foods))
cond2_foods['dep_cond'] <- '1'

dep_foods_long <- rbind.data.frame(cond1_foods, cond2_foods)

# merge with already long foodg data
dep_long <- merge(dep_vas_long[!grepl('session|group|gwater', names(dep_vas_long))], dep_foodg_data, by = c('id', 'dep_cond'), all = TRUE)

dep_long <- merge(dep_long, dep_foods_long[!grepl('session|group|water|time|total|perc', names(dep_foods_long))], by = c('id', 'dep_cond'), all = TRUE)

dep_long <- merge(dep_long, dep_data[c('id', 'restrict_cond')], by = 'id', all = TRUE)

# reorder
dep_long <- dep_long[c('id', 'group', 'restrict_cond', 'dep_cond', 'session', 'time', names(dep_long)[grepl('pre|post', names(dep_long))], names(dep_long)[grepl('_g|cal', names(dep_long))])]

# make percent
dep_long[grepl('perc', names(dep_long))] <- 100 * (dep_long[grepl('perc', names(dep_long))])


# demo data
dep_data['group'] <- dep_data['group'] - 1

dep_data['group'] <- ifelse(dep_data[['group']] >= 4, 3, dep_data[['group']])

dep_q_data <- dep_data[c('id', 'group', 'restrict_cond', 'age', 'zung', 'eat', 'bsq', 'edi_body_dissat', 'ei_cog_restraint', 'ei_hunger', 'ei_disinhibit', 'perc_ideal_bw', 'illness_dur')]


# replace ids with randomly generated values ####
dep_q_data['id_rand'] <- as.character(dep_q_data['id'])

set.seed(1992.1)
random_ids <- random_id(n = length(unique(dep_q_data[['id']])), bytes = 2)

id_count = 0

for (id_val in unique(dep_q_data[['id']])){
  id_count <- id_count + 1
  
  dep_q_data[dep_q_data['id'] == id_val, 'id_rand'] <- random_ids[id_count]
}

# match up random IDs and remove orig IDs ####
dep_long <- merge(dep_long, dep_q_data[c('id', 'id_rand')], by = 'id', all.x = TRUE)
dep_long['id'] <- dep_long['id_rand']
dep_long <- dep_long[!grepl('id_rand', names(dep_long))]

# match up ids for individual video coding files
curated_wd <- '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1992_eatdis_deprivation/'
script_wd <- 'study_scripts/1992_eatdis_deprivation/'
source(file.path(script_wd, '1992_eatdis-dep_video.R'))

dep_id_list$id <- as.numeric(dep_id_list$id)
dep_id_list <- merge(dep_id_list, dep_q_data[c('id', 'id_rand')], by = 'id')

dep_q_data['id'] <- dep_q_data['id_rand']
dep_q_data <- dep_q_data[!grepl('id_rand', names(dep_q_data))]


# write demo intake data and .json ####
source(file.path(script_wd, 'json_participant.R'))

# convert formatting to JSON
participant_json <- RJSONIO::toJSON(participant_list, pretty = TRUE)

# double check
isValidJSON(participant_json, asText = TRUE)

write(participant_json, file.path(curated_wd, 'data/assay-demo_data.json'))

# write out curated data
write.table(dep_q_data, file.path(curated_wd, 'data/assay-demo_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')


# write food deprivation intake data and .json ####
source(file.path(script_wd,'json_dep_intake.R'))

# convert formatting to JSON
dep_intake_json <- RJSONIO::toJSON(dep_intake_list, pretty = TRUE)

# double check
isValidJSON(dep_intake_json, asText = TRUE)

write(dep_intake_json, file.path(curated_wd, 'data/assay-intake_data.json'))

# write out curated data
write.table(dep_long, file.path(curated_wd, 'data/assay-intake_data.csv'), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')

# dataset_description.json ####

source(file.path(script_wd,'json_dataset_description.R'))

# convert formatting to JSON
dataset_json <- RJSONIO::toJSON(dataset_list, pretty = TRUE)

# double check
isValidJSON(dataset_json, asText = TRUE)


# write out json and data files ####
write(dataset_json, file.path(curated_wd, 'dataset_description.json'))

## raw video data ####
# copy and save individual files
mapply(parse_vid_records, file_path = dep_id_list[['file_path']], id = dep_id_list[['id']], cond = dep_id_list[['cond']], id_rand = dep_id_list[['id_rand']], MoreArgs = list(curated_wd = curated_wd))

# export json for individual files
source(file.path(script_wd, 'json_video_ind.R'))
vid_json <- RJSONIO::toJSON(video_list, pretty = TRUE)

# double check
isValidJSON(vid_json, asText = TRUE)

write(vid_json, file.path(curated_wd, 'data/raw/assay-microstructure.json'))


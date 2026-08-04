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
# match up ids for individual video coding files
curated_wd <- '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1992_eatdis_mealtime/'
script_wd <- 'study_scripts/1992_eatdis_mealtime/'

source(file.path(script_wd, '1992_eatdis-lunch_video.R'))

# replace ids with randomly generated values ####
lunch_id_list$id <- as.numeric(lunch_id_list$id)

lunch_id_list['id_rand'] <- as.character(lunch_id_list['id'])

set.seed(1992.4)
random_ids <- random_id(n = length(unique(lunch_id_list[['id']])), bytes = 2)

id_count = 0

for (id_val in unique(lunch_id_list[['id']])){
  id_count <- id_count + 1
  
  lunch_id_list[lunch_id_list['id'] == id_val, 'id_rand'] <- random_ids[id_count]
}

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
mapply(parse_lunchvid_records, file_path = lunch_id_list[['file_path']], id = lunch_id_list[['id']], cond = lunch_id_list[['timepoint']], id_rand = lunch_id_list[['id_rand']], group = lunch_id_list[['group']], MoreArgs = list(curated_wd = curated_wd))

# export json for individual files
source(file.path(script_wd, 'json_video_lunch.R'))
vid_lunch_json <- RJSONIO::toJSON(video_list_lunch, pretty = TRUE)

# double check
isValidJSON(vid_lunch_json, asText = TRUE)

write(vid_lunch_json, file.path(curated_wd, 'data/raw/assay-microstructure.json'))

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

# load
base_wd_lunch <- '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1992 EatDis Mealtime (CAMERA)/Individual Data 1993-94/'


#get list of files
lunch_paths <- list.files(path = base_wd_lunch, pattern = "\\.XLS$", full.names = TRUE)
lunch_paths <- lunch_paths[!grepl('SUBSUMM', lunch_paths)]

lunch_files <- list.files(path = base_wd_lunch, pattern = "\\.XLS$")
lunch_files <- lunch_files[!grepl('SUBSUMM', lunch_files)]

# get id lists and conditions
lunch_ids <- gsub('A|B|\\.XLS', '', lunch_files)
lunch_timepoint <- ifelse(grepl('A', lunch_files), '0', '1')

lunch_id_list <- data.frame('id' = lunch_ids, 'timepoint' = lunch_timepoint, 'file_path' = lunch_paths)
lunch_id_list['id'] <- as.numeric(lunch_id_list[['id']])
lunch_id_list['timepoint'] <- as.numeric(lunch_id_list[['timepoint']])

lunch_id_list['group'] <- ifelse(lunch_id_list[['id']] < 500, 2, 3)

# function to fix individual files
parse_lunchvid_records <- function(file_path, id, cond, curated_wd, id_rand, group) {
  
  print(paste0(id, cond))
  
  vid_data <- read_excel(file_path, col_names = FALSE)
  
  start_dict <- which(vid_data[, 1] == 'Selected activities') + 1
  end_dict <- which(vid_data[, 1] == 'Recordlayout') - 1
  
  if(length(end_dict) == 0){
    end_dict <- which(vid_data[, 1] == 'END OF COMMENT') - 1
  }
  
  start_data <- which(vid_data[, 1] == 'TRACE') + 1
  
  dict <- vid_data[start_dict:end_dict, 1]
  
  dict['num'] <- sapply(strsplit(dict[[1]], ':'), `[`, 1)
  dict['food'] <- sapply(strsplit(dict[[1]], ':'), `[`, 2)
  
  data_tab <- vid_data[start_data:nrow(vid_data), ]
  
  data_names <- as.character(vid_data[start_data - 1, 1:ncol(vid_data)])
  data_names <- data_names[!grepl('NA', data_names)]
  
  data_names <- tolower(data_names)
  
  data_names <- gsub('ti me |time ', 'time', data_names)
  data_names <- gsub('food', 'activity', data_names)
  
  names(data_tab) <- data_names
  data_tab['activity'] <- as.numeric(data_tab[['activity']])
  
  # fill in food names
  data_tab <- merge(data_tab, dict[c('num', 'food')], by.x = 'activity', by.y = 'num', all.x = TRUE, all.y = FALSE)
  data_tab <- data_tab[order(data_tab$start), ]
  
  # clean up foods
  data_tab['food'] <- gsub('carr', 'carrot', data_tab[['food']])
  data_tab['food'] <- gsub('prot', 'protein', data_tab[['food']])
  data_tab['food'] <- gsub('star', 'starch', data_tab[['food']])
  data_tab['food'] <- gsub('rice', 'starch', data_tab[['food']])
  data_tab['food'] <- gsub('bean', 'greenbean', data_tab[['food']])
  data_tab['food'] <- gsub('appl', 'apple', data_tab[['food']])
  data_tab['food'] <- gsub('cook', 'cookie', data_tab[['food']])
  data_tab['food'] <- gsub('watr', 'water', data_tab[['food']])
  
  
  data_tab['id'] <- id_rand
  data_tab['timepoint'] <- cond
  data_tab['group'] <- group
  
  data_tab <- data_tab[c('id', 'group', 'timepoint', data_names, 'food')]
  
  
  # save individual files
  if (!dir.exists(file.path(curated_wd, 'data', 'raw'))) {
    dir.create(file.path(curated_wd, 'data', 'raw'))
  }
  
  # new filename
  
  if (cond == 0){
    cond_str = 'a'
  } else {
    cond_str = 'b'
  }
  
  new_file_name <- paste0('sub-', id_rand, '_assay-microstructure_study-lunch_timepoint-', cond_str, '.csv')
  write.table(data_tab, file.path(curated_wd, 'data', 'raw', new_file_name), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')
  
}

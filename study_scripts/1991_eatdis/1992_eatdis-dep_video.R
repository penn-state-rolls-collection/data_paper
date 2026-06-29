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
base_wd_dep <- '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1992 EatDis Deprivation/Data - Individual/Indiv Excel - Food intake Aug 1994/'

base_wd_lunch <- '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1992 EatDis Mealtime (CAMERA)/Individual Data 1993-94/'


#get list of files
dep_paths <- list.files(path = base_wd_dep, pattern = "\\.XLS$", full.names = TRUE)
dep_paths <- dep_paths[!grepl('FRE', dep_paths)]

dep_files <- list.files(path = base_wd_dep, pattern = "\\.XLS$")
dep_files <- dep_files[!grepl('FRE', dep_files)]

# get id lists and conditions
dep_ids <- regmatches(dep_files, regexpr("D[^.]*", dep_files))
dep_cond <- ifelse(grepl('ND', dep_ids), 'control', ifelse(grepl('D$|DEX', dep_ids), 'deprivaiton', dep_ids))

dep_id_list <- data.frame('id' = dep_ids, 'cond' = dep_cond, 'file_path' = dep_paths)

dep_id_list <- dep_id_list[!grepl('D209ND$', dep_id_list[['id']]), ]
dep_id_list['id'] <- gsub('DEX|DE|NDEX|ND|D|FRE|P', '', dep_id_list[['id']])

# function to fix individual files
parse_vid_records <- function(file_path, id, cond, curated_wd, id_rand) {
  
  print(paste0(id, '-', cond))
  
  vid_data <- read_excel(file_path, col_names = FALSE)
  
  start_dict <- which(vid_data[, 1] == 'Selected activities') + 1
  end_dict <- which(vid_data[, 1] == 'Recordlayout') - 1
  
  start_data <- which(vid_data[, 1] == 'TRACE') + 1
  
  dict <- vid_data[start_dict:end_dict, 1]
  
  dict['num'] <- sapply(strsplit(dict[[1]], ' : '), `[`, 1)
  dict['food'] <- sapply(strsplit(dict[[1]], ' : '), `[`, 2)
  
  data_names <- as.character(vid_data[start_data - 1, 1:ncol(vid_data)])
  
  data_tab <- vid_data[start_data:nrow(vid_data), ]

  data_names <- as.character(vid_data[start_data - 1, 1:ncol(vid_data)])
  data_names <- data_names[!grepl('NA', data_names)]
  data_tab_names <- c(data_names, paste0(data_names[!grepl('thirds', data_names)], '-2'))
  
  if (ncol(data_tab) < length(data_tab_names)) {
    nrep <- length(data_tab_names) - ncol(data_tab)
    empty_column <- rep(NA, nrow(data_tab))
    data_tab <- cbind.data.frame(data_tab, matrix(c(rep(empty_column, nrep)), ncol = nrep))
  }
  
  names(data_tab) <- c(data_names, paste0(data_names[!grepl('thirds', data_names)], '-2'))
  
  data_tab <- merge(data_tab, dict[c('num', 'food')], by.x = 'activity', by.y = 'num', all.x = TRUE, all.y = FALSE)
  
  data_tab <- merge(data_tab, dict[c('num', 'food')], by.x = 'activity-2', by.y = 'num', all.x = TRUE, all.y = FALSE)
  
  names(data_tab)[names(data_tab) == 'food.x'] <- 'food'
  names(data_tab)[names(data_tab) == 'food.y'] <- 'food-2'
  
  data_tab['id'] <- id_rand
  data_tab['cond'] <- cond
  
  data_tab <- data_tab[c('id', 'cond', data_names, 'food', paste0(data_names[!grepl('thirds', data_names)], '-2'), 'food-2')]
  
  names(data_tab) <- tolower(names(data_tab))
  names(data_tab) <- gsub('time ', 'time_', names(data_tab))
  names(data_tab) <- gsub('time_1-2', 'time_2-1', names(data_tab))
  
  # clean up foods
  data_tab['food'] <- gsub('bred', 'bread', data_tab[['food']])
  data_tab['food'] <- gsub('past', 'pasta', data_tab[['food']])
  data_tab['food'] <- gsub('pmri', 'pasta_marinara', data_tab[['food']])
  data_tab['food'] <- gsub('palf', 'pasta_alfredo', data_tab[['food']])
  data_tab['food'] <- gsub('cucm', 'cucumber', data_tab[['food']])
  data_tab['food'] <- gsub('lett', 'lettuce', data_tab[['food']])
  data_tab['food'] <- gsub('tom', 'tomato', data_tab[['food']])
  data_tab['food'] <- gsub('sald', 'salad', data_tab[['food']])
  data_tab['food'] <- gsub('appl', 'apple', data_tab[['food']])
  data_tab['food'] <- gsub('chef', 'chef_salad', data_tab[['food']])
  data_tab['food'] <- gsub('turk', 'turkey', data_tab[['food']])
  data_tab['food'] <- gsub('chse', 'cheese', data_tab[['food']])
  data_tab['food'] <- gsub('chip', 'chips', data_tab[['food']])
  data_tab['food'] <- gsub('cook', 'cookies', data_tab[['food']])
  data_tab['food'] <- gsub('brow', 'brownie', data_tab[['food']])
  data_tab['food'] <- gsub('iccr', 'icecream', data_tab[['food']])
  data_tab['food'] <- gsub('choc', 'chocolate', data_tab[['food']])
  data_tab['food'] <- gsub('watr', 'water', data_tab[['food']])
  
  
  # save individual files
  if (!dir.exists(file.path(curated_wd, 'data', 'raw'))) {
    dir.create(file.path(curated_wd, 'data', 'raw'))
  }
  
  # new filename
  new_file_name <- paste0('sub-', id_rand, '_assay-microstructure_study-dep_cond-', cond, '.csv')
  write.table(data_tab, file.path(curated_wd, 'data', 'raw', new_file_name), quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')
  
}

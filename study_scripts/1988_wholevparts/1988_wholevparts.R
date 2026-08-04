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

# load
intake_data <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1988 Whole versus Parts - unpublished/Data/WVPint.xls')

vas_data <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1988 Whole versus Parts - unpublished/Data/WVPsensVAS.xls')

# fix a miss-assignment of visit number
vas_data[vas_data['id'] == 208 & vas_data['cond'] == 'a', 'session'] <- 2


# merge data into single dataframe
wvp_data <- merge(intake_data, vas_data, by = c('id', 'cond', 'session'), all = TRUE)

# update variable names to be more readable
names(wvp_data) <- gsub('0', '_screen', names(wvp_data))
names(wvp_data) <- gsub('1', '_pre', names(wvp_data))
names(wvp_data) <- gsub('2', '_post', names(wvp_data))

names(wvp_data) <- gsub('sand', 'sandwich_', names(wvp_data))
names(wvp_data) <- gsub('h_postog', 'water_g', names(wvp_data))

names(wvp_data) <- gsub('hung', 'hunger', names(wvp_data))
names(wvp_data) <- gsub('thirs|thir', 'thirst', names(wvp_data))
names(wvp_data) <- gsub('full', 'fullness', names(wvp_data))
names(wvp_data) <- gsub('muche', 'much_eat', names(wvp_data))
names(wvp_data) <- gsub('dte', 'desire_eat', names(wvp_data))

# remove participant because order of conditions unclear
wvp_data <- wvp_data[wvp_data['id'] != 212, ]

# replace ids with randomly generated values
set.seed(19881)
random_ids <- random_id(n = length(unique(wvp_data[['id']])), bytes = 2)

id_count = 0

for (id_val in unique(wvp_data[['id']])){
  id_count <- id_count + 1
  
  wvp_data[wvp_data['id'] == id_val, 'id'] <- random_ids[id_count]
}


# write data dictionary
source('study_scripts/1988_wholevparts/json_dataset_description.R')

# convert formatting to JSON
dataset_json <- RJSONIO::toJSON(dataset_list, pretty = TRUE)

# double check
isValidJSON(dataset_json, asText = TRUE)

# write out curated data and json
write.table(wvp_data, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1988_whole_vs_parts/data/assay-intake_data.csv', quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')

write(dataset_json, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1988_whole_vs_parts/dataset_description.json')





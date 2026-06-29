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
smell_data <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 EatDis Smell/Data - Excel & SAS from SPSS/SMELL1 1995-02-07.xls')

#remove non-smell data
smell_data <- smell_data[c('id', 'group', 'smoke_', 'age', 'ad_ibw', 'adthresh', 'adupsit', 'dc_ibw', 'dcthresh', 'dcupsit', 'length', 'cigspday', 'yrsmoked')]

# deal with pre/post meal and admit vs discharge visits
names(smell_data) <- gsub('ad|ad_', 'admit_', names(smell_data))
names(smell_data) <- gsub('dc|dc_', 'discharge_', names(smell_data))

names(smell_data) <- gsub('ibw', 'perc_ideal_bw', names(smell_data))
names(smell_data)[names(smell_data) == 'length'] <- 'illness_dur'
names(smell_data) <- gsub('cigspday', 'cigs_day', names(smell_data))
names(smell_data) <- gsub('yrsmoked', 'years_smoked', names(smell_data))
names(smell_data) <- gsub('smoke_', 'smoke', names(smell_data))
names(smell_data) <- gsub('thresh', 'odor_threshold', names(smell_data))

# re-base variables to 0
smell_data['group'] <- smell_data['group'] - 1
smell_data['smoke'] <- smell_data['smoke'] - 1

# odor threshold should be negative values
smell_data['admit_odor_threshold'] <- smell_data['admit_odor_threshold']*-1
smell_data['discharge_odor_threshold'] <- smell_data['discharge_odor_threshold']*-1

# no illness duration for controls
smell_data['illness_dur'] <- ifelse(smell_data['group'] == 4, NA, smell_data[['illness_dur']])

# split and then stack for admit and discharge timepoints
pre_smell_data <- smell_data[grepl('^id|group|age|illness|smoke|cig|admit', names(smell_data))]
names(pre_smell_data) <- gsub('admit_', '', names(pre_smell_data))
pre_smell_data['timepoint'] <- 0


post_smell_data <- smell_data[grepl('^id|group|age|illness|smoke|cig|discharge', names(smell_data))]
names(post_smell_data) <- gsub('discharge_', '', names(post_smell_data))
post_smell_data['timepoint'] <- 1

long_smell_data <- rbind.data.frame(pre_smell_data, post_smell_data)

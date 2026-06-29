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
vas_hourly <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 EatDis VAS [hourly] - unpublished/Data - Excel from SPSS/VASdata 1994-03-25.xls', na = "999")

vas_hourly <- vas_hourly[!(vas_hourly['id'] == 501 & vas_hourly['group'] == 1), ]

# fix names to be more readable and consistent
names(vas_hourly) <- gsub('hunger', 'hunger_', names(vas_hourly))
names(vas_hourly) <- gsub('thirst', 'thirst_', names(vas_hourly))
names(vas_hourly) <- gsub('full', 'fullness_', names(vas_hourly))
names(vas_hourly) <- gsub('fear', 'fear_fat_', names(vas_hourly))
names(vas_hourly) <- gsub('binge', 'binge_desire_', names(vas_hourly))
names(vas_hourly) <- gsub('purge', 'purge_desire_', names(vas_hourly))
names(vas_hourly) <- gsub('depres', 'depressed_', names(vas_hourly))
names(vas_hourly) <- gsub('anxiou', 'anxious_', names(vas_hourly))


names(vas_hourly) <- gsub('_a$', '_breakfast_pre', names(vas_hourly))
names(vas_hourly) <- gsub('_b$', '_breakfast_post', names(vas_hourly))
names(vas_hourly) <- gsub('_c$', '_lunch_pre', names(vas_hourly))
names(vas_hourly) <- gsub('_d$', '_lunch_post', names(vas_hourly))
names(vas_hourly) <- gsub('_e$', '_dinner_pre', names(vas_hourly))
names(vas_hourly) <- gsub('_f$', '_dinner_post', names(vas_hourly))

names(vas_hourly) <- gsub('_12$', '_10pm', names(vas_hourly))
names(vas_hourly) <- gsub('_11$', '_9pm', names(vas_hourly))
names(vas_hourly) <- gsub('_10$', '_8pm', names(vas_hourly))
names(vas_hourly) <- gsub('_9$', '_7pm', names(vas_hourly))
names(vas_hourly) <- gsub('_8$', '_6pm', names(vas_hourly))
names(vas_hourly) <- gsub('_7$', '_4pm', names(vas_hourly))
names(vas_hourly) <- gsub('_6$', '_3pm', names(vas_hourly))
names(vas_hourly) <- gsub('_5$', '_2pm', names(vas_hourly))
names(vas_hourly) <- gsub('_4$', '_1pm', names(vas_hourly))
names(vas_hourly) <- gsub('_3$', '_11am', names(vas_hourly))
names(vas_hourly) <- gsub('_2$', '_10am', names(vas_hourly))
names(vas_hourly) <- gsub('_1$', '_9am', names(vas_hourly))

names(vas_hourly)[names(vas_hourly) == 'session'] <- 'week'

# group data
vas_hourly['group'] <- vas_hourly[['group']] - 1
vas_hourly['group'] <- ifelse(vas_hourly[['group']] == 4, 3, vas_hourly[['group']])

                               
# replace clear data missentry value
vas_hourly[!is.na(vas_hourly['thirst_11am']) & vas_hourly['thirst_11am'] > 100, 'thirst_11am'] <- NA
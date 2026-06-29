# This script was upadted/written by Alaina Pearce in Summer 2026
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
library(reshape2)

# load
diff_data <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1990 EatDis Salad Preload - SSS & VAS only/Data - Excel from SPSS sys files/DifSSS.xls')

hunger_data <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1990 EatDis Salad Preload - SSS & VAS only/Data - Excel from SPSS sys files/HungerDat.xls')

sss_exp3_data <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1990 EatDis Salad Preload - SSS & VAS only/Data - Excel from SPSS sys files/SSS1.xls')

# deal with naming in diff data
names(diff_data) <- gsub('dif', 'dif_', names(diff_data))
names(diff_data) <- gsub('app', 'appearance_', names(diff_data))
names(diff_data) <- gsub('sml', 'odor_', names(diff_data))
names(diff_data) <- gsub('tx', 'texture_', names(diff_data))
names(diff_data) <- gsub('tst', 'taste_', names(diff_data))
names(diff_data) <- gsub('des', 'desire_', names(diff_data))

names(diff_data) <- gsub('_1', '_turkey', names(diff_data))
names(diff_data) <- gsub('_2', '_chips', names(diff_data))
names(diff_data) <- gsub('_3', '_cookie', names(diff_data))
names(diff_data) <- gsub('_4', '_led_salad', names(diff_data))
names(diff_data) <- gsub('_5', '_cottage_cheese', names(diff_data))
names(diff_data) <- gsub('_6', '_apple', names(diff_data))
names(diff_data) <- gsub('_7', '_hed_salad', names(diff_data))
names(diff_data) <- gsub('_8', '_snickers', names(diff_data))

names(diff_data) <- gsub('gp', 'group', names(diff_data))
names(diff_data) <- gsub('expt', 'cond', names(diff_data))

names(diff_data) <- gsub('uneat', 'uneaten_', names(diff_data))
names(diff_data) <- gsub('*_$', '', names(diff_data))


# deal with naming in hunger data
names(hunger_data) <- gsub('grp', 'group', names(hunger_data))
names(hunger_data) <- gsub('expt', 'cond', names(hunger_data))

hunger_dat_long <- reshape2::melt(hunger_data, id.vars = c('id', 'group', 'cond'), variable.name = 'time', value.name = 'hunger')

hunger_dat_long['time'] <- ifelse(hunger_dat_long[['time']] == 'hun1', 0, ifelse(hunger_dat_long[['time']] == 'hun2', 1, ifelse(hunger_dat_long[['time']] == 'hun3', 2, 3)))

# deal with naming sss3 data
names(sss_exp3_data) <- gsub('gp', 'group', names(sss_exp3_data))
names(sss_exp3_data) <- gsub('expt', 'cond', names(sss_exp3_data))

names(sss_exp3_data) <- gsub('app', 'appearance_', names(sss_exp3_data))
names(sss_exp3_data) <- gsub('sml', 'odor_', names(sss_exp3_data))
names(sss_exp3_data) <- gsub('tx', 'texture_', names(sss_exp3_data))
names(sss_exp3_data) <- gsub('tst', 'taste_', names(sss_exp3_data))
names(sss_exp3_data) <- gsub('des', 'desire_', names(sss_exp3_data))

names(sss_exp3_data) <- gsub('1$', '_turkey', names(sss_exp3_data))
names(sss_exp3_data) <- gsub('2$', '_chips', names(sss_exp3_data))
names(sss_exp3_data) <- gsub('3$', '_cookie', names(sss_exp3_data))
names(sss_exp3_data) <- gsub('4$', '_led_salad', names(sss_exp3_data))
names(sss_exp3_data) <- gsub('5$', '_cottage_cheese', names(sss_exp3_data))
names(sss_exp3_data) <- gsub('6$', '_apple', names(sss_exp3_data))
names(sss_exp3_data) <- gsub('7$', '_hed_salad', names(sss_exp3_data))
names(sss_exp3_data) <- gsub('8$', '_snickers', names(sss_exp3_data))


# make long
library(dplyr)
library(tidyr)

sss3_rate_long <- sss_exp3_data[!grepl('dif|uneat', names(sss_exp3_data))] %>%
  pivot_longer(
    cols = matches("^(appearance|odor|texture|taste|desire)_[1-4]_"),
    names_to = c(".value", "time", "food"),
    names_pattern = "(.*)_([1-4])_(.*)"
  )

sss3_rate_long <- sss3_rate_long %>%
  tidyr::pivot_wider(
    names_from = food,
    values_from = c(appearance, odor, texture, taste, desire)
  )

# re-base variables to 0
diff_data['group'] <- ifelse(diff_data[['group']] == 5, 3, diff_data[['group']])
diff_data['group'] <- ifelse(diff_data[['group']] < 3, diff_data[['group']] - 1, diff_data[['group']])

diff_data['cond'] <- diff_data[['cond']] - 1

hunger_dat_long['group'] <- ifelse(hunger_dat_long[['group']] < 3, hunger_dat_long[['group']] - 1, hunger_dat_long[['group']])
hunger_dat_long['cond'] <- hunger_dat_long[['cond']] - 1


sss3_rate_long['group'] <- ifelse(sss3_rate_long[['group']] == 5, 3, sss3_rate_long[['group']])
sss3_rate_long['group'] <- ifelse(sss3_rate_long[['group']] < 3, sss3_rate_long[['group']] - 1, sss3_rate_long[['group']])
sss3_rate_long['cond'] <- sss3_rate_long[['cond']] - 1



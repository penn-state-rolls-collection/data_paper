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
sue_data <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 EatDis Food Preference/Data - Excel from SPSS/SueFoods 1993-05-26.xls')

demo_cal_data <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 EatDis Food Preference/Data - Excel from SPSS/FoodPref 1993-05-26.xls')

# clean Sue data ####
names(sue_data) <- gsub('gp', 'group', names(sue_data))

names(sue_data) <- gsub('bakpt', 'baked_potato_', names(sue_data))
names(sue_data) <- gsub('wamel', 'watermelon_', names(sue_data))
names(sue_data) <- gsub('tunas', 'tuna_salad_', names(sue_data))
names(sue_data) <- gsub('bbyog', 'berry_yogurt_', names(sue_data))
names(sue_data) <- gsub('popcn', 'popcorn_', names(sue_data))
names(sue_data) <- gsub('chchz', 'cheddar_cheese_', names(sue_data))
names(sue_data) <- gsub('rootb', 'root_beer_', names(sue_data))
names(sue_data) <- gsub('brice', 'rice_', names(sue_data))
names(sue_data) <- gsub('orang', 'oranges_', names(sue_data))
names(sue_data) <- gsub('feggs', 'friedegg_', names(sue_data))
names(sue_data) <- gsub('pickl', 'dill_pickle_', names(sue_data))
names(sue_data) <- gsub('skimm', 'skim_milk_', names(sue_data))
names(sue_data) <- gsub('ginbr', 'gingerbread_', names(sue_data))
names(sue_data) <- gsub('cslaw', 'coleslaw_', names(sue_data))
names(sue_data) <- gsub('bolog', 'bologna_', names(sue_data))
names(sue_data) <- gsub('salad', 'salad_', names(sue_data))
names(sue_data) <- gsub('lmpie', 'lemon_pie_', names(sue_data))
names(sue_data) <- gsub('beggs', 'boiledegg_', names(sue_data))
names(sue_data) <- gsub('pnapp', 'pineapple_', names(sue_data))
names(sue_data) <- gsub('pizza', 'pizza_', names(sue_data))
names(sue_data) <- gsub('banan', 'banana_', names(sue_data))
names(sue_data) <- gsub('sherb', 'lime_sherbet_', names(sue_data))
names(sue_data) <- gsub('wheat', 'wheat_bread_', names(sue_data))
names(sue_data) <- gsub('celry', 'celery_', names(sue_data))
names(sue_data) <- gsub('punch', 'fruit_punch_', names(sue_data))
names(sue_data) <- gsub('pchip', 'potato_chip_', names(sue_data))
names(sue_data) <- gsub('strwb', 'strawberry_', names(sue_data))
names(sue_data) <- gsub('brocc', 'broccoli_', names(sue_data))
names(sue_data) <- gsub('wintg', 'wintergreen_candy_', names(sue_data))
names(sue_data) <- gsub('turky', 'turkey_', names(sue_data))
names(sue_data) <- gsub('cocon', 'coconut_', names(sue_data))
names(sue_data) <- gsub('melba', 'melba_toast_', names(sue_data))
names(sue_data) <- gsub('icecm', 'choc_icecream_', names(sue_data))
names(sue_data) <- gsub('penut', 'peanuts_', names(sue_data))
names(sue_data) <- gsub('grape', 'grape_', names(sue_data))
names(sue_data) <- gsub('frfry', 'french_fries_', names(sue_data))
names(sue_data) <- gsub('salmn', 'salmon_', names(sue_data))
names(sue_data) <- gsub('cotch', 'cottage_cheese_', names(sue_data))
names(sue_data) <- gsub('chpie', 'cherry_pie_', names(sue_data))
names(sue_data) <- gsub('peach', 'peaches_', names(sue_data))
names(sue_data) <- gsub('steak', 'steak_', names(sue_data))
names(sue_data) <- gsub('wholm', 'whole_milk_', names(sue_data))
names(sue_data) <- gsub('dcola', 'diet_cola_', names(sue_data))
names(sue_data) <- gsub('chsbg', 'cheese_burger_', names(sue_data))
names(sue_data) <- gsub('croll', 'cinnamon_roll_', names(sue_data))
names(sue_data) <- gsub('cukes', 'cucumber_', names(sue_data))
names(sue_data) <- gsub('gjuic', 'grapefruit_juice_', names(sue_data))
names(sue_data) <- gsub('licor', 'licorice_', names(sue_data))
names(sue_data) <- gsub('onion', 'onion_rings_', names(sue_data))
names(sue_data) <- gsub('jello', 'jello_', names(sue_data))

# rating type
names(sue_data) <- gsub('_l', '_like_', names(sue_data))
names(sue_data) <- gsub('_e', '_eat_', names(sue_data))

# pre vs post
names(sue_data) <- gsub('_1', '_pre', names(sue_data))
names(sue_data) <- gsub('_2', '_post', names(sue_data))


# fix intake var names
names(sue_data) <- gsub('egg', '_egg', names(sue_data))
names(sue_data) <- gsub('__', '_', names(sue_data))

# re-base variables to 0
sue_data['group'] <- ifelse(sue_data[['group']] < 5, sue_data[['group']] - 1, sue_data[['group']] - 2)

# split and then stack for admit and discharge timepoints
pre_data <- sue_data[grepl('^id|group|pre', names(sue_data))]
names(pre_data) <- gsub('_pre', '', names(pre_data))
pre_data['timepoint'] <- 0


post_data <- sue_data[grepl('^id|group|post', names(sue_data))]
names(post_data) <- gsub('_post', '', names(post_data))
post_data['timepoint'] <- 1

rate_long_data <- rbind.data.frame(pre_data, post_data)

rate_long_data <- rate_long_data[c('id', 'timepoint', 'group', names(rate_long_data)[!grepl('^id$|timepoint|group', names(rate_long_data))])]

# clean preference data files ####
demo_cal_data <- demo_cal_data[grepl('^id$|local|hical|smoke|ad|dc|upsit|cig|yrs|length|age', names(demo_cal_data))]


names(demo_cal_data) <- gsub('1', '_pre', names(demo_cal_data))
names(demo_cal_data) <- gsub('2', '_post', names(demo_cal_data))
names(demo_cal_data) <- gsub('call', '_cal_like', names(demo_cal_data))
names(demo_cal_data) <- gsub('cale', '_cal_eat', names(demo_cal_data))
names(demo_cal_data) <- gsub('lo_', 'low_', names(demo_cal_data))
names(demo_cal_data) <- gsub('hi_', 'high_', names(demo_cal_data))


names(demo_cal_data) <- gsub('ibw', 'perc_ideal_bw', names(demo_cal_data))

names(demo_cal_data)[grepl('ad', names(demo_cal_data))] <- paste0(names(demo_cal_data)[grepl('ad', names(demo_cal_data))], '_pre')
names(demo_cal_data)[grepl('dc', names(demo_cal_data))] <- paste0(names(demo_cal_data)[grepl('dc', names(demo_cal_data))], '_post')

names(demo_cal_data) <- gsub('ad_|dc_|ad|dc', '', names(demo_cal_data))

names(demo_cal_data) <- gsub('length', 'illness_dur', names(demo_cal_data))
names(demo_cal_data) <- gsub('cigspday', 'cigs_day', names(demo_cal_data))
names(demo_cal_data) <- gsub('yrsmoked', 'years_smoked', names(demo_cal_data))
names(demo_cal_data) <- gsub('smoke_', 'smoke', names(demo_cal_data))

# split and then stack for admit and discharge timepoints
pre_pref_data <- demo_cal_data[grepl('^id|age|illness|smoke|cig|pre', names(demo_cal_data))]
names(pre_pref_data) <- gsub('_pre', '', names(pre_pref_data))
pre_pref_data['timepoint'] <- 0


post_pref_data <- demo_cal_data[grepl('^id|age|illness|smoke|cig|post', names(demo_cal_data))]
names(post_pref_data) <- gsub('_post', '', names(post_pref_data))
post_pref_data['timepoint'] <- 1

long_pref_data <- rbind.data.frame(pre_pref_data, post_pref_data)

# merge with long data ####
long_data_merge <- merge(rate_long_data, long_pref_data, by = c('id', 'timepoint'), all = TRUE)

# re-order
pref_demo_data <- long_data_merge[c('id', 'group', 'age', 'illness_dur', 'smoke', 'cigs_day', 'years_smoked', 'timepoint', 'perc_ideal_bw', 'thresh', 'upsit')]

food_rating_dat <- long_data_merge[c('id', 'group', 'timepoint', names(long_data_merge)[grep('like|eat', names(long_data_merge))])]
food_rating_dat <- food_rating_dat[!grepl('_cal_', names(food_rating_dat))]

food_pref_calc <- long_data_merge[c('id', 'group', 'timepoint', names(long_data_merge)[grep('cal', names(long_data_merge))])]

## make foods data table ####

food_names <- names(food_rating_dat[!grepl('id|group|timepoint|like', names(food_rating_dat))])
food_names <- gsub('_eat', '', food_names)

food_tab <- data.frame(food = food_names)
food_tab['energy_density'] <- c(1.09, 0.31, 1.87, 1.12, 3.86, 4.03, 0.41, 1.29, 0.46, 1.98, 0.11, 2.76, 0.35, 1.76, 3.13, 0.59, 2.50, 1.58, 0.50, 2.42, 0.92, 1.31, 2.54, 0.15, 0.47, 5.29, 0.30, 0.27, 3.89, 1.07, 3.53, 3.20, 2.17, 5.86, 0.63, 3.16, 1.85, 0.73, 2.61, 0.43, 3.24, 0.64, 0.00, 2.67, 3.67, 0.13, 0.39, 4.29, 3.31, 0.07)

food_tab['low_cho'] <- c(0, 1, 1, NA, 0, 1, NA, 0, NA, 1, 1, 0, NA, NA, 1, NA, 0, 1, NA, 0, 0, 0, NA, 1, NA, 0, 1, 1, 0, NA, NA, 0, NA, 1, NA, 0, 1, 1, 0, NA, 1, NA, NA, 0, 0, 1, NA, 0, 0, 1)

food_tab['high_cho'] <- ifelse(!is.na(food_tab[['low_cho']]) & food_tab[['low_cho']] == 1, 0, ifelse(!is.na(food_tab[['low_cho']]) & food_tab[['low_cho']] == 0, 1, NA))

food_tab['low_fat'] <- c(1, 1, 0, NA, 1, 0, NA, 1, NA, 0, 1, 0, NA, NA, 0, NA, 0, 0, NA, 0, 1, 1, NA, 1, NA, 0, 1, 1, 1, NA, NA, 1, NA, 0, NA, 0, 0, 1, 0, NA, 0, NA, NA, 0, 0, 1, NA, 1, 0, 1)
food_tab['high_fat'] <- ifelse(!is.na(food_tab[['low_fat']]) & food_tab[['low_fat']] == 1, 0, ifelse(!is.na(food_tab[['low_fat']]) & food_tab[['low_fat']] == 0, 1, NA))

# get the computed values for fat and cho ####

high_cho_foods <- food_tab[!is.na(food_tab['high_cho']) & food_tab['high_cho'] == 1, 'food']
low_cho_foods <- food_tab[!is.na(food_tab['low_cho']) & food_tab['low_cho'] == 1, 'food']


high_fat_foods <- food_tab[!is.na(food_tab['high_fat']) & food_tab['high_fat'] == 1, 'food']
low_fat_foods <- food_tab[!is.na(food_tab['low_fat']) & food_tab['low_fat'] == 1, 'food']

food_pref_calc['low_cho_like'] <- round(rowMeans(food_rating_dat[names(food_rating_dat) %in% paste0(low_cho_foods, '_like')], na.rm = TRUE), 2)
food_pref_calc['low_cho_eat'] <- round(rowMeans(food_rating_dat[names(food_rating_dat) %in% paste0(low_cho_foods, '_eat')], na.rm = TRUE), 2)

food_pref_calc['high_cho_like'] <- round(rowMeans(food_rating_dat[names(food_rating_dat) %in% paste0(high_cho_foods, '_like')], na.rm = TRUE), 2)
food_pref_calc['high_cho_eat'] <- round(rowMeans(food_rating_dat[names(food_rating_dat) %in% paste0(high_cho_foods, '_eat')], na.rm = TRUE), 2)


food_pref_calc['low_fat_like'] <- round(rowMeans(food_rating_dat[names(food_rating_dat) %in% paste0(low_fat_foods, '_like')], na.rm = TRUE), 2)
food_pref_calc['low_fat_eat'] <- round(rowMeans(food_rating_dat[names(food_rating_dat) %in% paste0(low_fat_foods, '_eat')], na.rm = TRUE), 2)

food_pref_calc['high_fat_like'] <- round(rowMeans(food_rating_dat[names(food_rating_dat) %in% paste0(high_fat_foods, '_like')], na.rm = TRUE), 2)
food_pref_calc['high_fat_eat'] <- round(rowMeans(food_rating_dat[names(food_rating_dat) %in% paste0(high_fat_foods, '_eat')], na.rm = TRUE), 2)


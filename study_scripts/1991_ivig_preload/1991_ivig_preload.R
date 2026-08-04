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
library(reshape2)

# load IV
iv_sub <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 IV&IG Preloads (DifRoute)/Data IV - Excel from SPSS/IVSubChar.xls')

iv_vas1 <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 IV&IG Preloads (DifRoute)/Data IV - Excel from SPSS/IVvas1.xls', na = '999')

iv_vas2 <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 IV&IG Preloads (DifRoute)/Data IV - Excel from SPSS/IVvas2.xls', na = '999')

iv_dinner_kcals <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 IV&IG Preloads (DifRoute)/Data IV - Excel from SPSS/DinCals.xls')

iv_dinner_g <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 IV&IG Preloads (DifRoute)/Data IV - Excel from SPSS/IVdinner.xls')

iv_lunch_kcals <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 IV&IG Preloads (DifRoute)/Data IV - Excel from SPSS/LunCals.xls')

iv_lunch_g <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 IV&IG Preloads (DifRoute)/Data IV - Excel from SPSS/IVlunch.xls')

iv_totals <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 IV&IG Preloads (DifRoute)/Data IV - Excel from SPSS/IVkp meal kcal totals.xls')


# load - IG
ig_sub <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 IV&IG Preloads (DifRoute)/Data IG - Excel from SPSS/IG SubChar.xls')

ig_dinner_kcals <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 IV&IG Preloads (DifRoute)/Data IG - Excel from SPSS/TDinCal DinNutrients.xls')

ig_dinner_g <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 IV&IG Preloads (DifRoute)/Data IG - Excel from SPSS/InFDin DinGrams.xls')

ig_lunch_g<- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 IV&IG Preloads (DifRoute)/Data IG - Excel from SPSS/InFLun LunGrams doesnt match others.xls')

ig_lunch_kcals <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 IV&IG Preloads (DifRoute)/Data IG - Excel from SPSS/LunTemp LunTotKcals.xls')

ig_hvas1 <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 IV&IG Preloads (DifRoute)/Data IG - Excel from SPSS/IGVAS1 HVASpart1.xls', na = '999')

ig_hvas2 <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 IV&IG Preloads (DifRoute)/Data IG - Excel from SPSS/IGVAS2 HVASpart2.xls', na = '999')

ig_hvas3 <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 IV&IG Preloads (DifRoute)/Data IG - Excel from SPSS/IGVAS3 HVASpart3.xls', na = '999')

ig_cck <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 IV&IG Preloads (DifRoute)/Data IG - Excel from SPSS/CCKdata.xls')

# load yogurt preload data
iv_yogurt_lunch_kcals <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 IV&IG Preloads (DifRoute)/Data IV - Excel from SPSS/YlunCal different IDs multivar.xls')

iv_yogurt_lunch_g <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 IV&IG Preloads (DifRoute)/Data IV - Excel from SPSS/YogLun different IDs multivar.xls')

ig_yogurt_lunch_g <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 IV&IG Preloads (DifRoute)/Data IG - Excel from SPSS/YogLun LunGrams1.xls')

ig_yogurt_lunch_kcals <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 IV&IG Preloads (DifRoute)/Data IG - Excel from SPSS/YLunCal LunNutrients.xls')

ig_yogurt_vas <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 IV&IG Preloads (DifRoute)/Data IG - Excel from SPSS/YogVAS HVASsome1.xls', na = '999')


## data org - sub ####

ig_sub['ID'] <- ifelse(ig_sub[['ID']] == 101, 201, ig_sub[['ID']])
# merge ind dif data
sub_char_data <- rbind.data.frame(iv_sub, ig_sub)

#fix height variable
height_matrix <- matrix(c(unlist(strsplit(sub_char_data[['Height']], "'"))), ncol = 2, byrow = TRUE)
height_matrix <- gsub('\"', '', height_matrix)
height_dat <- data.frame(height_matrix)
height_dat <- sapply(c('X1', 'X2'), function(x) as.numeric(height_dat[[x]]))

sub_char_data['Height'] <- (height_dat[, 1]*12) + height_dat[, 2]

# fix variable names
names(sub_char_data) <- tolower(names(sub_char_data))

names(sub_char_data) <- gsub('height', 'height_in', names(sub_char_data))
names(sub_char_data) <- gsub('h/cm', 'height_cm', names(sub_char_data))
names(sub_char_data) <- gsub('%ibw', 'perc_ideal_bw', names(sub_char_data))


## data org - IV VAS ####

# merge ind dif data
iv_vas <- merge(iv_vas1, iv_vas2[!grepl('sess', names(iv_vas2))], by = 'id')

# fix names to make easier to parse
names(iv_vas) <- gsub('a', 'a_', names(iv_vas))
names(iv_vas) <- gsub('b', 'b_', names(iv_vas))
names(iv_vas) <- gsub('c', 'c_', names(iv_vas))
names(iv_vas) <- gsub('na_us', 'naus', names(iv_vas))

# make long
library(dplyr)
library(tidyr)

iv_vas_long <- iv_vas[!grepl('sess', names(iv_vas))] %>%
  pivot_longer(
    cols = -id,
    names_to = c(".value", "time"),
    names_pattern = "(.*)_(.*)$"
  )


# update names
names(iv_vas_long) <- gsub('hung', 'hunger_', names(iv_vas_long))
names(iv_vas_long) <- gsub('thir', 'thirst_', names(iv_vas_long))
names(iv_vas_long) <- gsub('full', 'fullness_', names(iv_vas_long))
names(iv_vas_long) <- gsub('naus', 'nausea_', names(iv_vas_long))
names(iv_vas_long) <- gsub('desi', 'desire_', names(iv_vas_long))

iv_vas_long <- iv_vas_long %>%
  pivot_longer(
    cols = -c(id, time),
    names_to = c(".value", "cond"),
    names_pattern = "(.*)_(.*)$"
  )


## data org - IG VAS ####

# merge ind dif data
ig_hvas1['id'] <- ig_hvas2[['id']]
ig_vas <- merge(ig_hvas1, ig_hvas2, by = 'id')
ig_vas <- merge(ig_vas, ig_hvas3[!grepl('sess', names(ig_hvas3))], by = 'id')

# fix names to make easier to parse
names(ig_vas) <- gsub('a', 'a_', names(ig_vas))
names(ig_vas) <- gsub('b', 'b_', names(ig_vas))
names(ig_vas) <- gsub('c', 'c_', names(ig_vas))
names(ig_vas) <- gsub('d', 'd_', names(ig_vas))
names(ig_vas) <- gsub('e', 'e_', names(ig_vas))
names(ig_vas) <- gsub('f', 'f_', names(ig_vas))

names(ig_vas) <- gsub('na_us', 'naus', names(ig_vas))
names(ig_vas) <- gsub('d_e_si', 'desi', names(ig_vas))
names(ig_vas) <- gsub('f_ull', 'full', names(ig_vas))
names(ig_vas) <- gsub('c_ra_m', 'cram', names(ig_vas))
names(ig_vas) <- gsub('b_loa_', 'bloa', names(ig_vas))
names(ig_vas) <- gsub('se_ss', 'sess', names(ig_vas))
names(ig_vas) <- gsub('id_$', 'id', names(ig_vas))

# make long
ig_vas_long <- ig_vas[!grepl('sess', names(ig_vas))] %>%
  pivot_longer(
    cols = -id,
    names_to = c(".value", "time"),
    names_pattern = "(.*)_(.*)$"
  )

# update names
names(ig_vas_long) <- gsub('hung', 'hunger_', names(ig_vas_long))
names(ig_vas_long) <- gsub('thir', 'thirst_', names(ig_vas_long))
names(ig_vas_long) <- gsub('full', 'fullness_', names(ig_vas_long))
names(ig_vas_long) <- gsub('naus', 'nausea_', names(ig_vas_long))
names(ig_vas_long) <- gsub('desi', 'desire_', names(ig_vas_long))
names(ig_vas_long) <- gsub('bloa', 'bloated_', names(ig_vas_long))
names(ig_vas_long) <- gsub('cram', 'cramps_', names(ig_vas_long))

ig_vas_long <- ig_vas_long %>%
  pivot_longer(
    cols = -c(id, time),
    names_to = c(".value", "cond"),
    names_pattern = "(.*)_(.*)$"
  )

## data org - IV dinner ####

# add units to names
iv_dinner_kcals['cond'] <- ifelse(iv_dinner_kcals[['cond']] == 1, 'a', ifelse(iv_dinner_kcals[['cond']] == 2, 'b', 'c'))

names(iv_dinner_g)[!grepl('id|sess|cond|time', names(iv_dinner_g))] <- paste0(names(iv_dinner_g)[!grepl('id|sess|cond|time', names(iv_dinner_g))], '_g')

# merge ind dif data
iv_dinner <- merge(iv_dinner_g, iv_dinner_kcals[!grepl('sess|time|wat', names(iv_dinner_kcals))], by = c('id', 'cond'))

# fix names to make easier to parse
names(iv_dinner) <- gsub('sess', 'session', names(iv_dinner))
names(iv_dinner) <- gsub('chick', 'chicken', names(iv_dinner))
names(iv_dinner) <- gsub('rgrv', 'gravy', names(iv_dinner))
names(iv_dinner) <- gsub('lgrv', 'light_gravy', names(iv_dinner))
names(iv_dinner) <- gsub('mar', 'margarine', names(iv_dinner))
names(iv_dinner) <- gsub('cook', 'cookie', names(iv_dinner))
names(iv_dinner) <- gsub('rpud', 'pudding', names(iv_dinner))
names(iv_dinner) <- gsub('ffpud', 'fatfree_pudding', names(iv_dinner))
names(iv_dinner) <- gsub('wat', 'water', names(iv_dinner))

names(iv_dinner) <- gsub('cal', '_cal', names(iv_dinner))
names(iv_dinner) <- gsub('pro', '_pro', names(iv_dinner))
names(iv_dinner) <- gsub('fat', '_fat', names(iv_dinner))
names(iv_dinner) <- gsub('cho', '_cho', names(iv_dinner))

names(iv_dinner) <- gsub('_fatfree', 'fatfree', names(iv_dinner))

names(iv_dinner) <- gsub('chic_', 'chicken_', names(iv_dinner))
names(iv_dinner) <- gsub('fpud_', 'fatfree_pudding_', names(iv_dinner))

names(iv_dinner) <- gsub('d_', 'dinner_', names(iv_dinner))
names(iv_dinner) <- gsub('proclp', 'perc_pro_cal', names(iv_dinner))
names(iv_dinner) <- gsub('fatclp', 'perc_fat_cal', names(iv_dinner))
names(iv_dinner) <- gsub('choclp', 'perc_cho_cal', names(iv_dinner))

names(iv_dinner) <- gsub('pro$', 'pro_g', names(iv_dinner))
names(iv_dinner) <- gsub('cho$', 'cho_g', names(iv_dinner))
names(iv_dinner) <- gsub('fat$', 'fat_g', names(iv_dinner))


## data org - IG dinner ####

# make long format
ig_dinner_kcals_long <- ig_dinner_kcals[!grepl('subdf', names(ig_dinner_kcals))] %>%
  pivot_longer(
    cols = -subac,
    names_to = c(".value", "cond"),
    names_pattern = "^(.*)([a-f]$)"
  )

ig_dinner_g_long <- ig_dinner_g[!grepl('subdf', names(ig_dinner_g))] %>%
  pivot_longer(
    cols = -subac,
    names_to = c(".value", "cond"),
    names_pattern = "^(.*)([a-f]$)"
  )

names(ig_dinner_kcals_long) <- gsub('subac', 'id', names(ig_dinner_kcals_long))
names(ig_dinner_g_long) <- gsub('subac', 'id', names(ig_dinner_g_long))

#add units
names(ig_dinner_g_long)[!grepl('id|ses|cond|tim', names(ig_dinner_g_long))] <- paste0(names(ig_dinner_g_long)[!grepl('id|ses|cond|tim', names(ig_dinner_g_long))], '_g')

# merge ind dif data
ig_dinner <- merge(ig_dinner_g_long, ig_dinner_kcals_long[!grepl('ses|tim|wat|rgrv', names(ig_dinner_kcals_long))], by = c('id', 'cond'))

# fix names to make easier to parse
names(ig_dinner) <- gsub('ses', 'session', names(ig_dinner))
names(ig_dinner) <- gsub('tim', 'time', names(ig_dinner))

names(ig_dinner) <- gsub('chick', 'chicken', names(ig_dinner))
names(ig_dinner) <- gsub('rgrv', 'gravy', names(ig_dinner))
names(ig_dinner) <- gsub('lgrv', 'light_gravy', names(ig_dinner))
names(ig_dinner) <- gsub('ric', 'rice', names(ig_dinner))
names(ig_dinner) <- gsub('mar', 'margarine', names(ig_dinner))
names(ig_dinner) <- gsub('pea', 'peas', names(ig_dinner))
names(ig_dinner) <- gsub('cok', 'cookie', names(ig_dinner))
names(ig_dinner) <- gsub('rpud', 'pudding', names(ig_dinner))
names(ig_dinner) <- gsub('ffpud', 'fatfree_pudding', names(ig_dinner))
names(ig_dinner) <- gsub('watr', 'water', names(ig_dinner))
names(ig_dinner) <- gsub('peass', 'peas', names(ig_dinner))
names(ig_dinner) <- gsub('ricee', 'rice', names(ig_dinner))

names(ig_dinner) <- gsub('cal', '_cal', names(ig_dinner))
names(ig_dinner) <- gsub('pro', '_pro_g', names(ig_dinner))
names(ig_dinner) <- gsub('fat', '_fat_g', names(ig_dinner))
names(ig_dinner) <- gsub('cho', '_cho_g', names(ig_dinner))

names(ig_dinner) <- gsub('_fat_gfree', 'fatfree', names(ig_dinner))
names(ig_dinner) <- gsub('chic_', 'chicken_', names(ig_dinner))
names(ig_dinner) <- gsub('fpud_', 'fatfree_pudding_', names(ig_dinner))

#fix fatfree pudding values
ig_dinner['gravy_cal'] <- ig_dinner['gravy_g']*0.319
ig_dinner['gravy_fat_g'] <- ig_dinner['gravy_g']*0.007
ig_dinner['gravy_pro_g'] <- ig_dinner['gravy_g']*0.010
ig_dinner['gravy_cho_g'] <- ig_dinner['gravy_g']*0.055

ig_dinner['fatfree_pudding_cal'] <- ig_dinner['fatfree_pudding_g']*0.882
ig_dinner['fatfree_pudding_fat_g'] <- ig_dinner['fatfree_pudding_g']*0.0
ig_dinner['fatfree_pudding_pro_g'] <- ig_dinner['fatfree_pudding_g']*0.026
ig_dinner['fatfree_pudding_cho_g'] <- ig_dinner['fatfree_pudding_g']*0.203

ig_dinner['dinner_cal'] <- rowSums(ig_dinner[grepl('_cal', names(ig_dinner))])
ig_dinner['dinner_fat_g'] <- rowSums(ig_dinner[grepl('_fat_g', names(ig_dinner))])
ig_dinner['dinner_pro_g'] <- rowSums(ig_dinner[grepl('_pro_g', names(ig_dinner))])
ig_dinner['dinner_cho_g'] <- rowSums(ig_dinner[grepl('_cho_g', names(ig_dinner))])
ig_dinner['dinner_fat_cal'] <- ig_dinner['dinner_fat_g']*9
ig_dinner['dinner_perc_fat_cal'] <- ig_dinner['dinner_fat_cal']/ig_dinner['dinner_cal'] 
ig_dinner['dinner_pro_cal'] <- ig_dinner['dinner_pro_g']*4
ig_dinner['dinner_perc_pro_cal'] <- ig_dinner['dinner_pro_cal']/ig_dinner['dinner_cal'] 
ig_dinner['dinner_cho_cal'] <- ig_dinner['dinner_cho_g']*4
ig_dinner['dinner_perc_cho_cal'] <- ig_dinner['dinner_cho_cal']/ig_dinner['dinner_cal'] 

## data org - IV Lunch ####

# add units to names
iv_lunch_kcals['cond'] <- ifelse(iv_lunch_kcals[['cond']] == 1, 'a', ifelse(iv_lunch_kcals[['cond']] == 2, 'b', 'c'))

iv_lunch_g['cond'] <- tolower(iv_lunch_g[['cond']])
names(iv_lunch_g)[!grepl('id|sess|cond|time', names(iv_lunch_g))] <- paste0(names(iv_lunch_g)[!grepl('id|sess|cond|time', names(iv_lunch_g))], '_g')


# merge ind dif data
iv_lunch <- merge(iv_lunch_g, iv_lunch_kcals[!grepl('sess|time|wat', names(iv_lunch_kcals))], by = c('id', 'cond'))

# fix names to make easier to parse
names(iv_lunch) <- gsub('sess', 'session', names(iv_lunch))

names(iv_lunch) <- gsub('pret', 'pretzel', names(iv_lunch))
names(iv_lunch) <- gsub('must', 'mustard', names(iv_lunch))
names(iv_lunch) <- gsub('brd', 'bread', names(iv_lunch))
names(iv_lunch) <- gsub('let', 'lettuce', names(iv_lunch))
names(iv_lunch) <- gsub('tom', 'tomato', names(iv_lunch))
names(iv_lunch) <- gsub('cuc', 'cucumber', names(iv_lunch))
names(iv_lunch) <- gsub('turk', 'turkey', names(iv_lunch))
names(iv_lunch) <- gsub('tuna', 'tuna_salad', names(iv_lunch))
names(iv_lunch) <- gsub('rdrs', 'dressing', names(iv_lunch))
names(iv_lunch) <- gsub('rdres', 'dressing', names(iv_lunch))
names(iv_lunch) <- gsub('ldres', 'lc_dressing', names(iv_lunch))
names(iv_lunch) <- gsub('ldrs', 'lc_dressing', names(iv_lunch))
names(iv_lunch) <- gsub('wat', 'water', names(iv_lunch))
names(iv_lunch) <- gsub('app', 'apple', names(iv_lunch))
names(iv_lunch) <- gsub('ice', 'icecream', names(iv_lunch))
names(iv_lunch) <- gsub('icecreamcm', 'icecream', names(iv_lunch))
names(iv_lunch) <- gsub('sort', 'sorbet', names(iv_lunch))
names(iv_lunch) <- gsub('dor', 'chips', names(iv_lunch))
names(iv_lunch) <- gsub('ches', 'cheese', names(iv_lunch))

names(iv_lunch) <- gsub('cal$', '_cal', names(iv_lunch))
names(iv_lunch) <- gsub('pro$', '_pro_g', names(iv_lunch))
names(iv_lunch) <- gsub('cho$', '_cho_g', names(iv_lunch))
names(iv_lunch) <- gsub('fat$', '_fat_g', names(iv_lunch))

names(iv_lunch) <- gsub('l_', 'lunch_', names(iv_lunch))
names(iv_lunch) <- gsub('lfat', 'lunch_fat', names(iv_lunch))
names(iv_lunch) <- gsub('lcho', 'lunch_cho', names(iv_lunch))
names(iv_lunch) <- gsub('lpro', 'lunch_pro', names(iv_lunch))

names(iv_lunch) <- gsub('proclp', 'perc_pro_cal', names(iv_lunch))
names(iv_lunch) <- gsub('fatclp', 'perc_fat_cal', names(iv_lunch))
names(iv_lunch) <- gsub('choclp', 'perc_cho_cal', names(iv_lunch))

names(iv_lunch) <- gsub('pretzelunch', 'pretzel', names(iv_lunch))

## data org - IG Lunch ####

# make long format
ig_lunch_kcals_long <- ig_lunch_kcals %>%
  pivot_longer(
    cols = -id,
    names_to = c(".value", "cond"),
    names_pattern = "^(.*)([a-f]$)"
  )

ig_lunch_g_long <- ig_lunch_g[!grepl('subdf', names(ig_lunch_g))] %>%
  pivot_longer(
    cols = -subac,
    names_to = c(".value", "cond"),
    names_pattern = "^(.*)([a-f]$)"
  )

names(ig_lunch_g_long) <- gsub('subac', 'id', names(ig_lunch_g_long))

# add units to names
names(ig_lunch_g_long)[!grepl('id|ses|cond|tim', names(ig_lunch_g_long))] <- paste0(names(ig_lunch_g_long)[!grepl('id|ses|cond|tim', names(ig_lunch_g_long))], '_g')

# fix a split variable
ig_lunch_g_long['tom_g'] <- ifelse(is.na(ig_lunch_g_long[['tom_g']]), ig_lunch_g_long[['toma_g']], ig_lunch_g_long[['tom_g']])

ig_lunch_g_long <- ig_lunch_g_long[names(ig_lunch_g_long)[!grepl('toma', names(ig_lunch_g_long))]]

# compute vars included in IV with documented info
ig_lunch_g_long['dor_cal'] <- ig_lunch_g_long['dor_g']*4.94
ig_lunch_g_long['dor_fat_g'] <- ig_lunch_g_long['dor_g']*0.25
ig_lunch_g_long['dor_cho_g'] <- ig_lunch_g_long['dor_g']*0.64
ig_lunch_g_long['dor_pro_g'] <- ig_lunch_g_long['dor_g']*0.07

ig_lunch_g_long['pret_cal'] <- ig_lunch_g_long['pret_g']*3.88
ig_lunch_g_long['pret_fat_g'] <- ig_lunch_g_long['pret_g']*0.04
ig_lunch_g_long['pret_cho_g'] <- ig_lunch_g_long['pret_g']*0.78
ig_lunch_g_long['pret_pro_g'] <- ig_lunch_g_long['pret_g']*0.11

ig_lunch_g_long['must_cal'] <- ig_lunch_g_long['must_g']*1.14
ig_lunch_g_long['must_fat_g'] <- ig_lunch_g_long['must_g']*0.30
ig_lunch_g_long['must_cho_g'] <- ig_lunch_g_long['must_g']*0.30
ig_lunch_g_long['must_pro_g'] <- ig_lunch_g_long['must_g']*0.30

ig_lunch_g_long['mayo_cal'] <- ig_lunch_g_long['mayo_g']*7.14
ig_lunch_g_long['mayo_fat_g'] <- ig_lunch_g_long['mayo_g']*0.79
ig_lunch_g_long['mayo_cho_g'] <- ig_lunch_g_long['mayo_g']*0.00
ig_lunch_g_long['mayo_pro_g'] <- ig_lunch_g_long['mayo_g']*0.01

ig_lunch_g_long['brd_cal'] <- ig_lunch_g_long['brd_g']*2.61
ig_lunch_g_long['brd_fat_g'] <- ig_lunch_g_long['brd_g']*0.00
ig_lunch_g_long['brd_cho_g'] <- ig_lunch_g_long['brd_g']*0.48
ig_lunch_g_long['brd_pro_g'] <- ig_lunch_g_long['brd_g']*0.09

ig_lunch_g_long['let_cal'] <- ig_lunch_g_long['let_g']*0.15
ig_lunch_g_long['let_fat_g'] <- ig_lunch_g_long['let_g']*0.00
ig_lunch_g_long['let_cho_g'] <- ig_lunch_g_long['let_g']*0.02
ig_lunch_g_long['let_pro_g'] <- ig_lunch_g_long['let_g']*0.01

ig_lunch_g_long['tom_cal'] <- ig_lunch_g_long['tom_g']*0.20
ig_lunch_g_long['tom_fat_g'] <- ig_lunch_g_long['tom_g']*0.00
ig_lunch_g_long['tom_cho_g'] <- ig_lunch_g_long['tom_g']*0.04
ig_lunch_g_long['tom_pro_g'] <- ig_lunch_g_long['tom_g']*0.01

ig_lunch_g_long['cuc_cal'] <- ig_lunch_g_long['cuc_g']*0.14
ig_lunch_g_long['cuc_fat_g'] <- ig_lunch_g_long['cuc_g']*0.00
ig_lunch_g_long['cuc_cho_g'] <- ig_lunch_g_long['cuc_g']*0.03
ig_lunch_g_long['cuc_pro_g'] <- ig_lunch_g_long['cuc_g']*0.01

ig_lunch_g_long['ches_cal'] <- ig_lunch_g_long['ches_g']*3.93
ig_lunch_g_long['ches_fat_g'] <- ig_lunch_g_long['ches_g']*0.32
ig_lunch_g_long['ches_cho_g'] <- ig_lunch_g_long['ches_g']*0.04
ig_lunch_g_long['ches_pro_g'] <- ig_lunch_g_long['ches_g']*0.25

ig_lunch_g_long['turk_cal'] <- ig_lunch_g_long['turk_g']*1.47
ig_lunch_g_long['turk_fat_g'] <- ig_lunch_g_long['turk_g']*0.26
ig_lunch_g_long['turk_cho_g'] <- ig_lunch_g_long['turk_g']*0.00
ig_lunch_g_long['turk_pro_g'] <- ig_lunch_g_long['turk_g']*0.19

ig_lunch_g_long['tuna_cal'] <- ig_lunch_g_long['tuna_g']*2.95
ig_lunch_g_long['tuna_fat_g'] <- ig_lunch_g_long['tuna_g']*0.26
ig_lunch_g_long['tuna_cho_g'] <- ig_lunch_g_long['tuna_g']*0.00
ig_lunch_g_long['tuna_pro_g'] <- ig_lunch_g_long['tuna_g']*0.16

ig_lunch_g_long['rdrs_cal'] <- ig_lunch_g_long['rdrs_g']*4.60
ig_lunch_g_long['rdrs_fat_g'] <- ig_lunch_g_long['rdrs_g']*0.47
ig_lunch_g_long['rdrs_cho_g'] <- ig_lunch_g_long['rdrs_g']*0.10
ig_lunch_g_long['rdrs_pro_g'] <- ig_lunch_g_long['rdrs_g']*0.01

ig_lunch_g_long['ldrs_cal'] <- ig_lunch_g_long['ldrs_g']*0.51
ig_lunch_g_long['ldrs_fat_g'] <- ig_lunch_g_long['ldrs_g']*0.00
ig_lunch_g_long['ldrs_cho_g'] <- ig_lunch_g_long['ldrs_g']*0.09
ig_lunch_g_long['ldrs_pro_g'] <- ig_lunch_g_long['ldrs_g']*0.00

ig_lunch_g_long['milk_cal'] <- ig_lunch_g_long['milk_g']*4.57
ig_lunch_g_long['milk_fat_g'] <- ig_lunch_g_long['milk_g']*0.17
ig_lunch_g_long['milk_cho_g'] <- ig_lunch_g_long['milk_g']*0.69
ig_lunch_g_long['milk_pro_g'] <- ig_lunch_g_long['milk_g']*0.05

ig_lunch_g_long['app_cal'] <- ig_lunch_g_long['app_g']*0.59
ig_lunch_g_long['app_fat_g'] <- ig_lunch_g_long['app_g']*0.00
ig_lunch_g_long['app_cho_g'] <- ig_lunch_g_long['app_g']*0.15
ig_lunch_g_long['app_pro_g'] <- ig_lunch_g_long['app_g']*0.00

ig_lunch_g_long['ice_cal'] <- ig_lunch_g_long['ice_g']*2.70
ig_lunch_g_long['ice_fat_g'] <- ig_lunch_g_long['ice_g']*0.17
ig_lunch_g_long['ice_cho_g'] <- ig_lunch_g_long['ice_g']*0.24
ig_lunch_g_long['ice_pro_g'] <- ig_lunch_g_long['ice_g']*0.05

ig_lunch_g_long['sorb_cal'] <- ig_lunch_g_long['sorb_g']*1.28
ig_lunch_g_long['sorb_fat_g'] <- ig_lunch_g_long['sorb_g']*0.00
ig_lunch_g_long['sorb_cho_g'] <- ig_lunch_g_long['sorb_g']*0.33
ig_lunch_g_long['sorb_pro_g'] <- ig_lunch_g_long['sorb_g']*0.00


# merge ind dif data
ig_lunch <- merge(ig_lunch_g_long, ig_lunch_kcals_long[!grepl('ses|tim', names(ig_lunch_kcals_long))], by = c('id', 'cond'))

# fix names to make easier to parse
names(ig_lunch) <- gsub('ses', 'session', names(ig_lunch))
names(ig_lunch) <- gsub('tim', 'time', names(ig_lunch))

names(ig_lunch) <- gsub('pret', 'pretzel', names(ig_lunch))
names(ig_lunch) <- gsub('must', 'mustard', names(ig_lunch))
names(ig_lunch) <- gsub('brd', 'bread', names(ig_lunch))
names(ig_lunch) <- gsub('let', 'lettuce', names(ig_lunch))
names(ig_lunch) <- gsub('tom', 'tomato', names(ig_lunch))
names(ig_lunch) <- gsub('cuc', 'cucumber', names(ig_lunch))
names(ig_lunch) <- gsub('turk', 'turkey', names(ig_lunch))
names(ig_lunch) <- gsub('tuna', 'tuna_salad', names(ig_lunch))
names(ig_lunch) <- gsub('rdrs', 'dressing', names(ig_lunch))
names(ig_lunch) <- gsub('ldrs', 'lc_dressing', names(ig_lunch))
names(ig_lunch) <- gsub('watr', 'water', names(ig_lunch))
names(ig_lunch) <- gsub('app', 'apple', names(ig_lunch))
names(ig_lunch) <- gsub('ice', 'icecream', names(ig_lunch))
names(ig_lunch) <- gsub('sorb', 'sorbet', names(ig_lunch))
names(ig_lunch) <- gsub('dor', 'chips', names(ig_lunch))
names(ig_lunch) <- gsub('ches', 'cheese', names(ig_lunch))

names(ig_lunch) <- gsub('lcal', 'lunch_cal', names(ig_lunch))
names(ig_lunch) <- gsub('lfat$', 'lunch_fat_g', names(ig_lunch))
names(ig_lunch) <- gsub('lcho$', 'lunch_cho_g', names(ig_lunch))
names(ig_lunch) <- gsub('lpro$', 'lunch_pro_g', names(ig_lunch))

names(ig_lunch) <- gsub('lfatcal', 'lunch_fat_cal', names(ig_lunch))
names(ig_lunch) <- gsub('lchocal', 'lunch_cho_cal', names(ig_lunch))
names(ig_lunch) <- gsub('lprocal', 'lunch_pro_cal', names(ig_lunch))

names(ig_lunch) <- gsub('lproclp', 'lunch_perc_pro_cal', names(ig_lunch))
names(ig_lunch) <- gsub('lfatclp', 'lunch_perc_fat_cal', names(ig_lunch))
names(ig_lunch) <- gsub('lchoclp', 'lunch_perc_cho_cal', names(ig_lunch))

## data org - IV totals ####
iv_totals['cond'] <- ifelse(iv_totals[['cond']] == 1, 'a', ifelse(iv_totals[['cond']] == 2, 'b', 'c'))

names(iv_totals) <- gsub('lun', 'lunch_', names(iv_totals))
names(iv_totals) <- gsub('din', 'dinner_', names(iv_totals))
names(iv_totals) <- gsub('ldebp', 'day_total_', names(iv_totals))
names(iv_totals) <- gsub('ld', 'meals_', names(iv_totals))
names(iv_totals) <- gsub('preload', 'preload_cal', names(iv_totals))
names(iv_totals) <- gsub('lp', 'lunch_prelaod_', names(iv_totals))
names(iv_totals) <- gsub('ldp', 'meals_prelaod_', names(iv_totals))

## data org - IV yogurt lunch ####

#convert to long format and merge
iv_yogurt_g_long <- iv_yogurt_lunch_g %>%
  pivot_longer(
    cols = -id,
    names_to = c(".value", "cond"),
    names_pattern = "(.*)([1-3])$"
  )

names(iv_yogurt_g_long)[!grepl('id|cond|time|sess', names(iv_yogurt_g_long))] <- paste0(names(iv_yogurt_g_long)[!grepl('id|cond|time|sess', names(iv_yogurt_g_long))], '_g')

iv_yogurt_kcal_long <- iv_yogurt_lunch_kcals %>%
  pivot_longer(
    cols = -id,
    names_to = c(".value", "cond"),
    names_pattern = "(.*)([1-3])$"
  )

iv_yogurt <- merge(iv_yogurt_g_long, iv_yogurt_kcal_long[!grepl('sess|time|water|yog', names(iv_yogurt_kcal_long))], by = c('id', 'cond'))

#fix names
names(iv_yogurt) <- gsub('sess', 'session', names(iv_yogurt))

names(iv_yogurt) <- gsub('cal$', '_cal', names(iv_yogurt))
names(iv_yogurt) <- gsub('pro$', '_pro_g', names(iv_yogurt))
names(iv_yogurt) <- gsub('cho$', '_cho_g', names(iv_yogurt))
names(iv_yogurt) <- gsub('fat$', '_fat_g', names(iv_yogurt))

names(iv_yogurt) <- gsub('rdor', 'chips', names(iv_yogurt))
names(iv_yogurt) <- gsub('pret', 'pretzel', names(iv_yogurt))
names(iv_yogurt) <- gsub('must', 'mustard', names(iv_yogurt))
names(iv_yogurt) <- gsub('lett', 'lettuce', names(iv_yogurt))
names(iv_yogurt) <- gsub('tom', 'tomato', names(iv_yogurt))
names(iv_yogurt) <- gsub('cuc', 'cucumber', names(iv_yogurt))
names(iv_yogurt) <- gsub('turk', 'turkey', names(iv_yogurt))
names(iv_yogurt) <- gsub('tuna', 'tuna_salad', names(iv_yogurt))
names(iv_yogurt) <- gsub('rdress', 'dressing', names(iv_yogurt))
names(iv_yogurt) <- gsub('ldress', 'lc_dressing', names(iv_yogurt))
names(iv_yogurt) <- gsub('app', 'apple', names(iv_yogurt))
names(iv_yogurt) <- gsub('chice', 'icecream', names(iv_yogurt))
names(iv_yogurt) <- gsub('rsorb', 'sorbet', names(iv_yogurt))
names(iv_yogurt) <- gsub('yog', 'yogurt', names(iv_yogurt))

names(iv_yogurt) <- gsub('dor_', 'chips_', names(iv_yogurt))
names(iv_yogurt) <- gsub('brd', 'bread', names(iv_yogurt))
names(iv_yogurt) <- gsub('let_', 'lettuce_', names(iv_yogurt))
names(iv_yogurt) <- gsub('ches', 'cheese', names(iv_yogurt))
names(iv_yogurt) <- gsub('rdrs', 'dressing', names(iv_yogurt))
names(iv_yogurt) <- gsub('ldrs', 'lc_dressing', names(iv_yogurt))
names(iv_yogurt) <- gsub('ice_', 'icecream_', names(iv_yogurt))
names(iv_yogurt) <- gsub('sort', 'sorbet', names(iv_yogurt))
names(iv_yogurt) <- gsub('ches', 'cheese', names(iv_yogurt))

names(iv_yogurt) <- gsub('l_', 'lunch_', names(iv_yogurt))
names(iv_yogurt) <- gsub('lfat', 'lunch_fat', names(iv_yogurt))
names(iv_yogurt) <- gsub('lcho', 'lunch_cho', names(iv_yogurt))
names(iv_yogurt) <- gsub('lpro', 'lunch_pro', names(iv_yogurt))

names(iv_yogurt) <- gsub('proclp', 'perc_pro_cal', names(iv_yogurt))
names(iv_yogurt) <- gsub('fatclp', 'perc_fat_cal', names(iv_yogurt))
names(iv_yogurt) <- gsub('choclp', 'perc_cho_cal', names(iv_yogurt))

names(iv_yogurt) <- gsub('pretzelunch', 'pretzel', names(iv_yogurt))
names(iv_yogurt) <- gsub('^y_', 'yogurt_', names(iv_yogurt))
names(iv_yogurt) <- gsub('mway_', 'chocolate_', names(iv_yogurt))

## data org - IG yogurt lunch ####

#convert to long format and merge
ig_yogurt_lunch_g['cond'] <- tolower(ig_yogurt_lunch_g[['cond']])
names(ig_yogurt_lunch_g)[names(ig_yogurt_lunch_g) == 'subno'] <- 'id'

names(ig_yogurt_lunch_g)[!grepl('id|cond|session|time', names(ig_yogurt_lunch_g))] <- paste0(names(ig_yogurt_lunch_g)[!grepl('id|cond|session|time', names(ig_yogurt_lunch_g))], '_g')

ig_yogurt_kcal_long <- ig_yogurt_lunch_kcals %>%
  pivot_longer(
    cols = -subno,
    names_to = c(".value", "cond"),
    names_pattern = "(.*)([a-c])$"
  )

names(ig_yogurt_kcal_long)[names(ig_yogurt_kcal_long) == 'subno'] <- 'id'

ig_yogurt <- merge(ig_yogurt_lunch_g, ig_yogurt_kcal_long[!grepl('sess|ytime|ltime|water|yog', names(ig_yogurt_kcal_long))], by = c('id', 'cond'))

#fix names
names(ig_yogurt) <- gsub('ytime', 'time_yogurt', names(ig_yogurt))
names(ig_yogurt) <- gsub('ltime', 'time', names(ig_yogurt))

names(ig_yogurt) <- gsub('cal$', '_cal', names(ig_yogurt))
names(ig_yogurt) <- gsub('pro$', '_pro_g', names(ig_yogurt))
names(ig_yogurt) <- gsub('cho$', '_cho_g', names(ig_yogurt))
names(ig_yogurt) <- gsub('fat$', '_fat_g', names(ig_yogurt))

names(ig_yogurt) <- gsub('pretzels', 'pretzel', names(ig_yogurt))
names(ig_yogurt) <- gsub('regdor', 'chips', names(ig_yogurt))
names(ig_yogurt) <- gsub('regdress', 'dressing', names(ig_yogurt))
names(ig_yogurt) <- gsub('localdrs', 'lc_dressing', names(ig_yogurt))
names(ig_yogurt) <- gsub('chice', 'icecream', names(ig_yogurt))
names(ig_yogurt) <- gsub('raspsorb', 'sorbet', names(ig_yogurt))

names(ig_yogurt) <- gsub('dor_', 'chips_', names(ig_yogurt))
names(ig_yogurt) <- gsub('pret_', 'pretzel_', names(ig_yogurt))
names(ig_yogurt) <- gsub('brd_', 'bread_', names(ig_yogurt))
names(ig_yogurt) <- gsub('must_', 'mustard_', names(ig_yogurt))
names(ig_yogurt) <- gsub('let_', 'lettuce_', names(ig_yogurt))
names(ig_yogurt) <- gsub('tom_', 'tomato_', names(ig_yogurt))
names(ig_yogurt) <- gsub('cuc_', 'cucumber_', names(ig_yogurt))
names(ig_yogurt) <- gsub('turk_', 'turkey_', names(ig_yogurt))
names(ig_yogurt) <- gsub('tuna_', 'tuna_salad_', names(ig_yogurt))
names(ig_yogurt) <- gsub('rdrs_', 'dressing_', names(ig_yogurt))
names(ig_yogurt) <- gsub('ldrs_', 'lc_dressing_', names(ig_yogurt))
names(ig_yogurt) <- gsub('app_', 'apple_', names(ig_yogurt))
names(ig_yogurt) <- gsub('ice_', 'icecream_', names(ig_yogurt))
names(ig_yogurt) <- gsub('sort_', 'sorbet_', names(ig_yogurt))
names(ig_yogurt) <- gsub('ches_', 'cheese_', names(ig_yogurt))
names(ig_yogurt) <- gsub('^y_', 'yogurt_', names(ig_yogurt))

names(ig_yogurt) <- gsub('l_', 'lunch_', names(ig_yogurt))
names(ig_yogurt) <- gsub('lfat', 'lunch_fat', names(ig_yogurt))
names(ig_yogurt) <- gsub('lcho', 'lunch_cho', names(ig_yogurt))
names(ig_yogurt) <- gsub('lpro', 'lunch_pro', names(ig_yogurt))

names(ig_yogurt) <- gsub('proclp', 'perc_pro_cal', names(ig_yogurt))
names(ig_yogurt) <- gsub('fatclp', 'perc_fat_cal', names(ig_yogurt))
names(ig_yogurt) <- gsub('choclp', 'perc_cho_cal', names(ig_yogurt))

names(ig_yogurt) <- gsub('pretzelunch', 'pretzel', names(ig_yogurt))
names(ig_yogurt) <- gsub('mway_', 'chocolate_', names(ig_yogurt))

## data org - IG yogurt VAS ####

ig_yogurt_vas_long <- ig_yogurt_vas %>%
  pivot_longer(
    cols = matches("(hung|full|deseat|mucheat|thirst|nausea)[1-4]$"),
    names_to = c(".value", "time"),
    names_pattern = "(.*)([1-4])$"
  )

names(ig_yogurt_vas_long)[names(ig_yogurt_vas_long) == 'subno'] <- 'id'

#fix names
names(ig_yogurt_vas_long) <- gsub('pltaste', 'yogurt_pleasant', names(ig_yogurt_vas_long))
names(ig_yogurt_vas_long) <- gsub('deseaty', 'yogurt_desire_eat', names(ig_yogurt_vas_long))
names(ig_yogurt_vas_long) <- gsub('calories', 'yogurt_subj_cal', names(ig_yogurt_vas_long))
names(ig_yogurt_vas_long) <- gsub('creamy', 'yogurt_creaminess', names(ig_yogurt_vas_long))
names(ig_yogurt_vas_long) <- gsub('fruit', 'yogurt_fruitiness', names(ig_yogurt_vas_long))
names(ig_yogurt_vas_long) <- gsub('fat', 'yogurt_fattiness', names(ig_yogurt_vas_long))
names(ig_yogurt_vas_long) <- gsub('carb', 'yogurt_subj_cho', names(ig_yogurt_vas_long))
names(ig_yogurt_vas_long) <- gsub('sweet', 'yogurt_sweetness', names(ig_yogurt_vas_long))
names(ig_yogurt_vas_long) <- gsub('muceaty', 'yogurt_much_eat', names(ig_yogurt_vas_long))

names(ig_yogurt_vas_long) <- gsub('hung', 'hunger', names(ig_yogurt_vas_long))
names(ig_yogurt_vas_long) <- gsub('full', 'fullness', names(ig_yogurt_vas_long))
names(ig_yogurt_vas_long) <- gsub('deseat', 'desire_eat', names(ig_yogurt_vas_long))
names(ig_yogurt_vas_long) <- gsub('mucheat', 'much_eat', names(ig_yogurt_vas_long))

## data org - IG physiology ####

ig_physiology <- ig_cck[!grepl('cond|time', names(ig_cck))] %>%
  pivot_longer(
    cols = -id,
    names_to = c(".value", "time"),
    names_pattern = "(.*)([1-9])$"
  )

ig_physiology <- ig_physiology %>%
  pivot_longer(
    cols = -c(id, time),
    names_to =  'cond',
    values_to = 'cck'
  )


#fix cond
ig_physiology['cond'] <- ifelse(ig_physiology[['cond']] == 'rapsal', 'saline-rapid', ifelse(ig_physiology[['cond']] == 'rapcho', 'cho-rapid', ifelse(ig_physiology[['cond']] == 'rapfat', 'fat-rapid', ifelse(ig_physiology[['cond']] == 'lonsal', 'saline-long', ifelse(ig_physiology[['cond']] == 'loncho', 'cho-long', 'fat-long')))))

ig_physiology['id'] <- ifelse(ig_physiology[['id']] == 101, 201, ig_physiology[['id']])

## merge lunch data ####
iv_lunch['group'] <- 'iv'
iv_lunch['cond'] <- ifelse(iv_lunch[['cond']] == 'a', 'cho', ifelse(iv_lunch[['cond']] == 'b', 'fat', 'saline'))

ig_lunch['group'] <- 'ig'
ig_lunch['cond'] <- ifelse(ig_lunch[['cond']] == 'a', 'cho-long', ifelse(ig_lunch[['cond']] == 'b', 'fat-long', ifelse(ig_lunch[['cond']] == 'c', 'saline-long',ifelse(ig_lunch[['cond']] == 'd', 'cho-rapid', ifelse(ig_lunch[['cond']] == 'e', 'fat-rapid', 'saline-rapid')))))

ig_lunch['id'] <- ifelse(ig_lunch[['id']] == 101, 201, ig_lunch[['id']])

merged_lunch <- bind_rows(iv_lunch, ig_lunch)

merged_lunch <- merged_lunch[c('id', 'group', 'cond', 'session', names(merged_lunch)[!grepl('id|group|cond|session', names(merged_lunch))])]

merged_lunch[grepl('_perc_', names(merged_lunch))] <- merged_lunch[grepl('_perc_', names(merged_lunch))]*100


## merge dinner data ####
iv_dinner['group'] <- 'iv'
iv_dinner['cond'] <- ifelse(iv_dinner[['cond']] == 'a', 'cho', ifelse(iv_dinner[['cond']] == 'b', 'fat', 'saline'))

ig_dinner['group'] <- 'ig'
ig_dinner['cond'] <- ifelse(ig_dinner[['cond']] == 'a', 'cho-long', ifelse(ig_dinner[['cond']] == 'b', 'fat-long', ifelse(ig_dinner[['cond']] == 'c', 'saline-long',ifelse(ig_dinner[['cond']] == 'd', 'cho-rapid', ifelse(ig_dinner[['cond']] == 'e', 'fat-rapid', 'saline-rapid')))))

ig_dinner['id'] <- ifelse(ig_dinner[['id']] == 101, 201, ig_dinner[['id']])

merged_dinner <- bind_rows(iv_dinner, ig_dinner)

merged_dinner <- merged_dinner[c('id', 'group', 'cond', 'session', 'time', names(merged_dinner)[!grepl('id|group|cond|session|time', names(merged_dinner))])]

merged_dinner[grepl('_perc_', names(merged_dinner))] <- merged_dinner[grepl('_perc_', names(merged_dinner))]*100

## merge VAS data ####
iv_vas_long['group'] <- 'iv'
iv_vas_long['cond'] <- ifelse(iv_vas_long[['cond']] == 'a', 'cho', ifelse(iv_vas_long[['cond']] == 'b', 'fat', 'saline'))

ig_vas_long['group'] <- 'ig'
ig_vas_long['cond'] <- ifelse(ig_vas_long[['cond']] == 'a', 'cho-long', ifelse(ig_vas_long[['cond']] == 'b', 'fat-long', ifelse(ig_vas_long[['cond']] == 'c', 'saline-long',ifelse(ig_vas_long[['cond']] == 'd', 'cho-rapid', ifelse(ig_vas_long[['cond']] == 'e', 'fat-rapid', 'saline-rapid')))))

ig_vas_long['id'] <- ifelse(ig_vas_long[['id']] == 101, 201, ig_vas_long[['id']])

merged_vas <- bind_rows(iv_vas_long, ig_vas_long)

merged_vas <- merged_vas[c('id', 'group', 'cond', 'time', 'hunger', 'fullness', 'nausea', 'thirst', 'desire', 'cramps', 'bloated')]

## merge YOGURT lunch data ####
iv_yogurt['group'] <- 'iv'
iv_yogurt['cond'] <- ifelse(iv_yogurt[['cond']] == 1, 'cho', ifelse(iv_yogurt[['cond']] == 2, 'fat', 'saline'))

ig_yogurt['group'] <- 'ig'
ig_yogurt['cond'] <- ifelse(ig_yogurt[['cond']] == 'a', 'cho-long', ifelse(ig_yogurt[['cond']] == 'b', 'fat-long', ifelse(ig_yogurt[['cond']] == 'c', 'saline-long',ifelse(ig_yogurt[['cond']] == 'd', 'cho-rapid', ifelse(ig_yogurt[['cond']] == 'e', 'fat-rapid', 'saline-rapid')))))

ig_yogurt['id'] <- ifelse(ig_yogurt[['id']] == 101, 201, ig_yogurt[['id']])

merged_yogurt_lunch <- bind_rows(iv_yogurt, ig_yogurt)

merged_yogurt_lunch <- merged_yogurt_lunch[c('id', 'group', 'cond', 'session', 'time', 'time_yogurt', names(merged_yogurt_lunch)[!grepl('id|group|cond|session|time', names(merged_yogurt_lunch))])]

merged_yogurt_lunch[grepl('_perc_', names(merged_yogurt_lunch))] <- merged_yogurt_lunch[grepl('_perc_', names(merged_yogurt_lunch))]*100


# replace ids with randomly generated values ####
sub_char_data['id_rand'] <- as.character(sub_char_data['id'])

set.seed(1991.5)
random_ids <- random_id(n = length(unique(sub_char_data[['id']])), bytes = 2)

id_count = 0

for (id_val in unique(sub_char_data[['id']])){
  id_count <- id_count + 1
  
  sub_char_data[sub_char_data['id'] == id_val, 'id_rand'] <- random_ids[id_count]
}

# match up random IDs and remove orig IDs ####
merged_vas <- merge(merged_vas, sub_char_data[c('id', 'id_rand')], by = 'id')
merged_vas['id'] <- merged_vas['id_rand']
merged_vas <- merged_vas[!grepl('id_rand', names(merged_vas))]

merged_lunch <- merge(merged_lunch, sub_char_data[c('id', 'id_rand')], by = 'id')
merged_lunch['id'] <- merged_lunch['id_rand']
merged_lunch <- merged_lunch[!grepl('id_rand', names(merged_lunch))]

merged_dinner <- merge(merged_dinner, sub_char_data[c('id', 'id_rand')], by = 'id')
merged_dinner['id'] <- merged_dinner['id_rand']
merged_dinner <- merged_dinner[!grepl('id_rand', names(merged_dinner))]

merged_yogurt_lunch <- merge(merged_yogurt_lunch, sub_char_data[c('id', 'id_rand')], by = 'id')
merged_yogurt_lunch['id'] <- merged_yogurt_lunch['id_rand']
merged_yogurt_lunch <- merged_yogurt_lunch[!grepl('id_rand', names(merged_yogurt_lunch))]

ig_yogurt_vas_long <- merge(ig_yogurt_vas_long, sub_char_data[c('id', 'id_rand')], by = 'id')
ig_yogurt_vas_long['id'] <- ig_yogurt_vas_long['id_rand']
ig_yogurt_vas_long <- ig_yogurt_vas_long[!grepl('id_rand', names(ig_yogurt_vas_long))]

ig_physiology <- merge(ig_physiology, sub_char_data[c('id', 'id_rand')], by = 'id')
ig_physiology['id'] <- ig_physiology['id_rand']
ig_physiology <- ig_physiology[!grepl('id_rand', names(ig_physiology))]

sub_char_data['id'] <- sub_char_data['id_rand']
sub_char_data <- sub_char_data[!grepl('id_rand', names(sub_char_data))]

## particpant.json ####

source('study_scripts/1991_ivig_preload/json_participant.R')

# convert formatting to JSON
participant_json <- RJSONIO::toJSON(participant_list, pretty = TRUE)

# double check
isValidJSON(participant_json, asText = TRUE)

## merged_vas.json ####

source('study_scripts/1991_ivig_preload/json_vas.R')

# convert formatting to JSON
vas_hourly_json <- RJSONIO::toJSON(vas_hourly_list, pretty = TRUE)

# double check
isValidJSON(vas_hourly_json, asText = TRUE)

## merged_lunch.json ####

source('study_scripts/1991_ivig_preload/json_lunch.R')

# convert formatting to JSON
lunch_json <- RJSONIO::toJSON(lunch_sum_list, pretty = TRUE)

# double check
isValidJSON(lunch_json, asText = TRUE)

## merged_dinner.json ####

source('study_scripts/1991_ivig_preload/json_dinner.R')

# convert formatting to JSON
dinner_json <- RJSONIO::toJSON(dinner_sum_list, pretty = TRUE)

# double check
isValidJSON(dinner_json, asText = TRUE)

## merged_yogurt_lunch.json ####

source('study_scripts/1991_ivig_preload/json_yogurt_lunch.R')

# convert formatting to JSON
yogurt_json <- RJSONIO::toJSON(yogurt_sum_list, pretty = TRUE)

# double check
isValidJSON(yogurt_json, asText = TRUE)

## ig_yogurt_vas_long.json ####

source('study_scripts/1991_ivig_preload/json_yogurt_vas.R')

# convert formatting to JSON
vas_yogurt_json <- RJSONIO::toJSON(vas_yogurt_list, pretty = TRUE)

# double check
isValidJSON(vas_yogurt_json, asText = TRUE)

## ig_physiology.json ####

source('study_scripts/1991_ivig_preload/json_cck.R')

# convert formatting to JSON
cck_json <- RJSONIO::toJSON(cck_list, pretty = TRUE)

# double check
isValidJSON(cck_json, asText = TRUE)

# dataset_description.json ####

source('study_scripts/1991_ivig_preload/json_dataset_description.R')

# convert formatting to JSON
dataset_json <- RJSONIO::toJSON(dataset_list, pretty = TRUE)

# double check
isValidJSON(dataset_json, asText = TRUE)


# write out json and data files ####
write(dataset_json, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1991_ivig_preload/dataset_description.json')

# demo
write(participant_json, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1991_ivig_preload/data/assay-demo_data.json')

write.table(sub_char_data, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1991_ivig_preload/data/assay-demo_data.csv', quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')

# hourly vas
write(vas_hourly_json, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1991_ivig_preload/data/exp-ivig_assay-rating_data.json')

write.table(merged_vas, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1991_ivig_preload/data/exp-ivig_assay-rating_data.csv', quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')

#lunch 
write(lunch_json, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1991_ivig_preload/data/exp-ivig_assay-lunch_data.json')

write.table(merged_lunch, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1991_ivig_preload/data/exp-ivig_assay-lunch_data.csv', quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')

#dinner
write(dinner_json, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1991_ivig_preload/data/exp-ivig_assay-dinner_data.json')

write.table(merged_dinner, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1991_ivig_preload/data/exp-ivig_assay-dinner_data.csv', quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')

#yogurt
write(yogurt_json, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1991_ivig_preload/data/exp-yogurtsss_assay-intake_data.json')

write.table(merged_yogurt_lunch, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1991_ivig_preload/data/exp-yogurtsss_assay-intake_data.csv', quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')

#yogurt vas
write(vas_yogurt_json, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1991_ivig_preload/data/exp-yogurtsss_assay-rating_data.json')

write.table(ig_yogurt_vas_long, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1991_ivig_preload/data/exp-yogurtsss_assay-rating_data.csv', quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')

#physio
write(cck_json, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1991_ivig_preload/data/exp-ivig_assay-cck_data.json')

write.table(ig_physiology, '/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - currated_data/1991_ivig_preload/data/exp-ivig_assay-cck_data.csv', quote = FALSE, sep = ',', col.names = TRUE, row.names = FALSE, na = 'n/a')

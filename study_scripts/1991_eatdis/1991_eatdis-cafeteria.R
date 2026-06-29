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
caf_data <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 EatDis Cafeteria/Data - Excel from SPSS/Master 1993-08-03.xls')

#remove second BMI column - duplicate/not meaningful and sex because all women
caf_data <- caf_data[!grepl('bmi2|sex', names(caf_data))]

# deal with pre/post meal and admit vs discharge visits
names(caf_data) <- gsub('1d', '_discharge_pre', names(caf_data))
names(caf_data) <- gsub('2d', '_discharge_post', names(caf_data))

names(caf_data) <- gsub('difa', '_dif_admit', names(caf_data))
names(caf_data) <- gsub('difd', '_dif_discharge', names(caf_data))

names(caf_data)[grep('tot|time|gram|per|mgca|eat|edi|bmi', names(caf_data))] <- gsub('2', '_discharge', names(caf_data)[grep('tot|time|gram|per|mgca|eat|edi|bmi', names(caf_data))])

names(caf_data)[grep('edi|ei', names(caf_data))] <- gsub('1', '_admit', names(caf_data)[grep('edi|ei', names(caf_data))])

names(caf_data)[grepl('tot|time|gram|per|mgca|eat|edi|bmi', names(caf_data)) & !grepl('discharge|much|admit', names(caf_data))] <- paste0(names(caf_data)[grepl('tot|time|gram|per|mgca|eat|edi|bmi', names(caf_data)) & !grepl('discharge|much|admit', names(caf_data))], '_admit')

names(caf_data) <- gsub('1', '_admit_pre', names(caf_data))
names(caf_data) <- gsub('2', '_admit_post', names(caf_data))

# fix names to be more readable and consistent
names(caf_data) <- gsub('full', 'fullness', names(caf_data))
names(caf_data) <- gsub('amount_|amou_', 'much_eat_', names(caf_data))
names(caf_data) <- gsub('fear', 'fear_fat', names(caf_data))
names(caf_data) <- gsub('bloat_|bloa_', 'bloated_', names(caf_data))
names(caf_data) <- gsub('binge_|bing_', 'binge_desire_', names(caf_data))
names(caf_data) <- gsub('purge_|purg_', 'purge_desire_', names(caf_data))
names(caf_data) <- gsub('aler_', 'alert_', names(caf_data))
names(caf_data) <- gsub('guil_', 'guilt_', names(caf_data))
names(caf_data) <- gsub('tens_', 'tense_', names(caf_data))
names(caf_data) <- gsub('depress_|depr_|depres_', 'depressed_', names(caf_data))
names(caf_data) <- gsub('drow_', 'drowsy_', names(caf_data))
names(caf_data) <- gsub('relax_|rela_', 'relaxed_', names(caf_data))
names(caf_data) <- gsub('anxiou_|anxi_', 'anxious_', names(caf_data))
names(caf_data) <- gsub('conten_|cont_', 'content_', names(caf_data))

names(caf_data) <- gsub('hung_', 'hunger_', names(caf_data))
names(caf_data) <- gsub('thir_', 'thirst_', names(caf_data))
names(caf_data) <- gsub('desi_', 'desire_', names(caf_data))
names(caf_data) <- gsub('amou_', 'much_eat_', names(caf_data))
names(caf_data) <- gsub('bloa_', 'bloated_', names(caf_data))

# fix intake var names
names(caf_data) <- gsub('tot_kcal|totcal', 'total_kcal', names(caf_data))
names(caf_data) <- gsub('tot_gram|totgram', 'total_g', names(caf_data))
names(caf_data) <- gsub('percalch|percho', 'perc_cal_cho', names(caf_data))
names(caf_data) <- gsub('grams_ch|gramcho', 'g_cho', names(caf_data))
names(caf_data) <- gsub('percalpr|perpro', 'perc_cal_pro', names(caf_data))
names(caf_data) <- gsub('grams_pr|grampro', 'g_pro', names(caf_data))
names(caf_data) <- gsub('percalfa|perfat', 'perc_cal_fat', names(caf_data))
names(caf_data) <- gsub('grams_fa|gramfat', 'g_fat', names(caf_data))

names(caf_data) <- gsub('dif$', '_tdif', names(caf_data))
names(caf_data) <- gsub('gfat', 'g_fat', names(caf_data))
names(caf_data) <- gsub('gcho', 'g_cho', names(caf_data))
names(caf_data) <- gsub('gpro', 'g_pro', names(caf_data))
names(caf_data) <- gsub('pfat', 'p_fat', names(caf_data))
names(caf_data) <- gsub('pcho', 'p_cho', names(caf_data))
names(caf_data) <- gsub('ppro', 'p_pro', names(caf_data))
names(caf_data) <- gsub('more', 'more_', names(caf_data))

names(caf_data)[names(caf_data) == 'edidt_admit'] <- 'edi_thinness'
names(caf_data)[names(caf_data) == 'edibu_admit'] <- 'edi_bulimia'
names(caf_data)[names(caf_data) == 'edibd_admit'] <- 'edi_body_dissat'
names(caf_data)[names(caf_data) == 'ediie_admit'] <- 'edi_ineffectiveness'
names(caf_data)[names(caf_data) == 'edipe_admit'] <- 'edi_perfectionism'
names(caf_data)[names(caf_data) == 'ediid_admit'] <- 'edi_distrust'
names(caf_data)[names(caf_data) == 'ediia_admit'] <- 'edi_intero_aware'
names(caf_data)[names(caf_data) == 'edimf_admit'] <- 'edi_mature_fears'
names(caf_data)[names(caf_data) == 'eicr_admit'] <- 'ei_cog_restraint'
names(caf_data)[names(caf_data) == 'eidi_admit'] <- 'ei_disinhibit'
names(caf_data)[names(caf_data) == 'eihu_admit'] <- 'ei_hunger'

names(caf_data) <- gsub('ibw$', 'perc_ideal_bw_admit', names(caf_data))
names(caf_data) <- gsub('ibw_admit_post', 'perc_ideal_bw_discharge', names(caf_data))

names(caf_data)[names(caf_data) == 'months_i'] <- 'illness_dur'
names(caf_data)[names(caf_data) == 'los'] <- 'hospital_stay_wks'

# re-base variables to 0
caf_data['group'] <- caf_data['group'] - 1
caf_data['ed_dx'] <- caf_data['ed_dx'] - 1
caf_data['race'] <- ifelse(caf_data[['race']] == 1, 0, 1)


# split and then stack for admit and discharge timepoints
admit_data <- caf_data[grepl('^id$|admit', names(caf_data)) & !grepl('edi|ei|bmi', names(caf_data))]
names(admit_data) <- gsub('_admit', '', names(admit_data))
admit_data['timepoint'] <- 0


discharge_data <- caf_data[grepl('^id$|discharge', names(caf_data)) & !grepl('edi', names(caf_data))]
names(discharge_data) <- gsub('_discharge', '', names(discharge_data))
discharge_data['timepoint'] <- 1

caf_long_data <- rbind.data.frame(admit_data, discharge_data)

# merge with demo data
caf_demo_data <- caf_data[c('id', 'group', 'age', 'race', 'illness_dur', 'hospital_stay_wks', 'bmi_admit', 'edi_thinness', 'edi_bulimia', 'edi_body_dissat', 'edi_ineffectiveness', 'edi_perfectionism', 'edi_distrust', 'edi_intero_aware', 'edi_mature_fears', 'ei_cog_restraint', 'ei_disinhibit', 'ei_hunger', 'edi_discharge')]


caf_long_data <- merge(caf_demo_data[c('id', 'group')], caf_long_data, by = 'id', all = TRUE)

# re-order
caf_long_data <- caf_long_data[c('id', 'group', 'timepoint', 'eat', 'perc_ideal_bw', names(caf_long_data)[grep('_pre', names(caf_long_data))], names(caf_long_data)[grep('total|time$|_cal_|g_|mgca', names(caf_long_data))], names(caf_long_data)[grep('post|dif', names(caf_long_data))])]

# make the timepoint difference dataset
caf_data['perc_ideal_bw_tdif'] <- caf_data['perc_ideal_bw_discharge'] - caf_data['perc_ideal_bw_admit'] 

caf_data['eat_tdif'] <- caf_data['eat_discharge'] - caf_data['eat_admit'] 
caf_tdif_data <- caf_data[grepl('^id$|group|tdif|more', names(caf_data))]

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
library(data.table)

# load
sum_data <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 EatDis Yogurt Preload/Data - Excel from SPSS/TotKcal 1994-08-02 N=27.xls', na = c('', '#NULL!', 999))

foods_data <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 EatDis Yogurt Preload/Data - Excel from SPSS/FoodKcal 1994-08-02 N=27.xlsx', na = c('', '#NULL!', 999))


rating_data <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 EatDis Yogurt Preload/Data - Excel from SPSS/EDYOGvas 1994-07-18 N=27 Hung etc.xlsx', na = c('', '#NULL!', 999))

yogurt_q_data <- read_excel('/Users/azp271/Library/CloudStorage/OneDrive-ThePennsylvaniaStateUniversity/Rolls, Barbara Jeans files - Archived Study Data 1988-1999/1991 EatDis Yogurt Preload/Data - Excel from SPSS/EDYOGss 1994-07-27 N=23 Subchar by ID.xls', na = c('', '#NULL!', 999))



## Summary Data ####
# fix names to be more readable and consistent
names(sum_data) <- gsub('yog', 'yogurt_', names(sum_data))
names(sum_data) <- gsub('h20', 'water_', names(sum_data))
names(sum_data) <- gsub('sess', 'session_', names(sum_data))
names(sum_data) <- gsub('^tot', 'meal_', names(sum_data))

names(sum_data) <- gsub('^lc', 'low_ed_', names(sum_data))
names(sum_data) <- gsub('^hc', 'high_ed_', names(sum_data))

names(sum_data) <- gsub('fcal', 'fat_cal', names(sum_data))
names(sum_data) <- gsub('pcal', 'pro_cal', names(sum_data))
names(sum_data) <- gsub('ccal', 'cho_cal', names(sum_data))

names(sum_data) <- gsub('^per', 'perc_', names(sum_data))

names(sum_data) <- gsub('fatg', 'fat_g', names(sum_data))
names(sum_data) <- gsub('prog', 'pro_g', names(sum_data))
names(sum_data) <- gsub('chog', 'cho_g', names(sum_data))

names(sum_data) <- gsub('^y', 'yogurt_', names(sum_data))
names(sum_data) <- gsub('yogurt_ogurt', 'yogurt_g', names(sum_data))


names(sum_data) <- gsub('^ty', 'total_', names(sum_data))

names(sum_data) <- gsub('fcap', 'perc_fat_cal', names(sum_data))
names(sum_data) <- gsub('ccap', 'perc_cho_cal', names(sum_data))
names(sum_data) <- gsub('pcap', 'perc_pro_cal', names(sum_data))

names(sum_data) <- gsub('kcal', 'cal', names(sum_data))
names(sum_data) <- gsub('gram', 'g', names(sum_data))

# individual foods 

names(foods_data) <- gsub('sess', 'session_', names(foods_data))

names(foods_data) <- gsub('fcal', 'fat_cal', names(foods_data))
names(foods_data) <- gsub('pcal', 'pro_cal', names(foods_data))
names(foods_data) <- gsub('ccal', 'cho_cal', names(foods_data))

names(foods_data) <- gsub('h2o', 'water', names(foods_data))
names(foods_data) <- gsub('pc', '_chips', names(foods_data))
names(foods_data) <- gsub('mus', '_mustard', names(foods_data))
names(foods_data) <- gsub('may', '_mayo', names(foods_data))
names(foods_data) <- gsub('let', '_lettuce', names(foods_data))
names(foods_data) <- gsub('tom', '_tomato', names(foods_data))
names(foods_data) <- gsub('cuc', '_cucumber', names(foods_data))
names(foods_data) <- gsub('che', '_cheese', names(foods_data))
names(foods_data) <- gsub('tur', '_turkey', names(foods_data))
names(foods_data) <- gsub('piz', '_pizza', names(foods_data))
names(foods_data) <- gsub('rsd', '_dressing', names(foods_data))
names(foods_data) <- gsub('lsd', '_lc_dressing', names(foods_data))
names(foods_data) <- gsub('mm', '_mms', names(foods_data))
names(foods_data) <- gsub('ap', '_apple', names(foods_data))
names(foods_data) <- gsub('cic', '_icecream', names(foods_data))
names(foods_data) <- gsub('sts', '_sorbet', names(foods_data))
names(foods_data) <- gsub('br', '_bread', names(foods_data))

names(foods_data) <- gsub('fatg', 'fat_g', names(foods_data))
names(foods_data) <- gsub('prog', 'pro_g', names(foods_data))
names(foods_data) <- gsub('chog', 'cho_g', names(foods_data))

names(foods_data) <- gsub('^tot', 'meal_', names(foods_data))

names(foods_data) <- gsub('^lc', 'low_ed_', names(foods_data))
names(foods_data) <- gsub('^hc', 'high_ed_', names(foods_data))

names(foods_data) <- gsub('gram', 'g', names(foods_data))

# rating data

names(rating_data) <- gsub('sess', 'session_', names(rating_data))

names(rating_data) <- gsub('alert', 'alert_', names(rating_data))
names(rating_data) <- gsub('amt', 'much_eat_', names(rating_data))
names(rating_data) <- gsub('binge', 'binge_desire_', names(rating_data))
names(rating_data) <- gsub('bloat', 'bloated_', names(rating_data))
names(rating_data) <- gsub('cont', 'content_', names(rating_data))
names(rating_data) <- gsub('depres', 'depressed_', names(rating_data))
names(rating_data) <- gsub('deseat', 'desire_eat_', names(rating_data))
names(rating_data) <- gsub('fear', 'fear_fat_', names(rating_data))
names(rating_data) <- gsub('full', 'fullness_', names(rating_data))
names(rating_data) <- gsub('guilt', 'guilt_', names(rating_data))
names(rating_data) <- gsub('hung', 'hunger_', names(rating_data))
names(rating_data) <- gsub('naus', 'nausea_', names(rating_data))
names(rating_data) <- gsub('purge', 'purge_desire_', names(rating_data))
names(rating_data) <- gsub('thirst', 'thirst_', names(rating_data))

names(rating_data) <- gsub('^y', 'yogurt_', names(rating_data))
names(rating_data) <- gsub('pleas', 'pleasant_', names(rating_data))
names(rating_data) <- gsub('dte', 'desire_eat_', names(rating_data))
names(rating_data) <- gsub('yogurt_cal', 'yogurt_cal_', names(rating_data))
names(rating_data) <- gsub('cream', 'creaminess_', names(rating_data))
names(rating_data) <- gsub('fruit', 'fruitiness_', names(rating_data))
names(rating_data) <- gsub('yogurt_fat', 'yogurt_fattiness_', names(rating_data))
names(rating_data) <- gsub('yogurt_cho', 'yogurt_cho_', names(rating_data))
names(rating_data) <- gsub('sweet', 'sweetness_', names(rating_data))
names(rating_data) <- gsub('amt', 'amount_', names(rating_data))

# questionnaire data
names(yogurt_q_data) <- gsub('_#', '', names(yogurt_q_data))
names(yogurt_q_data) <- gsub('\\.', '', names(yogurt_q_data))
names(yogurt_q_data) <- gsub('_', '', names(yogurt_q_data))
names(yogurt_q_data) <- gsub('loi', 'illness_dur', names(yogurt_q_data))

# organize data into long format ####

# summary data
time1_sumdat <- sum_data[grepl('^id|group|session_a|1', names(sum_data))]
names(time1_sumdat) <- gsub('_a|_1|1', '', names(time1_sumdat))
time1_sumdat['condition'] <- 'a'

time2_sumdat <- sum_data[grepl('^id|group|session_b|2', names(sum_data))]
time2_sumdat <- time2_sumdat[!grepl('h2o1|h2o3', names(time2_sumdat))]
names(time2_sumdat) <- gsub('_b|_2|2', '', names(time2_sumdat))
names(time2_sumdat) <- gsub('^ho', 'h2o', names(time2_sumdat))
time2_sumdat['condition'] <- 'b'

time3_sumdat <- sum_data[grepl('^id|group|session_c|3', names(sum_data))]
names(time3_sumdat) <- gsub('_c$|_3|3', '', names(time3_sumdat))
time3_sumdat['condition'] <- 'c'

yogurt_sum_long <- rbind.data.frame(time1_sumdat, time2_sumdat, time3_sumdat)

# add yogurt ratings to long data

rate_yogurt <- rating_data[c('id', 'group', names(rating_data)[grepl('yogurt|session', names(rating_data))])]
names(rate_yogurt) <- gsub('_cal', '_subj_cal', names(rate_yogurt))
names(rate_yogurt) <- gsub('_cho', '_subj_cho', names(rate_yogurt))


time1_rate_yogurt <- rate_yogurt[grepl('^id|_a$', names(rate_yogurt))]
names(time1_rate_yogurt) <- gsub('_a$', '', names(time1_rate_yogurt))
time1_rate_yogurt['condition'] <- 'a'

time2_rate_yogurt <- rate_yogurt[grepl('^id|_b$', names(rate_yogurt))]
names(time2_rate_yogurt) <- gsub('_b$', '', names(time2_rate_yogurt))
time2_rate_yogurt['condition'] <- 'b'

time3_rate_yogurt <- rate_yogurt[grepl('^id|_c$', names(rate_yogurt))]
names(time3_rate_yogurt) <- gsub('_c$', '', names(time3_rate_yogurt))
time3_rate_yogurt['condition'] <- 'c'

rate_yogurt_long <- rbind.data.frame(time1_rate_yogurt, time2_rate_yogurt, time3_rate_yogurt)

yogurt_sum_long <- merge(rate_yogurt_long, yogurt_sum_long, by = c('id', 'session', 'condition'), all = TRUE)

yogurt_sum_long <- yogurt_sum_long[c('id', 'group', 'session', 'condition', 'time', 'h2o', names(yogurt_sum_long)[grepl('yogurt', names(yogurt_sum_long))], names(yogurt_sum_long)[grepl('meal|^perc', names(yogurt_sum_long))], names(yogurt_sum_long)[grepl('high|low|total', names(yogurt_sum_long))])]

# other rating data
rating_data <- rating_data[!grepl('yogurt', names(rating_data))]

time1_rate <- rating_data[grepl('^id|group|_a', names(rating_data))]
names(time1_rate) <- gsub('_a', '', names(time1_rate))
time1_rate['condition'] <- 'a'

time2_rate <- rating_data[grepl('^id|group|_b', names(rating_data))]
names(time2_rate) <- gsub('_b', '', names(time2_rate))
time2_rate['condition'] <- 'b'

time3_rate <- rating_data[grepl('^id|group|_c', names(rating_data))]
names(time3_rate) <- gsub('_c', '', names(time3_rate))
time3_rate['condition'] <- 'c'

yogurt_vas_long <- rbind.data.frame(time1_rate, time2_rate, time3_rate)

yogurt_vas_long <- data.table::melt(setDT(yogurt_vas_long), id.vars = c('id', 'group', 'session', 'condition'), measure.vars = data.table::patterns('alert', 'much_eat', 'binge_desire', 'bloated', 'content', 'depressed', 'desire_eat', 'fear_fat', 'fullness', 'guilt', 'hunger', 'nausea', 'purge_desire', 'thirst'), variable.name = 'time', value.name = c('alert', 'much_eat', 'binge_desire', 'bloated', 'content', 'depressed', 'desire_eat', 'fear_fat', 'fullness', 'guilt', 'hunger', 'nausea', 'purge_desire', 'thirst'))

yogurt_vas_long <- as.data.frame(yogurt_vas_long)
yogurt_vas_long['time'] <- ifelse(yogurt_vas_long[['time']] == 1, 'pre_yogurt', ifelse(yogurt_vas_long[['time']] == 2, 'post_yogurt', ifelse(yogurt_vas_long[['time']] == 3, 'hr1', ifelse(yogurt_vas_long[['time']] == 4, 'hr2', ifelse(yogurt_vas_long[['time']] == 5, 'hr3', ifelse(yogurt_vas_long[['time']] == 6, 'hr4', ifelse(yogurt_vas_long[['time']] == 7, 'pre_dinner', ifelse(yogurt_vas_long[['time']] == 8, 'post_dinner', yogurt_vas_long[['time']]))))))))

# measured foods data
foods_data <- foods_data[!grepl('meal|low|high', names(foods_data))]

time1_foods <- foods_data[grepl('^id|group|_a$|1', names(foods_data))]
names(time1_foods) <- gsub('_a$|1', '', names(time1_foods))
time1_foods['condition'] <- 'a'

time2_foods <- foods_data[grepl('^id|group|_b$|2', names(foods_data))]
names(time2_foods) <- gsub('_b$|2', '', names(time2_foods))
time2_foods['condition'] <- 'b'

time3_foods <- foods_data[grepl('^id|group|_c$|3', names(foods_data))]
names(time3_foods) <- gsub('_c$|3', '', names(time3_foods))
time3_foods['condition'] <- 'c'

yogurt_dinner_long <- rbind.data.frame(time1_foods, time2_foods, time3_foods)
names(yogurt_dinner_long) <- gsub('water', 'h2o', names(yogurt_dinner_long))

yogurt_dinner_long <- yogurt_dinner_long[c('id', 'group', 'session', 'condition', 'time', 'h2o', names(yogurt_dinner_long)[!grepl('id|group|sess|cond|time|h2o', names(yogurt_dinner_long))])]

# merge with summary data
yogurt_long <- merge(yogurt_sum_long, yogurt_dinner_long[!grepl('group|time|h2o', names(yogurt_dinner_long))], by = c('id', 'session', 'condition'), all = TRUE)

yogurt_q_data['bmi'] <- (yogurt_q_data['wt']/(yogurt_q_data['ht']^2))*703

# re-base variables to 0 ####
yogurt_long['group'] <- yogurt_sum_long['group'] - 1
yogurt_long['group'] <- ifelse(yogurt_sum_long[['group']] == 4, 3, yogurt_long[['group']])


yogurt_vas_long['group'] <- yogurt_vas_long['group'] - 1
yogurt_vas_long['group'] <- ifelse(yogurt_vas_long[['group']] == 8, 3, yogurt_vas_long[['group']])


yogurt_q_data['group'] <- yogurt_q_data['group'] - 1

# make values true percents
yogurt_long[grepl('perc', names(yogurt_long))] <- 100 * (yogurt_long[grepl('perc', names(yogurt_long))])

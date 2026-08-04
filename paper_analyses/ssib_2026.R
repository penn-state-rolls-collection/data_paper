# This script was written by Alaina Pearce in July 2026
# to do pilot analyses for the SSIB Meeting
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

library(ggplot2)
library(car)
library(gtsummary)
theme_gtsummary_compact()
library(ggpubr)
library(reshape2)

# get processed phenotype data
#merge brake data
rolls_data <- read.csv('data/rolls_collection_overview.csv', header = TRUE)

rolls_data['sub_n'] <- ifelse(is.na(rolls_data[['sub_n']]), rolls_data[['study_n']], rolls_data[['sub_n']])

# make long for graphing
rolls_data_long <- melt(rolls_data[c(1, 2, 9, 13:25)], id.vars = c('study', 'year', 'sub_n'))

names(rolls_data_long)[names(rolls_data_long) == 'variable'] <- 'design'

rolls_data_long <- rolls_data_long[rolls_data_long['value'] == 1 & !is.na(rolls_data_long['value']), ]

rolls_data_long['year'] <- as.numeric(rolls_data_long[['year']])

# count for number of studies by year
rolls_data_long <- rolls_data_long |>
  mutate(year_bucket = paste0(floor(year / 5) * 5, "–", floor(year / 5) * 5 + 4))

design_list <- c('sss', 'ps_manipulation', 'ed_manipulation', 'preload_used', 'fat_manipulation', 'volume_manipulation', 'weight_loss', 'microstructure')

# get data set for figure study by year and design
rolls_subcounts_method <- rolls_data_long[(rolls_data_long[['design']] %in% design_list), ] |>
  mutate(design = factor(design, levels = design_list)) |>
  count(year_bucket, sub_n, design, .drop = FALSE, name = "n_studies")

#figures
colors8 <- c('#E69F00', '#009E73', '#56B4E9',  '#F0E442', '#0072B2', '#D55E00', '#CC79A7', '#5D3A9B')

study_method_bar <- ggplot(rolls_counts_method, aes(x = year_bucket, y = n_studies, fill = design)) +
  geom_col(position = "stack") +
  scale_y_continuous(
    breaks = scales::breaks_pretty(),
    limits = c(0, NA),
    expand = expansion(mult = c(0, 0.1))
  ) +
  scale_fill_manual(values = setNames(colors8, design_list),
                     limits = design_list,
                    labels = c('Sensory Specific Satiety', 'Preload', 'Portion Size', 'Energy Density', 'Fat Substitution', 'Volume', 'Weight Loss Trial', 'Eating Rate')) +
  labs(
    title = "Number of Studies Published per Year by Category",
    x = "Year",
    y = "Number of Studies",
  ) +
  #guides(fill = guide_legend(reverse = TRUE)) +
  theme_minimal(base_size = 13) +
  theme(
    panel.grid.minor = element_blank(),
    legend.position = "right"
  )


#co-occurrence heatmat
outcome_cols <- c('preload_used', 'sss', 'ps_manipulation', 'ed_manipulation', 'fat_manipulation', 'volume_manipulation', 'weight_loss', 'microstructure')

heatmap_study <- rolls_data |>
  filter(!is.na(study)) |>                                         # drop rows with no study ID
  distinct(study, across(all_of(outcome_cols))) |>
  mutate(across(all_of(outcome_cols), \(x) replace_na(as.numeric(x), 0)))  # NA → 0

mat <- t(as.matrix(heatmap_study[, outcome_cols])) %*% as.matrix(heatmap_study[, outcome_cols])

cooccur_long <- as.data.frame(as.table(mat)) |>
  rename(measure_x = Var1, measure_y = Var2, count = Freq)|>
  mutate(
    measure_x = factor(measure_x, levels = outcome_cols),          # apply fixed order to x-axis
    measure_y = factor(measure_y, levels = rev(outcome_cols))      # reverse for y-axis (matrix orientation)
  )

ggplot(cooccur_long, aes(x = measure_x, y = measure_y, fill = count)) +
  geom_tile(color = "white", linewidth = 0.5) +
  geom_text(aes(label = count), size = 20, color = "black") +
  scale_fill_gradient(low = "#f7fbff", high = "#08519c") +
  labs(
    title = "Outcome Measure Co-occurrence Across Studies",
    x = NULL,
    y = NULL,
    fill = "No. Studies"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    axis.text.x = element_text(angle = 30, hjust = 1),
    panel.grid = element_blank()
  )


# sample size chart
rolls_data['year'] <- as.numeric(rolls_data[['year']])

rolls_data['sample_age'] <- ifelse(rolls_data[['sample_age']] == 'chef', 'adult', rolls_data[['sample_age']])

rolls_data_sub <- rolls_data[rolls_data['sample_age'] != 'retro', ]

rolls_samplesize_dat <- rolls_data_sub |>
  distinct(study, year, sub_n, sample_age) |>
  mutate(
    sub_n   = as.numeric(sub_n),
    year      = as.numeric(year),
    sample_age = factor(sample_age, levels = c('elderly', 'adult', 'child'))
  ) |>
  filter(
    !is.na(sub_n),
    !is.na(year),
    !is.na(sample_age)
  )


# count for number of studies by year
rolls_samplesize_dat <- rolls_samplesize_dat |>
  mutate(year_bucket = paste0(floor(year / 5) * 5, "–", floor(year / 5) * 5 + 4))

study_nsub_bar <- ggplot(rolls_samplesize_dat, aes(x = year_bucket, y = sub_n, fill = sample_age)) +
  geom_col(position = "stack") +
  scale_y_continuous(
    breaks = scales::breaks_pretty(),
    limits = c(0, NA),
    expand = expansion(mult = c(0, 0.1))
  ) +
 scale_fill_manual(values = setNames(colors8[2:4], c('elderly', 'adult', 'child')),
                   limits = c('elderly', 'adult', 'child'),
                   labels = c('Elderly', 'Adult', 'Child')) +
  labs(
    title = "Number of Participants per Year by Age group",
    x = "Year",
    y = "Number of Participants",
  ) +
  #guides(fill = guide_legend(reverse = TRUE)) +
  theme_minimal(base_size = 13) +
  theme(
    panel.grid.minor = element_blank(),
    legend.position = "right"
  )

#tables
overview_byage_data <- rolls_data[c(5, 4, 6, 9, 28:30, 32, 34, 37, 40, 44:57)]

overview_byage_data['sample_age'] <- ifelse(overview_byage_data[['sample_age']] == 'chefs', 'adult', overview_byage_data[['sample_age']])

overview_byage_data <- overview_byage_data[overview_byage_data['sample_age'] != 'retro', ]

overview_byage_tab <-
  tbl_summary(
    data = overview_byage_data,
    by = sample_age,
    statistic = all_continuous() ~ c('{mean} ({sd})'),
    missing = 'ifany',
    digits = all_continuous() ~ 2)


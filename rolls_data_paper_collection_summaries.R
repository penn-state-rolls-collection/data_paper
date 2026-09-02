library(dplyr)
library(tidyr)
library(readr)
library(stringr)
library(ggplot2)
library(scales)

rolls_data <- read_csv(
  "data/rolls_collection_overview(Overview).csv",
  show_col_types = FALSE,
  na = c("", "NA")
)

dir.create("figures", showWarnings = FALSE, recursive = TRUE)
dir.create("tables", showWarnings = FALSE, recursive = TRUE)

is_present <- function(x) {
  x_num <- suppressWarnings(as.numeric(as.character(x)))
  !is.na(x_num) & x_num == 1
}

safe_num <- function(x) {
  suppressWarnings(as.numeric(as.character(x)))
}

first_nonmissing <- function(x) {
  x <- as.character(x)
  x <- x[!is.na(x) & nzchar(str_trim(x))]
  if (length(x) == 0) NA_character_ else x[1]
}

clean_age <- function(x) {
  x <- str_to_lower(str_trim(as.character(x)))
  case_when(
    x %in% c("chef", "chefs", "adult", "adults") ~ "Adult",
    str_detect(x, "child|children|pediatric|paediatric|adolescent|teen") ~ "Child",
    str_detect(x, "elder|older") ~ "Elderly",
    str_detect(x, "adult") ~ "Adult",
    TRUE ~ str_to_title(x)
  )
}

clean_sex <- function(x) {
  x <- str_to_lower(str_trim(as.character(x)))
  case_when(
    str_detect(x, "mixed|both") ~ "Mixed",
    x %in% c("female", "women", "woman", "f") ~ "Female",
    x %in% c("male", "men", "man", "m") ~ "Male",
    TRUE ~ str_to_title(x)
  )
}

rolls_data <- rolls_data %>%
  mutate(
    study = as.character(study),
    year = safe_num(year),
    study_n = safe_num(study_n),
    sub_n = safe_num(sub_n),
    sample_n = coalesce(sub_n, study_n),
    sample_age_clean = clean_age(sample_age),
    sample_sex_clean = clean_sex(sample_sex),
    location_clean = str_squish(as.character(location))
  ) %>%
  filter(!is.na(study), nzchar(str_trim(study)))

method_labels <- c(
  sss = "Sensory-specific satiety",
  preload_used = "Preload",
  ed_manipulation = "Energy density",
  ps_manipulation = "Portion size",
  volume_manipulation = "Volume",
  fat_manipulation = "Fat manipulation",
  food_form = "Food form",
  microstructure = "Eating rate/Microstructure",
  eating_disorder = "Eating-disorder sample",
  weight_loss = "Weight-loss intervention",
  obesity = "Obesity sample",
  social_context = "Social context"
)

demographic_labels <- c(
  age = "Age",
  sex = "Sex",
  race = "Race/Ethnicity",
  ses = "Socioeconomic status",
  bmi = "BMI/Weight status"
)

intake_labels <- c(
  recall_intake = "Recall intake",
  measured_intake = "Measured intake",
  pre_post_meal_q = "Pre/Post-meal ratings",
  cho_intake = "Carbohydrate intake",
  fat_intake = "Fat intake",
  pro_intake = "Protein intake",
  fiber_intake = "Fiber intake",
  food_preference = "Food preference",
  eat_duration = "Eating duration",
  substance_use = "Substance use",
  current_status_q = "Current-status questions"
)

questionnaire_labels <- c(
  zung = "Zung",
  eat = "EAT",
  edi = "EDI",
  ei = "EI",
  beck = "Beck",
  bsq = "BSQ",
  `qewp-r` = "QEWP-R",
  debq = "DEBQ",
  pfs = "PFS",
  cfq = "CFQ",
  upsit = "UPSIT",
  birth_control = "Birth control",
  menstrual_cycle = "Menstrual cycle"
)

all_known_flags <- unique(c(
  names(method_labels),
  names(demographic_labels),
  names(intake_labels),
  names(questionnaire_labels)
))

available_flags <- intersect(all_known_flags, names(rolls_data))

study_level <- rolls_data %>%
  group_by(study) %>%
  summarise(
    year = {
      z <- year[is.finite(year)]
      if (length(z) == 0) NA_real_ else min(z)
    },
    study_n = {
      z <- study_n[is.finite(study_n)]
      if (length(z) == 0) NA_real_ else max(z)
    },
    sample_age = paste(
      sort(unique(sample_age_clean[
        !is.na(sample_age_clean) & nzchar(sample_age_clean)
      ])),
      collapse = "; "
    ),
    sample_sex = paste(
      sort(unique(sample_sex_clean[
        !is.na(sample_sex_clean) & nzchar(sample_sex_clean)
      ])),
      collapse = "; "
    ),
    location = paste(
      sort(unique(location_clean[
        !is.na(location_clean) & nzchar(location_clean)
      ])),
      collapse = "; "
    ),
    across(
      any_of(available_flags),
      ~ as.integer(any(is_present(.x), na.rm = TRUE))
    ),
    .groups = "drop"
  )

n_studies <- nrow(study_level)

make_feature_summary <- function(data, label_vector, domain_name) {
  vars <- intersect(names(label_vector), names(data))
  
  if (length(vars) == 0) return(tibble())
  
  data %>%
    select(study, all_of(vars)) %>%
    pivot_longer(
      cols = all_of(vars),
      names_to = "variable",
      values_to = "present"
    ) %>%
    group_by(variable) %>%
    summarise(
      n_studies = sum(is_present(present), na.rm = TRUE),
      total_studies = n_distinct(study),
      proportion = n_studies / total_studies,
      .groups = "drop"
    ) %>%
    mutate(
      feature = unname(label_vector[variable]),
      domain = domain_name,
      percent = 100 * proportion,
      label = paste0(n_studies, " (", round(percent, 1), "%)")
    )
}

save_horizontal_percent <- function(
    dat, filename, title, subtitle = NULL,
    width = 8.5, height = 6.5) {
  
  if (nrow(dat) == 0) return(invisible(NULL))
  
  xmax <- max(dat$percent, na.rm = TRUE)
  xmax <- ifelse(is.finite(xmax), max(10, xmax * 1.20), 100)
  
  p <- dat %>%
    arrange(percent) %>%
    mutate(feature = factor(feature, levels = feature)) %>%
    ggplot(aes(x = percent, y = feature)) +
    geom_col(width = 0.72) +
    geom_text(
      aes(label = label),
      hjust = -0.08,
      size = 3.5
    ) +
    scale_x_continuous(
      labels = label_percent(scale = 1, accuracy = 1),
      limits = c(0, xmax),
      expand = expansion(mult = c(0, 0))
    ) +
    labs(
      title = title,
      subtitle = subtitle,
      x = "Percentage of studies",
      y = NULL
    ) +
    theme_minimal(base_size = 12) +
    theme(
      panel.grid.major.y = element_blank(),
      panel.grid.minor = element_blank(),
      plot.title = element_text(face = "bold")
    )
  
  ggsave(filename, p, width = width, height = height, dpi = 300)
  invisible(p)
}

method_summary <- make_feature_summary(
  study_level, method_labels, "Study design/population"
)

demographic_summary <- make_feature_summary(
  study_level, demographic_labels, "Demographics"
)

intake_summary <- make_feature_summary(
  study_level, intake_labels, "Intake/eating behavior"
)

questionnaire_summary <- make_feature_summary(
  study_level, questionnaire_labels, "Questionnaires/related measures"
)

all_feature_summary <- bind_rows(
  method_summary,
  demographic_summary,
  intake_summary,
  questionnaire_summary
)

write_csv(
  all_feature_summary %>%
    select(domain, variable, feature, n_studies, total_studies, percent),
  "tables/collection_feature_counts_and_percentages.csv"
)

# FIGURE 01: Study characteristics

save_horizontal_percent(
  method_summary,
  "figures/figure_01_study_characteristics.png",
  "Study characteristics represented in the Rolls Collection",
  paste0("Distinct studies as denominator (N = ", n_studies, ")")
)

# FIGURE 02: All data availability

all_data_availability <- bind_rows(
  demographic_summary,
  intake_summary,
  questionnaire_summary
)

if (nrow(all_data_availability) > 0) {
  p02 <- all_data_availability %>%
    group_by(domain) %>%
    mutate(feature = reorder(feature, percent)) %>%
    ungroup() %>%
    ggplot(aes(x = percent, y = feature)) +
    geom_col(width = 0.72) +
    geom_text(
      aes(label = label),
      hjust = -0.08,
      size = 3.2
    ) +
    facet_wrap(~domain, scales = "free_y", ncol = 1) +
    scale_x_continuous(
      labels = label_percent(scale = 1, accuracy = 1),
      limits = c(0, max(100, max(all_data_availability$percent, na.rm = TRUE) * 1.18))
    ) +
    labs(
      title = "Data availability across the Rolls Collection",
      subtitle = paste0("Percentage of distinct studies containing each data element (N = ", n_studies, ")"),
      x = "Percentage of studies",
      y = NULL
    ) +
    theme_minimal(base_size = 11) +
    theme(
      panel.grid.major.y = element_blank(),
      panel.grid.minor = element_blank(),
      strip.text = element_text(face = "bold"),
      plot.title = element_text(face = "bold")
    )
  
  ggsave(
    "figures/figure_02_all_data_availability.png",
    p02, width = 9, height = 10.5, dpi = 300
  )
}

# FIGURE 03: Demographic-data availability only

save_horizontal_percent(
  demographic_summary,
  "figures/figure_03_demographic_data_availability.png",
  "Demographic data available across studies",
  paste0("Distinct studies as denominator (N = ", n_studies, ")"),
  height = 4.8
)

# FIGURE 04: Intake/eating-behavior availability only

save_horizontal_percent(
  intake_summary,
  "figures/figure_04_intake_data_availability.png",
  "Intake/Eating behavior data available across studies",
  paste0("Distinct studies as denominator (N = ", n_studies, ")"),
  height = 6.2
)

# FIGURE 05: Questionnaire availability only

save_horizontal_percent(
  questionnaire_summary,
  "figures/figure_05_questionnaire_availability.png",
  "Questionnaire/Related measures available across studies",
  paste0("Distinct studies as denominator (N = ", n_studies, ")"),
  height = 6.8
)

total_distinct_studies <- nrow(study_level)

study_age <- rolls_data %>%
  filter(
    !is.na(sample_age_clean),
    nzchar(sample_age_clean)
  ) %>%
  distinct(study, sample_age_clean) %>%
  count(sample_age_clean, name = "n_studies") %>%
  mutate(
    percent = 100 * n_studies / total_distinct_studies,
    label = paste0(n_studies, " (", round(percent, 1), "%)")
  )

# FIGURE 06: Studies by age group

if (nrow(study_age) > 0) {
  p06 <- study_age %>%
    arrange(n_studies) %>%
    mutate(sample_age_clean = factor(sample_age_clean, levels = sample_age_clean)) %>%
    ggplot(aes(x = n_studies, y = sample_age_clean)) +
    geom_col(width = 0.7) +
    geom_text(aes(label = label), hjust = -0.08, size = 3.5) +
    scale_x_continuous(
      limits = c(0, max(study_age$n_studies) * 1.22),
      expand = expansion(mult = c(0, 0))
    ) +
    labs(
      title = "Studies represented by sample age group",
      subtitle = "A study can contribute to more than one age group if applicable",
      x = "Number of distinct studies",
      y = NULL
    ) +
    theme_minimal(base_size = 12) +
    theme(
      panel.grid.major.y = element_blank(),
      panel.grid.minor = element_blank(),
      plot.title = element_text(face = "bold")
    )
  
  ggsave("figures/figure_06_studies_by_age_group.png", p06, width = 7.5, height = 4.5, dpi = 300)
}

# FIGURE 07: Studies by sex composition

study_sex <- rolls_data %>%
  filter(
    !is.na(sample_sex_clean),
    nzchar(sample_sex_clean)
  ) %>%
  distinct(study, sample_sex_clean) %>%
  count(sample_sex_clean, name = "n_studies") %>%
  mutate(
    percent = 100 * n_studies / total_distinct_studies,
    label = paste0(n_studies, " (", round(percent, 1), "%)")
  )

if (nrow(study_sex) > 0) {
  p07 <- study_sex %>%
    arrange(n_studies) %>%
    mutate(sample_sex_clean = factor(sample_sex_clean, levels = sample_sex_clean)) %>%
    ggplot(aes(x = n_studies, y = sample_sex_clean)) +
    geom_col(width = 0.7) +
    geom_text(aes(label = label), hjust = -0.08, size = 3.5) +
    scale_x_continuous(
      limits = c(0, max(study_sex$n_studies) * 1.22),
      expand = expansion(mult = c(0, 0))
    ) +
    labs(
      title = "Studies by sample sex composition",
      subtitle = "Distinct studies; categories reflect the overview metadata",
      x = "Number of distinct studies",
      y = NULL
    ) +
    theme_minimal(base_size = 12) +
    theme(
      panel.grid.major.y = element_blank(),
      panel.grid.minor = element_blank(),
      plot.title = element_text(face = "bold")
    )
  
  ggsave("figures/figure_07_studies_by_sex_composition.png", p07, width = 7.5, height = 4.5, dpi = 300)
}

# FIGURE 08: Studies by location

study_location <- rolls_data %>%
  filter(
    !is.na(location_clean),
    nzchar(location_clean)
  ) %>%
  distinct(study, location_clean) %>%
  count(location_clean, name = "n_studies") %>%
  arrange(n_studies) %>%
  mutate(
    percent = 100 * n_studies / total_distinct_studies,
    label = paste0(n_studies, " (", round(percent, 1), "%)")
  )

if (nrow(study_location) > 0) {
  p08 <- study_location %>%
    mutate(location_clean = factor(location_clean, levels = location_clean)) %>%
    ggplot(aes(x = n_studies, y = location_clean)) +
    geom_col(width = 0.7) +
    geom_text(aes(label = label), hjust = -0.08, size = 3.4) +
    scale_x_continuous(
      limits = c(0, max(study_location$n_studies) * 1.23),
      expand = expansion(mult = c(0, 0))
    ) +
    labs(
      title = "Studies by research location",
      x = "Number of distinct studies",
      y = NULL
    ) +
    theme_minimal(base_size = 12) +
    theme(
      panel.grid.major.y = element_blank(),
      panel.grid.minor = element_blank(),
      plot.title = element_text(face = "bold")
    )
  
  ggsave("figures/figure_08_studies_by_location.png", p08, width = 8, height = 5, dpi = 300)
}

# FIGURE 09: Number of studies beginning each year

studies_by_year <- study_level %>%
  filter(!is.na(year), is.finite(year)) %>%
  count(year, name = "n_studies") %>%
  arrange(year)

if (nrow(studies_by_year) > 0) {
  p09 <- ggplot(studies_by_year, aes(x = year, y = n_studies)) +
    geom_col(width = 0.85) +
    scale_x_continuous(breaks = pretty_breaks()) +
    labs(
      title = "Number of studies represented by study year",
      x = "Study year",
      y = "Number of distinct studies"
    ) +
    theme_minimal(base_size = 12) +
    theme(
      panel.grid.minor = element_blank(),
      plot.title = element_text(face = "bold")
    )
  
  ggsave("figures/figure_09_studies_by_year.png", p09, width = 9, height = 5, dpi = 300)
}

# FIGURE 10: Number of studies by 5-year period

study_period <- study_level %>%
  filter(!is.na(year), is.finite(year)) %>%
  mutate(
    period_start = floor(year / 5) * 5,
    period = paste0(period_start, "-", period_start + 4)
  ) %>%
  count(period_start, period, name = "n_studies") %>%
  arrange(period_start)

if (nrow(study_period) > 0) {
  p10 <- study_period %>%
    mutate(period = factor(period, levels = period)) %>%
    ggplot(aes(x = period, y = n_studies)) +
    geom_col(width = 0.75) +
    geom_text(aes(label = n_studies), vjust = -0.3, size = 3.5) +
    scale_y_continuous(
      limits = c(0, max(study_period$n_studies) * 1.15),
      expand = expansion(mult = c(0, 0))
    ) +
    labs(
      title = "Studies represented across 5-year periods",
      x = "Study period",
      y = "Number of distinct studies"
    ) +
    theme_minimal(base_size = 12) +
    theme(
      axis.text.x = element_text(angle = 45, hjust = 1),
      panel.grid.minor = element_blank(),
      plot.title = element_text(face = "bold")
    )
  
  ggsave("figures/figure_10_studies_by_5_year_period.png", p10, width = 9, height = 5.5, dpi = 300)
}


age_flag_vars <- intersect(
  c(names(method_labels), names(demographic_labels), names(intake_labels)),
  names(rolls_data)
)

study_age_level <- rolls_data %>%
  filter(
    !is.na(sample_age_clean),
    sample_age_clean %in% c("Child", "Adult", "Elderly")
  ) %>%
  group_by(study, sample_age_clean) %>%
  summarise(
    across(
      any_of(age_flag_vars),
      ~ as.integer(any(is_present(.x), na.rm = TRUE))
    ),
    .groups = "drop"
  )

make_age_summary <- function(label_vector) {
  vars <- intersect(names(label_vector), names(study_age_level))
  if (length(vars) == 0 || nrow(study_age_level) == 0) return(tibble())
  
  study_age_level %>%
    pivot_longer(
      cols = all_of(vars),
      names_to = "variable",
      values_to = "present"
    ) %>%
    group_by(sample_age_clean, variable) %>%
    summarise(
      n_studies = sum(is_present(present), na.rm = TRUE),
      total_studies_age = n_distinct(study),
      percent = 100 * n_studies / total_studies_age,
      .groups = "drop"
    ) %>%
    mutate(feature = unname(label_vector[variable]))
}

age_data_summary <- bind_rows(
  make_age_summary(demographic_labels),
  make_age_summary(intake_labels)
)

# FIGURE 11: Selected data availability by age group

selected_age_features <- c(
  "Race/Ethnicity",
  "Socioeconomic status",
  "BMI/Weight status",
  "Measured intake",
  "Carbohydrate intake",
  "Fat intake",
  "Protein intake",
  "Fiber intake"
)

age_selected <- age_data_summary %>%
  filter(feature %in% selected_age_features)

if (nrow(age_selected) > 0) {
  p11 <- age_selected %>%
    mutate(
      feature = factor(feature, levels = rev(selected_age_features)),
      sample_age_clean = factor(sample_age_clean, levels = c("Child", "Adult", "Elderly"))
    ) %>%
    ggplot(aes(x = percent, y = feature, fill = sample_age_clean)) +
    geom_col(position = position_dodge(width = 0.78), width = 0.7) +
    scale_x_continuous(
      labels = label_percent(scale = 1, accuracy = 1),
      limits = c(0, 100)
    ) +
    labs(
      title = "Selected data availability by sample age group",
      subtitle = "Percentages use the number of distinct studies within each age group as the denominator",
      x = "Percentage of studies",
      y = NULL,
      fill = "Age group"
    ) +
    theme_minimal(base_size = 11) +
    theme(
      panel.grid.major.y = element_blank(),
      panel.grid.minor = element_blank(),
      plot.title = element_text(face = "bold")
    )
  
  ggsave("figures/figure_11_selected_data_availability_by_age.png", p11, width = 9.5, height = 6.5, dpi = 300)
}

# FIGURE 12: Study characteristics by age group

age_method_summary <- make_age_summary(method_labels)

if (nrow(age_method_summary) > 0) {
  p12 <- age_method_summary %>%
    mutate(
      sample_age_clean = factor(sample_age_clean, levels = c("Child", "Adult", "Elderly"))
    ) %>%
    ggplot(aes(x = percent, y = reorder(feature, percent), fill = sample_age_clean)) +
    geom_col(position = position_dodge(width = 0.78), width = 0.7) +
    scale_x_continuous(
      labels = label_percent(scale = 1, accuracy = 1),
      limits = c(0, 100)
    ) +
    labs(
      title = "Study characteristics by sample age group",
      subtitle = "Percentages are calculated within each age group",
      x = "Percentage of studies",
      y = NULL,
      fill = "Age group"
    ) +
    theme_minimal(base_size = 11) +
    theme(
      panel.grid.major.y = element_blank(),
      panel.grid.minor = element_blank(),
      plot.title = element_text(face = "bold")
    )
  
  ggsave("figures/figure_12_study_characteristics_by_age.png", p12, width = 10, height = 7, dpi = 300)
}



# ------------------------------------------------------------
# 10. Participants represented over time
#     Uses unique study/sample-age/sample-size combinations to
#     reduce double-counting of repeated overview rows.
# ------------------------------------------------------------

participant_period <- rolls_data %>%
  filter(
    !is.na(year),
    is.finite(year),
    !is.na(sample_n),
    is.finite(sample_n),
    sample_n >= 0,
    !is.na(sample_age_clean),
    nzchar(sample_age_clean)
  ) %>%
  mutate(
    period_start = floor(year / 5) * 5,
    period = paste0(period_start, "-", period_start + 4)
  ) %>%
  distinct(study, year, period_start, period, sample_age_clean, sample_n) %>%
  group_by(period_start, period, sample_age_clean) %>%
  summarise(participants = sum(sample_n, na.rm = TRUE), .groups = "drop")

# FIGURE 13: Participants represented by 5-year period

if (nrow(participant_period) > 0) {
  p17 <- participant_period %>%
    mutate(
      period = factor(period, levels = unique(period[order(period_start)])),
      sample_age_clean = factor(sample_age_clean, levels = c("Child", "Adult", "Elderly"))
    ) %>%
    ggplot(aes(x = period, y = participants, fill = sample_age_clean)) +
    geom_col() +
    labs(
      title = "Participants represented across 5-year periods",
      subtitle = "Stacked by sample age group",
      x = "Study period",
      y = "Number of participants represented",
      fill = "Age group"
    ) +
    theme_minimal(base_size = 11) +
    theme(
      axis.text.x = element_text(angle = 45, hjust = 1),
      panel.grid.minor = element_blank(),
      plot.title = element_text(face = "bold")
    )
  
  ggsave("figures/figure_13_participants_by_5_year_period.png", p17, width = 9.5, height = 5.8, dpi = 300)
}


# Tables

collection_summary_table <- tibble(
  characteristic = c(
    "Number of distinct studies",
    "Earliest study year",
    "Latest study year",
    "Median study sample size",
    "Mean study sample size",
    "Minimum study sample size",
    "Maximum study sample size"
  ),
  value = c(
    as.character(n_studies),
    as.character(min(study_level$year, na.rm = TRUE)),
    as.character(max(study_level$year, na.rm = TRUE)),
    as.character(round(median(study_level$study_n, na.rm = TRUE), 1)),
    as.character(round(mean(study_level$study_n, na.rm = TRUE), 1)),
    as.character(min(study_level$study_n, na.rm = TRUE)),
    as.character(max(study_level$study_n, na.rm = TRUE))
  )
)

write_csv(
  collection_summary_table,
  "tables/table_01_collection_summary_characteristics.csv"
)

write_csv(
  method_summary %>%
    arrange(desc(percent)) %>%
    select(
      characteristic = feature,
      n_studies,
      total_studies,
      percent
    ),
  "tables/table_02_study_characteristics_n_percent.csv"
)

write_csv(
  all_data_availability %>%
    arrange(domain, desc(percent)) %>%
    select(
      domain,
      data_element = feature,
      n_studies,
      total_studies,
      percent
    ),
  "tables/table_03_data_availability_n_percent.csv"
)

write_csv(
  age_selected %>%
    arrange(sample_age_clean, desc(percent)),
  "tables/table_04_selected_data_availability_by_age.csv"
)


write_csv(
  study_age,
  "tables/table_05_studies_by_age_group.csv"
)

write_csv(
  study_sex,
  "tables/table_06_studies_by_sex_composition.csv"
)

write_csv(
  study_location,
  "tables/table_07_studies_by_location.csv"
)

cat("Rolls Collection candidate figures complete\n")
cat("Distinct studies:", n_studies, "\n")
cat("Figures folder:", normalizePath("figures"), "\n")
cat("Tables folder:", normalizePath("tables"), "\n\n")

cat("Candidate figures created:\n")
created_figures <- list.files(
  "figures",
  pattern = "^figure_.*\\.png$",
  full.names = FALSE
)
cat(paste0("  - ", created_figures, collapse = "\n"), "\n\n")

cat("Figures retained in this script:
")
cat("  - figure_01_study_characteristics.png
")
cat("  - figure_02_all_data_availability.png
")
cat("  - figure_03_demographic_data_availability.png
")
cat("  - figure_04_intake_data_availability.png
")
cat("  - figure_05_questionnaire_availability.png
")
cat("  - figure_06_studies_by_age_group.png
")
cat("  - figure_07_studies_by_sex_composition.png
")
cat("  - figure_08_studies_by_location.png
")
cat("  - figure_09_studies_by_year.png
")
cat("  - figure_10_studies_by_5_year_period.png
")
cat("  - figure_11_selected_data_availability_by_age.png
")
cat("  - figure_12_study_characteristics_by_age.png
")
cat("  - figure_13_participants_by_5_year_period.png
")
cat("
")


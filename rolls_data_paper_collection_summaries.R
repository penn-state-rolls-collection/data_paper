library(dplyr)
library(tidyr)
library(readr)
library(stringr)
library(ggplot2)
library(scales)

rolls_colors <- c(
  orange = "#E69F00",
  sky = "#56B4E9",
  green = "#009E73",
  yellow = "#F0E442",
  blue = "#0072B2",
  vermillion = "#D55E00",
  purple = "#CC79A7",
  black = "#000000"
)

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
    str_detect(x, "elder|older") ~ "Older adults",
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
    geom_col(width = 0.72, fill = unname(rolls_colors["blue"])) +
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
      plot.title = element_text(face = "bold"),
      axis.text.x = element_text(angle = 0, hjust = 0.5)
    )
  
  ggsave(filename, p, width = width, height = height, dpi = 300)
  invisible(p)
}

method_summary <- make_feature_summary(
  study_level, method_labels, "Study design/population"
) %>%
  filter(percent >= 3)

demographic_summary <- make_feature_summary(
  study_level, demographic_labels, "Demographics"
) %>%
  filter(percent >= 3)

intake_summary <- make_feature_summary(
  study_level, intake_labels, "Intake/eating behavior"
) %>%
  filter(percent >= 3)

questionnaire_summary <- make_feature_summary(
  study_level, questionnaire_labels, "Questionnaires/related measures"
) %>%
  filter(percent >= 3)

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
all_data_availability <- bind_rows(demographic_summary, intake_summary, questionnaire_summary)

if (nrow(all_data_availability) > 0) {
  p02 <- all_data_availability %>%
    group_by(domain) %>% mutate(feature = reorder(feature, percent)) %>% ungroup() %>%
    ggplot(aes(x = percent, y = feature, fill = domain)) +
    geom_col(width = 0.72, show.legend = FALSE) +
    geom_text(aes(label = label), hjust = -0.08, size = 4.2) +
    facet_wrap(~domain, scales = "free_y", ncol = 1) +
    scale_fill_manual(values = c("Demographics"=rolls_colors["blue"],
                                 "Intake/eating behavior"=rolls_colors["green"],
                                 "Questionnaires/related measures"=rolls_colors["orange"])) +
    scale_x_continuous(labels=label_percent(scale=1, accuracy=1),
                       limits=c(0,max(100,max(all_data_availability$percent,na.rm=TRUE)*1.18))) +
    labs(title="Data availability across the Rolls Collection",
         subtitle=paste0("Percentage of distinct studies containing each data element (N = ",n_studies,")"),
         x="Percentage of studies", y=NULL) +
    theme_minimal(base_size=14) +
    theme(panel.grid.major.y=element_blank(), panel.grid.minor=element_blank(),
          strip.text=element_text(face="bold",size=14),
          plot.title=element_text(face="bold",size=18), axis.text=element_text(size=12))
  ggsave("figures/figure_02_all_data_availability.png",p02,width=11,height=13,dpi=300)
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
    ggplot(aes(x = n_studies, y = sample_age_clean, fill = sample_age_clean)) +
    geom_col(width = 0.7, show.legend = FALSE) +
    scale_fill_manual(values = c(
      "Child" = unname(rolls_colors["orange"]),
      "Adult" = unname(rolls_colors["blue"]),
      "Older adults" = unname(rolls_colors["green"])
    )) +
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
    ggplot(aes(x = n_studies, y = sample_sex_clean, fill = sample_sex_clean)) +
    geom_col(width = 0.7, show.legend = FALSE) +
    scale_fill_manual(values = c(
      "Female" = unname(rolls_colors["orange"]),
      "Male" = unname(rolls_colors["blue"]),
      "Mixed" = unname(rolls_colors["green"])
    )) +
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
    ggplot(aes(x = n_studies, y = location_clean, fill = location_clean)) +
    geom_col(width = 0.7, show.legend = FALSE) +
    scale_fill_manual(values = rep(
      unname(c(rolls_colors["blue"], rolls_colors["orange"], rolls_colors["green"],
               rolls_colors["purple"], rolls_colors["sky"], rolls_colors["vermillion"])),
      length.out = n_distinct(study_location$location_clean)
    )) +
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

# FIGURE 09: Distinct studies by adjustable year bin
# Change year_bin_width to 2, 4, or 5 to compare bin sizes.
year_bin_width <- 3

studies_by_year_bin <- study_level %>%
  filter(!is.na(year), is.finite(year)) %>%
  mutate(bin_start=floor(year/year_bin_width)*year_bin_width,
         bin_end=bin_start+year_bin_width-1,
         year_bin=paste0(bin_start,"-",bin_end)) %>%
  distinct(study,bin_start,bin_end,year_bin) %>%
  count(bin_start,bin_end,year_bin,name="n_studies") %>% arrange(bin_start)

if(nrow(studies_by_year_bin)>0){
  p09 <- studies_by_year_bin %>%
    mutate(year_bin=factor(year_bin,levels=year_bin)) %>%
    ggplot(aes(x=year_bin,y=n_studies)) +
    geom_col(width=.75,fill=rolls_colors["blue"]) +
    geom_text(aes(label=n_studies),vjust=-.3,size=3.8) +
    scale_y_continuous(limits=c(0,max(studies_by_year_bin$n_studies)*1.15),
                       expand=expansion(mult=c(0,0))) +
    labs(title=paste0("Distinct studies represented across ",year_bin_width,"-year periods"),
         subtitle="Each study is counted once based on its study year",
         x="Study period",y="Number of distinct studies") +
    theme_minimal(base_size=13) +
    theme(axis.text.x=element_text(angle=0,hjust=0.5),panel.grid.minor=element_blank(),
          plot.title=element_text(face="bold"))
  ggsave("figures/figure_09_studies_by_year.png",p09,width=10,height=5.8,dpi=300)
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
    geom_col(width = 0.75, fill = unname(rolls_colors["green"])) +
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
      axis.text.x = element_text(angle = 0, hjust = 0.5),
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
    sample_age_clean %in% c("Child", "Adult", "Older adults")
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
      sample_age_clean = factor(sample_age_clean, levels = c("Child", "Adult", "Older adults"))
    ) %>%
    ggplot(aes(x = percent, y = feature, fill = sample_age_clean)) +
    geom_col(position = position_dodge(width = 0.78), width = 0.7) +
    scale_fill_manual(values=c("Child"=rolls_colors["orange"],"Adult"=rolls_colors["blue"],
                               "Older adults"=rolls_colors["green"])) +
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
      sample_age_clean = factor(sample_age_clean, levels = c("Child", "Adult", "Older adults"))
    ) %>%
    ggplot(aes(x = percent, y = reorder(feature, percent), fill = sample_age_clean)) +
    geom_col(position = position_dodge(width = 0.78), width = 0.7) +
    scale_fill_manual(values=c("Child"=rolls_colors["orange"],"Adult"=rolls_colors["blue"],
                               "Older adults"=rolls_colors["green"])) +
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
      sample_age_clean = factor(sample_age_clean, levels = c("Child", "Adult", "Older adults"))
    ) %>%
    ggplot(aes(x = period, y = participants, fill = sample_age_clean)) +
    geom_col(fill = unname(rolls_colors["blue"])) +
    scale_fill_manual(values=c("Child"=rolls_colors["orange"],"Adult"=rolls_colors["blue"],
                               "Older adults"=rolls_colors["green"])) +
    labs(
      title = "Participants represented across 5-year periods",
      subtitle = "Stacked by sample age group",
      x = "Study period",
      y = "Number of participants represented",
      fill = "Age group"
    ) +
    theme_minimal(base_size = 11) +
    theme(
      axis.text.x = element_text(angle = 0, hjust = 0.5),
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

# TABLE 08: Poster-style overview of study characteristics and included measures

poster_age_levels <- c("Older adults", "Adult", "Child")

poster_study_age <- rolls_data %>%
  filter(sample_age_clean %in% poster_age_levels) %>%
  group_by(study, sample_age_clean) %>%
  summarise(
    study_n = {
      z <- study_n[is.finite(study_n)]
      if (length(z) == 0) NA_real_ else max(z)
    },
    location = paste(unique(na.omit(location_clean)), collapse = "; "),
    sample_sex = paste(unique(na.omit(sample_sex_clean)), collapse = "; "),
    race_present = if ("race" %in% names(rolls_data)) as.integer(any(is_present(race), na.rm = TRUE)) else 0L,
    ses_present = if ("ses" %in% names(rolls_data)) as.integer(any(is_present(ses), na.rm = TRUE)) else 0L,
    bmi_present = if ("bmi" %in% names(rolls_data)) as.integer(any(is_present(bmi), na.rm = TRUE)) else 0L,
    measured_present = if ("measured_intake" %in% names(rolls_data)) as.integer(any(is_present(measured_intake), na.rm = TRUE)) else 0L,
    cho_present = if ("cho_intake" %in% names(rolls_data)) as.integer(any(is_present(cho_intake), na.rm = TRUE)) else 0L,
    fat_present = if ("fat_intake" %in% names(rolls_data)) as.integer(any(is_present(fat_intake), na.rm = TRUE)) else 0L,
    pro_present = if ("pro_intake" %in% names(rolls_data)) as.integer(any(is_present(pro_intake), na.rm = TRUE)) else 0L,
    fiber_present = if ("fiber_intake" %in% names(rolls_data)) as.integer(any(is_present(fiber_intake), na.rm = TRUE)) else 0L,
    .groups = "drop"
  ) %>%
  mutate(macro_present = as.integer(cho_present == 1 | fat_present == 1 | pro_present == 1))

age_denoms <- poster_study_age %>%
  count(sample_age_clean, name = "denominator")

fmt_n_pct <- function(n, d) {
  paste0(n, " (", round(100 * n / d), "%)")
}

make_poster_row <- function(label, variable) {
  poster_study_age %>%
    group_by(sample_age_clean) %>%
    summarise(n = sum(.data[[variable]], na.rm = TRUE), .groups = "drop") %>%
    right_join(age_denoms, by = "sample_age_clean") %>%
    mutate(
      n = replace_na(n, 0),
      characteristic = label,
      value = fmt_n_pct(n, denominator)
    ) %>%
    select(characteristic, sample_age_clean, value)
}

table08_long <- bind_rows(
  age_denoms %>%
    transmute(characteristic = "Number of Studies",
              sample_age_clean,
              value = as.character(denominator)),
  poster_study_age %>%
    group_by(sample_age_clean) %>%
    summarise(
      value = ifelse(
        sum(is.finite(study_n)) > 1,
        paste0(round(mean(study_n, na.rm = TRUE)), " (", round(sd(study_n, na.rm = TRUE)), ")"),
        paste0(round(mean(study_n, na.rm = TRUE)), " (NA)")
      ),
      .groups = "drop"
    ) %>%
    mutate(characteristic = "Sample Size, Mean (SD)") %>%
    select(characteristic, sample_age_clean, value),
  make_poster_row("Data Present: Race/Ethnicity", "race_present"),
  make_poster_row("Data Present: Socioeconomic Status", "ses_present"),
  make_poster_row("Data Present: BMI/Weight Status", "bmi_present"),
  make_poster_row("Data Present: Measured Intake", "measured_present"),
  make_poster_row("Data Present: Macronutrient Intake", "macro_present"),
  make_poster_row("Data Present: Fiber Intake", "fiber_present")
)

location_rows <- bind_rows(
  poster_study_age %>% mutate(flag = str_detect(str_to_lower(location), "johns hopkins")) %>%
    group_by(sample_age_clean) %>% summarise(n = sum(flag, na.rm = TRUE), .groups = "drop") %>%
    right_join(age_denoms, by = "sample_age_clean") %>%
    mutate(characteristic = "Location: Johns Hopkins", n = replace_na(n, 0),
           value = fmt_n_pct(n, denominator)) %>% select(characteristic, sample_age_clean, value),
  poster_study_age %>% mutate(flag = str_detect(str_to_lower(location), "penn state")) %>%
    group_by(sample_age_clean) %>% summarise(n = sum(flag, na.rm = TRUE), .groups = "drop") %>%
    right_join(age_denoms, by = "sample_age_clean") %>%
    mutate(characteristic = "Location: Penn State", n = replace_na(n, 0),
           value = fmt_n_pct(n, denominator)) %>% select(characteristic, sample_age_clean, value)
)

sex_rows <- bind_rows(
  lapply(c("Male","Female","Mixed"), function(sx) {
    poster_study_age %>%
      mutate(flag = sample_sex == sx) %>%
      group_by(sample_age_clean) %>%
      summarise(n = sum(flag, na.rm = TRUE), .groups = "drop") %>%
      right_join(age_denoms, by = "sample_age_clean") %>%
      mutate(characteristic = paste0("Study Sex: ", sx),
             n = replace_na(n, 0),
             value = fmt_n_pct(n, denominator)) %>%
      select(characteristic, sample_age_clean, value)
  })
)

table08 <- bind_rows(
  table08_long %>% slice(1:(nrow(age_denoms) * 2)),
  location_rows,
  sex_rows,
  table08_long %>% slice((nrow(age_denoms) * 2 + 1):n())
) %>%
  mutate(sample_age_clean = factor(sample_age_clean, levels = poster_age_levels)) %>%
  pivot_wider(names_from = sample_age_clean, values_from = value) %>%
  select(Characteristic = characteristic, `Older adults`, Adult, Child)

write_csv(table08, "tables/table_08_participant_characteristics_by_age.csv")

message("Finished creating revised figures and tables.")



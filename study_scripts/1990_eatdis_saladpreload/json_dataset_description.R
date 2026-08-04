# This script was updated/written by Alaina Pearce in Winter 2026
# to create a json file for the Rolls Collection
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

dataset_list <- list(
  "@context" = "http://schema.org/",
  "@type" = "Dataset",
  "name" = "High- vs. Low-Calorie Preloads and Appetite Regulation in Eating Disorder Inpatients: Partial data from a 1990 Study",
  "description" = "This dataset contains partial data from a 1990 study examining the effects of caloric preloads on appetite and sensory-specific satiety (SSS) in inpatients from the Johns Hopkins Hospital Eating Disorder Unit and healthy community controls. Participants completed three sessions in counterbalanced order on alternating days during the first week of hospital admission. During each session, participants received one of three condition preloads for lunch: high calorie salad preload, low calorie salad preload, or no preload. Visual analog scales (VAS) were used to assess hunger, fullness, desire to eat, how much they thought they could eat (i.e., prospective consumption), bloatedness, fear of becoming fat, desire to binge and purge, alertness, guilt, depression, contentment, and nausea before and after the preload and lunch (a total of four assessments). SSS was assessed using a 9-food taste-test before and after preload and lunch. Intake was measured by weighing foods before and after the consumption. Note: Available data include select VAS ratings and calculated difference scores.",
  "schemaVersion" = "Psych-DS 0.1.0",
  "author" = list(
    list("@type" = "Person",
         "name" = "Alaina L Pearce",
         "ORCID" = "0000-0003-3157-6566"),
    list("@type" = "Person",
         "name" = "Arnold E. Anderson"),
    list("@type" = "Person",
         "name" = "Timothy H. Moran"),
    list("@type" = "Person",
         "name" = "Amy L. McNelis"),
    list("@type" = "Person",
         "name" = "Ingrid C. Federoff"),
    list("@type" = "Person",
         "name" = "Hope C. Baier"),
    list("@type" = "Person",
         "name" = "Barbara J Rolls",
         "ORCID" = "0000-0003-2374-1517")),
  "temporalCoverage" = "1990",
  "@software" = list('psychds',
                     "title" = "psychds: Tools for Creating and Validating Psych-DS Datasets",
                     "author" = "Psych-DS Development Team",
                     "year" = "2026",
                     "url" = "https://github.com/psych-ds/psychds-r"))
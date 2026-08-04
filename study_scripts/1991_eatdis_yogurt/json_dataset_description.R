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
  "name" = "High-Fat vs. High-Carbohydrate Preloads and Satiety in Bulimia Nervosa: Data from a 1991 Laboratory Study",
  "description" = "This dataset is from a 1991 study examining how yogurt preloads varying in macronutrient composition affect appetite and psychological state in with inpatients from the Johns Hopkins Hospital Eating Disorder Unit and healthy community controls. Inpatients completed three counterbalanced sessions on alternating days during the first week of their hospital admission. At each session, participants received consumed one of three yogurt preloads for lunch–high fat, high carbohydrate, or low fat/low carbohydrate—followed by dinner. Visual analog scales (VAS) were used to assess hunger, fullness, desire to eat, how much they thought they could eat (i.e., prospective consumption), bloatedness, fear of becoming fat, desire to binge and purge, alertness, guilt, depression, contentment, and nausea before and after the yogurt preload, every 60 minutes between the preload and dinner (four times), and before and after dinner. Intake was measured by weighing foods before and after the consumption.",
  "schemaVersion" = "Psych-DS 0.1.0",
  "author" = list(
    list("@type" = "Person",
         "name" = "Alaina L Pearce",
         "ORCID" = "0000-0003-3157-6566"),
    list("@type" = "Person",
         "name" = "Marion M Hetherington",
         "ORCID" = "0000-0001-8677-5234"),
    list("@type" = "Person",
         "name" = "Arnold E. Anderson"),
    list("@type" = "Person",
         "name" = "Susan A. Stoner",
         "ORCID" = "0000-0001-8548-219X"),
    list("@type" = "Person",
         "name" = "Barbara J Rolls",
         "ORCID" = "0000-0003-2374-1517")),
  "temporalCoverage" = "1991",
  "@software" = list('psychds',
                     "title" = "psychds: Tools for Creating and Validating Psych-DS Datasets",
                     "author" = "Psych-DS Development Team",
                     "year" = "2026",
                     "url" = "https://github.com/psych-ds/psychds-r"))
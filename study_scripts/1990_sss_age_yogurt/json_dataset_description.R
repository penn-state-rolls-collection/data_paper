# This script was upadesire_eatd/written by Alaina Pearce in Winter 2026
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
  "name" = "Age Differences in Sensory-Specific Satiety After Yogurt Consumption: Data from a 1990 Laboratory Study",
  "description" = "This dataset is from a 1990 study investigating how age influences sensory-specific satiety (SSS), which is the decline in palatability of a food after consuming it. Individuals from four age groups (12-15 y; 22-35:45-60; 65-82) completed two counterbalanced lab visits, during which they consumed two different amounts (ad libitum or 300 g) of yogurt. Visual analog scales (VAS) were used to measure current state (e.g., hunger, thirst, nausea, fullness, and how much they thought they could eat (i.e., prospective consumption) before and after eating. SSS was measured using VAS ratings of pleasantness of foods before and after eating the yogurt. Intake was measured by weighing foods before and after the meal.",
  "schemaVersion" = "Psych-DS 0.1.0",
  "author" = list(
    list("@type" = "Person",
         "name" = "Alaina L Pearce",
         "ORCID" = "0000-0003-3157-6566"),
    list("@type" = "Person",
         "name" = "Teresa M. McDermott"),
    list("@type" = "Person",
         "name" = "Barbara J Rolls",
         "ORCID" = "0000-0003-2374-1517")),
  "temporalCoverage" = "1990",
  "@software" = list('psychds',
                     "title" = "psychds: Tools for Creating and Validating Psych-DS Datasets",
                     "author" = "Psych-DS Development Team",
                     "year" = "2026",
                     "url" = "https://github.com/psych-ds/psychds-r"),
  "DatasetType" = 'derivative')
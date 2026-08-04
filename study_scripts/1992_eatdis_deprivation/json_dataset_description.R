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
  "name" = "Effects of Overnight Fasting on Appetite and Meal Behavior in Eating Disorders: A 1992 Laboratory Study",
  "description" = "This dataset is from a 1992 study examining the effects of food deprivation on appetite, mood, and eating behavior in with inpatients from the Johns Hopkins Hospital Eating Disorder Unit and healthy community controls. Participants completed two counterbalanced dinner sessions in counterbalanced order, with at least one non-test day between sessions on alternating days during the first week of admission to the hospital. In the deprivation condition, inpatients started fasting after their 6pm dinner and healthy controls participants started fasting at 10 pm. The fast lasted until dinner the following day. In the non-deprivation condition, there was no fast. Visual analog scales (VAS) were used to assess hunger, thirst, desire to eat, fullness, prospective consumption (i.e. how much they thought they could eat), bloatedness, fear of fatness, desire to binge, desire to purge, alertness, guilt, depression, contentedness, and nausea before and after dinner. Dinner meals were consumed alone and video-recorded and coded for eating behaviors. Intake was measured by weighing foods before and after the consumption.",
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
  "temporalCoverage" = "1992",
  "@software" = list('psychds',
                     "title" = "psychds: Tools for Creating and Validating Psych-DS Datasets",
                     "author" = "Psych-DS Development Team",
                     "year" = "2026",
                     "url" = "https://github.com/psych-ds/psychds-r"))
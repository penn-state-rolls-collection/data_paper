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
  "name" = "Mealtime Behavior Coding in Eating Disorders at Admission and Discharge: A 1992 Video-Coded Dataset",
  "description" = "This dataset contains intake ad video-coded mealtime behavior data from a 1992 study in inpatients from the Johns Hopkins Hospital Eating Disorder Unit and healthy community controls. Participants were tested twice with inpatients completing sessions during the first week of hospital admission and at discharge and with healthy controls completing sessions at similar intervals. Lunch meals were recorded an analyzed for both intake and non-intake related behaviors. Intake was measured by weighing foods before and after the consumption.
Note: available data include raw coded data for food item microstructure only.",
  "schemaVersion" = "Psych-DS 0.1.0",
  "author" = list(
    list("@type" = "Person",
         "name" = "Alaina L Pearce",
         "ORCID" = "0000-0003-3157-6566"),
    list("@type" = "Person",
         "name" = "Karyn A. Tappe"),
    list("@type" = "Person",
         "name" = "Susan E. Gerberg"),
    list("@type" = "Person",
         "name" = "David J. Shide"),
    list("@type" = "Person",
         "name" = "Arnold E. Anderson"),
    list("@type" = "Person",
         "name" = "Barbara J Rolls",
         "ORCID" = "0000-0003-2374-1517")),
  "temporalCoverage" = "1992",
  "@software" = list('psychds',
                     "title" = "psychds: Tools for Creating and Validating Psych-DS Datasets",
                     "author" = "Psych-DS Development Team",
                     "year" = "2026",
                     "url" = "https://github.com/psych-ds/psychds-r"))
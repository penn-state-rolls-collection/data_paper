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
  "name" = "Daily Fluctuations in Hunger, Urges, and Affect in Eating Disorders: A 1991 Ecological Monitoring Dataset
",
  "description" = "This dataset contains hourly self-report data collected in 1991 from inpatients at the Johns Hopkins Hospital Eating Disorder Unit and healthy community controls. Visual analog scales (VAS) were used to assess hunger, thirst, desire to binge and purge, fear of being fat, anxiety, and depression every hour from 8:00 a.m. to 10:00 p.m. and before and after each meal. This was completed weekly on Fridays, starting with the first Friday after admission. ",
  "schemaVersion" = "Psych-DS 0.1.0",
  "author" = list(
    list("@type" = "Person",
         "name" = "Alaina L Pearce",
         "ORCID" = "0000-0003-3157-6566"),
    list("@type" = "Person",
         "name" = "Arnold E. Anderson"),
    list("@type" = "Person",
         "name" = "Susan A. Stoner",
         "ORCID" = "0000-0001-8548-219X"),
    list("@type" = "Person",
         "name" = "Ingrid C. Federoff"),
    list("@type" = "Person",
         "name" = "Barbara J Rolls",
         "ORCID" = "0000-0003-2374-1517")),
  "temporalCoverage" = "1991",
  "@software" = list('psychds',
                     "title" = "psychds: Tools for Creating and Validating Psych-DS Datasets",
                     "author" = "Psych-DS Development Team",
                     "year" = "2026",
                     "url" = "https://github.com/psych-ds/psychds-r"))
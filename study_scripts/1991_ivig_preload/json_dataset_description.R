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
  "name" = "Route of Nutrient Delivery and Satiety in Men: Data from a 1991 IV and Intragastric Infusion Study",
  "description" = "The study examined the effect of intravenous (IV) or intragastric (IG) preload infulsions of carbohydrates, fat, and saline on food intake throughout an entire day.",
  "schemaVersion" = "Psych-DS 0.1.0",
  "author" = list(
    list("@type" = "Person",
         "name" = "Alaina L Pearce",
         "ORCID" = "0000-0003-3157-6566"),
    list("@type" = "Person",
         "name" = "David J Shide"),
    list("@type" = "Person",
         "name" = "Benjamín H Caballero",
         "ORCID" = "0000-0003-4311-6321"),
    list("@type" = "Person",
         "name" = "Roger D. Reidelberger"),
    list("@type" = "Person",
         "name" = "Barbara J Rolls",
         "ORCID" = "0000-0003-2374-1517")),
  "temporalCoverage" = "1991",
  "@software" = list('psychds',
                     "title" = "psychds: Tools for Creating and Validating Psych-DS Datasets",
                     "author" = "Psych-DS Development Team",
                     "year" = "2026",
                     "url" = "https://github.com/psych-ds/psychds-r"))
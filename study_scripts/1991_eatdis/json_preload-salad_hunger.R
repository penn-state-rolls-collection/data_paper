# This script was upadted/written by Alaina Pearce in Winter 2026
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

salad_hunger_list <- list(
  "@context" = "http://schema.org/",
  "@type" = "Dataset",
  "name" = "study-salad_assay-hunger_data",
  "description" = "Hunger ratings for food attributes across 3 preload conditions in the Salad Preload - 1990 Study",
  "isPartOf" = "",
  "schemaVersion" = "Psych-DS 0.1.0",
  "subjectOf" = "Rolls BJ, Andersen AE, Moran TH, McNelis AL, Baier HC, Fedoroff IC. Food intake, hunger, and satiety after preloads in women with eating disorders. The American journal of clinical nutrition. 1992 Jun 1;55(6):1093-103",
  "General" = list("MissingValueCode" = "All missing values in this dataset are represented by n/a"),
  "variableMeasured" = list(
    list("name" = "id", 
         "description" = "participant id - note, this was randomly generated in the de-identified data to break any linkage to identifiable information originally collected with the study",
         "required" = "true",
         "@type" = "PropertyValue"),
    list("name" = "group", 
         "description" = "eating disorder group",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "anorexia nervosa - binge subtype"),
           list( "value" = "1",
                 "label" = "bulimia nervosa"),
           list( "value" = "2",
                 "label" = "anorexia nervosa - restrictive subtype"),
           list( "value" = "3",
                 "label" = "control - no eating disorder")),
         "@type" = "PropertyValue"),
    list("name" = "cond", 
         "description" = "preload condition",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "low calorie salad"),
           list( "value" = "1",
                 "label" = "no preload"),
           list( "value" = "2",
                 "label" = "high calorie salad")),
         "@type" = "PropertyValue"),
    list("name" = "time", 
         "description" = "time of taste-test",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "before preload"),
           list( "value" = "1",
                 "label" = "after preload"),
           list( "value" = "2",
                 "label" = "before lunch"),
           list( "value" = "3",
                 "label" = "after lunch")),
         "@type" = "PropertyValue"),
    list("name" = "hunger", 
         "description" = "Participant hunger rating using a visual analog scale from 0-100",
         "minValue" = "0",
         "maxValue" = "99",
         "@type" = "PropertyValue")))
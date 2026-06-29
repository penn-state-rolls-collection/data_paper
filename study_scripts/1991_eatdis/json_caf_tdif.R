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

caf_tdif_list <- list(
  "@context" = "http://schema.org/",
  "@type" = "Dataset",
  "name" = "study-cafeteria_calc-timedif_data.csv",
  "DatasetType" = 'derivative',
  "description" = "Cafeteria intake differences by timepoint for the 1991 Eating Disorders - Cafeteria Study",
  "schemaVersion" = "Psych-DS 0.1.0",
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
    list("name" = "g_fat_tdif", 
         "description" = "difference in grams of fat consumed after admission meal versus after discharge",
         "unitText" = "g",
         "minValue" = "-131",
         "maxValue" = "66",
         "@type" = "PropertyValue"),
    list("name" = "p_fat_tdif", 
         "description" = "percent difference in grams of fat consumed after admission meal versus after discharge",
         "unitText" = "g",
         "minValue" = "-72",
         "maxValue" = "43",
         "@type" = "PropertyValue"),
    list("name" = "g_cho_tdif", 
         "description" = "difference in grams of carbohydrates consumed after admission meal versus after discharge",
         "unitText" = "g",
         "minValue" = "-83",
         "maxValue" = "127",
         "@type" = "PropertyValue"),
    list("name" = "p_cho_tdif", 
         "description" = "percent difference in grams of carbohydrates consumed after admission meal versus after discharge",
         "unitText" = "g",
         "minValue" = "-81",
         "maxValue" = "72",
         "@type" = "PropertyValue"),
    list("name" = "g_pro_tdif", 
         "description" = "difference in grams of protein consumed after admission meal versus after discharge",
         "unitText" = "g",
         "minValue" = "-21",
         "maxValue" = "103",
         "@type" = "PropertyValue"),
    list("name" = "p_pro_tdif", 
         "description" = "percent difference in grams of protein consumed after admission meal versus after discharge",
         "unitText" = "g",
         "minValue" = "-25",
         "maxValue" = "34",
         "@type" = "PropertyValue"),
    list("name" = "more_g_fat", 
         "description" = "participant ate more grams of fat at discharge compared to admission",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "No"),
           list( "value" = "1",
                 "label" = "Yes")),
         "@type" = "PropertyValue"),
    list("name" = "more_p_fat", 
         "description" = "participant ate a greater percentage of fat at discharge compared to admission",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "No"),
           list( "value" = "1",
                 "label" = "Yes")),
         "@type" = "PropertyValue"),
    list("name" = "more_g_cho", 
         "description" = "participant ate more grams of carbohydrates at discharge compared to admission",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "No"),
           list( "value" = "1",
                 "label" = "Yes")),
         "@type" = "PropertyValue"),
    list("name" = "more_p_cho", 
         "description" = "participant ate a greater percentage of carbohydrates at discharge compared to admission",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "No"),
           list( "value" = "1",
                 "label" = "Yes")),
         "@type" = "PropertyValue"),
    list("name" = "more_g_pro", 
         "description" = "participant ate more grams of protein at discharge compared to admission",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "No"),
           list( "value" = "1",
                 "label" = "Yes")),
         "@type" = "PropertyValue"),
    list("name" = "more_p_pro", 
         "description" = "participant ate a greater percentage of protein at discharge compared to admission",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "No"),
           list( "value" = "1",
                 "label" = "Yes")),
         "@type" = "PropertyValue"),
    list("name" = "perc_ideal_bw_tdif", 
         "description" = "difference in the percent of ideal body weight between admission and discharge",
         "minValue" = "-7",
         "maxValue" = "42",
         "@type" = "PropertyValue"),
    list("name" = "eat_tdif", 
         "description" = "difference in the Eating Attitudes Test between admission and discharge",
         "minValue" = "-62",
         "maxValue" = "54",
         "measurementTechnique" = "Garner DM, Garfinkel PE. The Eating Attitudes Test: An index of the symptoms of anorexia nervosa. Psychological medicine. 1979 May;9(2):273-9.",
         "@type" = "PropertyValue")))
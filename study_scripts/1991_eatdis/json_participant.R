# This script was upadated/written by Alaina Pearce in Winter 2026
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

participant_list <- list(
  "@context" = "http://schema.org/",
  "@type" = "Dataset",
  "name" = "assay-demo_data.csv",
  "description" = "Demographic data for the dataset titled: Eating Behavior, Food Preferences, and Olfactory Function in Eating Disorder Patients: Data from 1991",
  "schemaVersion" = "Psych-DS 0.1.0",
  "General" = list("MissingValueCode" = "All missing values in this dataset are represented by n/a"),
  "variableMeasured" = list(
    list("name" = "id", 
         "description" = "participant id - note, this was randomly generated in the de-identified data to break any linkage to identifiable information originally collected with the study",
         "required" = "true",
         "@type" = "PropertyValue"),
    list("name" = "cafeteria_study", 
         "description" = "participant is represented in data for the Cafeteria Study",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "no"),
           list( "value" = "1",
                 "label" = "yes")),
         "@type" = "PropertyValue"),
    list("name" = "foodpref_study", 
         "description" = "participant is represented in data for the Food Preference Study",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "no"),
           list( "value" = "1",
                 "label" = "yes")),
         "@type" = "PropertyValue"),
    list("name" = "smell_study", 
         "description" = "participant is represented in data for the Smell Study",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "no"),
           list( "value" = "1",
                 "label" = "yes")),
         "@type" = "PropertyValue"),
    list("name" = "timepoint", 
         "description" = "time of assessment",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "admission (baseline for controls)"),
           list( "value" = "1",
                 "label" = "discharge/end of treatment (follow-up for controls)")),
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
         "missingValues" = "n/a",
         "@type" = "PropertyValue"),
    list("name" = "group_anr_split", 
         "description" = "eating disorder group with anorexia nervosa - restrictive subtype split by percent of ideal body weight",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "anorexia nervosa - binge subtype"),
           list( "value" = "1",
                 "label" = "bulimia nervosa"),
           list( "value" = "2",
                 "label" = "anorexia nervosa - restrictive subtype with > 70% of ideal body weight"),
           list( "value" = "3",
                 "label" = "anorexia nervosa - restrictive subtype with < 70% of ideal body weight"),
           list( "value" = "4",
                 "label" = "control - no eating disorder")),
         "missingValues" = "n/a",
         "@type" = "PropertyValue"),
    list("name" = "age", 
         "description" = "participant age",
         "minValue" = "12",
         "maxValue" = "46",
         "@type" = "PropertyValue"),
    list("name" = "race", 
         "description" = "participant race",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "white"),
           list( "value" = "1",
                 "label" = "non-white")),
         "@type" = "PropertyValue"),
    list("name" = "illness_dur", 
         "description" = "duration of eating disorder illness",
         "unitText" = "months",
         "minValue" = "0",
         "maxValue" = "348",
         "@type" = "PropertyValue"),
    list("name" = "hospital_stay_wks", 
         "description" = "duration of in-patient stay at Johns Hopkins",
         "unitText" = "weeks",
         "minValue" = "4",
         "maxValue" = "16",
         "@type" = "PropertyValue"),
    list("name" = "bmi", 
         "description" = "body mass index (BMI)",
         "unitText" = "kg/m^2",
         "minValue" = "8.3",
         "maxValue" = "25.2",
         "@type" = "PropertyValue"),
    list("name" = "perc_ideal_bw", 
         "description" = "the percent of ideal body weight",
         "minValue" = "34",
         "maxValue" = "118",
         "@type" = "PropertyValue")))
# This script was upadated/written by Alaina Pearce in Summer 2026
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

video_list_lunch <- list(
  "@context" = "http://schema.org/",
  "@type" = "Dataset",
  "name" = "sub-*_assay-microstructure_study-lunch_rater-*.csv",
  "description" = "Individual participant raw data files exported from the Video Timecode Generator (VTG) software ",
  "schemaVersion" = "Psych-DS 0.1.0",
  "General" = list("MissingValueCode" = "All missing values in this dataset are represented by n/a"),
  "variableMeasured" = list(
    list("name" = "id", 
         "description" = "participant id - note, this was randomly generated in the de-identified data to break any linkage to identifiable information originally collected with the study",
         "required" = "true",
         "@type" = "PropertyValue"),
    list("name" = "group", 
         "description" = "participant group",
         "valueReference" = list(
           list( "value" = "2",
                 "label" = "anorexia nervosa - restrictive subtype"),
           list( "value" = "3",
                 "label" = "control - no eating disorder")),
         "@type" = "PropertyValue"),
    list("name" = "timepoint", 
         "description" = "time of meal/study session",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "admission (baseline for controls)"),
           list( "value" = "1",
                 "label" = "discharge/end of treatment")),
         "@type" = "PropertyValue"),
    list("name" = "trace", 
         "description" = "internal parameter from software indicating pass through coding",
         "valueReference" = list(
           list( "value" = "1",
                 "label" = "curent trace"),
           list( "value" = "0",
                 "label" = "not trace")),
         "@type" = "PropertyValue"),
    list("name" = "start", 
         "description" = "start of behavior",
         "unit" = "sec",
         "@type" = "PropertyValue"),
    list("name" = "activity", 
         "description" = "coded activity - food item consumed",
         "valueReference" = list(
           list( "value" = "1",
                 "label" = "protein"),
           list( "value" = "2",
                 "label" = "starch"),
           list( "value" = "3",
                 "label" = "green beans"),
           list( "value" = "4",
                 "label" = "carrots"),
           list( "value" = "5",
                 "label" = "apple"),
           list( "value" = "6",
                 "label" = "cookie"),
           list( "value" = "7",
                 "label" = "water")),
         "@type" = "PropertyValue"),
    list("name" = "time_1", 
         "description" = "start time of event",
         "unitText" = "sec/100",
         "@type" = "PropertyValue"),
    list("name" = "time_2", 
       "description" = "end time of event",
       "unitText" = "sec/100",
       "@type" = "PropertyValue"),
    list("name" = "food", 
         "description" = "food item consumed at event",
         "@type" = "PropertyValue")))
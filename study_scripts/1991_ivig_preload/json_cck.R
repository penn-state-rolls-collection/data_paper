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

cck_list <- list(
  "@context" = "http://schema.org/",
  "@type" = "Dataset",
  "name" = "study-yogurt_assay-food_data.csv",
  "description" = "Cholecystokinin after infusion for the dataset titled: Route of Nutrient Delivery and Satiety in Men: Data from a 1991 IV and Intragastric Infusion Study",
  "schemaVersion" = "Psych-DS 0.1.0",
  "General" = list("MissingValueCode" = "All missing values in this dataset are represented by n/a"),
  "variableMeasured" = list(
    list("name" = "id", 
         "description" = "participant id - note, this was randomly generated in the de-identified data to break any linkage to identifiable information originally collected with the study",
         "required" = "true",
         "@type" = "PropertyValue"),
    list("name" = "cond", 
         "description" = "preload condition",
         "valueReference" = list(
           list( "value" = "cho",
                 "label" = "iv: charbohydrate preload"),
           list( "value" = "fat",
                 "label" = "iv: fat preload"),
           list( "value" = "saline",
                 "label" = "iv: isotonic saliene preload"),
           list( "value" = "cho-long",
                 "label" = "ig: slow/long delivery charbohydrate preload"),
           list( "value" = "fat-long",
                 "label" = "ig: slow/long delivery fat preload"),
           list( "value" = "saline-long",
                 "label" = "ig: slow/long delivery isotonic saliene preload"),
           list( "value" = "cho-rapid",
                 "label" = "ig: rapid/quick delivery charbohydrate preload"),
           list( "value" = "fat-rapid",
                 "label" = "ig: rapid/quick delivery fat preload"),
           list( "value" = "saline-rapid",
                 "label" = "ig: rapid/quick delivery isotonic saliene preload")),
         "@type" = "PropertyValue"),
    list("name" = "time", 
         "description" = "draw number",
         "valueReference" = list(
           list( "value" = "1",
                 "label" = "0 min after influsion start"),
           list( "value" = "2",
                 "label" = "15 min after influsion start"),
           list( "value" = "3",
                 "label" = "30 min after influsion start"),
           list( "value" = "4",
                 "label" = "60 min after influsion start"),
           list( "value" = "5",
                 "label" = "0 min after influsion start"),
           list( "value" = "120",
                 "label" = "0 min after influsion start"),
           list( "value" = "180",
                 "label" = "0 min after influsion start")),
         "@type" = "PropertyValue"),
    list("name" = "cck", 
         "description" = "Cholecystokinin value",
         "unitText" = "g",
         "minValue" = "69",
         "maxValue" = "268.2",
         "@type" = "PropertyValue")))
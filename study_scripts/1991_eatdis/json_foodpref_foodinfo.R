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

foodpref_foodinfo_list <- list(
  "@context" = "http://schema.org/",
  "@type" = "Dataset",
  "name" = "study-foodpref_calc-foodinfo_data.csv",
  "description" = "Food Preference Questionnaire food attributes for energy density, carbohydrates, and fat from the 1991 Eating Disorders - Food Preference Study",
  "schemaVersion" = "Psych-DS 0.1.0",
  "General" = list("MissingValueCode" = "All missing values in this dataset are represented by n/a"),
  "variableMeasured" = list(
    list("name" = "food", 
         "description" = "food preferences questionnaire food item",
         "required" = "true",
         "@type" = "PropertyValue"),
    list("name" = "energy_density", 
         "description" = "kcal/g",
         "minValue" = "0",
         "maxValue" = "5.86",
         "@type" = "PropertyValue"),
    list("name" = "low_cho", 
         "description" = "food has <= 10g carbohydrates in 100 g of food item",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "no"),
           list( "value" = "1",
                 "label" = "yes"),
           list( "value" = "n/a",
                 "label" = "uncategorized")),
         "@type" = "PropertyValue"),
    list("name" = "high_cho", 
         "description" = "food has >= 20g carbohydrates in 100 g of food item",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "no"),
           list( "value" = "1",
                 "label" = "yes"),
           list( "value" = "n/a",
                 "label" = "uncategorized")),
         "@type" = "PropertyValue"),
    list("name" = "low_fat", 
         "description" = "food has <= 2g fat in 100 g of food item",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "yes"),
           list( "value" = "1",
                 "label" = "no"),
           list( "value" = "n/a",
                 "label" = "uncategorized")),
         "@type" = "PropertyValue"),
    list("name" = "high_fat", 
         "description" = "food has >= 5g fat in 100 g of food item",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "yes"),
           list( "value" = "1",
                 "label" = "no"),
           list( "value" = "n/a",
                 "label" = "uncategorized")),
         "@type" = "PropertyValue")))
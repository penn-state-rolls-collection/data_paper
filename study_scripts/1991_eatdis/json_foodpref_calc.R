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

foodpref_calc_list <- list(
  "@context" = "http://schema.org/",
  "@type" = "Dataset",
  "name" = "study-foodpref_calc-preference_data.csv",
  "DatasetType" = 'derivative',
  "description" = "Food Preference Questionnaire calculated preferences based on energy density, carbohydrates, and fat from the Food Preference Study in Eating Behavior, Food Preferences, and Olfactory Function in Eating Disorder Patients: Data from 1991",
  "schemaVersion" = "Psych-DS 0.1.0",
  "General" = list("MissingValueCode" = "All missing values in this dataset are represented by n/a"),
  "variableMeasured" = list(
    list("name" = "id", 
         "description" = "participant id - note, this was randomly generated in the de-identified data to break any linkage to identifiable information originally collected with the study",
         "required" = "true",
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
    list("name" = "low_cal_like", 
         "description" = "average liking rating for low calorie foods (<= 1 kcal/g of food item)",
         "minValue" = "19.4",
         "maxValue" = "90",
         "@type" = "PropertyValue"),
    list("name" = "low_cal_eat", 
           "description" = "average desire to eat rating for low calorie foods (<= 1 kcal/g of food item)",
         "minValue" = "3.25",
         "maxValue" = "91.5",
         "@type" = "PropertyValue"),
    list("name" = "high_cal_like", 
         "description" = "average liking rating for high calorie foods (>= 2 kcal/g of food item)",
         "minValue" = "3.35",
         "maxValue" = "90.24",
         "@type" = "PropertyValue"),
    list("name" = "high_cal_eat", 
         "description" = "average desire to eat rating for high calorie foods (>= 2 kcal/g of food item)",
         "minValue" = "0.71",
         "maxValue" = "90.06",
         "@type" = "PropertyValue"),
    list("name" = "low_cho_like", 
         "description" = "average liking rating for low carbohydrate foods  (<= 10g carbohydrates in 100 g of food item)",
         "minValue" = "19.4",
         "maxValue" = "90",
         "@type" = "PropertyValue"),
    list("name" = "low_cho_eat", 
         "description" = "average desire to eat rating for low carbohydrate foods  (<= 10g carbohydrates in 100 g of food item)",
         "minValue" = "3.25",
         "maxValue" = "91.5",
         "@type" = "PropertyValue"),
    list("name" = "high_cho_like", 
         "description" = "average liking rating for high carbohydrate foods (>= 20g carbohydrates in 100 g of food item)",
         "minValue" = "3.35",
         "maxValue" = "90.24",
         "@type" = "PropertyValue"),
    list("name" = "high_cho_eat", 
         "description" = "average desire to eat rating for high carbohydrate foods (>= 20g carbohydrates in 100 g of food item)",
         "minValue" = "0.71",
         "maxValue" = "90.06",
         "@type" = "PropertyValue"),
    list("name" = "low_fat_like", 
         "description" = "average liking rating for low fat foods  (<= 2g fat in 100 g of food item)",
         "minValue" = "19.4",
         "maxValue" = "90",
         "@type" = "PropertyValue"),
    list("name" = "low_fat_eat", 
         "description" = "average desire to eat rating for low fat foods  (<= 2g fat in 100 g of food item)",
         "minValue" = "3.25",
         "maxValue" = "91.5",
         "@type" = "PropertyValue"),
    list("name" = "high_fat_like", 
         "description" = "average liking rating for high fat foods (>= 5g fat in 100 g of food item)",
         "minValue" = "3.35",
         "maxValue" = "90.24",
         "@type" = "PropertyValue"),
    list("name" = "high_fat_eat", 
         "description" = "average desire to eat rating for high fat foods (>= 5g fat in 100 g of food item)",
         "minValue" = "0.71",
         "maxValue" = "90.06",
         "@type" = "PropertyValue")))
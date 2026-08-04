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

participant_list <- list(
  "@context" = "http://schema.org/",
  "@type" = "Dataset",
  "name" = "participants",
  "description" = "Demographic data for the datset titled: Age Differences in Sensory-Specific Satiety After Yogurt Consumption: Data from a 1990 Laboratory Study",
  "schemaVersion" = "Psych-DS 0.1.0",
  "General" = list("MissingValueCode" = "All missing values in this dataset are represented by n/a"),
  "variableMeasured" = list(
    list("name" = "id", 
         "description" = "participant id - note, this was randomly generated in the de-identified data to break any linkage to identifiable information originally collected with the study",
         "required" = "true",
         "@type" = "PropertyValue"),
    list("name" = "session", 
         "description" = "participant visit number",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "visit 1"),
           list( "value" = "1",
                 "label" = "visit 2")),
         "@type" = "PropertyValue"),
    list("name" = "agegroup", 
         "description" = "participant age group",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "adolescents (12-15 years)"),
           list( "value" = "1",
                 "label" = "young adults (22-35 years)"),
           list( "value" = "2",
                 "label" = "older adults (45-60 years)"),
           list( "value" = "3",
                 "label" = "elderly (64-82 years)")),
         "@type" = "PropertyValue"),
    list("name" = "sex", 
         "description" = "participant sex",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "male"),
           list( "value" = "1",
                 "label" = "female")),
         "@type" = "PropertyValue"),
    list("name" = "upsitsc", 
         "description" = "score on the University of Pennsylvania Smell Identification Test (UPSIT). Individual data provided in the upsit.csv database.",
         "minValue" = "14",
         "maxValue" = "40",
         "@type" = "PropertyValue"),
    list("name" = "zung", 
         "description" = "Zung depression inventory",
         "minValue" = "17",
         "maxValue" = "54",
         "@type" = "PropertyValue"),
    list("name" = "eat", 
         "description" = "Eating Attitudes Test score",
         "minValue" = "2",
         "maxValue" = "26",
         "measurementTechnique" = "Garner DM, Garfinkel PE. The Eating Attitudes Test: An index of the symptoms of anorexia nervosa. Psychological medicine. 1979 May;9(2):273-9.",
         "@type" = "PropertyValue"),
    list("name" = "lsi", 
         "description" = "n/a; unknown variable",
         "@type" = "PropertyValue"),
    list("name" = "ei", 
         "description" = "Stunkard Eating Inventory score",
         "MeasurementTechnique" = "Stunkard, A. J., & Messick, S. (1988). Eating inventory manual. San Antonio, TX: Harcourt Brace Jovanovich, Inc.",
         "@type" = "PropertyValue"),
    list("name" = "eisc", 
         "description" = "Eating Inventory score",
         "minValue" = "0",
         "maxValue" = "17",
         "MeasurementTechnique" = "Stunkard, A. J., & Messick, S. (1988). Eating inventory manual. San Antonio, TX: Harcourt Brace Jovanovich, Inc.",
         "@type" = "PropertyValue"),
    list("name" = "bmi", 
         "description" = "body mass index",
         "unitText" = "kg/m^2",
         "minValue" = "0",
         "maxValue" = "44",
         "@type" = "PropertyValue"),
    list("name" = "dentures", 
         "description" = "participant report of wearing dentures",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "no"),
           list( "value" = "1",
                 "label" = "yes")),
         "@type" = "PropertyValue"),
    list("name" = "meds", 
         "description" = "participant report of taking medications",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "no"),
           list( "value" = "1",
                 "label" = "yes")),
         "@type" = "PropertyValue"),
    list("name" = "cvd_risk", 
         "description" = "numnber of risk factors participant reported related to cardiovascular disease. Variables assessed included high blood pressure, high cholesterol, and use of aspirin, nitrates, or lanoxin",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "no"),
           list( "value" = "1",
                 "label" = "yes")),
         "derivative" = "true",
         "@type" = "PropertyValue")))
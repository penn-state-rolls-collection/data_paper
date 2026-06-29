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

smell_list <- list(
  "@context" = "http://schema.org/",
  "@type" = "Dataset",
  "name" = "study-smell_data.csv",
  "description" = "Smell Study - Olfactory and smoking data related to participants in the 1991 Eating Disorders Study",
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
    list("name" = "illness_dur", 
         "description" = "length of eating disorder illness",
         "unitText" = "months",
         "minValue" = "3",
         "maxValue" = "348",
         "@type" = "PropertyValue"),
    list("name" = "perc_ideal_bw", 
         "description" = "the percent of ideal body weight",
         "minValue" = "34",
         "maxValue" = "114",
         "@type" = "PropertyValue"),
    list("name" = "smoke", 
         "description" = "does the participant smoke cigarettes",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "no"),
           list( "value" = "1",
                 "label" = "yes"),
           list( "value" = "2",
                 "label" = "quit smoking")),
         "@type" = "PropertyValue"),
    list("name" = "years_smoked", 
         "description" = "number of years smoked",
         "unitText" = "years",
         "minValue" = "0.5",
         "maxValue" = "22",
         "@type" = "PropertyValue"),
    list("name" = "cigs_day", 
         "description" = "number of cigarettes smoked per day",
         "unitText" = "cigarettes",
         "minValue" = "3",
         "maxValue" = "50",
         "@type" = "PropertyValue"),
    list("name" = "odor_threshold", 
         "description" = "odor detection threshold with less negative values indicating lower sensitivity (worse olfaction) and more negative values indicating higher sensitivity (better olfaction)",
         "minValue" = "-13",
         "maxValue" = "-2.7",
         "measurementTechnique" = "odor detection threshold was measured by having participant choose which of two stimuli was stronger using a single staircase. The rose-like stimulus phenyl ethyl alcohol (PEA; Aldrich Chemical Company) was presented in a half-log step (volume/volume) dilution from - 13.0 to - 1.0 log concentrations",
         "@type" = "PropertyValue"),
    list("name" = "upsit", 
         "description" = "score on the University of Pennsylvania Smell Identification Test (UPSIT). Individual data provided in the upsit.csv database.",
         "minValue" = "10",
         "maxValue" = "40",
         "measurementTechnique" = "Doty RL, Shaman P, Dann M. Development of the University of Pennsylvania smell identification test: a standardized microencapsulated test of olfactory function. Physiol Behav 1984;32:489-502",
         "@type" = "PropertyValue")))
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
  "description" = "Demographic data related to participants in study title: High-Fat vs. High-Carbohydrate Preloads and Satiety in Bulimia Nervosa: Data from a 1991 Laboratory Study",
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
    list("name" = "age", 
         "description" = "participant age",
         "minValue" = "16",
         "maxValue" = "37",
         "@type" = "PropertyValue"),
    list("name" = "ei", 
         "description" = "Stunkard Eating Inventory score",
         "minValue" = "0",
         "maxValue" = "9",
         "measurementTechnique" = "Stunkard, A. J., & Messick, S. (1988). Eating inventory manual. San Antonio, TX: Harcourt Brace Jovanovich, Inc.",
         "@type" = "PropertyValue"), 
    list("name" = "eat", 
         "description" = "Eating Attitudes Test score",
         "minValue" = "4",
         "maxValue" = "81",
         "measurementTechnique" = "Garner DM, Garfinkel PE. The Eating Attitudes Test: An index of the symptoms of anorexia nervosa. Psychological medicine. 1979 May;9(2):273-9.",
         "@type" = "PropertyValue"),
    list("name" = "zung", 
         "description" = "Zung Self-Rating Scale for Depression",
         "minValue" = "27.5",
         "maxValue" = "48.75",
         "measurementTechnique" = "Zung, W. W. K. (1986). Zung Self-Rating Depression Scale and Depression Status Inventory. In N. Sartorius and T. A. Ban (eds), Assessment of Depression. Pp. 221–231. Berlin:Springer-Verlag.",
         "@type" = "PropertyValue"), 
    list("name" = "edi", 
         "description" = "Total Eating Disorder Inventory at discharge",
         "minValue" = "12",
         "maxValue" = "21",
         "measurementTechnique" = "Garner DM, Olmstead MP, Polivy J. Development and validation of a multidimensional eating disorder inventory for anorexia nervosa and bulimia. International journal of eating disorders. 1983 Mar;2(2):15-34.",
         "@type" = "PropertyValue"),
    list("name" = "bsq", 
         "description" = "Body Shape Questionnaire Score",
         "minValue" = "61",
         "maxValue" = "184",
         "measurementTechnique" = "Cooper PJ, Taylor MJ, Cooper Z, Fairbum CG. The development and validation of the Body Shape Questionnaire. International Journal of Eating Disorders. 1987 Jul;6(4):485-94.",
         "@type" = "PropertyValue"),
    list("name" = "illness_dur", 
         "description" = "duration of eating disorder illness",
         "unitText" = "months",
         "minValue" = "12",
         "maxValue" = "180",
         "@type" = "PropertyValue"),
    list("name" = "bmi", 
         "description" = "body mass index (BMI)",
         "unitText" = "kg/m^2",
         "minValue" = "18.4",
         "maxValue" = "26.5",
         "@type" = "PropertyValue")))
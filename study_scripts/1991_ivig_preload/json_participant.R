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
  "description" = "Demographic data for the dataset titled: Route of Nutrient Delivery and Satiety in Men: Data from a 1991 IV and Intragastric Infusion Study",
  "schemaVersion" = "Psych-DS 0.1.0",
  "General" = list("MissingValueCode" = "All missing values in this dataset are represented by n/a"),
  "variableMeasured" = list(
    list("name" = "id", 
         "description" = "participant id - note, this was randomly generated in the de-identified data to break any linkage to identifiable information originally collected with the study",
         "required" = "true",
         "@type" = "PropertyValue"),
    list("name" = "age", 
         "description" = "participant age",
         "minValue" = "22",
         "maxValue" = "30",
         "@type" = "PropertyValue"),
    list("name" = "height_in", 
         "description" = "participant height in inches",
         "minValue" = "65",
         "maxValue" = "75",
         "@type" = "PropertyValue"),
    list("name" = "height_cm", 
         "description" = "participant height in cm",
         "minValue" = "165.1",
         "maxValue" = "190.5",
         "@type" = "PropertyValue"),
    list("name" = "weight", 
         "description" = "participant weight in pounds",
         "minValue" = "135",
         "maxValue" = "193",
         "@type" = "PropertyValue"),
    list("name" = "bmi", 
         "description" = "participant body mass index",
         "unitText" = "kg/m^2",
         "minValue" = "21.2",
         "maxValue" = "25.1",
         "@type" = "PropertyValue"),
    list("name" = "ei", 
         "description" = "Stunkard Eating Inventory score",
         "minValue" = "0",
         "maxValue" = "7",
         "MeasurementTechnique" = "Stunkard, A. J., & Messick, S. (1988). Eating inventory manual. San Antonio, TX: Harcourt Brace Jovanovich, Inc.",
         "@type" = "PropertyValue"),
    list("name" = "eat", 
         "description" = "Eating Attitudes Test score",
         "minValue" = "3",
         "maxValue" = "20",
         "measurementTechnique" = "Garner DM, Garfinkel PE. The Eating Attitudes Test: An index of the symptoms of anorexia nervosa. Psychological medicine. 1979 May;9(2):273-9.",
         "@type" = "PropertyValue"),
    list("name" = "zung", 
         "description" = "Zung Self-Rating Scale for Depression",
         "minValue" = "27.5",
         "maxValue" = "43.75",
         "measurementTechnique" = "Zung, W. W. K. (1986). Zung Self-Rating Depression Scale and Depression Status Inventory. In N. Sartorius and T. A. Ban (eds), Assessment of Depression. Pp. 221–231. Berlin:Springer-Verlag.",
         "@type" = "PropertyValue"),
    list("name" = "perc_ideal_bw", 
          "description" = "Percent of ideal body weight",
          "minValue" = "1.0",
          "maxValue" = "107.5",
          "@type" = "PropertyValue")))
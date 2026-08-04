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
  "description" = "Demographic and questionnaire data related to participants in the study titled: Effects of Overnight Fasting on Appetite and Meal Behavior in Eating Disorders: A 1992 Laboratory Study",
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
                "label" = "control - no eating disorder")),
        "@type" = "PropertyValue"),
    list("name" = "restrict_cond", 
         "description" = "category based on restriction and patient status",
         "valueReference" = list(
           list( "value" = "0",
                 "label" = "anorexia nervosa - binge subtype"),
           list( "value" = "1",
                 "label" = "bulimia nervosa - inpatient"),
           list( "value" = "2",
                 "label" = "bulimia nervosa - outpatient"),
           list( "value" = "3",
                 "label" = "control - restricted"),
           list( "value" = "4",
                 "label" = "control - unrestricted")),
         "@type" = "PropertyValue"),
    list("name" = "age", 
         "description" = "participant age",
         "minValue" = "17",
         "maxValue" = "50",
         "@type" = "PropertyValue"),
    list("name" = "bsq", 
         "description" = "Body Shape Questionnaire Score",
         "minValue" = "53",
         "maxValue" = "204",
         "measurementTechnique" = "Cooper PJ, Taylor MJ, Cooper Z, Fairbum CG. The development and validation of the Body Shape Questionnaire. International Journal of Eating Disorders. 1987 Jul;6(4):485-94.",
         "@type" = "PropertyValue"),
    list("name" = "zung", 
         "description" = "Zung Self-Rating Scale for Depression",
         "minValue" = "22",
         "maxValue" = "78",
         "measurementTechnique" = "Zung, W. W. K. (1986). Zung Self-Rating Depression Scale and Depression Status Inventory. In N. Sartorius and T. A. Ban (eds), Assessment of Depression. Pp. 221–231. Berlin:Springer-Verlag.",
         "@type" = "PropertyValue"), 
    list("name" = "eat", 
         "description" = "Eating Attitudes Test score",
         "minValue" = "3",
         "maxValue" = "108",
         "measurementTechnique" = "Garner DM, Garfinkel PE. The Eating Attitudes Test: An index of the symptoms of anorexia nervosa. Psychological medicine. 1979 May;9(2):273-9.",
         "@type" = "PropertyValue"),
    list("name" = "edi_body_dissat", 
        "description" = "body dissatisfaction at admission",
        "minValue" = "0",
        "maxValue" = "21",
        "measurementTechnique" = "Garner DM, Olmstead MP, Polivy J. Development and validation of a multidimensional eating disorder inventory for anorexia nervosa and bulimia. International journal of eating disorders. 1983 Mar;2(2):15-34.",
        "@type" = "PropertyValue"),
    list("name" = "ei_cog_restraint", 
         "description" = "cognitive restraint at admission",
         "minValue" = "1",
         "maxValue" = "21",
         "measurementTechnique" = "Stunkard, A. J., & Messick, S. (1988). Eating inventory manual. San Antonio, TX: Harcourt Brace Jovanovich, Inc.",
         "@type" = "PropertyValue"),
    list("name" = "ei_hunger", 
         "description" = "hunger at admission",
         "minValue" = "1",
         "maxValue" = "14",
         "measurementTechnique" = "Stunkard, A. J., & Messick, S. (1988). Eating inventory manual. San Antonio, TX: Harcourt Brace Jovanovich, Inc.",
         "@type" = "PropertyValue"),
    list("name" = "ei_disinhibit", 
         "description" = "disinhibition at admission",
         "minValue" = "2",
         "maxValue" = "16",
         "measurementTechnique" = "Stunkard, A. J., & Messick, S. (1988). Eating inventory manual. San Antonio, TX: Harcourt Brace Jovanovich, Inc.",
         "@type" = "PropertyValue"),
    list("name" = "perc_ideal_bw", 
         "description" = "the percent of ideal body weight",
         "minValue" = "73",
         "maxValue" = "109",
         "@type" = "PropertyValue"),
    list("name" = "illness_dur", 
         "description" = "duration of eating disorder illness",
         "unitText" = "months",
         "minValue" = "12",
         "maxValue" = "432",
         "@type" = "PropertyValue")))
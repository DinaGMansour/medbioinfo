#!/bin/bash

SCRIPT_DIR=${0%/*}
##### Tools path:
SNPTEST=
RSCRIPT= 
PERL=

#### Genotyping data files:
CHROMOSOME_RAW_DATA=

#### Input files and information:
STUDY_NAME=$1
SAMPLE=$2 
EXCLUSION_FILE=$3
COV_NAMES=$4
PHENO_NAME=$5
PHENO_VARIABLE_TYPE=$6
METHOD=$7

#### Association_Analysis using SNPTEST:

for chr $(seq 1 22);do
   $SNPTEST  -data $CHROMOSOME_RAW_DATA/$chr"$chr".dose.vcf.gz $SAMPLE -genotype_field GP -exclude_samples $EXCLUSION_FILE -cov_names $COV_NAMES -o GWAS_$STUDY_NAME_CHR"$chr".out -log log_GWAS_$STUDY_NAME_CHR"$chr".txt  -frequentist 1 -method $METHOD -hwe -pheno $PHENO_NAME;done
   
   cat $SCRIPT_DIR/$*.out | grep -v "#" | head -1 > $header.txt
   cat $SCRIPT_DIR/$*.out | grep -v "#" | grep -v "all_maf" > $ALL_data.txt
   cat $SCRIPT_DIR/$header.txt $SCRIPT_DIR/$ALL_data.txt > $ALL_unfiltered_data.txt
   
   
#### Filteration of SNPTEST output and PLOTS for GWAS_analysis:

$RSCRIPT $SCRIPT_DIR/"GWAS_plots.r"

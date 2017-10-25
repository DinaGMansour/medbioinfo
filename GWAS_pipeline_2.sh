SCRIPT_DIR=${0%/*}
##### Tools path:
SNPTEST=
RSCRIPT= 
PERL=

#### Genotyping data files:
COHORT_1_CHROMOSOME_RAW_DATA=
COHORT_2_CHROMOSOME_RAW_DATA=

#### Input files and information:
STUDY_NAME=$1
COHORT_1_SAMPLE=$2
COHORT_2_SAMPLE=$3
EXCLUSION_FILE=$4
COV_NAMES=$5
PHENO_NAME=$6
PHENO_VARIABLE_TYPE=$7
METHOD=$8

#### Association_Analysis using SNPTEST:

for chr $(seq 1 22);do
   $SNPTEST  -data $COHORT_1_CHROMOSOME_RAW_DATA/$chr"$chr".dose.vcf.gz $COHORT_1_SAMPLE $COHORT_2_CHROMOSOME_RAW_DATA/$chr"$chr".dose.vcf.gz $COHORT_2_SAMPLE -genotype_field GP -exclude_samples $EXCLUSION_FILE -cov_names $COV_NAMES -o GWAS_$STUDY_NAME_CHR"$chr".out -log log_GWAS_$STUDY_NAME_CHR"$chr".txt  -frequentist 1 -method $METHOD -hwe -pheno $PHENO_NAME;done

    cat $SCRIPT_DIR/$*.out | grep -v "#" | head -1 > $header.txt
    cat $SCRIPT_DIR/$*.out | grep -v "#" | grep -v "all_maf" > $ALL_data.txt
    cat $SCRIPT_DIR/$header.txt $SCRIPT_DIR/$ALL_data.txt > $ALL_unfiltered_data.txt
   
#### Filteration of SNPTEST output and PLOTS for GWAS_analysis:

$RSCRIPT $SCRIPT_DIR/"GWAS_plots.r"

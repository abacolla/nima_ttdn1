#!/bin/bash

d0="group_ko-group_wt"
d1="group_ko-group_wt_data"
d2="group_ko-group_wt_logFCabove0585"
d3="group_ko-group_wt_logFCbelow0585"
d4="group_ko-group_wt_logFCns0585"
d5="group_ko-group_wt_logFC0585"

  # significant
cut -f1-6,8,14 ${d1}/${d0}_FDR_Significant_Differential_Expression_Subset.tsv | gawk '$7 > 0.58500' | sort -u > $d2
cut -f1-6,8,14 ${d1}/${d0}_FDR_Significant_Differential_Expression_Subset.tsv | gawk '$7 < -0.58500' | sort -u > $d3
cut -f1,7 $d2 > ${d2}_f2
cut -f1,7 $d3 > ${d3}_f2

vga_intersect2x3 ${d2}_f2 ../brittany_ttdn1_21/knownGene_refFiles/knownGene_dec20_ens_length_exonsNO1.txt ./${d2}_tLength_exon
vga_intersect2x3 ${d3}_f2 ../brittany_ttdn1_21/knownGene_refFiles/knownGene_dec20_ens_length_exonsNO1.txt ./${d3}_tLength_exon

gawk '{ print log($4)/log(10) }' ${d2}_tLength_exon > ${d2}_tLength_log10
gawk '{ print log($4)/log(10) }' ${d3}_tLength_exon > ${d3}_tLength_log10
vga_tTest ${d2}_tLength_log10 ${d3}_tLength_log10

gawk '{ print log($5)/log(10) }' ${d2}_tLength_exon > ${d2}_exon_log10
gawk '{ print log($5)/log(10) }' ${d3}_tLength_exon > ${d3}_exon_log10
vga_tTest ${d2}_exon_log10 ${d3}_exon_log10

  # nonsignificant
cut -f1 ${d2}_f2 ${d3}_f2 | sort -u | grep -v -w -f - ${d1}/${d0}_Differential_Expression.tsv | cut -f1-6,8,14 | sort -u > $d4
cut -f1,7 $d4 > ${d4}_f2

vga_intersect2x3 ${d4}_f2 ../brittany_ttdn1_21/knownGene_refFiles/knownGene_dec20_ens_length_exonsNO1.txt ${d4}_tLength_exon

gawk '{ print log($4)/log(10) }' ${d4}_tLength_exon > ${d4}_tLength_log10
gawk '{ print log($5)/log(10) }' ${d4}_tLength_exon > ${d4}_exon_log10

  # files for R boxplot
gawk '{print $0 "\tup"}' ${d2}_exon_log10 > ${d5}_E
gawk '{print $0 "\tdown"}' ${d3}_exon_log10 >> ${d5}_E
gawk '{print $0 "\ta_ns"}' ${d4}_exon_log10 >> ${d5}_E # "a_ns_ to order plots

gawk '{print $0 "\tup"}' ${d2}_tLength_log10 > ${d5}_L
gawk '{print $0 "\tdown"}' ${d3}_tLength_log10 >> ${d5}_L
gawk '{print $0 "\ta_ns"}' ${d4}_tLength_log10 >> ${d5}_L


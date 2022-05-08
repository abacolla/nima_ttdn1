#!/bin/bash

d0="group_ko-group_wt"
d1="/work/02076/abacolla/stampede2/brittany_ttdn1_21/knownGene_refFiles"
n=200
d2="ko_wt"

cut -f1-6,8,14 ${d0}_data/${d0}_FDR_Significant_Differential_Expression_Subset.tsv > ${d0}_logFCallFdr

  # get exon and tLength
cut -f1,7 ${d0}_logFCallFdr > ${d0}_logFCallFdr_f2
vga_intersect2x3 ${d0}_logFCallFdr_f2 ${d1}/knownGene_dec20_ens_length_exonsNO1.txt ${d0}_logFCallFdr_tLength_exon

  # get the data for the line plots
sort -nk4,4 ${d0}_logFCallFdr_tLength_exon | gawk '{print $4 "\t" $2}' > ${d0}_logFCallFdr_tLength_logFC
split -l $n --additional-suffix=${d2}_set1 ${d0}_logFCallFdr_tLength_logFC
sed -n '41,$p' ${d0}_logFCallFdr_tLength_logFC | split -l $n --additional-suffix=${d2}_set2 -
sed -n '81,$p' ${d0}_logFCallFdr_tLength_logFC | split -l $n --additional-suffix=${d2}_set3 -
sed -n '121,$p' ${d0}_logFCallFdr_tLength_logFC | split -l $n --additional-suffix=${d2}_set4 -
sed -n '161,$p' ${d0}_logFCallFdr_tLength_logFC | split -l $n --additional-suffix=${d2}_set5 -

for i in x[a-z]*; do cut -f1 $i > ${i}_f1; cut -f2 $i > ${i}_f2; vga_tTest ${i}_f1 ${i}_f2 ; done > lp_${d2}_res
gawk '$1 ~ /^x/ {print $1 "\t" $2 "\t" $3 "\t" $4/sqrt($2)}' lp_${d2}_res > lp_${d2}_res2
grep f1 lp_${d2}_res2 > t1; grep f2 lp_${d2}_res2 > t2; paste t1 t2 > lp_${d2}_res3
gawk '{print $2 "\t" $3 "\t" $7 "\t" $8}' lp_${d2}_res3 > lp_${d2}_res4

rm t1 t2



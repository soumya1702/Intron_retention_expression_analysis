#!/bin/bash
#SBATCH -J quantification
#SBATCH -p general
#SBATCH -o quantification.txt
#SBATCH -A students
#SBATCH -e quantification.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --time=48:00:00
#SBATCH --mem=200G

mkdir /N/scratch/syennapu/intron_retention/intronretention
chmod +rwx /N/scratch/syennapu/intron_retention/intronretention 

#this code will loop over all bam files present in mapping directory.
./N/scratch/syennapu/intron_retention/IntronNeoantigen-master-2/intronneoantigen calling -b /N/scratch/syennapu/intron_retention/mapping/*.bam -g /N/scratch/syennapu/intron_retention/re_annotation/gencode.v46.chr_patch_hapl_scaff.annotation.re-annotation.gtf -t 20 -o /N/scratch/syennapu/intron_retention/intronretention


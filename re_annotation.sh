#!/bin/bash
#SBATCH -J re_annotation
#SBATCH -p general
#SBATCH -o re_annotation.txt
#SBATCH -A students
#SBATCH -e re_annotation.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --time=48:00:00
#SBATCH --mem=200G

module spider python/3.11.4
# Activate virtual environment
source ~/myenv/bin/activate

mkdir -p /N/scratch/syennapu/intron_retention/re_annotation
chmod +rwx /N/scratch/syennapu/intron_retention/re_annotation

/N/scratch/syennapu/intron_retention/IntronNeoantigen-master-2/intronneoantigen index -gtf /N/scratch/syennapu/intron_retention/gencode.v46.chr_patch_hapl_scaff.annotation.gtf -out /N/scratch/syennapu/intron_retention/re_annotation -t 8

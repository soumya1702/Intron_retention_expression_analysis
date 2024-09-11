#!/bin/bash
#SBATCH -J indexing
#SBATCH -p general
#SBATCH -o indexing.txt
#SBATCH -A students
#SBATCH -e indexing.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --time=48:00:00
#SBATCH --mem=200G


module load star

GENOMEDIR="/N/scratch/syennapu/intron_retention/"
mkdir -p $GENOMEDIR/indexingfiles
echo "$NOW1 STAR: Generate Genome Index 1"
echo "======================================"

STAR --runThreadN 12 --runMode genomeGenerate --genomeDir $GENOMEDIR/indexingfiles --genomeFastaFiles $GENOMEDIR/GRCh38.p14.genome.fa --sjdbGTFfile $GENOMEDIR/gencode.v46.chr_patch_hapl_scaff.annotation.gtf --sjdbOverhang 149

echo "=============================number of threads used are 12"


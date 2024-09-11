#!/bin/bash
#SBATCH -J mapping
#SBATCH -p general
#SBATCH -o mapping.txt
#SBATCH -A students
#SBATCH -e mapping.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --time=48:00:00
#SBATCH --mem=200G


#loading star module
module spider star/2.7.11a

#loading python module
module spider python/3.12.4

#creating a new directory for output files
mkdir -p /N/scratch/syennapu/intron_retention/mapping

#Genome directory where all the directories are present. Later using this to give a simple path.
GENOMEDIR="/N/scratch/syennapu/intron_retention/"
#samples directory where samples are located
FASTQ_FILES="/N/scratch/syennapu/intron_retention/samples"

#This code will loop over the samples from SRR6834781 to SRR6834783 which are present in the samples directory.
for ((i=81; i<=83; i++)); do
  SAMPLE_NAME="SRR68347${i}"

  # Check if both input files exist
  if [[ ! -f "$FASTQ_FILES/${SAMPLE_NAME}_1.fastq.gz" || ! -f "$FASTQ_FILES/${SAMPLE_NAME}_2.fastq.gz" ]]; then
    echo "sample $SAMPLE_NAME does not exist"
    continue  # Skip the current iteration
  fi
  #Running star using 12 threads and indexingfiles from previously obtained files from indexing 
  STAR --runThreadN 12 --genomeDir $GENOMEDIR/indexingfiles --readFilesIn $FASTQ_FILES/${SAMPLE_NAME}_1.fastq.gz $FASTQ_FILES/${SAMPLE_NAME}_2.fastq.gz \
      --readFilesCommand zcat \
      --quantMode GeneCounts \
      --outFileNamePrefix /N/scratch/syennapu/intron_retention/mapping/${SAMPLE_NAME} --outSAMmapqUnique 60 --outSAMtype BAM SortedByCoordinate --outReadsUnmapped Fastx
done



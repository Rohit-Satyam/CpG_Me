#!/bin/bash
#
#SBATCH --job-name=hg38
#SBATCH --workdir /share/lasallelab/genomes/
#SBATCH --partition=production               
#SBATCH --ntasks=12
#SBATCH --mem=18000
#SBATCH --output=hg38.out # File to which STDOUT will be written
#SBATCH --error=hg38.err # File to which STDERR will be written
#SBATCH --time=0-05:00:00

export mainPath="/share/lasallelab"
PATH="$PATH:${mainPath}/programs/CpG_Me/Bismark-master/"
module load bowtie2/2.3.4.1
module load samtools/1.10

mkdir ${mainPath}/genomes/hg38
cd ${mainPath}/genomes/hg38

rsync -avzP rsync://hgdownload.cse.ucsc.edu/goldenPath/hg38/bigZips/latest/hg38.fa.gz .
gunzip hg38.fa.gz

bowtie2-build --threads 12 --verbose hg38.fa hg38

mkdir Bowtie2
mv *.bt2 Bowtie2/

bismark_genome_preparation --bowtie2 --parallel 6 --verbose .

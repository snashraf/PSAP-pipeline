# Initialization script that downloads all necessary annotation tables prior to running the PSAP pipeline for the first time
ANNOVAR_PATH= #ADD PATH TO ANNOVAR DIRECTORY HERE eg. /scratch/dclab/annovar/
PSAP_PATH= # ADD PATH TO PSAP DIRECTORY HERE eg. /scratch/dclab/

cd $ANNOVAR_PATH
# Download Sep 2014 1000 Genomes allele frequencies from ANNOVAR
perl annotate_variation.pl -downdb -buildver hg19 -webfrom annovar 1000g2014sep humandb/

# Download CADD V1.3 scores from University of Washington and formats the data into annovar format
perl annotate_variation.pl -v -downdb cadd -buildver hg19 -webfrom annovar humandb/

# Download ESP 6500 allele frequencies from ANNOVAR
perl annotate_variation.pl -downdb -buildver hg19 -webfrom annovar esp6500si_all humandb/

# Download dbSNP137 annotations from ANNOVAR
perl annotate_variation.pl -downdb -buildver hg19 -webfrom annovar snp137 humandb/

# Download GencodeV19 gene map from UCSC
perl annotate_variation.pl -downdb -buildver hg19 wgEncodeGencodeBasicV19 humandb/
perl retrieve_seq_from_fasta.pl -format genericGene -seqdir humandb/ humandb/hg19_wgEncodeGencodeBasicV19.txt --outfile hg19_wgEncodeGencodeBasicV19Mrna.fa

# Move ExAC allele frequencies provided with the PSAP pipeline to the ANNOVAR annotation folder and unzip
mv ${PSAP_PATH}psap/lookups/hg19_mac63kFreq_ALL.txt.gz humandb/
gzip -d humandb/hg19_mac63kFreq_ALL.txt.gz

# Template notebooks for data analysis

This folder contains the data analysis pipeline notebooks to analyse the 10X
Multiome and CITE-seq data. These notebooks should be adapted to the individual
samples to generate a processed single-sample single-modality data object.

## The files in here are:

Load_data.ipynb				- Loading and parsing the data from the S3 bucket to start a
					  single-sample analysis
                      
**Multiome analysis files**

NeurIPS_GEX_analysis.ipynb		- The GEX analysis pipeline for 10X multiome samples

NeurIPS_ATAC_part1_R.ipynb		- The QC and preprocessing for 10X multiome ATAC samples
					  that is done in R

NeurIPS_ATAC_part2_py.ipynb		- The clustering, subclustering, and annotation for 10X
					  multiome ATAC samples that is done in python

Merge_data.ipynb			- The harmonization of cell annotations between RNA and ATAC
					  for 10X multiome data and the trajectory inferece (python)
                      
**CITE-seq analysis files**

NeurIPS_CITE_GEX_analysis.ipynb		- The GEX analysis pipeline for 10X CITE-seq samples
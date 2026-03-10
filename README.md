# atb_agc_extract

A prototype script to download genomes from phylogenetically compressed [1] ATB collection [2] using AGC compressor [3]

## Usage

```bash
./agc_extract.sh <accession_id> <output> [thread] [archives_folder] [file_list]
```

## Example
```bash
./agc_extract.sh SAMEA104410971 ./extracted.fa
```

REFERENCE:

[1] Břinda, Karel, Leandro Lima, Simone Pignotti, Natalia Quinones-Olvera, Kamil Salikhov, Rayan Chikhi, Gregory Kucherov, Zamin Iqbal, and Michael Baym. 2025. “Efficient and Robust Search of Microbial Genomes via Phylogenetic Compression.” Nature Methods 22 (4): 692–97.

[2] Hunt, Martin, Leandro Lima, Daniel Anderson, Jane Hawkey, Wei Shen, John Lees, and Zamin Iqbal. 2024. “AllTheBacteria - All Bacterial Genomes Assembled, Available and Searchable.” bioRxiv. https://doi.org/10.1101/2024.03.08.584059.

[3] Deorowicz, Sebastian, Agnieszka Danek, and Heng Li. 2023. “AGC: Compact Representation of Assembled Genomes with Fast Queries and Updates.” Bioinformatics (Oxford, England) 39 (3): btad097.

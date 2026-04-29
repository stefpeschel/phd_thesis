Build reduced data set
================
Compiled at 2026-04-29 13:08:33 UTC

In this script, we load the original PASTURE data (not published) and
build the reduced data set, which is the basis for all analyses
conducted in this project.

## Load data & set parameters

    ## phyloseq-class experiment-level object
    ## otu_table()   OTU Table:         [ 367 taxa and 740 samples ]
    ## sample_data() Sample Data:       [ 740 samples by 517 sample variables ]
    ## tax_table()   Taxonomy Table:    [ 367 taxa by 7 taxonomic ranks ]

    ## phyloseq-class experiment-level object
    ## otu_table()   OTU Table:         [ 5834 taxa and 740 samples ]
    ## sample_data() Sample Data:       [ 740 samples by 517 sample variables ]
    ## tax_table()   Taxonomy Table:    [ 5834 taxa by 7 taxonomic ranks ]

## Select variables of interest

### ASV level

    ## phyloseq-class experiment-level object
    ## otu_table()   OTU Table:         [ 5834 taxa and 592 samples ]
    ## sample_data() Sample Data:       [ 592 samples by 9 sample variables ]
    ## tax_table()   Taxonomy Table:    [ 5834 taxa by 7 taxonomic ranks ]

### Genus level

    ## phyloseq-class experiment-level object
    ## otu_table()   OTU Table:         [ 367 taxa and 592 samples ]
    ## sample_data() Sample Data:       [ 592 samples by 9 sample variables ]
    ## tax_table()   Taxonomy Table:    [ 367 taxa by 7 taxonomic ranks ]

## Filter

Remove taxa absent from all samples, then remove samples with zero total
counts.

### ASV level

    ## phyloseq-class experiment-level object
    ## otu_table()   OTU Table:         [ 2045 taxa and 592 samples ]
    ## sample_data() Sample Data:       [ 592 samples by 9 sample variables ]
    ## tax_table()   Taxonomy Table:    [ 2045 taxa by 7 taxonomic ranks ]

### Genus level

    ## phyloseq-class experiment-level object
    ## otu_table()   OTU Table:         [ 235 taxa and 592 samples ]
    ## sample_data() Sample Data:       [ 592 samples by 9 sample variables ]
    ## tax_table()   Taxonomy Table:    [ 235 taxa by 7 taxonomic ranks ]

## Files written

These files have been written to the target directory,
`data/00_build_dataset`:

    ## # A tibble: 2 × 4
    ##   path                    type         size modification_time  
    ##   <fs::path>              <fct> <fs::bytes> <dttm>             
    ## 1 bact_phylo_2m_asv.rds   file       212.9K 2026-04-29 13:08:36
    ## 2 bact_phylo_2m_genus.rds file        67.5K 2026-04-29 13:08:36

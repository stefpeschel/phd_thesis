Build reduced data set
================
Compiled at 2026-06-10 12:10:08 UTC

``` r
here::i_am(paste0(params$name, ".Rmd"), uuid = "8ad93c89-8d43-4945-9813-3d10fac8034c")
```

In this script, we load the original PASTURE data (not published) and
build the reduced data set, which is the basis for all analyses
conducted in this project.

    ## Warning: package 'ggrepel' was built under R version 4.5.3

## Load data & set parameters

    ## Warning in path_source("PASTURE_data", paste0("bact_2m_genus.rds")): PASTURE_data is not previous to 00_build_dataset

    ## Warning in path_source("PASTURE_data", paste0("bact_2m_asv.rds")): PASTURE_data is not previous to 00_build_dataset

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

## Sample metadata with display labels

## Files written

These files have been written to the target directory,
`data/00_build_dataset`:

    ## # A tibble: 3 × 4
    ##   path                    type         size modification_time  
    ##   <fs::path>              <fct> <fs::bytes> <dttm>             
    ## 1 bact_phylo_2m_asv.rds   file       212.8K 2026-06-10 12:10:15
    ## 2 bact_phylo_2m_genus.rds file        67.5K 2026-06-10 12:10:15
    ## 3 sampdata.rds            file         5.2K 2026-06-10 12:10:15

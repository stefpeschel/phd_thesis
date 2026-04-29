Differential abundance analysis with `dacomp` - EBF vs non-EBF
================
Compiled at 2026-04-28 07:29:55 UTC

The purpose of this document is …

## Load data & set parameters

    ## phyloseq-class experiment-level object
    ## otu_table()   OTU Table:         [ 367 taxa and 740 samples ]
    ## sample_data() Sample Data:       [ 740 samples by 517 sample variables ]
    ## tax_table()   Taxonomy Table:    [ 367 taxa by 7 taxonomic ranks ]

    ## phyloseq-class experiment-level object
    ## otu_table()   OTU Table:         [ 5834 taxa and 740 samples ]
    ## sample_data() Sample Data:       [ 740 samples by 517 sample variables ]
    ## tax_table()   Taxonomy Table:    [ 5834 taxa by 7 taxonomic ranks ]

    ## phyloseq-class experiment-level object
    ## otu_table()   OTU Table:         [ 367 taxa and 592 samples ]
    ## sample_data() Sample Data:       [ 592 samples by 9 sample variables ]
    ## tax_table()   Taxonomy Table:    [ 367 taxa by 7 taxonomic ranks ]

    ## phyloseq-class experiment-level object
    ## otu_table()   OTU Table:         [ 5834 taxa and 592 samples ]
    ## sample_data() Sample Data:       [ 592 samples by 9 sample variables ]
    ## tax_table()   Taxonomy Table:    [ 5834 taxa by 7 taxonomic ranks ]

## Files written

These files have been written to the target directory,
`data/00_phyloseq_objects`:

    ## # A tibble: 2 × 4
    ##   path                    type         size modification_time  
    ##   <fs::path>              <fct> <fs::bytes> <dttm>             
    ## 1 bact_phylo_2m_asv.rds   file       391.2K 2026-04-28 07:29:58
    ## 2 bact_phylo_2m_genus.rds file        72.8K 2026-04-28 07:29:58

Exploratory taxon-level analysis
================
Compiled at 2026-07-06 19:20:35 UTC

``` r
here::i_am(paste0(params$name, ".Rmd"), uuid = "0fb365aa-5986-41d1-9910-df766aa9b502")
```

## Set global parameters

## Load data

### Phyloseq object on genus level

    ## phyloseq-class experiment-level object
    ## otu_table()   OTU Table:         [ 117 taxa and 592 samples ]
    ## sample_data() Sample Data:       [ 592 samples by 9 sample variables ]
    ## tax_table()   Taxonomy Table:    [ 117 taxa by 7 taxonomic ranks ]

## Helper functions

The exploratory analyses use the filtered genus-level object that is
also used for differential abundance and differential distribution
analyses. Relative abundances are used for compositional summaries,
while multiplicative zero replacement followed by CLR transformation is
used for transformed-abundance visualizations.

## Prepare matrices

    ## Warning in zCompositions::multRepl(rel_abund_mat, label = 0, dl = detection_limit_mat, : Column no. 1 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 3 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 5 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 6 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 7 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 12 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 13 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 15 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 17 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 18 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 19 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 20 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 22 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 23 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 25 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 26 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 27 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 28 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 30 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 33 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 34 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 35 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 36 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 37 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 38 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 39 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 40 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 42 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 43 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 44 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 45 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 46 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 48 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 50 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 51 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 54 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 55 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 58 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 59 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 60 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 61 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 64 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 66 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 67 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 69 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 70 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 71 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 72 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 73 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 74 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 76 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 77 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 78 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 81 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 84 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 85 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 86 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 87 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 88 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 90 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 91 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 92 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 93 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Column no. 94 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Col

    ## Warning in zCompositions::multRepl(rel_abund_mat, label = 0, dl = detection_limit_mat, : Row no. 80 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Row no. 102 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Row no. 112 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Row no. 145 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Row no. 147 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Row no. 157 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Row no. 164 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Row no. 265 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Row no. 366 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Row no. 368 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Row no. 397 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Row no. 399 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Row no. 403 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Row no. 410 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Row no. 416 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Row no. 436 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Row no. 471 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Row no. 480 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Row no. 533 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).
    ## Row no. 551 containing >90% zeros/unobserved values found (see arguments z.warning and z.delete. Check out with zPatterns()).

    ## # A tibble: 1 × 12
    ##   n_samples n_taxa min_library_size median_library_size max_library_size zero_fraction detection_limit replacement_value replacement_fraction
    ##       <int>  <int>            <dbl>               <dbl>            <dbl>         <dbl>           <dbl>             <dbl>                <dbl>
    ## 1       592    117             1456              21898.            69556         0.796       0.0000288         0.0000187                 0.65
    ## # ℹ 3 more variables: n_non_ebf <int>, n_ebf <int>, n_excluded_from_ebf_comparison <int>

## Taxon summaries

    ## # A tibble: 117 × 17
    ##    taxon_id   taxon total_count prevalence mean_relative_abunda…¹ median_relative_abun…² max_relative_abundance mean_clr median_clr clr_variance
    ##    <chr>      <chr>       <dbl>      <dbl>                  <dbl>                  <dbl>                  <dbl>    <dbl>      <dbl>        <dbl>
    ##  1 Bifidobac… Bifi…     8417119      1                     0.639                0.721                     0.988     9.18       9.57         1.42
    ##  2 Escherich… Esch…      790539      0.973                 0.0594               0.0104                    0.844     5.52       5.40         4.02
    ##  3 Streptoco… Stre…      597247      0.993                 0.0495               0.0175                    0.807     5.89       5.90         2.20
    ##  4 Bacteroid… Bact…      640951      0.905                 0.0456               0.00191                   0.868     4.15       3.66         6.47
    ##  5 24_Entero… 24_E…      395293      0.738                 0.0294               0.000954                  0.816     2.98       2.93         8.28
    ##  6 Enterococ… Ente…      350643      0.902                 0.0280               0.00292                   0.697     4.25       4.14         5.41
    ##  7 [Ruminoco… [Rum…      318542      0.976                 0.0231               0.00272                   0.691     4.47       4.03         2.54
    ##  8 Blautia    Blau…      250905      0.992                 0.0205               0.00476                   0.621     4.82       4.62         1.27
    ##  9 Collinsel… Coll…      178149      0.850                 0.0134               0.000750                  0.367     2.99       2.71         5.38
    ## 10 Lactobaci… Lact…      167883      0.542                 0.0129               0.000266                  0.370     2.00       1.64         9.48
    ## # ℹ 107 more rows
    ## # ℹ abbreviated names: ¹​mean_relative_abundance, ²​median_relative_abundance
    ## # ℹ 7 more variables: Kingdom <chr>, Phylum <chr>, Class <chr>, Order <chr>, Family <chr>, Genus <chr>, Species <chr>

## Prevalence and abundance

![](figures/07_exploration/prevalence_histogram-1.png)<!-- -->

![](figures/07_exploration/abundance_histogram-1.png)<!-- -->

![](figures/07_exploration/thesis_prevalence_abundance-1.png)<!-- -->

![](figures/07_exploration/rank_abundance_curve-1.png)<!-- -->

**Most variable genera after CLR transformation**

![](figures/07_exploration/clr_variance_by_taxon-1.png)<!-- -->

## Dominant taxonomic composition

    ## # A tibble: 27 × 3
    ##    EBF_group taxon                     mean_relative_abundance
    ##    <fct>     <fct>                                       <dbl>
    ##  1 non-EBF   Bifidobacterium                            0.560 
    ##  2 non-EBF   Escherichia-Shigella                       0.0392
    ##  3 non-EBF   Streptococcus                              0.0810
    ##  4 non-EBF   Bacteroides                                0.0260
    ##  5 non-EBF   24_Enterobacteriaceae(F)                   0.0236
    ##  6 non-EBF   Enterococcus                               0.0568
    ##  7 non-EBF   [Ruminococcus]_gnavugroup                  0.0411
    ##  8 non-EBF   Blautia                                    0.0347
    ##  9 non-EBF   Other                                      0.137 
    ## 10 EBF       Bifidobacterium                            0.687 
    ## # ℹ 17 more rows

![](figures/07_exploration/thesis_relative_abundance_barplot-1.png)<!-- -->

## CLR coordinatess

![](figures/07_exploration/clr_heatmap_top20_unclustered-1.png)<!-- -->

![](figures/07_exploration/clr_heatmap_top20_clustered-1.png)<!-- -->

## Selected taxon distributions

    ## # A tibble: 3,324 × 5
    ##    SampleID EBF_group taxon_id                 clr_abundance taxon                   
    ##    <chr>    <fct>     <chr>                            <dbl> <fct>                   
    ##  1 s025647  non-EBF   Bifidobacterium                   8.10 Bifidobacterium         
    ##  2 s025647  non-EBF   Escherichia-Shigella              3.14 Escherichia-Shigella    
    ##  3 s025647  non-EBF   Streptococcus                     4.53 Streptococcus           
    ##  4 s025647  non-EBF   Bacteroides                       2.91 Bacteroides             
    ##  5 s025647  non-EBF   24_Enterobacteriaceae(F)         -1.54 24_Enterobacteriaceae(F)
    ##  6 s025647  non-EBF   Enterococcus                      5.38 Enterococcus            
    ##  7 s023779  non-EBF   Bifidobacterium                   9.74 Bifidobacterium         
    ##  8 s023779  non-EBF   Escherichia-Shigella              5.09 Escherichia-Shigella    
    ##  9 s023779  non-EBF   Streptococcus                     5.09 Streptococcus           
    ## 10 s023779  non-EBF   Bacteroides                       4.34 Bacteroides             
    ## # ℹ 3,314 more rows

**Distributional change from relative to CLR coordinates**

![](figures/07_exploration/thesis_rel_to_clr_histogram_comparison-1.png)<!-- -->

    ## Scale for x is already present.
    ## Adding another scale for x, which will replace the existing scale.

    ## Warning in scale_x_log10(): log-10 transformation introduced infinite values.

![](figures/07_exploration/rel_to_clr_scatter-1.png)<!-- -->

![](figures/07_exploration/thesis_selected_taxon_violin-1.png)<!-- -->

![](figures/07_exploration/selected_taxon_violin_jitter-1.png)<!-- -->

![](figures/07_exploration/selected_taxon_density-1.png)<!-- -->

![](figures/07_exploration/selected_taxon_prevalence_by_group-1.png)<!-- -->

## Files written

These files have been written to the target directory,
`data/07_exploration`:

    ## # A tibble: 5 × 4
    ##   path                                  type         size modification_time  
    ##   <fs::path>                            <fct> <fs::bytes> <dttm>             
    ## 1 exploration_preprocessed_objects.rds  file       557.8K 2026-07-06 19:20:38
    ## 2 exploration_summary.csv               file          291 2026-07-06 19:20:38
    ## 3 exploration_top_taxa_table.tex        file        1.54K 2026-07-06 19:20:38
    ## 4 selected_taxa_prevalence_by_group.csv file        1.06K 2026-07-06 19:20:58
    ## 5 taxon_level_summary.csv               file       28.64K 2026-07-06 19:20:38

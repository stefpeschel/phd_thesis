Compositional equivalence
================
Compiled at 2026-06-11 20:05:00 UTC

## Set global parameters

## Load data

### Phyloseq object on genus level

    ## phyloseq-class experiment-level object
    ## otu_table()   OTU Table:         [ 117 taxa and 592 samples ]
    ## sample_data() Sample Data:       [ 592 samples by 9 sample variables ]
    ## tax_table()   Taxonomy Table:    [ 117 taxa by 7 taxonomic ranks ]

## Helper functions

Counts are transformed to relative abundances, zeros are replaced by
multiplicative replacement, and the CLR transformation is applied after
replacement. This follows the same preprocessing strategy as the
beta-diversity and regression analyses.

## Prepare CLR matrix

    ## # A tibble: 1 × 9
    ##   n_samples n_taxa min_library_size median_library_size max_library_size zero_fraction detection_limit replacement_value
    ##       <int>  <int>            <dbl>               <dbl>            <dbl>         <dbl>           <dbl>             <dbl>
    ## 1       592    117             1456              21898.            69556         0.796       0.0000288         0.0000187
    ## # ℹ 1 more variable: replacement_fraction <dbl>

## Contrast setup

Compositional equivalence is a two-group procedure. Country is omitted,
and the number of siblings is collapsed to a two-level variable
contrasting children without siblings against children with at least one
sibling. The sparse `EBF duration == "1 month"` category is set to
missing only for the EBF-specific contrast setup; those samples remain
in the CLR matrix and are available for all other contrasts.

    ## # A tibble: 6 × 6
    ##   variable     group1   group2     n_group1 n_group2 n_missing_or_other
    ##   <chr>        <chr>    <chr>         <int>    <int>              <int>
    ## 1 C-section    Cesarean Vaginal         121      468                  3
    ## 2 BF duration  0 months >=2 months       36      456                100
    ## 3 EBF duration 0 months >=2 months      179      375                 38
    ## 4 Sex          Female   Male            294      298                  0
    ## 5 Smoking      No       Yes             529       63                  0
    ## 6 Siblings     0        >=1              46      457                 89

## Compositional equivalence tests

For each contrast, the statistic is the largest standardized squared
difference between group CLR means. Group labels are permuted while the
CLR-transformed microbial profiles are kept fixed.

    ## # A tibble: 6 × 10
    ##   contrast     group1   group2        n1    n2 n_taxa_tested statistic_obs p_empirical n_exceed n_perm
    ##   <fct>        <chr>    <chr>      <int> <int>         <int>         <dbl> <chr>          <int>  <dbl>
    ## 1 C-section    Cesarean Vaginal      121   468           117         25.1  1.00e-03           0    999
    ## 2 BF duration  0 months >=2 months    36   456           117         33.2  4.00e-03           3    999
    ## 3 EBF duration 0 months >=2 months   179   375           117         74.7  1.00e-03           0    999
    ## 4 Sex          Female   Male         294   298           117          9.79 1.58e-01         157    999
    ## 5 Smoking      No       Yes          529    63           117         13.9  1.20e-01         119    999
    ## 6 Siblings     0        >=1           46   457           117         14.2  1.24e-01         123    999

## p-value refinement with permApprox

    ## permApprox result
    ## -----------------
    ## Number of tests             : 6
    ## Approximation method        : GPD tail approximation
    ## Approximation threshold     : p-values < 0.1
    ## Multiple testing adjustment : none
    ## 
    ## Successful fits          : 3
    ## GOF rejections           : 0
    ## Fit failed               : 0
    ## No threshold found       : 0
    ## Discrete distributions   : 0
    ## Not selected for fitting : 3
    ## 
    ## Final p-values:
    ##   min = 2.311e-66, median = 6.149e-02, max = 1.580e-01
    ## 
    ## Use summary() for detailed fit diagnostics.

    ## # A tibble: 6 × 15
    ##   contrast     group1 group2    n1    n2 n_samples n_taxa n_taxa_tested n_taxa_zero_variance statistic_obs n_exceed n_perm p_empirical
    ##   <fct>        <chr>  <chr>  <int> <int>     <int>  <int>         <int>                <int>         <dbl>    <int>  <dbl> <chr>      
    ## 1 C-section    Cesar… Vagin…   121   468       589    117           117                    0         25.1         0    999 1.00e-03   
    ## 2 BF duration  0 mon… >=2 m…    36   456       492    117           117                    0         33.2         3    999 4.00e-03   
    ## 3 EBF duration 0 mon… >=2 m…   179   375       554    117           117                    0         74.7         0    999 1.00e-03   
    ## 4 Sex          Female Male     294   298       592    117           117                    0          9.79      157    999 1.58e-01   
    ## 5 Smoking      No     Yes      529    63       592    117           117                    0         13.9       119    999 1.20e-01   
    ## 6 Siblings     0      >=1       46   457       503    117           117                    0         14.2       123    999 1.24e-01   
    ## # ℹ 2 more variables: p_permapprox <chr>, method_used <chr>

## Permutation distributions

The following diagnostic plot shows selected empirical null
distributions. These plots are used as a visual check of the permutation
tail before relying on the GPD-based p-value refinement.

![](figures/06_comp_equivalence/comp_equi_comp_equivalence_perm_dist_selected-1.png)<!-- -->

## Taxon-wise CLR contrasts

The test is global and does not provide taxon-level inference. The
following plots are descriptive: they show the taxa with the largest
coordinate-wise contributions to the maximum statistic for each
contrast.

![](figures/06_comp_equivalence/comp_equi_taxon_contrast_top10_all-1.png)<!-- -->

As we will use `EBF duration` as grouping variable in later analyses, we
generate an isolated plot for this variable here, which will be shown in
the thesis chapter.

![](figures/06_comp_equivalence/comp_equi_taxon_contrast_top10_selected-1.png)<!-- -->

## Files written

These files have been written to the target directory,
`data/06_comp_equivalence`:

    ## # A tibble: 10 × 4
    ##    path                                                 type         size modification_time  
    ##    <fs::path>                                           <fct> <fs::bytes> <dttm>             
    ##  1 comp_equivalence_contrast_level_summary.csv          file          259 2026-06-11 20:05:05
    ##  2 comp_equivalence_multrepl_clr_object.rds             file      262.74K 2026-06-11 20:05:05
    ##  3 comp_equivalence_permapprox_results_multrepl_clr.rds file       13.56K 2026-06-11 15:12:59
    ##  4 comp_equivalence_preprocessing_summary.csv           file          233 2026-06-11 20:05:05
    ##  5 comp_equivalence_results_multrepl_clr.csv            file          728 2026-06-11 20:05:06
    ##  6 comp_equivalence_results_multrepl_clr.rds            file       68.42K 2026-06-11 15:12:58
    ##  7 comp_equivalence_table.tex                           file        1.25K 2026-06-11 20:05:06
    ##  8 comp_equivalence_taxon_contrasts.csv                 file       87.54K 2026-06-11 20:05:11
    ##  9 comp_equivalence_top10_taxon_contrasts.csv           file         7.6K 2026-06-11 20:05:13
    ## 10 comp_equivalence_top20_taxon_contrasts.csv           file          15K 2026-06-11 20:00:55

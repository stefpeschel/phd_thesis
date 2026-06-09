Beta diversity analysis
================
Compiled at 2026-06-09 10:34:34 UTC

## Load packages

## Set global parameters

``` r
zero_replacement_fraction <- 0.65
n_perm <- 999
permutation_seed <- 42
alpha_perm_approx <- 0.05

var_order_beta <- c("Country", "Sex", "C-section", "BF duration",
                    "EBF duration", "Smoking", "Siblings")
```

## Colors

## Load data

### Phyloseq object on genus level

    ## phyloseq-class experiment-level object
    ## otu_table()   OTU Table:         [ 117 taxa and 592 samples ]
    ## sample_data() Sample Data:       [ 592 samples by 9 sample variables ]
    ## tax_table()   Taxonomy Table:    [ 117 taxa by 7 taxonomic ranks ]

## Helper functions

**Note on the CLR transformation:**

Counts are first transformed to relative abundances. Zeros are then
replaced using multiplicative replacement from
`zCompositions::multRepl()`, with the global minimum non-zero relative
abundance used as the detection limit and `frac = 0.65`. The CLR
transformation is applied after replacement.

## Prepare genus-level data

For the PASTURE application, beta-diversity analyses are performed at
genus level. Taxa observed in less than 10% of samples are removed
before the beta-diversity matrices are computed. Bray-Curtis
dissimilarity is computed on relative abundance profiles, whereas
Euclidean distance is computed after multiplicative replacement and CLR
transformation.

    ## # A tibble: 1 × 6
    ##   n_samples n_taxa min_library_size median_library_size max_library_size zero_fraction
    ##       <int>  <int>            <dbl>               <dbl>            <dbl>         <dbl>
    ## 1       592    117             1456              21898.            69556         0.796

## Compute dissimilarity matrices

### Bray-Curtis dissimilarity

    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ## 0.005646 0.228688 0.421947 0.456196 0.662530 0.987332

### Euclidean distance after multiplicative replacement and CLR transformation

    ## # A tibble: 1 × 7
    ##   replacement_method      input_scale        detection_limit replacement_fraction replacement_value n_zeros_replaced zero_fraction
    ##   <chr>                   <chr>                        <dbl>                <dbl>             <dbl>            <int>         <dbl>
    ## 1 zCompositions::multRepl relative abundance       0.0000288                 0.65         0.0000187            55160         0.796

    ##  [1] 18.28522 21.24676 23.68095 20.53115 23.59390 22.62087 25.87166 23.59254 25.12752 23.75427

### Save distance objects

## Ordination

### Compute PCoA coordinates

### Uncolored PCoA plots

![](figures/04_beta_diversity/beta_PCoA_uncolored-1.png)<!-- -->

The Bray-Curtis PCoA (PCo1: 29.5%, PCo2: 8.9%) displays the
characteristic arch shape common to PCoA on compositional count data,
where the cloud folds back on itself along PCo2. This is an ordination
artifact rather than a biological signal and reflects how Bray-Curtis
dissimilarity handles the full gradient of community turnover.

The CLR-based PCoA produces a more symmetric, roughly elliptical cloud
with variance spread more evenly across axes — a consequence of the
log-ratio transformation removing compositional constraints. Note that
the first two axes together may explain considerably less total
variation for CLR, which is expected given its more Euclidean structure.

### PCoA plots colored by selected variables

Set the variables to inspect here. Unknown or misspelled variables are
ignored.

    ##        Country            Sex      C-section    BF duration   EBF duration        Smoking       Siblings 
    ##      "Country"          "Sex"    "C-section"  "BF duration" "EBF duration"      "Smoking"     "Siblings"

![](figures/04_beta_diversity/beta_PCoA_colored-1.png)<!-- -->![](figures/04_beta_diversity/beta_PCoA_colored-2.png)<!-- -->![](figures/04_beta_diversity/beta_PCoA_colored-3.png)<!-- -->![](figures/04_beta_diversity/beta_PCoA_colored-4.png)<!-- -->![](figures/04_beta_diversity/beta_PCoA_colored-5.png)<!-- -->![](figures/04_beta_diversity/beta_PCoA_colored-6.png)<!-- -->![](figures/04_beta_diversity/beta_PCoA_colored-7.png)<!-- -->

None of the variables examined produce visually discernible separation
in either ordination. Specifically:

- Country (Austria, Germany, Switzerland): The three groups are
  thoroughly intermixed along both axes in both ordinations. If
  country-level effects on microbiome composition exist, they do not
  dominate the major axes of variation captured here.
- Sex: No separation is visible. Male and female samples overlap
  completely.
- Delivery mode: Cesarean samples are scattered across the same space as
  vaginal births. The relatively small number of cesarean samples limits
  visual detection of any potential signal.
- BF duration / Exclusive BF: Both breastfeeding variables show the same
  mixed pattern. Samples from all duration categories are intermingled,
  with no gradient along PCo1 or PCo2. This does not rule out a
  breastfeeding effect, but suggests it is not among the dominant
  sources of between-sample variation.
- Prenatal smoking / No. of siblings: No visual structure.

### Distance matrix heatmaps

These heatmaps are mainly diagnostic. For several hundred samples, they
become visually dense, but they are useful for checking whether strong
blocks or outlying samples occur.

![](figures/04_beta_diversity/beta_heatmap_bray-1.png)<!-- -->

The Bray-Curtis distance heatmap reveals a block of samples in the
upper-left cluster (after hierarchical reordering) that are
substantially more similar to each other than to the rest of the cohort
— visible as a lighter region against the predominantly dark-blue
background. This suggests some subgroup of samples shares a notably
similar community composition. The annotation bars do not immediately
reveal a single metadata variable that cleanly aligns with this block,
so the driver of this cluster is not apparent from the variables
available here.

![](figures/04_beta_diversity/beta_heatmap_euclid-1.png)<!-- -->

The CLR heatmap is considerably more homogeneous: distances are more
uniformly distributed with less pronounced block structure, which is
consistent with the more diffuse spread seen in its ordination.

## PERMANOVA and PERMDISP

The following analyses are performed for both beta-diversity
representations: Bray-Curtis dissimilarity on relative abundance
profiles and Euclidean distance after multiplicative replacement and CLR
transformation. PERMANOVA is used to test for differences in group
centroids, while PERMDISP assesses differences in within-group
dispersion.

    ##        Country            Sex      C-section    BF duration   EBF duration        Smoking       Siblings 
    ##      "Country"          "Sex"    "C-section"  "BF duration" "EBF duration"      "Smoking"     "Siblings"

### Parallel backend and progress reporting

### Helper functions for permutation-based testing

### PERMANOVA

    ## # A tibble: 14 × 12
    ##    analysis  distance            variable n_samples n_groups statistic_obs p_empirical statistic_adonis2 r2_adonis2 p_adonis2 n_exceed n_perm
    ##    <chr>     <chr>               <fct>        <int>    <int>         <dbl>       <dbl>             <dbl>      <dbl>     <dbl>    <int>  <dbl>
    ##  1 PERMANOVA Bray-Curtis         Country        592        3          4.54       0.001              4.54    0.0152      0.001        0    999
    ##  2 PERMANOVA Bray-Curtis         Sex            592        2          1.36       0.184              1.36    0.00230     0.163      183    999
    ##  3 PERMANOVA Bray-Curtis         C-secti…       589        2          3.69       0.011              3.69    0.00624     0.005       10    999
    ##  4 PERMANOVA Bray-Curtis         BF dura…       580        3         14.3        0.001             14.3     0.0473      0.001        0    999
    ##  5 PERMANOVA Bray-Curtis         EBF dur…       557        3         10.2        0.001             10.2     0.0355      0.001        0    999
    ##  6 PERMANOVA Bray-Curtis         Smoking        592        2          5.70       0.002              5.70    0.00957     0.001        1    999
    ##  7 PERMANOVA Bray-Curtis         Siblings       503        3          2.23       0.021              2.23    0.00884     0.02        20    999
    ##  8 PERMANOVA multRepl + CLR Euc… Country        592        3          2.58       0.001              2.58    0.00868     0.001        0    999
    ##  9 PERMANOVA multRepl + CLR Euc… Sex            592        2          1.45       0.034              1.45    0.00245     0.03        33    999
    ## 10 PERMANOVA multRepl + CLR Euc… C-secti…       589        2          2.48       0.001              2.48    0.00420     0.001        0    999
    ## 11 PERMANOVA multRepl + CLR Euc… BF dura…       580        3          6.36       0.001              6.36    0.0216      0.001        0    999
    ## 12 PERMANOVA multRepl + CLR Euc… EBF dur…       557        3          5.69       0.001              5.69    0.0201      0.001        0    999
    ## 13 PERMANOVA multRepl + CLR Euc… Smoking        592        2          3.09       0.001              3.09    0.00521     0.001        0    999
    ## 14 PERMANOVA multRepl + CLR Euc… Siblings       503        3          1.58       0.006              1.58    0.00626     0.006        5    999

![](figures/04_beta_diversity/beta_permanova_perm_dist-1.png)<!-- -->

**Mean and median of permutation distributions**

    ## `summarise()` has regrouped the output.
    ## ℹ Summaries were computed grouped by distance and variable.
    ## ℹ Output is grouped by distance.
    ## ℹ Use `summarise(.groups = "drop_last")` to silence this message.
    ## ℹ Use `summarise(.by = c(distance, variable))` for per-operation grouping (`?dplyr::dplyr_by`) instead.

    ## # A tibble: 14 × 4
    ## # Groups:   distance [2]
    ##    distance                 variable      mean median
    ##    <chr>                    <fct>        <dbl>  <dbl>
    ##  1 Bray-Curtis              Country      1.02   0.914
    ##  2 Bray-Curtis              Sex          0.974  0.851
    ##  3 Bray-Curtis              C-section    1.00   0.850
    ##  4 Bray-Curtis              BF duration  0.984  0.888
    ##  5 Bray-Curtis              EBF duration 0.994  0.839
    ##  6 Bray-Curtis              Smoking      0.993  0.853
    ##  7 Bray-Curtis              Siblings     1.00   0.922
    ##  8 multRepl + CLR Euclidean Country      1.00   0.994
    ##  9 multRepl + CLR Euclidean Sex          0.985  0.961
    ## 10 multRepl + CLR Euclidean C-section    0.997  0.970
    ## 11 multRepl + CLR Euclidean BF duration  0.998  0.986
    ## 12 multRepl + CLR Euclidean EBF duration 1.01   0.986
    ## 13 multRepl + CLR Euclidean Smoking      1.01   0.969
    ## 14 multRepl + CLR Euclidean Siblings     1.000  0.988

### PERMANOVA p-value refinement with permApprox

    ## permApprox result
    ## -----------------
    ## Number of tests             : 14
    ## Approximation method        : GPD tail approximation
    ## Approximation threshold     : p-values < 0.1
    ## Multiple testing adjustment : none
    ## 
    ## Successful fits          : 13
    ## GOF rejections           : 0
    ## Fit failed               : 0
    ## No threshold found       : 0
    ## Discrete distributions   : 0
    ## Not selected for fitting : 1
    ## 
    ## Final p-values:
    ##   min = 3.907e-97, median = 5.948e-05, max = 1.840e-01
    ## 
    ## Use summary() for detailed fit diagnostics.

    ## Summary of permApprox result
    ## ----------------------------
    ## Number of tests             : 14
    ## Approximation method        : GPD tail approximation
    ## Approximation threshold     : p-values < 0.1
    ## Multiple testing adjustment : none
    ## 
    ## Fit status counts:
    ##   Successful fits          : 13
    ##   GOF rejections           : 0
    ##   Fit failed               : 0
    ##   No threshold found       : 0
    ##   Discrete distributions   : 0
    ##   Not selected for fitting : 1
    ## 
    ## GPD parameter summary (successful fits)
    ## --------------------------------------
    ##   shape:
    ##     min = -0.12, median = -0.0321, mean = -0.0205, max = 0.149
    ##   scale:
    ##     min = 0.117, median = 0.202, mean = 0.305, max = 0.597
    ##   n_exceed:
    ##     min =  170, median =  250, mean =  241, max =  250
    ## 
    ## P-value summary
    ## ---------------
    ## Empirical p-values:
    ##   empirical:
    ##     min = 1.000e-03, median = 1.000e-03, mean = 1.900e-02, max = 1.840e-01
    ## 
    ## Final p-values (unadjusted):
    ##   unadjusted:
    ##     min = 3.907e-97, median = 5.948e-05, mean = 1.779e-02, max = 1.840e-01

    ## # A tibble: 14 × 9
    ##    distance                 variable     n_samples statistic_obs n_exceed n_perm p_empirical p_permapprox method_used
    ##    <chr>                    <fct>            <int>         <dbl>    <int>  <dbl>       <dbl>        <dbl> <chr>      
    ##  1 Bray-Curtis              Country            592          4.54        0    999       0.001     1.18e- 4 gpd        
    ##  2 Bray-Curtis              Sex                592          1.36      183    999       0.184     1.84e- 1 empirical  
    ##  3 Bray-Curtis              C-section          589          3.69       10    999       0.011     7.56e- 3 gpd        
    ##  4 Bray-Curtis              BF duration        580         14.3         0    999       0.001     3.00e-11 gpd        
    ##  5 Bray-Curtis              EBF duration       557         10.2         0    999       0.001     1.65e- 7 gpd        
    ##  6 Bray-Curtis              Smoking            592          5.70        1    999       0.002     6.81e- 4 gpd        
    ##  7 Bray-Curtis              Siblings           503          2.23       20    999       0.021     1.99e- 2 gpd        
    ##  8 multRepl + CLR Euclidean Country            592          2.58        0    999       0.001     9.72e-14 gpd        
    ##  9 multRepl + CLR Euclidean Sex                592          1.45       33    999       0.034     3.51e- 2 gpd        
    ## 10 multRepl + CLR Euclidean C-section          589          2.48        0    999       0.001     4.79e- 7 gpd        
    ## 11 multRepl + CLR Euclidean BF duration        580          6.36        0    999       0.001     3.91e-97 gpd        
    ## 12 multRepl + CLR Euclidean EBF duration       557          5.69        0    999       0.001     5.18e-61 gpd        
    ## 13 multRepl + CLR Euclidean Smoking            592          3.09        0    999       0.001     5.28e-10 gpd        
    ## 14 multRepl + CLR Euclidean Siblings           503          1.58        5    999       0.006     1.80e- 3 gpd

![](figures/04_beta_diversity/beta_permanova_permapprox_perm_dist-1.png)<!-- -->

### PERMDISP

    ## # A tibble: 14 × 11
    ##    analysis distance                 variable  n_samples n_groups statistic_obs p_empirical statistic_betadisper p_betadisper n_exceed n_perm
    ##    <chr>    <chr>                    <fct>         <int>    <int>         <dbl>       <dbl>                <dbl>        <dbl>    <int>  <dbl>
    ##  1 PERMDISP Bray-Curtis              Country         592        3        10.6         0.005               10.6          0.001        4    999
    ##  2 PERMDISP Bray-Curtis              Sex             592        2         2.67        0.216                2.67         0.104      215    999
    ##  3 PERMDISP Bray-Curtis              C-section       589        2         8.87        0.035                8.87         0.003       34    999
    ##  4 PERMDISP Bray-Curtis              BF durat…       580        3        14.9         0.002               14.9          0.001        1    999
    ##  5 PERMDISP Bray-Curtis              EBF dura…       557        3         8.42        0.005                8.42         0.002        4    999
    ##  6 PERMDISP Bray-Curtis              Smoking         592        2         6.74        0.048                6.74         0.011       47    999
    ##  7 PERMDISP Bray-Curtis              Siblings        503        3         5.88        0.043                5.88         0.006       42    999
    ##  8 PERMDISP multRepl + CLR Euclidean Country         592        3        13.3         0.001               13.3          0.001        0    999
    ##  9 PERMDISP multRepl + CLR Euclidean Sex             592        2         0.610       0.434                0.610        0.414      433    999
    ## 10 PERMDISP multRepl + CLR Euclidean C-section       589        2         3.54        0.067                3.54         0.074       66    999
    ## 11 PERMDISP multRepl + CLR Euclidean BF durat…       580        3        32.1         0.001               32.1          0.001        0    999
    ## 12 PERMDISP multRepl + CLR Euclidean EBF dura…       557        3        30.9         0.001               30.9          0.001        0    999
    ## 13 PERMDISP multRepl + CLR Euclidean Smoking         592        2        15.7         0.001               15.7          0.001        0    999
    ## 14 PERMDISP multRepl + CLR Euclidean Siblings        503        3         2.63        0.084                2.63         0.062       83    999

### PERMDISP p-value refinement with permApprox

    ## permApprox result
    ## -----------------
    ## Number of tests             : 14
    ## Approximation method        : GPD tail approximation
    ## Approximation threshold     : p-values < 0.1
    ## Multiple testing adjustment : none
    ## 
    ## Successful fits          : 12
    ## GOF rejections           : 0
    ## Fit failed               : 0
    ## No threshold found       : 0
    ## Discrete distributions   : 0
    ## Not selected for fitting : 2
    ## 
    ## Final p-values:
    ##   min = 8.659e-36, median = 1.646e-02, max = 4.340e-01
    ## 
    ## Use summary() for detailed fit diagnostics.

    ## # A tibble: 14 × 9
    ##    distance                 variable     n_samples statistic_obs n_exceed n_perm p_empirical p_permapprox method_used
    ##    <chr>                    <fct>            <int>         <dbl>    <int>  <dbl>       <dbl>        <dbl> <chr>      
    ##  1 Bray-Curtis              Country            592        10.6          4    999       0.005     2.89e- 3 gpd        
    ##  2 Bray-Curtis              Sex                592         2.67       215    999       0.216     2.16e- 1 empirical  
    ##  3 Bray-Curtis              C-section          589         8.87        34    999       0.035     2.85e- 2 gpd        
    ##  4 Bray-Curtis              BF duration        580        14.9          1    999       0.002     5.88e- 4 gpd        
    ##  5 Bray-Curtis              EBF duration       557         8.42         4    999       0.005     4.45e- 3 gpd        
    ##  6 Bray-Curtis              Smoking            592         6.74        47    999       0.048     4.63e- 2 gpd        
    ##  7 Bray-Curtis              Siblings           503         5.88        42    999       0.043     4.77e- 2 gpd        
    ##  8 multRepl + CLR Euclidean Country            592        13.3          0    999       0.001     2.22e-10 gpd        
    ##  9 multRepl + CLR Euclidean Sex                592         0.610      433    999       0.434     4.34e- 1 empirical  
    ## 10 multRepl + CLR Euclidean C-section          589         3.54        66    999       0.067     6.93e- 2 gpd        
    ## 11 multRepl + CLR Euclidean BF duration        580        32.1          0    999       0.001     2.14e-26 gpd        
    ## 12 multRepl + CLR Euclidean EBF duration       557        30.9          0    999       0.001     8.66e-36 gpd        
    ## 13 multRepl + CLR Euclidean Smoking            592        15.7          0    999       0.001     2.63e- 4 gpd        
    ## 14 multRepl + CLR Euclidean Siblings           503         2.63        83    999       0.084     8.03e- 2 gpd

![](figures/04_beta_diversity/beta_permdisp_permapprox_perm_dist-1.png)<!-- -->

## Within-group dispersion

Each sample’s distance to its group centroid, as used by PERMDISP.
Unequal box heights across groups indicate heterogeneous dispersion
(PERMDISP signal). PERMANOVA tests whether the centroids themselves are
at different positions in composition space — a complementary question
that requires an ordination plot to visualise directly.

Panels are annotated with permApprox-refined p-values for PERMANOVA
(PERM) and PERMDISP (DISP).

![](figures/04_beta_diversity/beta_beta_centroid_dist-1.png)<!-- -->

## Files written

These files have been written to the target directory,
`data/04_beta_diversity`:

    ## # A tibble: 10 × 4
    ##    path                                          type         size modification_time  
    ##    <fs::path>                                    <fct> <fs::bytes> <dttm>             
    ##  1 beta_clr_summary.csv                          file          232 2026-06-09 10:34:38
    ##  2 beta_data_summary.csv                         file          131 2026-06-09 10:34:38
    ##  3 beta_diversity_objects.rds                    file        3.06M 2026-06-09 10:34:37
    ##  4 beta_pcoa_coordinates.csv                     file       146.5K 2026-06-09 10:34:39
    ##  5 permanova_permapprox_results_multrepl_clr.rds file       75.62K 2026-06-09 08:47:15
    ##  6 permanova_results_multrepl_clr.rds            file      103.83K 2026-06-09 07:59:10
    ##  7 permanova_table.tex                           file        2.24K 2026-06-09 10:35:35
    ##  8 permdisp_permapprox_results_multrepl_clr.rds  file       74.46K 2026-06-09 10:33:13
    ##  9 permdisp_results_multrepl_clr.rds             file      105.42K 2026-06-09 09:24:54
    ## 10 permdisp_table.tex                            file        2.27K 2026-06-09 10:35:40

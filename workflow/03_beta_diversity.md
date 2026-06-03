Beta diversity analysis
================
Compiled at 2026-06-03 15:22:34 UTC

## Load packages

## Set global parameters

``` r
min_taxon_prevalence <- 0.10
zero_replacement_fraction <- 0.65
n_perm <- 999
permutation_seed <- 42
alpha_perm_approx <- 0.05

var_order_beta <- c("Country", "Sex", "Delivery mode", "BF duration",
                    "Exclusive BF", "Prenatal smoking", "No. of siblings")
```

## Load data

### Phyloseq object on genus level

    ## phyloseq-class experiment-level object
    ## otu_table()   OTU Table:         [ 235 taxa and 592 samples ]
    ## sample_data() Sample Data:       [ 592 samples by 9 sample variables ]
    ## tax_table()   Taxonomy Table:    [ 235 taxa by 7 taxonomic ranks ]

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

    ## # A tibble: 1 × 9
    ##   n_samples n_taxa_before_filter n_taxa_after_filter n_taxa_removed min_taxon_prevalence min_library_size
    ##       <int>                <int>               <int>          <int>                <dbl>            <dbl>
    ## 1       592                  235                  41            194                  0.1             1438
    ## # ℹ 3 more variables: median_library_size <dbl>, max_library_size <dbl>, zero_fraction <dbl>

## Compute dissimilarity matrices

### Bray-Curtis dissimilarity

    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ## 0.005478 0.217522 0.411612 0.448515 0.647734 0.987328

### Euclidean distance after multiplicative replacement and CLR transformation

    ## # A tibble: 1 × 7
    ##   replacement_method      input_scale  detection_limit replacement_fraction replacement_value n_zeros_replaced
    ##   <chr>                   <chr>                  <dbl>                <dbl>             <dbl>            <int>
    ## 1 zCompositions::multRepl relative ab…       0.0000315                 0.65         0.0000205            11749
    ## # ℹ 1 more variable: zero_fraction <dbl>

    ##  [1] 13.11239 15.40842 18.90061 16.10400 18.27695 16.88383 19.97237 18.99845 20.75608 19.21515

### Save distance objects

## Ordination

### Compute PCoA coordinates

### Uncolored PCoA plots

![](figures/03_beta_diversity/beta_PCoA_uncolored-1.png)<!-- -->

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

    ##            Country                Sex           cesarean    breast_dur_cat1   breast_excl_cat1 
    ##          "Country"              "Sex"    "Delivery mode"      "BF duration"     "Exclusive BF" 
    ##          pregsmoke      sibs_numb_cat 
    ## "Prenatal smoking"  "No. of siblings"

![](figures/03_beta_diversity/beta_PCoA_colored-1.png)<!-- -->![](figures/03_beta_diversity/beta_PCoA_colored-2.png)<!-- -->![](figures/03_beta_diversity/beta_PCoA_colored-3.png)<!-- -->![](figures/03_beta_diversity/beta_PCoA_colored-4.png)<!-- -->![](figures/03_beta_diversity/beta_PCoA_colored-5.png)<!-- -->![](figures/03_beta_diversity/beta_PCoA_colored-6.png)<!-- -->![](figures/03_beta_diversity/beta_PCoA_colored-7.png)<!-- -->

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

![](figures/03_beta_diversity/beta_heatmap_bray-1.png)<!-- -->

The Bray-Curtis distance heatmap reveals a block of samples in the
upper-left cluster (after hierarchical reordering) that are
substantially more similar to each other than to the rest of the cohort
— visible as a lighter region against the predominantly dark-blue
background. This suggests some subgroup of samples shares a notably
similar community composition. The annotation bars do not immediately
reveal a single metadata variable that cleanly aligns with this block,
so the driver of this cluster is not apparent from the variables
available here.

![](figures/03_beta_diversity/beta_heatmap_euclid-1.png)<!-- -->

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

    ##            Country                Sex           cesarean    breast_dur_cat1   breast_excl_cat1 
    ##          "Country"              "Sex"    "Delivery mode"      "BF duration"     "Exclusive BF" 
    ##          pregsmoke      sibs_numb_cat 
    ## "Prenatal smoking"  "No. of siblings"

### Parallel backend and progress reporting

### Helper functions for permutation-based testing

### PERMANOVA

    ## # A tibble: 14 × 12
    ##    analysis  distance       variable n_samples n_groups statistic_obs p_empirical statistic_adonis2 r2_adonis2
    ##    <chr>     <chr>          <fct>        <int>    <int>         <dbl>       <dbl>             <dbl>      <dbl>
    ##  1 PERMANOVA Bray-Curtis    Country        592        3          4.61       0.001              4.61    0.0154 
    ##  2 PERMANOVA Bray-Curtis    Sex            592        2          1.49       0.154              1.49    0.00252
    ##  3 PERMANOVA Bray-Curtis    Deliver…       589        2          3.76       0.012              3.76    0.00636
    ##  4 PERMANOVA Bray-Curtis    BF dura…       580        3         14.4        0.001             14.4     0.0475 
    ##  5 PERMANOVA Bray-Curtis    Exclusi…       557        3         10.2        0.001             10.2     0.0354 
    ##  6 PERMANOVA Bray-Curtis    Prenata…       592        2          5.66       0.002              5.66    0.00951
    ##  7 PERMANOVA Bray-Curtis    No. of …       503        3          2.33       0.018              2.33    0.00923
    ##  8 PERMANOVA multRepl + CL… Country        592        3          2.76       0.001              2.76    0.00929
    ##  9 PERMANOVA multRepl + CL… Sex            592        2          1.45       0.053              1.45    0.00245
    ## 10 PERMANOVA multRepl + CL… Deliver…       589        2          3.03       0.001              3.03    0.00514
    ## 11 PERMANOVA multRepl + CL… BF dura…       580        3          7.03       0.001              7.03    0.0238 
    ## 12 PERMANOVA multRepl + CL… Exclusi…       557        3          6.64       0.001              6.64    0.0234 
    ## 13 PERMANOVA multRepl + CL… Prenata…       592        2          3.19       0.001              3.19    0.00537
    ## 14 PERMANOVA multRepl + CL… No. of …       503        3          1.78       0.003              1.78    0.00706
    ## # ℹ 3 more variables: p_adonis2 <dbl>, n_exceed <int>, n_perm <dbl>

![](figures/03_beta_diversity/beta_permanova_perm_dist-1.png)<!-- -->

**Mean and median of permutation distributions**

    ## # A tibble: 14 × 4
    ## # Groups:   distance [2]
    ##    distance                 variable          mean median
    ##    <chr>                    <fct>            <dbl>  <dbl>
    ##  1 Bray-Curtis              Country          1.02   0.919
    ##  2 Bray-Curtis              Sex              0.973  0.850
    ##  3 Bray-Curtis              Delivery mode    1.00   0.848
    ##  4 Bray-Curtis              BF duration      0.984  0.884
    ##  5 Bray-Curtis              Exclusive BF     0.994  0.839
    ##  6 Bray-Curtis              Prenatal smoking 0.993  0.844
    ##  7 Bray-Curtis              No. of siblings  1.000  0.919
    ##  8 multRepl + CLR Euclidean Country          1.00   0.984
    ##  9 multRepl + CLR Euclidean Sex              0.977  0.949
    ## 10 multRepl + CLR Euclidean Delivery mode    1.00   0.974
    ## 11 multRepl + CLR Euclidean BF duration      0.999  0.978
    ## 12 multRepl + CLR Euclidean Exclusive BF     1.01   0.992
    ## 13 multRepl + CLR Euclidean Prenatal smoking 1.01   0.964
    ## 14 multRepl + CLR Euclidean No. of siblings  0.996  0.977

### PERMANOVA p-value refinement with permApprox

    ## Run threshold detection ...
    ## Done.
    ## Run GPD fit ...
    ## Done.

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
    ##   min = 3.454e-86, median = 8.231e-05, max = 1.540e-01
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
    ##     min = -0.181, median = -0.0302, mean = -0.0295, max = 0.139
    ##   scale:
    ##     min = 0.141, median = 0.268, mean = 0.333, max = 0.629
    ##   n_exceed:
    ##     min =  170, median =  250, mean =  244, max =  250
    ## 
    ## P-value summary
    ## ---------------
    ## Empirical p-values:
    ##   empirical:
    ##     min = 1.000e-03, median = 1.000e-03, mean = 1.786e-02, max = 1.540e-01
    ## 
    ## Final p-values (unadjusted):
    ##   unadjusted:
    ##     min = 3.454e-86, median = 8.231e-05, mean = 1.705e-02, max = 1.540e-01

    ## # A tibble: 14 × 9
    ##    distance              variable n_samples statistic_obs n_exceed n_perm p_empirical p_permapprox method_used
    ##    <chr>                 <fct>        <int>         <dbl>    <int>  <dbl>       <dbl>        <dbl> <chr>      
    ##  1 Bray-Curtis           Country        592          4.61        0    999       0.001     1.65e- 4 gpd        
    ##  2 Bray-Curtis           Sex            592          1.49      153    999       0.154     1.54e- 1 empirical  
    ##  3 Bray-Curtis           Deliver…       589          3.76       11    999       0.012     7.44e- 3 gpd        
    ##  4 Bray-Curtis           BF dura…       580         14.4         0    999       0.001     1.99e-12 gpd        
    ##  5 Bray-Curtis           Exclusi…       557         10.2         0    999       0.001     8.15e- 8 gpd        
    ##  6 Bray-Curtis           Prenata…       592          5.66        1    999       0.002     7.49e- 4 gpd        
    ##  7 Bray-Curtis           No. of …       503          2.33       17    999       0.018     1.60e- 2 gpd        
    ##  8 multRepl + CLR Eucli… Country        592          2.76        0    999       0.001     2.76e-12 gpd        
    ##  9 multRepl + CLR Eucli… Sex            592          1.45       52    999       0.053     5.98e- 2 gpd        
    ## 10 multRepl + CLR Eucli… Deliver…       589          3.03        0    999       0.001     2.75e- 8 gpd        
    ## 11 multRepl + CLR Eucli… BF dura…       580          7.03        0    999       0.001     3.45e-86 gpd        
    ## 12 multRepl + CLR Eucli… Exclusi…       557          6.64        0    999       0.001     4.06e-68 gpd        
    ## 13 multRepl + CLR Eucli… Prenata…       592          3.19        0    999       0.001     6.59e- 8 gpd        
    ## 14 multRepl + CLR Eucli… No. of …       503          1.78        2    999       0.003     6.28e- 4 gpd

![](figures/03_beta_diversity/beta_permanova_permapprox_perm_dist-1.png)<!-- -->

### PERMDISP

    ## # A tibble: 14 × 11
    ##    analysis distance   variable n_samples n_groups statistic_obs p_empirical statistic_betadisper p_betadisper
    ##    <chr>    <chr>      <fct>        <int>    <int>         <dbl>       <dbl>                <dbl>        <dbl>
    ##  1 PERMDISP Bray-Curt… Country        592        3         10.7        0.004                10.7         0.001
    ##  2 PERMDISP Bray-Curt… Sex            592        2          3.39       0.17                  3.39        0.069
    ##  3 PERMDISP Bray-Curt… Deliver…       589        2          8.85       0.034                 8.85        0.003
    ##  4 PERMDISP Bray-Curt… BF dura…       580        3         14.4        0.002                14.4         0.001
    ##  5 PERMDISP Bray-Curt… Exclusi…       557        3          7.49       0.007                 7.49        0.002
    ##  6 PERMDISP Bray-Curt… Prenata…       592        2          6.11       0.06                  6.11        0.013
    ##  7 PERMDISP Bray-Curt… No. of …       503        3          6.38       0.037                 6.38        0.004
    ##  8 PERMDISP multRepl … Country        592        3         14.5        0.001                14.5         0.001
    ##  9 PERMDISP multRepl … Sex            592        2          1.54       0.224                 1.54        0.201
    ## 10 PERMDISP multRepl … Deliver…       589        2          6.22       0.017                 6.22        0.013
    ## 11 PERMDISP multRepl … BF dura…       580        3         19.6        0.001                19.6         0.001
    ## 12 PERMDISP multRepl … Exclusi…       557        3         20.3        0.001                20.3         0.001
    ## 13 PERMDISP multRepl … Prenata…       592        2          9.22       0.001                 9.22        0.003
    ## 14 PERMDISP multRepl … No. of …       503        3          5.51       0.011                 5.51        0.005
    ## # ℹ 2 more variables: n_exceed <int>, n_perm <dbl>

### PERMDISP p-value refinement with permApprox

    ## Run threshold detection ...
    ## Done.
    ## Run GPD fit ...
    ## Done.

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
    ##   min = 2.292e-12, median = 7.624e-03, max = 2.240e-01
    ## 
    ## Use summary() for detailed fit diagnostics.

    ## # A tibble: 14 × 9
    ##    distance              variable n_samples statistic_obs n_exceed n_perm p_empirical p_permapprox method_used
    ##    <chr>                 <fct>        <int>         <dbl>    <int>  <dbl>       <dbl>        <dbl> <chr>      
    ##  1 Bray-Curtis           Country        592         10.7         3    999       0.004     2.56e- 3 gpd        
    ##  2 Bray-Curtis           Sex            592          3.39      169    999       0.17      1.7 e- 1 empirical  
    ##  3 Bray-Curtis           Deliver…       589          8.85       33    999       0.034     2.90e- 2 gpd        
    ##  4 Bray-Curtis           BF dura…       580         14.4         1    999       0.002     6.27e- 4 gpd        
    ##  5 Bray-Curtis           Exclusi…       557          7.49        6    999       0.007     8.11e- 3 gpd        
    ##  6 Bray-Curtis           Prenata…       592          6.11       59    999       0.06      6.09e- 2 gpd        
    ##  7 Bray-Curtis           No. of …       503          6.38       36    999       0.037     3.68e- 2 gpd        
    ##  8 multRepl + CLR Eucli… Country        592         14.5         0    999       0.001     2.29e-12 gpd        
    ##  9 multRepl + CLR Eucli… Sex            592          1.54      223    999       0.224     2.24e- 1 empirical  
    ## 10 multRepl + CLR Eucli… Deliver…       589          6.22       16    999       0.017     1.93e- 2 gpd        
    ## 11 multRepl + CLR Eucli… BF dura…       580         19.6         0    999       0.001     1.77e-10 gpd        
    ## 12 multRepl + CLR Eucli… Exclusi…       557         20.3         0    999       0.001     4.70e-12 gpd        
    ## 13 multRepl + CLR Eucli… Prenata…       592          9.22        0    999       0.001     2.01e- 3 gpd        
    ## 14 multRepl + CLR Eucli… No. of …       503          5.51       10    999       0.011     7.14e- 3 gpd

![](figures/03_beta_diversity/beta_permdisp_permapprox_perm_dist-1.png)<!-- -->

## Within-group dispersion

Each sample’s distance to its group centroid, as used by PERMDISP.
Unequal box heights across groups indicate heterogeneous dispersion
(PERMDISP signal). PERMANOVA tests whether the centroids themselves are
at different positions in composition space — a complementary question
that requires an ordination plot to visualise directly.

Panels are annotated with permApprox-refined p-values for PERMANOVA
(PERM) and PERMDISP (DISP).

![](figures/03_beta_diversity/beta_beta_centroid_dist-1.png)<!-- -->

## Files written

These files have been written to the target directory,
`data/03_beta_diversity`:

    ## # A tibble: 18 × 4
    ##    path                                          type         size modification_time  
    ##    <fs::path>                                    <fct> <fs::bytes> <dttm>             
    ##  1 beta_clr_summary.csv                          file          233 2026-06-03 15:22:39
    ##  2 beta_data_summary.csv                         file          210 2026-06-03 15:22:39
    ##  3 beta_diversity_objects.rds                    file        3.01M 2026-06-03 15:22:39
    ##  4 beta_emclr_sample_offsets.csv                 file       17.16K 2026-05-20 14:05:22
    ##  5 beta_emclr_summary.csv                        file          199 2026-05-20 14:05:22
    ##  6 beta_pcoa_coordinates.csv                     file      146.63K 2026-06-03 15:22:40
    ##  7 beta_taxa_filter_summary.csv                  file          106 2026-06-03 15:22:39
    ##  8 beta_taxa_prevalence_summary.csv              file       10.25K 2026-06-03 15:22:39
    ##  9 permanova_permapprox_results.rds              file       72.59K 2026-05-20 06:36:20
    ## 10 permanova_permapprox_results_multrepl_clr.rds file       75.86K 2026-06-03 15:42:00
    ## 11 permanova_results.rds                         file      103.81K 2026-05-19 14:29:56
    ## 12 permanova_results_multrepl_clr.rds            file      103.95K 2026-06-03 15:39:11
    ## 13 permanova_table.tex                           file        2.26K 2026-06-03 15:42:02
    ## 14 permdisp_permapprox_results.rds               file       71.08K 2026-05-20 09:24:56
    ## 15 permdisp_permapprox_results_multrepl_clr.rds  file       74.98K 2026-06-03 20:51:06
    ## 16 permdisp_results.rds                          file      105.52K 2026-05-20 09:20:41
    ## 17 permdisp_results_multrepl_clr.rds             file      105.52K 2026-06-03 20:49:15
    ## 18 permdisp_table.tex                            file        2.29K 2026-06-03 20:51:06

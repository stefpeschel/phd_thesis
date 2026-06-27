Network comparison between EBF groups
================
Compiled at 2026-06-27 18:12:23 UTC

``` r
here::i_am(paste0(params$name, ".Rmd"), uuid = "2e531120-aad0-4546-bf2a-05d6465091a5")
```

This document compares genus-level microbial association networks
between infants without exclusive breastfeeding and infants with at
least two months of exclusive breastfeeding. The first part contrasts
several network construction approaches descriptively. The second part
conducts permutation-based network comparison for one selected
descriptive network.

## Parameters

## Load And Prepare Data

The comparison uses the two EBF groups that define the main contrast in
this chapter: no exclusive breastfeeding and exclusive breastfeeding for
at least two months. Samples with one month of exclusive breastfeeding
are excluded.

    ## Column 7 contains NAs only and is ignored.

    ##    ebf_group n_samples
    ## 1   0 months       179
    ## 2 >=2 months       375

## Helper Functions

## Descriptive Network Comparisons

The following sections construct and describe EBF-group-specific
networks without permutation testing.

### SPIEC-EASI MB with multRepl

#### Association Histogram

![](figures/11_network_comparison/net_ebf_spieceasi_multRepl_association_histogram-1.png)<!-- -->

#### Degree Distribution

![](figures/11_network_comparison/net_ebf_spieceasi_multRepl_degree_distribution-1.png)<!-- -->

#### Graphlet Correlation Matrix

![](figures/11_network_comparison/net_ebf_spieceasi_multRepl_gcm-1.png)<!-- -->

#### Network Plot

![](figures/11_network_comparison/net_ebf_spieceasi_multRepl_network_plot_different_layouts-1.png)<!-- -->

![](figures/11_network_comparison/net_ebf_spieceasi_multRepl_network_plot_same_layout-1.png)<!-- -->

![](figures/11_network_comparison/net_ebf_spieceasi_multRepl_network_plot_nolabs-1.png)<!-- -->

### SPIEC-EASI MB with BayesMult replacement

#### Association Histogram

![](figures/11_network_comparison/net_ebf_spieceasi_bayesMult_association_histogram-1.png)<!-- -->

#### Degree Distribution

![](figures/11_network_comparison/net_ebf_spieceasi_bayesMult_degree_distribution-1.png)<!-- -->

#### Graphlet Correlation Matrix

![](figures/11_network_comparison/net_ebf_spieceasi_bayesMult_gcm-1.png)<!-- -->

#### Network Plot

![](figures/11_network_comparison/net_ebf_spieceasi_bayesMult_network_plot_different_layouts-1.png)<!-- -->

![](figures/11_network_comparison/net_ebf_spieceasi_bayesMult_network_plot_same_layout-1.png)<!-- -->

![](figures/11_network_comparison/net_ebf_spieceasi_bayesMult_network_plot_nolabs-1.png)<!-- -->

### SPIEC-EASI SLR

#### Low-Rank Heatmaps

    ## # A tibble: 2 × 4
    ##   group    n_taxa n_common_taxa lambda
    ##   <chr>     <int>         <int>  <dbl>
    ## 1 EBF = 0     117           117  0.323
    ## 2 EBF >= 2    117           117  0.253

![](figures/11_network_comparison/net_ebf_slr_low_rank_heatmaps-1.png)<!-- -->

#### Association Histogram

![](figures/11_network_comparison/net_ebf_slr_association_histogram-1.png)<!-- -->

#### Degree Distribution

![](figures/11_network_comparison/net_ebf_slr_degree_distribution-1.png)<!-- -->

#### Graphlet Correlation Matrix

![](figures/11_network_comparison/net_ebf_slr_gcm-1.png)<!-- -->

#### Network Plot

![](figures/11_network_comparison/net_ebf_slr_network_plot_different_layouts-1.png)<!-- -->

![](figures/11_network_comparison/net_ebf_slr_network_plot_same_layout-1.png)<!-- -->

![](figures/11_network_comparison/net_ebf_slr_network_plot_nolabs-1.png)<!-- -->

### SPRING

    ## [1] 179  65

    ## [1] 375  65

The filtering reduced the data set to 65 taxa in each group.

#### Association Histogram

![](figures/11_network_comparison/net_ebf_spring_association_histogram-1.png)<!-- -->

#### Degree Distribution

![](figures/11_network_comparison/net_ebf_spring_degree_distribution-1.png)<!-- -->

#### Graphlet Correlation Matrix

![](figures/11_network_comparison/net_ebf_spring_gcm-1.png)<!-- -->

#### Network Plot

![](figures/11_network_comparison/net_ebf_spring_network_plot_different_layouts-1.png)<!-- -->

![](figures/11_network_comparison/net_ebf_spring_network_plot_same_layout-1.png)<!-- -->

![](figures/11_network_comparison/net_ebf_spring_network_plot_nolabs-1.png)<!-- -->

### rhoshrink with multRepl

#### Association Histogram

![](figures/11_network_comparison/net_ebf_rhoshrink_multRepl_association_histogram-1.png)<!-- -->

#### Degree Distribution

![](figures/11_network_comparison/net_ebf_rhoshrink_multRepl_degree_distribution-1.png)<!-- -->

#### Graphlet Correlation Matrix

![](figures/11_network_comparison/net_ebf_rhoshrink_multRepl_gcm-1.png)<!-- -->

#### Network Plot

![](figures/11_network_comparison/net_ebf_rhoshrink_multRepl_network_plot_different_layouts-1.png)<!-- -->

![](figures/11_network_comparison/net_ebf_rhoshrink_multRepl_network_plot_same_layout-1.png)<!-- -->

![](figures/11_network_comparison/net_ebf_rhoshrink_multRepl_network_plot_nolabs-1.png)<!-- -->

### rhoshrink with bayesMult replacement

#### Association Histogram

![](figures/11_network_comparison/net_ebf_rhoshrink_bayesMult_association_histogram-1.png)<!-- -->

#### Degree Distribution

![](figures/11_network_comparison/net_ebf_rhoshrink_bayesMult_degree_distribution-1.png)<!-- -->

#### Graphlet Correlation Matrix

![](figures/11_network_comparison/net_ebf_rhoshrink_bayesMult_gcm-1.png)<!-- -->

#### Network Plot

![](figures/11_network_comparison/net_ebf_rhoshrink_bayesMult_network_plot_different_layouts-1.png)<!-- -->

![](figures/11_network_comparison/net_ebf_rhoshrink_bayesMult_network_plot_same_layout-1.png)<!-- -->

![](figures/11_network_comparison/net_ebf_rhoshrink_bayesMult_network_plot_nolabs-1.png)<!-- -->

### corshrink with multiplicative replacement

#### Association Histogram

![](figures/11_network_comparison/net_ebf_corshrink_multRepl_association_histogram-1.png)<!-- -->

#### Degree Distribution

![](figures/11_network_comparison/net_ebf_corshrink_multRepl_degree_distribution-1.png)<!-- -->

#### Graphlet Correlation Matrix

![](figures/11_network_comparison/net_ebf_corshrink_multRepl_gcm-1.png)<!-- -->

#### Network Plot

![](figures/11_network_comparison/net_ebf_corshrink_multRepl_network_plot_different_layouts-1.png)<!-- -->

![](figures/11_network_comparison/net_ebf_corshrink_multRepl_network_plot_same_layout-1.png)<!-- -->

![](figures/11_network_comparison/net_ebf_corshrink_multRepl_network_plot_nolabs-1.png)<!-- -->

### corshrink with bayesMult replacement

#### Association Histogram

![](figures/11_network_comparison/net_ebf_corshrink_bayesMult_association_histogram-1.png)<!-- -->

#### Degree Distribution

![](figures/11_network_comparison/net_ebf_corshrink_bayesMult_degree_distribution-1.png)<!-- -->

#### Graphlet Correlation Matrix

![](figures/11_network_comparison/net_ebf_corshrink_bayesMult_gcm-1.png)<!-- -->

#### Network Plot

![](figures/11_network_comparison/net_ebf_corshrink_bayesMult_network_plot_different_layouts-1.png)<!-- -->

![](figures/11_network_comparison/net_ebf_corshrink_bayesMult_network_plot_same_layout-1.png)<!-- -->

![](figures/11_network_comparison/net_ebf_corshrink_bayesMult_network_plot_nolabs-1.png)<!-- -->

## Select Network For Permutation Testing

The permutation-testing part can be run for any network constructed in
the descriptive comparison above. Change `selected_permutation_method`
in the parameter chunk to switch the network and the folder used for all
permutation-related files.

    ## # A tibble: 1 × 5
    ##   selected_method     selected_label           n_taxa_group1 n_taxa_group2 output_dir                                                                   
    ##   <chr>               <chr>                            <int>         <int> <chr>                                                                        
    ## 1 corshrink_bayesMult corshrink with bayesMult           117           117 G:/PhD/projects/phd_thesis/ch07_application/data/11_network_comparison/permu…

## Generate Or Reuse Permuted Association Matrices

The following chunks are kept for reproducibility and are not evaluated
during normal rendering. The final filematrix at
`path_perm("assoPerm_ebf")` is used by both `netCompare()` and
`diffnet()`.

## Permutation-Based Differential Network Analysis

We compare local and global network characteristics with NetCoMi’s
`netCompare()` using empirical p-values, unconstrained `permApprox`
refinement, and constrained `permApprox` refinement.

### Empirical P-Values

    ## 
    ## Comparison of Network Properties
    ## ----------------------------------
    ## CALL: 
    ## netCompare(x = props_ebf_perm, permTest = TRUE, verbose = TRUE, 
    ##     nPerm = n_perm_network_comparison, adjust = "none", cores = cores, 
    ##     seed = permutation_seed, fileLoadAssoPerm = path_perm("assoPerm_ebf"))
    ## 
    ## ______________________________
    ## Global network properties
    ## `````````````````````````
    ## Largest connected component (LCC):
    ##                          EBF = 0   EBF >= 2    abs.diff.     p-value  
    ## Relative LCC size          0.068      0.650        0.581    0.347000  
    ## Clustering coefficient     0.336      0.440        0.105    0.623000  
    ## Modularity                 0.369      0.535        0.166    0.353000  
    ## Positive edge percentage 100.000     94.558        5.442    0.377000  
    ## Edge density               0.286      0.052        0.234    0.210000  
    ## Natural connectivity       0.192      0.019        0.173    0.133000  
    ## Vertex connectivity        1.000      1.000        0.000    1.000000  
    ## Edge connectivity          1.000      1.000        0.000    1.000000  
    ## Average dissimilarity*     0.895      0.981        0.086    0.207000  
    ## Average path length**      1.744      2.458        0.715    0.361000  
    ## 
    ## Whole network:
    ##                          EBF = 0   EBF >= 2    abs.diff.     p-value  
    ## Number of components      90.000     35.000       55.000    0.262000  
    ## Clustering coefficient     0.408      0.433        0.025    0.908000  
    ## Modularity                 0.840      0.565        0.275    0.443000  
    ## Positive edge percentage 100.000     94.805        5.195    0.259000  
    ## Edge density               0.005      0.023        0.018    0.461000  
    ## Natural connectivity       0.009      0.011        0.002    0.543000  
    ## -----
    ## p-values: one-tailed test with null hypothesis diff=0
    ##  *: Dissimilarity = 1 - edge weight
    ## **: Path length = Units with average dissimilarity
    ## 
    ## ______________________________
    ## Jaccard index (similarity betw. sets of most central nodes)
    ## ```````````````````````````````````````````````````````````
    ##                     Jacc   P(<=Jacc)     P(>=Jacc)   
    ## degree             0.130    0.026475 *    0.993250   
    ## betweenness centr. 0.065    0.000462 ***  0.999943   
    ## closeness centr.   0.121    0.005237 **   0.998715   
    ## eigenvec. centr.   0.121    0.005237 **   0.998715   
    ## hub taxa           0.091    0.075147 .    0.988439   
    ## -----
    ## Jaccard index in [0,1] (1 indicates perfect agreement)
    ## 
    ## ______________________________
    ## Adjusted Rand index (similarity betw. clusterings)
    ## ``````````````````````````````````````````````````
    ##         wholeNet       LCC
    ## ARI        0.002     0.031
    ## p-value 0.913000  0.023000
    ## -----
    ## ARI in [-1,1] with ARI=1: perfect agreement betw. clusterings
    ##                    ARI=0: expected for two random clusterings
    ## p-value: permutation test (n=1000) with null hypothesis ARI=0
    ## 
    ## ______________________________
    ## Graphlet Correlation Distance
    ## `````````````````````````````
    ##         wholeNet         LCC  
    ## GCD        2.372       4.221  
    ## p-value 0.161000    0.300000  
    ## -----
    ## GCD >= 0 (GCD=0 indicates perfect agreement between GCMs)
    ## p-value: permutation test with null hypothesis GCD=0
    ## 
    ## ______________________________
    ## Centrality measures
    ## - In decreasing order
    ## - Centrality of disconnected components is zero
    ## ````````````````````````````````````````````````
    ## Degree (unnormalized):
    ##                          EBF = 0 EBF >= 2 abs.diff. adj.p-value    
    ## Coprobacillus                  0       32        32    0.048000 *  
    ## Leuconostoc                    0       13        13    0.016000 *  
    ## Family_XIII_AD3011_group       3       12         9    0.521000    
    ## Faecalicoccus                  0        9         9    0.156000    
    ## Faecalitalea                   0        8         8    0.182000    
    ## 
    ## Betweenness centrality (unnormalized):
    ##                          EBF = 0 EBF >= 2 abs.diff. adj.p-value    
    ## Coprobacillus                  0     1936      1936    0.004000 ** 
    ## Family_XIII_AD3011_group      11      690       679    0.108000    
    ## Peptoniphilus                  0      610       610    0.007000 ** 
    ## Varibaculum                    0      594       594    0.003000 ** 
    ## Rothia                         0      536       536    0.002000 ** 
    ## 
    ## Closeness centrality (unnormalized):
    ##               EBF = 0 EBF >= 2 abs.diff. adj.p-value    
    ## Coprobacillus       0   76.861    76.861    0.095000 .  
    ## Leuconostoc         0   59.065    59.065    0.083000 .  
    ## Faecalicoccus       0   54.892    54.892    0.180000    
    ## Faecalitalea        0   53.778    53.778    0.206000    
    ## Epulopiscium        0   53.335    53.335    0.144000    
    ## 
    ## _________________________________________________________
    ## Significance codes: ***: 0.001, **: 0.01, *: 0.05, .: 0.1

    ## 
    ## Comparison of Network Properties
    ## ----------------------------------
    ## CALL: 
    ## netCompare(x = props_ebf_perm, permTest = TRUE, verbose = TRUE, 
    ##     nPerm = n_perm_network_comparison, adjust = "BH", cores = cores, 
    ##     seed = permutation_seed, fileLoadAssoPerm = path_perm("assoPerm_ebf"))
    ## 
    ## ______________________________
    ## Global network properties
    ## `````````````````````````
    ## Largest connected component (LCC):
    ##                          EBF = 0   EBF >= 2    abs.diff.     p-value  
    ## Relative LCC size          0.068      0.650        0.581    0.347000  
    ## Clustering coefficient     0.336      0.440        0.105    0.623000  
    ## Modularity                 0.369      0.535        0.166    0.353000  
    ## Positive edge percentage 100.000     94.558        5.442    0.377000  
    ## Edge density               0.286      0.052        0.234    0.210000  
    ## Natural connectivity       0.192      0.019        0.173    0.133000  
    ## Vertex connectivity        1.000      1.000        0.000    1.000000  
    ## Edge connectivity          1.000      1.000        0.000    1.000000  
    ## Average dissimilarity*     0.895      0.981        0.086    0.207000  
    ## Average path length**      1.744      2.458        0.715    0.361000  
    ## 
    ## Whole network:
    ##                          EBF = 0   EBF >= 2    abs.diff.     p-value  
    ## Number of components      90.000     35.000       55.000    0.262000  
    ## Clustering coefficient     0.408      0.433        0.025    0.908000  
    ## Modularity                 0.840      0.565        0.275    0.443000  
    ## Positive edge percentage 100.000     94.805        5.195    0.259000  
    ## Edge density               0.005      0.023        0.018    0.461000  
    ## Natural connectivity       0.009      0.011        0.002    0.543000  
    ## -----
    ## p-values: one-tailed test with null hypothesis diff=0
    ##  *: Dissimilarity = 1 - edge weight
    ## **: Path length = Units with average dissimilarity
    ## 
    ## ______________________________
    ## Jaccard index (similarity betw. sets of most central nodes)
    ## ```````````````````````````````````````````````````````````
    ##                     Jacc   P(<=Jacc)     P(>=Jacc)   
    ## degree             0.130    0.026475 *    0.993250   
    ## betweenness centr. 0.065    0.000462 ***  0.999943   
    ## closeness centr.   0.121    0.005237 **   0.998715   
    ## eigenvec. centr.   0.121    0.005237 **   0.998715   
    ## hub taxa           0.091    0.075147 .    0.988439   
    ## -----
    ## Jaccard index in [0,1] (1 indicates perfect agreement)
    ## 
    ## ______________________________
    ## Adjusted Rand index (similarity betw. clusterings)
    ## ``````````````````````````````````````````````````
    ##         wholeNet       LCC
    ## ARI        0.002     0.031
    ## p-value 0.913000  0.023000
    ## -----
    ## ARI in [-1,1] with ARI=1: perfect agreement betw. clusterings
    ##                    ARI=0: expected for two random clusterings
    ## p-value: permutation test (n=1000) with null hypothesis ARI=0
    ## 
    ## ______________________________
    ## Graphlet Correlation Distance
    ## `````````````````````````````
    ##         wholeNet         LCC  
    ## GCD        2.372       4.221  
    ## p-value 0.161000    0.300000  
    ## -----
    ## GCD >= 0 (GCD=0 indicates perfect agreement between GCMs)
    ## p-value: permutation test with null hypothesis GCD=0
    ## 
    ## ______________________________
    ## Centrality measures
    ## - In decreasing order
    ## - Centrality of disconnected components is zero
    ## ````````````````````````````````````````````````
    ## Degree (unnormalized):
    ##                          EBF = 0 EBF >= 2 abs.diff. adj.p-value  
    ## Coprobacillus                  0       32        32    1.000000  
    ## Leuconostoc                    0       13        13    1.000000  
    ## Family_XIII_AD3011_group       3       12         9    1.000000  
    ## Faecalicoccus                  0        9         9    1.000000  
    ## Faecalitalea                   0        8         8    1.000000  
    ## 
    ## Betweenness centrality (unnormalized):
    ##                          EBF = 0 EBF >= 2 abs.diff. adj.p-value  
    ## Coprobacillus                  0     1936      1936    0.156000  
    ## Family_XIII_AD3011_group      11      690       679    1.000000  
    ## Peptoniphilus                  0      610       610    0.204750  
    ## Varibaculum                    0      594       594    0.156000  
    ## Rothia                         0      536       536    0.156000  
    ## 
    ## Closeness centrality (unnormalized):
    ##               EBF = 0 EBF >= 2 abs.diff. adj.p-value  
    ## Coprobacillus       0   76.861    76.861    0.715565  
    ## Leuconostoc         0   59.065    59.065    0.715565  
    ## Faecalicoccus       0   54.892    54.892    0.715565  
    ## Faecalitalea        0   53.778    53.778    0.715565  
    ## Epulopiscium        0   53.335    53.335    0.715565  
    ## 
    ## _________________________________________________________
    ## Significance codes: ***: 0.001, **: 0.01, *: 0.05, .: 0.1

### permApprox Refinement Without Constraint

    ## 
    ## Comparison of Network Properties
    ## ----------------------------------
    ## CALL: 
    ## netCompare(x = props_ebf_perm, permTest = TRUE, verbose = TRUE, 
    ##     nPerm = n_perm_network_comparison, refinePermPvals = TRUE, 
    ##     permApproxParams = list(method = "gpd", gpd_ctrl = gpd_ctrl), 
    ##     adjust = "none", cores = cores, seed = permutation_seed, 
    ##     fileLoadAssoPerm = path_perm("assoPerm_ebf"))
    ## 
    ## ______________________________
    ## Global network properties
    ## `````````````````````````
    ## Largest connected component (LCC):
    ##                          EBF = 0   EBF >= 2    abs.diff.     p-value  
    ## Relative LCC size          0.068      0.650        0.581    0.347000  
    ## Clustering coefficient     0.336      0.440        0.105    0.623000  
    ## Modularity                 0.369      0.535        0.166    0.353000  
    ## Positive edge percentage 100.000     94.558        5.442    0.377000  
    ## Edge density               0.286      0.052        0.234    0.210000  
    ## Natural connectivity       0.192      0.019        0.173    0.133000  
    ## Vertex connectivity        1.000      1.000        0.000    1.000000  
    ## Edge connectivity          1.000      1.000        0.000    1.000000  
    ## Average dissimilarity*     0.895      0.981        0.086    0.207000  
    ## Average path length**      1.744      2.458        0.715    0.361000  
    ## 
    ## Whole network:
    ##                          EBF = 0   EBF >= 2    abs.diff.     p-value  
    ## Number of components      90.000     35.000       55.000    0.262000  
    ## Clustering coefficient     0.408      0.433        0.025    0.908000  
    ## Modularity                 0.840      0.565        0.275    0.443000  
    ## Positive edge percentage 100.000     94.805        5.195    0.259000  
    ## Edge density               0.005      0.023        0.018    0.461000  
    ## Natural connectivity       0.009      0.011        0.002    0.543000  
    ## -----
    ## p-values: one-tailed test with null hypothesis diff=0
    ##  *: Dissimilarity = 1 - edge weight
    ## **: Path length = Units with average dissimilarity
    ## 
    ## ______________________________
    ## Jaccard index (similarity betw. sets of most central nodes)
    ## ```````````````````````````````````````````````````````````
    ##                     Jacc   P(<=Jacc)     P(>=Jacc)   
    ## degree             0.130    0.026475 *    0.993250   
    ## betweenness centr. 0.065    0.000462 ***  0.999943   
    ## closeness centr.   0.121    0.005237 **   0.998715   
    ## eigenvec. centr.   0.121    0.005237 **   0.998715   
    ## hub taxa           0.091    0.075147 .    0.988439   
    ## -----
    ## Jaccard index in [0,1] (1 indicates perfect agreement)
    ## 
    ## ______________________________
    ## Adjusted Rand index (similarity betw. clusterings)
    ## ``````````````````````````````````````````````````
    ##         wholeNet       LCC
    ## ARI        0.002     0.031
    ## p-value 0.913087  0.023976
    ## -----
    ## ARI in [-1,1] with ARI=1: perfect agreement betw. clusterings
    ##                    ARI=0: expected for two random clusterings
    ## p-value: permutation test (n=1000) with null hypothesis ARI=0
    ## 
    ## ______________________________
    ## Graphlet Correlation Distance
    ## `````````````````````````````
    ##         wholeNet         LCC  
    ## GCD        2.372       4.221  
    ## p-value 0.161000    0.300000  
    ## -----
    ## GCD >= 0 (GCD=0 indicates perfect agreement between GCMs)
    ## p-value: permutation test with null hypothesis GCD=0
    ## 
    ## ______________________________
    ## Centrality measures
    ## - In decreasing order
    ## - Centrality of disconnected components is zero
    ## ````````````````````````````````````````````````
    ## Degree (unnormalized):
    ##                          EBF = 0 EBF >= 2 abs.diff. adj.p-value    
    ## Coprobacillus                  0       32        32    0.048000 *  
    ## Leuconostoc                    0       13        13    0.016000 *  
    ## Family_XIII_AD3011_group       3       12         9    0.521000    
    ## Faecalicoccus                  0        9         9    0.156000    
    ## Faecalitalea                   0        8         8    0.182000    
    ## 
    ## Betweenness centrality (unnormalized):
    ##                          EBF = 0 EBF >= 2 abs.diff. adj.p-value    
    ## Coprobacillus                  0     1936      1936    0.003549 ** 
    ## Family_XIII_AD3011_group      11      690       679    0.108000    
    ## Peptoniphilus                  0      610       610    0.004121 ** 
    ## Varibaculum                    0      594       594    0.003000 ** 
    ## Rothia                         0      536       536    0.002000 ** 
    ## 
    ## Closeness centrality (unnormalized):
    ##               EBF = 0 EBF >= 2 abs.diff. adj.p-value    
    ## Coprobacillus       0   76.861    76.861    0.099038 .  
    ## Leuconostoc         0   59.065    59.065    0.077189 .  
    ## Faecalicoccus       0   54.892    54.892    0.180000    
    ## Faecalitalea        0   53.778    53.778    0.206000    
    ## Epulopiscium        0   53.335    53.335    0.144000    
    ## 
    ## _________________________________________________________
    ## Significance codes: ***: 0.001, **: 0.01, *: 0.05, .: 0.1

    ## 
    ## Comparison of Network Properties
    ## ----------------------------------
    ## CALL: 
    ## netCompare(x = props_ebf_perm, permTest = TRUE, verbose = TRUE, 
    ##     nPerm = n_perm_network_comparison, refinePermPvals = TRUE, 
    ##     permApproxParams = list(method = "gpd", gpd_ctrl = gpd_ctrl), 
    ##     adjust = "BH", cores = cores, seed = permutation_seed, fileLoadAssoPerm = path_perm("assoPerm_ebf"))
    ## 
    ## ______________________________
    ## Global network properties
    ## `````````````````````````
    ## Largest connected component (LCC):
    ##                          EBF = 0   EBF >= 2    abs.diff.     p-value  
    ## Relative LCC size          0.068      0.650        0.581    0.347000  
    ## Clustering coefficient     0.336      0.440        0.105    0.623000  
    ## Modularity                 0.369      0.535        0.166    0.353000  
    ## Positive edge percentage 100.000     94.558        5.442    0.377000  
    ## Edge density               0.286      0.052        0.234    0.210000  
    ## Natural connectivity       0.192      0.019        0.173    0.133000  
    ## Vertex connectivity        1.000      1.000        0.000    1.000000  
    ## Edge connectivity          1.000      1.000        0.000    1.000000  
    ## Average dissimilarity*     0.895      0.981        0.086    0.207000  
    ## Average path length**      1.744      2.458        0.715    0.361000  
    ## 
    ## Whole network:
    ##                          EBF = 0   EBF >= 2    abs.diff.     p-value  
    ## Number of components      90.000     35.000       55.000    0.262000  
    ## Clustering coefficient     0.408      0.433        0.025    0.908000  
    ## Modularity                 0.840      0.565        0.275    0.443000  
    ## Positive edge percentage 100.000     94.805        5.195    0.259000  
    ## Edge density               0.005      0.023        0.018    0.461000  
    ## Natural connectivity       0.009      0.011        0.002    0.543000  
    ## -----
    ## p-values: one-tailed test with null hypothesis diff=0
    ##  *: Dissimilarity = 1 - edge weight
    ## **: Path length = Units with average dissimilarity
    ## 
    ## ______________________________
    ## Jaccard index (similarity betw. sets of most central nodes)
    ## ```````````````````````````````````````````````````````````
    ##                     Jacc   P(<=Jacc)     P(>=Jacc)   
    ## degree             0.130    0.026475 *    0.993250   
    ## betweenness centr. 0.065    0.000462 ***  0.999943   
    ## closeness centr.   0.121    0.005237 **   0.998715   
    ## eigenvec. centr.   0.121    0.005237 **   0.998715   
    ## hub taxa           0.091    0.075147 .    0.988439   
    ## -----
    ## Jaccard index in [0,1] (1 indicates perfect agreement)
    ## 
    ## ______________________________
    ## Adjusted Rand index (similarity betw. clusterings)
    ## ``````````````````````````````````````````````````
    ##         wholeNet       LCC
    ## ARI        0.002     0.031
    ## p-value 0.913087  0.023976
    ## -----
    ## ARI in [-1,1] with ARI=1: perfect agreement betw. clusterings
    ##                    ARI=0: expected for two random clusterings
    ## p-value: permutation test (n=1000) with null hypothesis ARI=0
    ## 
    ## ______________________________
    ## Graphlet Correlation Distance
    ## `````````````````````````````
    ##         wholeNet         LCC  
    ## GCD        2.372       4.221  
    ## p-value 0.161000    0.300000  
    ## -----
    ## GCD >= 0 (GCD=0 indicates perfect agreement between GCMs)
    ## p-value: permutation test with null hypothesis GCD=0
    ## 
    ## ______________________________
    ## Centrality measures
    ## - In decreasing order
    ## - Centrality of disconnected components is zero
    ## ````````````````````````````````````````````````
    ## Degree (unnormalized):
    ##                          EBF = 0 EBF >= 2 abs.diff. adj.p-value  
    ## Coprobacillus                  0       32        32    1.000000  
    ## Leuconostoc                    0       13        13    1.000000  
    ## Family_XIII_AD3011_group       3       12         9    1.000000  
    ## Faecalicoccus                  0        9         9    1.000000  
    ## Faecalitalea                   0        8         8    1.000000  
    ## 
    ## Betweenness centrality (unnormalized):
    ##                          EBF = 0 EBF >= 2 abs.diff. adj.p-value  
    ## Coprobacillus                  0     1936      1936    0.120527  
    ## Family_XIII_AD3011_group      11      690       679    1.000000  
    ## Peptoniphilus                  0      610       610    0.120527  
    ## Varibaculum                    0      594       594    0.120527  
    ## Rothia                         0      536       536    0.120527  
    ## 
    ## Closeness centrality (unnormalized):
    ##               EBF = 0 EBF >= 2 abs.diff. adj.p-value  
    ## Coprobacillus       0   76.861    76.861    0.715565  
    ## Leuconostoc         0   59.065    59.065    0.715565  
    ## Faecalicoccus       0   54.892    54.892    0.715565  
    ## Faecalitalea        0   53.778    53.778    0.715565  
    ## Epulopiscium        0   53.335    53.335    0.715565  
    ## 
    ## _________________________________________________________
    ## Significance codes: ***: 0.001, **: 0.01, *: 0.05, .: 0.1

### permApprox Refinement With Constraint

    ## 
    ## Comparison of Network Properties
    ## ----------------------------------
    ## CALL: 
    ## netCompare(x = props_ebf_perm, permTest = TRUE, verbose = TRUE, 
    ##     nPerm = n_perm_network_comparison, refinePermPvals = TRUE, 
    ##     permApproxParams = list(method = "gpd", gpd_ctrl = gpd_ctrl), 
    ##     adjust = "none", cores = cores, seed = permutation_seed, 
    ##     fileLoadAssoPerm = path_perm("assoPerm_ebf"))
    ## 
    ## ______________________________
    ## Global network properties
    ## `````````````````````````
    ## Largest connected component (LCC):
    ##                          EBF = 0   EBF >= 2    abs.diff.     p-value  
    ## Relative LCC size          0.068      0.650        0.581    0.347000  
    ## Clustering coefficient     0.336      0.440        0.105    0.623000  
    ## Modularity                 0.369      0.535        0.166    0.353000  
    ## Positive edge percentage 100.000     94.558        5.442    0.377000  
    ## Edge density               0.286      0.052        0.234    0.210000  
    ## Natural connectivity       0.192      0.019        0.173    0.133000  
    ## Vertex connectivity        1.000      1.000        0.000    1.000000  
    ## Edge connectivity          1.000      1.000        0.000    1.000000  
    ## Average dissimilarity*     0.895      0.981        0.086    0.207000  
    ## Average path length**      1.744      2.458        0.715    0.361000  
    ## 
    ## Whole network:
    ##                          EBF = 0   EBF >= 2    abs.diff.     p-value  
    ## Number of components      90.000     35.000       55.000    0.262000  
    ## Clustering coefficient     0.408      0.433        0.025    0.908000  
    ## Modularity                 0.840      0.565        0.275    0.443000  
    ## Positive edge percentage 100.000     94.805        5.195    0.259000  
    ## Edge density               0.005      0.023        0.018    0.461000  
    ## Natural connectivity       0.009      0.011        0.002    0.543000  
    ## -----
    ## p-values: one-tailed test with null hypothesis diff=0
    ##  *: Dissimilarity = 1 - edge weight
    ## **: Path length = Units with average dissimilarity
    ## 
    ## ______________________________
    ## Jaccard index (similarity betw. sets of most central nodes)
    ## ```````````````````````````````````````````````````````````
    ##                     Jacc   P(<=Jacc)     P(>=Jacc)   
    ## degree             0.130    0.026475 *    0.993250   
    ## betweenness centr. 0.065    0.000462 ***  0.999943   
    ## closeness centr.   0.121    0.005237 **   0.998715   
    ## eigenvec. centr.   0.121    0.005237 **   0.998715   
    ## hub taxa           0.091    0.075147 .    0.988439   
    ## -----
    ## Jaccard index in [0,1] (1 indicates perfect agreement)
    ## 
    ## ______________________________
    ## Adjusted Rand index (similarity betw. clusterings)
    ## ``````````````````````````````````````````````````
    ##         wholeNet       LCC
    ## ARI        0.002     0.031
    ## p-value 0.913087  0.023976
    ## -----
    ## ARI in [-1,1] with ARI=1: perfect agreement betw. clusterings
    ##                    ARI=0: expected for two random clusterings
    ## p-value: permutation test (n=1000) with null hypothesis ARI=0
    ## 
    ## ______________________________
    ## Graphlet Correlation Distance
    ## `````````````````````````````
    ##         wholeNet         LCC  
    ## GCD        2.372       4.221  
    ## p-value 0.161000    0.300000  
    ## -----
    ## GCD >= 0 (GCD=0 indicates perfect agreement between GCMs)
    ## p-value: permutation test with null hypothesis GCD=0
    ## 
    ## ______________________________
    ## Centrality measures
    ## - In decreasing order
    ## - Centrality of disconnected components is zero
    ## ````````````````````````````````````````````````
    ## Degree (unnormalized):
    ##                          EBF = 0 EBF >= 2 abs.diff. adj.p-value    
    ## Coprobacillus                  0       32        32    0.048000 *  
    ## Leuconostoc                    0       13        13    0.016000 *  
    ## Family_XIII_AD3011_group       3       12         9    0.521000    
    ## Faecalicoccus                  0        9         9    0.156000    
    ## Faecalitalea                   0        8         8    0.182000    
    ## 
    ## Betweenness centrality (unnormalized):
    ##                          EBF = 0 EBF >= 2 abs.diff. adj.p-value    
    ## Coprobacillus                  0     1936      1936    0.003549 ** 
    ## Family_XIII_AD3011_group      11      690       679    0.108000    
    ## Peptoniphilus                  0      610       610    0.004121 ** 
    ## Varibaculum                    0      594       594    0.003000 ** 
    ## Rothia                         0      536       536    0.002000 ** 
    ## 
    ## Closeness centrality (unnormalized):
    ##               EBF = 0 EBF >= 2 abs.diff. adj.p-value    
    ## Coprobacillus       0   76.861    76.861    0.096209 .  
    ## Leuconostoc         0   59.065    59.065    0.074274 .  
    ## Faecalicoccus       0   54.892    54.892    0.180000    
    ## Faecalitalea        0   53.778    53.778    0.206000    
    ## Epulopiscium        0   53.335    53.335    0.144000    
    ## 
    ## _________________________________________________________
    ## Significance codes: ***: 0.001, **: 0.01, *: 0.05, .: 0.1

    ## 
    ## Comparison of Network Properties
    ## ----------------------------------
    ## CALL: 
    ## netCompare(x = props_ebf_perm, permTest = TRUE, verbose = TRUE, 
    ##     nPerm = n_perm_network_comparison, refinePermPvals = TRUE, 
    ##     permApproxParams = list(method = "gpd", gpd_ctrl = gpd_ctrl), 
    ##     adjust = "BH", cores = cores, seed = permutation_seed, fileLoadAssoPerm = path_perm("assoPerm_ebf"))
    ## 
    ## ______________________________
    ## Global network properties
    ## `````````````````````````
    ## Largest connected component (LCC):
    ##                          EBF = 0   EBF >= 2    abs.diff.     p-value  
    ## Relative LCC size          0.068      0.650        0.581    0.347000  
    ## Clustering coefficient     0.336      0.440        0.105    0.623000  
    ## Modularity                 0.369      0.535        0.166    0.353000  
    ## Positive edge percentage 100.000     94.558        5.442    0.377000  
    ## Edge density               0.286      0.052        0.234    0.210000  
    ## Natural connectivity       0.192      0.019        0.173    0.133000  
    ## Vertex connectivity        1.000      1.000        0.000    1.000000  
    ## Edge connectivity          1.000      1.000        0.000    1.000000  
    ## Average dissimilarity*     0.895      0.981        0.086    0.207000  
    ## Average path length**      1.744      2.458        0.715    0.361000  
    ## 
    ## Whole network:
    ##                          EBF = 0   EBF >= 2    abs.diff.     p-value  
    ## Number of components      90.000     35.000       55.000    0.262000  
    ## Clustering coefficient     0.408      0.433        0.025    0.908000  
    ## Modularity                 0.840      0.565        0.275    0.443000  
    ## Positive edge percentage 100.000     94.805        5.195    0.259000  
    ## Edge density               0.005      0.023        0.018    0.461000  
    ## Natural connectivity       0.009      0.011        0.002    0.543000  
    ## -----
    ## p-values: one-tailed test with null hypothesis diff=0
    ##  *: Dissimilarity = 1 - edge weight
    ## **: Path length = Units with average dissimilarity
    ## 
    ## ______________________________
    ## Jaccard index (similarity betw. sets of most central nodes)
    ## ```````````````````````````````````````````````````````````
    ##                     Jacc   P(<=Jacc)     P(>=Jacc)   
    ## degree             0.130    0.026475 *    0.993250   
    ## betweenness centr. 0.065    0.000462 ***  0.999943   
    ## closeness centr.   0.121    0.005237 **   0.998715   
    ## eigenvec. centr.   0.121    0.005237 **   0.998715   
    ## hub taxa           0.091    0.075147 .    0.988439   
    ## -----
    ## Jaccard index in [0,1] (1 indicates perfect agreement)
    ## 
    ## ______________________________
    ## Adjusted Rand index (similarity betw. clusterings)
    ## ``````````````````````````````````````````````````
    ##         wholeNet       LCC
    ## ARI        0.002     0.031
    ## p-value 0.913087  0.023976
    ## -----
    ## ARI in [-1,1] with ARI=1: perfect agreement betw. clusterings
    ##                    ARI=0: expected for two random clusterings
    ## p-value: permutation test (n=1000) with null hypothesis ARI=0
    ## 
    ## ______________________________
    ## Graphlet Correlation Distance
    ## `````````````````````````````
    ##         wholeNet         LCC  
    ## GCD        2.372       4.221  
    ## p-value 0.161000    0.300000  
    ## -----
    ## GCD >= 0 (GCD=0 indicates perfect agreement between GCMs)
    ## p-value: permutation test with null hypothesis GCD=0
    ## 
    ## ______________________________
    ## Centrality measures
    ## - In decreasing order
    ## - Centrality of disconnected components is zero
    ## ````````````````````````````````````````````````
    ## Degree (unnormalized):
    ##                          EBF = 0 EBF >= 2 abs.diff. adj.p-value  
    ## Coprobacillus                  0       32        32    1.000000  
    ## Leuconostoc                    0       13        13    1.000000  
    ## Family_XIII_AD3011_group       3       12         9    1.000000  
    ## Faecalicoccus                  0        9         9    1.000000  
    ## Faecalitalea                   0        8         8    1.000000  
    ## 
    ## Betweenness centrality (unnormalized):
    ##                          EBF = 0 EBF >= 2 abs.diff. adj.p-value  
    ## Coprobacillus                  0     1936      1936    0.120527  
    ## Family_XIII_AD3011_group      11      690       679    1.000000  
    ## Peptoniphilus                  0      610       610    0.120527  
    ## Varibaculum                    0      594       594    0.120527  
    ## Rothia                         0      536       536    0.120527  
    ## 
    ## Closeness centrality (unnormalized):
    ##               EBF = 0 EBF >= 2 abs.diff. adj.p-value  
    ## Coprobacillus       0   76.861    76.861    0.715565  
    ## Leuconostoc         0   59.065    59.065    0.715565  
    ## Faecalicoccus       0   54.892    54.892    0.715565  
    ## Faecalitalea        0   53.778    53.778    0.715565  
    ## Epulopiscium        0   53.335    53.335    0.715565  
    ## 
    ## _________________________________________________________
    ## Significance codes: ***: 0.001, **: 0.01, *: 0.05, .: 0.1

## Permutation-Based Differential Association Analysis

Differential association analysis is performed with `diffnet()` on the
selected network and the same stored permutation association matrices.

### Empirical P-Values

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   0.001   0.199   0.467   0.477   0.753   1.000

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##  0.2828  0.7937  0.9337  0.8715  0.9981  1.0000

    ## There are no differential correlations to plot (after multiple testing adjustment).

### permApprox Refinement Without Constraint

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   0.000   0.199   0.467   0.477   0.753   1.000

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##  0.0000  0.7937  0.9337  0.8702  0.9981  1.0000

![](figures/11_network_comparison/net_plot_diffnet_main_BH-1.png)<!-- -->

### permApprox Refinement With Constraint

    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ## 2.69e-06 1.99e-01 4.67e-01 4.77e-01 7.53e-01 1.00e+00

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ## 0.01827 0.79368 0.93372 0.87098 0.99809 1.00000

## Raw P-Value Comparison

This section compares unadjusted p-values from empirical permutation
testing, unconstrained `permApprox` refinement, and constrained
`permApprox` refinement.

### diffnet P-Values

    ## # A tibble: 3 × 7
    ##   method            n        min   q25 median   q75   max
    ##   <chr>         <int>      <dbl> <dbl>  <dbl> <dbl> <dbl>
    ## 1 constrained    6786 0.00000269 0.199  0.467 0.753     1
    ## 2 empirical      6786 0.001      0.199  0.467 0.753     1
    ## 3 unconstrained  6786 0          0.199  0.467 0.753     1

![](figures/11_network_comparison/net_diffnet_raw_pvalue_comparison-1.png)<!-- -->

### netCompare Centrality P-Values

    ## # A tibble: 12 × 8
    ##    measure     method            n    min   q25 median   q75   max
    ##    <chr>       <chr>         <int>  <dbl> <dbl>  <dbl> <dbl> <dbl>
    ##  1 betweenness constrained     117 0.002  0.441  1         1     1
    ##  2 betweenness empirical       117 0.002  0.441  1         1     1
    ##  3 betweenness unconstrained   117 0.002  0.441  1         1     1
    ##  4 closeness   constrained     117 0.042  0.294  0.388     1     1
    ##  5 closeness   empirical       117 0.042  0.294  0.388     1     1
    ##  6 closeness   unconstrained   117 0.042  0.294  0.388     1     1
    ##  7 degree      constrained     117 0.016  0.345  0.66      1     1
    ##  8 degree      empirical       117 0.016  0.345  0.66      1     1
    ##  9 degree      unconstrained   117 0.016  0.345  0.66      1     1
    ## 10 eigenvector constrained     117 0.0226 0.293  0.531     1     1
    ## 11 eigenvector empirical       117 0.02   0.293  0.531     1     1
    ## 12 eigenvector unconstrained   117 0.0205 0.293  0.531     1     1

![](figures/11_network_comparison/net_netcompare_centrality_raw_pvalue_comparison-1.png)<!-- -->

## Files Written

    ## # A tibble: 244 × 4
    ##    path                            type         size modification_time  
    ##    <fs::path>                      <fct> <fs::bytes> <dttm>             
    ##  1 comp_ebf_main.rds               file      180.95K 2026-06-25 10:03:18
    ##  2 counts_ebf_rel_bayesMult.rds    file      722.02K 2026-06-27 08:17:18
    ##  3 net_ebf_corshrink_bayesMult.rds file        1.08M 2026-06-27 11:00:00
    ##  4 net_ebf_corshrink_multRepl.rds  file      620.74K 2026-06-27 13:50:38
    ##  5 net_ebf_main.rds                file        20.8M 2026-06-27 11:05:31
    ##  6 net_ebf_rhoshrink_bayesMult.rds file        1.49M 2026-06-27 10:43:59
    ##  7 net_ebf_rhoshrink_multRepl.rds  file      916.18K 2026-06-27 12:11:52
    ##  8 net_ebf_slr_r2.rds              file       75.55M 2026-06-27 08:36:00
    ##  9 net_ebf_spieceasi.rds           file        20.8M 2026-06-26 10:59:56
    ## 10 net_ebf_spieceasi_bayesMult.rds file       25.73M 2026-06-27 10:05:27
    ## # ℹ 234 more rows

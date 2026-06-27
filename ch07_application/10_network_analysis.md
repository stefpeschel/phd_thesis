Network analysis
================
Compiled at 2026-06-27 05:40:58 UTC

## Aim

This script contains the network analyses for the application chapter.
The first part builds one complete network on the filtered genus-level
data and evaluates how sensitive the resulting network is to common
preprocessing and association choices. The complete-network analysis
will compare the standard preprocessing approach with the final method
used in this thesis, and then vary one component at a time: zero
replacement, normalization, and association measure.

The second part will compare networks between the two main exclusive
breastfeeding groups used throughout this chapter, `EBF duration = 0`
and `EBF duration >=2`. The network-comparison analysis will contrast
the classical empirical permutation results with `permApprox`-refined
p-values. For the `permApprox` analysis we will fit both the
unconstrained approximation and the proposed constrained version, so
that the unconstrained fit can be used to inspect how many zero-valued
permutation statistics would be expected without the constraint.

## Set global parameters

## Load data

### Phyloseq object on genus level

    ## phyloseq-class experiment-level object
    ## otu_table()   OTU Table:         [ 117 taxa and 592 samples ]
    ## sample_data() Sample Data:       [ 592 samples by 9 sample variables ]
    ## tax_table()   Taxonomy Table:    [ 117 taxa by 7 taxonomic ranks ]

## Helper functions

## Prepare data

The network analyses use the same filtered genus-level object as the
differential abundance and differential distribution analyses. Counts
are represented as a samples-by-taxa matrix. Relative abundances are
prepared here because several network workflows use them directly.

Since SpiecEasi does only provide pseudo count zero replacement, we need
to apply zero replacement with multRepl beforehand.

    ## # A tibble: 1 × 7
    ##   n_samples n_taxa min_library_size median_library_size max_library_size zero_fraction_orig zero_fraction_repl
    ##       <int>  <int>            <dbl>               <dbl>            <dbl>              <dbl>              <dbl>
    ## 1       592    117             1456              21898.            69556              0.796                  0

Value imputed by multiplicative replacement: 1.8689976^{-5}.

Rename taxonomic table and make rank Genus unique.

    ## Column 7 contains NAs only and is ignored.

## Define taxa to label

In the respective network plots, the following taxa are labelled:

- Highly abundant taxa
- Taxa that appeared in the differential association analysis as well as
  the differential distribution analysis
- Most central genera with respect to eigenvector centrality in the
  respective network
- The three genera with a negative correlation to Bifidobacterium in the
  baseline network

## Baseline network with standard preprocessing

This section will estimate the complete genus-level network using the
final preprocessing and association pipeline selected for the thesis.
The resulting object should be saved to the target directory and reused
by downstream summary tables and figures.

The preprocessing approach used throughout the thesis is:

1.  Transform counts to relative abundances
2.  Perform multiplicative zero replacement
3.  Perform CLR transformation

### Network construction

### Network analysis

#### Association heatmap

**For all taxa**

![](figures/10_network_analysis/net_single_association_heatmap-1.png)<!-- -->

**For non-singletons only**

![](figures/10_network_analysis/net_single_association_heatmap_nonzero-1.png)<!-- -->

#### Association histogram

![](figures/10_network_analysis/net_single_association_histrogram-1.png)<!-- -->

    ## Entries in the lower triangle: 6786

    ## 
    ## Non-zero entries in the lower triangle: 124

#### Degree distribution

![](figures/10_network_analysis/net_single_degree_distribution-1.png)<!-- -->

#### Analysis with netAnalyze()

    ## 
    ## Component sizes
    ## ```````````````               
    ## size: 67 7 2  1
    ##    #:  1 1 6 31
    ## ______________________________
    ## Global network properties
    ## `````````````````````````
    ## Largest connected component (LCC):
    ##                                  
    ## Relative LCC size         0.57265
    ## Clustering coefficient    0.29647
    ## Modularity                0.52002
    ## Positive edge percentage 92.72727
    ## Edge density              0.04975
    ## Natural connectivity      0.01905
    ## Vertex connectivity       1.00000
    ## Edge connectivity         1.00000
    ## Average dissimilarity*    0.98455
    ## Average path length**     2.32219
    ## 
    ## Whole network:
    ##                                  
    ## Number of components     39.00000
    ## Clustering coefficient    0.26493
    ## Modularity                0.59308
    ## Positive edge percentage 93.54839
    ## Edge density              0.01827
    ## Natural connectivity      0.01006
    ## -----
    ## *: Dissimilarity = 1 - edge weight
    ## **: Path length = Units with average dissimilarity
    ## 
    ## ______________________________
    ## Clusters
    ## - In the whole network
    ## - Algorithm: cluster_fast_greedy
    ## ```````````````````````````````` 
    ##                                               
    ## name:  0 1  2 3  4 5 6 7 8 9 10 11 12 13 14 15
    ##    #: 31 9 16 4 19 9 4 7 3 3  2  2  2  2  2  2
    ## 
    ## ______________________________
    ## Hubs
    ## - In alphabetical/numerical order
    ## - Based on empirical quantiles of centralities
    ## ```````````````````````````````````````````````                             
    ##  8_Comamonadaceae(F)         
    ##  Blastococcus                
    ##  Brevundimonas               
    ##  Lachnospira                 
    ##  Lachnospiraceae_ND3007_group
    ##  Stenotrophomonas            
    ## 
    ## ______________________________
    ## Centrality measures
    ## - In decreasing order
    ## - Centrality of disconnected components is zero
    ## ````````````````````````````````````````````````
    ## Degree (unnormalized):
    ##                                 
    ## Lachnospiraceae_ND3007_group  23
    ## Stenotrophomonas              14
    ## 8_Comamonadaceae(F)           10
    ## Blastococcus                   9
    ## Fenollaria                     8
    ## Christensenellaceae_R-7_group  7
    ## Pseudomonas                    7
    ## Brevundimonas                  6
    ## Porphyromonas                  6
    ## Monoglobus                     6
    ## 
    ## Betweenness centrality (unnormalized):
    ##                                   
    ## Lachnospiraceae_ND3007_group  1384
    ## Stenotrophomonas               528
    ## 8_Comamonadaceae(F)            238
    ## Fenollaria                     194
    ## Bifidobacterium                192
    ## Phascolarctobacterium          189
    ## Monoglobus                     184
    ## Peptostreptococcus             175
    ## Lachnospiraceae_NK4A136_group  164
    ## Blastococcus                   137
    ## 
    ## Closeness centrality (unnormalized):
    ##                                      
    ## Lachnospiraceae_ND3007_group 59.96977
    ## Stenotrophomonas             50.60785
    ## 8_Comamonadaceae(F)          47.41856
    ## Blastococcus                 46.53516
    ## Fenollaria                   44.32539
    ## Pseudomonas                  43.96794
    ## Lachnospira                  43.32065
    ## Brevundimonas                43.08809
    ## Porphyromonas                41.66311
    ## Lachnoanaerobaculum          41.43020
    ## 
    ## Eigenvector centrality (unnormalized):
    ##                                     
    ## Lachnospiraceae_ND3007_group 0.46266
    ## Stenotrophomonas             0.34617
    ## Blastococcus                 0.32518
    ## 8_Comamonadaceae(F)          0.32387
    ## Lachnospira                  0.25236
    ## Brevundimonas                0.23924
    ## Pseudomonas                  0.23011
    ## Lachnoanaerobaculum          0.21844
    ## Porphyromonas                0.21102
    ## Fenollaria                   0.21002

### Graphlet correlation matrix

![](figures/10_network_analysis/net_single_gcm-1.png)<!-- -->

### Network plot

In the network plot, the following taxa are labelled:

- Highly abundant genera
- Genera that appeared in the differential association analysis as well
  as the differential distribution analysis.
- Most central genera with respect to eigenvector centrality.
- The three genera with a negative correlation to Bifidobacterium

#### Node colors: clusters; node size: eigenvector centrality

![](figures/10_network_analysis/net_single_net_plot_basic-1.png)<!-- -->

We store this layout as main layout.

#### Nodes colored by phyla

    ## phyla
    ##  Actinobacteriota      Bacteroidota  Desulfobacterota        Firmicutes    Fusobacteriota    Proteobacteria 
    ##                19                 6                 1                75                 1                14 
    ## Verrucomicrobiota 
    ##                 1

![](figures/10_network_analysis/net_single_net_plot_col_phyla-1.png)<!-- -->

**Add labels or further highly abundant taxa and improve layout**

![](figures/10_network_analysis/net_single_net_plot_baseline-1.png)<!-- -->

![](figures/10_network_analysis/net_single_net_plot_baseline_nolabs-1.png)<!-- -->

## Alternative preprocessing steps

In this section we analyze, how the network changes when alternative
preprocessing steps like filtering or zero replacement, or a different
association measure is used.

### Stronger filtering

In the network above, a prevalence filter of 1% was used. We now
increase this to 5% and 10%. Everything else stays the same.

#### 5% prevalence filter

    ## [1] 58 58

![](figures/10_network_analysis/net_single_net_plot_prev05-1.png)<!-- -->

![](figures/10_network_analysis/net_single_net_plot_prev05_nolabs-1.png)<!-- -->

#### 10% prevalence filter

    ## [1] 41 41

![](figures/10_network_analysis/net_single_net_plot_prev10-1.png)<!-- -->

![](figures/10_network_analysis/net_single_net_plot_prev10_nolabs-1.png)<!-- -->

### Different zero replacement

In this section, we construct the network with the following zero
replacement methods:

- pseudo count added to all counts (as example for what is not
  recommended)
- multiplicative replacement with sample-wise detection limits
- random pseudo counts below the detection limit
- alrEM
- Bayesian-multiplicative replacement

For all methods, zero replacement is applied externally via
`compute_zero_repl_clr()` before passing the result to `netConstruct()`
with `zeroMethod = "none"`. This ensures the stored `countMat1` in each
network object reflects the actual zero-treated data, so that CLR-based
node sizes are computed from the correct matrix (see analysis of node
size behaviour above).

Unlike the baseline multiplicative replacement, which uses one global
detection limit, the sample-wise variant defines the detection limit
separately for each sample. This reflects that the smallest observable
relative abundance depends on the sample’s sequencing depth. It may
therefore be more realistic for sampling zeros, but it can also
introduce library-size-dependent variation into the CLR-transformed
data. We therefore consider it as a sensitivity analysis rather than
replacing the baseline preprocessing.

**Minimum relative count and multRepl replacement value for reference**

    ## [1] 2.875381e-05

    ## [1] 1.868998e-05

We use 2e-5 as pseudo count to have a round number close to the multRepl
replacement value.

#### Prepare zero-replaced matrices

#### Additive pseudo count

![](figures/10_network_analysis/net_single_net_plot_zero_pseudo-1.png)<!-- -->

![](figures/10_network_analysis/net_single_net_plot_zero_pseudo_nolabs-1.png)<!-- -->

#### Multiplicative replacement with sample-wise detection limit

    ## # A tibble: 2 × 2
    ##   method                      n_edges
    ##   <chr>                         <int>
    ## 1 Global detection limit          124
    ## 2 Sample-wise detection limit     188

![](figures/10_network_analysis/net_single_net_plot_zero_multrepl_sample-1.png)<!-- -->

![](figures/10_network_analysis/net_single_net_plot_zero_multrepl_sample_nolabs-1.png)<!-- -->

#### Random pseudo counts

![](figures/10_network_analysis/net_single_net_plot_zero_random-1.png)<!-- -->

![](figures/10_network_analysis/net_single_net_plot_zero_random_nolabs-1.png)<!-- -->

#### Modified EM ALR algorithm

![](figures/10_network_analysis/net_single_net_plot_zero_alrEM-1.png)<!-- -->

![](figures/10_network_analysis/net_single_net_plot_zero_alrEM_nolabs-1.png)<!-- -->

#### Bayesian-multiplicative replacement

![](figures/10_network_analysis/net_single_net_plot_zero_bayesMult-1.png)<!-- -->

![](figures/10_network_analysis/net_single_net_plot_zero_bayesMult_nolabs-1.png)<!-- -->

### Different association estimation method

Finally, we will also investigate how the network would look like for
different association estimation methods. Here, we consider the
following alternatives:

- Sparse + low-rank decomposition (SPIEC-EASI slr)
- SPRING

#### Sparse + low-rank decomposition (SPIEC-EASI slr)

##### Find optimal rank

    ##   r opt_ind    lambda edges      BIC
    ## 1 2      10 0.2804681   175 62054.67
    ## 3 4      10 0.2804681   130 62571.76
    ## 2 3      10 0.2804681   174 62655.78
    ## 4 5      10 0.2804681   101 62679.08

    ## Optimal r: 2

##### Plot low rank heatmaps

![](figures/10_network_analysis/net_slr_low_rank_heatmaps-1.png)<!-- -->

##### Continue with optimal rank

![](figures/10_network_analysis/net_slr_decomposition_sparse_lowrank-1.png)<!-- -->

##### Network plot

![](figures/10_network_analysis/net_single_net_plot_slr-1.png)<!-- -->

![](figures/10_network_analysis/net_single_net_plot_slr_slrlay-1.png)<!-- -->

![](figures/10_network_analysis/net_single_net_plot_slr_slrlay_nolabs-1.png)<!-- -->

![](figures/10_network_analysis/net_single_net_plot_slr_nolabs-1.png)<!-- -->

#### Sparse + low rank (unsigned)

![](figures/10_network_analysis/net_single_net_plot_slr_us-1.png)<!-- -->

#### SPRING

![](figures/10_network_analysis/net_single_net_plot_spring-1.png)<!-- -->

![](figures/10_network_analysis/net_single_net_plot_spring_ownlay-1.png)<!-- -->

![](figures/10_network_analysis/net_single_net_plot_spring_nolabs-1.png)<!-- -->

![](figures/10_network_analysis/net_single_net_plot_spring_slrlay_nolabs-1.png)<!-- -->

#### SPRING (unsigned)

![](figures/10_network_analysis/net_single_net_plot_spring_us-1.png)<!-- -->

![](figures/10_network_analysis/net_single_net_plot_spring_us_nolabs-1.png)<!-- -->

#### Shrinkage proportionality

    ## Checking input arguments ... Done.
    ## 117 taxa and 592 samples remaining.
    ## 
    ## Zero treatment:
    ## Data contains no zeros.
    ## 
    ## Calculate 'rhoshrink' associations ... Done.

![](figures/10_network_analysis/net_single_rhoshrink_histrogram-1.png)<!-- -->

![](figures/10_network_analysis/net_single_net_plot_rhoshrink-1.png)<!-- -->

![](figures/10_network_analysis/net_single_net_plot_rhoshrink_nolabs-1.png)<!-- -->

## Summary of edge overlap

The following UpSet-style plots compare the edge sets of the networks
shown above. Edges are encoded as present or absent based on the
adjacency matrix. For this summary, only the signed versions of the
networks are included.

### Prevalence filtering

![](figures/10_network_analysis/net_edge_upset_prevalence-1.png)<!-- -->

![](figures/10_network_analysis/net_edge_upset_prevalence8-1.png)<!-- -->

### Zero replacement

![](figures/10_network_analysis/net_edge_upset_zero_replacement-1.png)<!-- -->

![](figures/10_network_analysis/net_edge_upset_zero_replacement8-1.png)<!-- -->

### Association measure

![](figures/10_network_analysis/net_edge_upset_association-1.png)<!-- -->

![](figures/10_network_analysis/net_edge_upset_association8-1.png)<!-- -->

## Persistent edges across selected networks

The following summary uses a selected set of signed networks and
identifies taxa-pairs that are connected in all of them.

<table class="table" style="color: black; width: auto !important; margin-left: auto; margin-right: auto;">

<caption>

Taxa-pairs connected in all selected signed networks.
</caption>

<thead>

<tr>

<th style="text-align:left;">

Taxon 1
</th>

<th style="text-align:left;">

Taxon 2
</th>

<th style="text-align:right;">

Networks
</th>

<th style="text-align:right;">

Mean association
</th>

<th style="text-align:right;">

Minimum
</th>

<th style="text-align:right;">

Maximum
</th>

<th style="text-align:right;">

Mean absolute association
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

Bacteroides
</td>

<td style="text-align:left;">

Parabacteroides
</td>

<td style="text-align:right;">

8
</td>

<td style="text-align:right;">

0.220
</td>

<td style="text-align:right;">

0.163
</td>

<td style="text-align:right;">

0.356
</td>

<td style="text-align:right;">

0.220
</td>

</tr>

<tr>

<td style="text-align:left;">

Rothia
</td>

<td style="text-align:left;">

Streptococcus
</td>

<td style="text-align:right;">

8
</td>

<td style="text-align:right;">

0.142
</td>

<td style="text-align:right;">

0.124
</td>

<td style="text-align:right;">

0.176
</td>

<td style="text-align:right;">

0.142
</td>

</tr>

<tr>

<td style="text-align:left;">

Streptococcus
</td>

<td style="text-align:left;">

Veillonella
</td>

<td style="text-align:right;">

8
</td>

<td style="text-align:right;">

0.108
</td>

<td style="text-align:right;">

0.044
</td>

<td style="text-align:right;">

0.158
</td>

<td style="text-align:right;">

0.108
</td>

</tr>

<tr>

<td style="text-align:left;">

Collinsella
</td>

<td style="text-align:left;">

Senegalimassilia
</td>

<td style="text-align:right;">

8
</td>

<td style="text-align:right;">

0.103
</td>

<td style="text-align:right;">

0.052
</td>

<td style="text-align:right;">

0.187
</td>

<td style="text-align:right;">

0.103
</td>

</tr>

<tr>

<td style="text-align:left;">

Staphylococcus
</td>

<td style="text-align:left;">

Streptococcus
</td>

<td style="text-align:right;">

8
</td>

<td style="text-align:right;">

0.102
</td>

<td style="text-align:right;">

0.070
</td>

<td style="text-align:right;">

0.147
</td>

<td style="text-align:right;">

0.102
</td>

</tr>

<tr>

<td style="text-align:left;">

Gemella
</td>

<td style="text-align:left;">

Streptococcus
</td>

<td style="text-align:right;">

8
</td>

<td style="text-align:right;">

0.049
</td>

<td style="text-align:right;">

0.013
</td>

<td style="text-align:right;">

0.097
</td>

<td style="text-align:right;">

0.049
</td>

</tr>

</tbody>

</table>

![](figures/10_network_analysis/net_persistent_edge_network_plot-1.png)<!-- -->

## Files written

These files have been written to the target directory,
`data/10_network_analysis`:

    ## # A tibble: 19 × 4
    ##    path                                type         size modification_time  
    ##    <fs::path>                          <fct> <fs::bytes> <dttm>             
    ##  1 counts_rel_alrEM.rds                file      517.53K 2026-06-25 20:43:46
    ##  2 counts_rel_bayesMult.rds            file      771.33K 2026-06-26 04:43:31
    ##  3 net_single_main.rds                 file       11.16M 2026-06-26 09:25:25
    ##  4 net_single_prev05.rds               file        4.34M 2026-06-25 18:29:13
    ##  5 net_single_prev10.rds               file        3.01M 2026-06-25 18:37:05
    ##  6 net_single_rhoshrink.rds            file      676.81K 2026-06-26 05:56:00
    ##  7 net_single_slr.rds                  file       36.21M 2026-06-26 05:10:10
    ##  8 net_single_slr_r2.rds               file       36.21M 2026-06-26 08:33:17
    ##  9 net_single_slr_r3.rds               file       36.17M 2026-06-26 08:41:55
    ## 10 net_single_slr_r4.rds               file        36.1M 2026-06-26 08:50:32
    ## 11 net_single_slr_r5.rds               file       36.03M 2026-06-26 09:14:35
    ## 12 net_single_slr_us.rds               file       36.21M 2026-06-26 15:51:26
    ## 13 net_single_spring.rds               file        7.73M 2026-06-26 16:24:04
    ## 14 net_single_spring_us.rds            file        7.73M 2026-06-26 16:35:10
    ## 15 net_single_zero_alrEM.rds           file       14.65M 2026-06-25 20:58:35
    ## 16 net_single_zero_bayesMult.rds       file        15.6M 2026-06-25 21:00:47
    ## 17 net_single_zero_multrepl_sample.rds file       11.76M 2026-06-26 21:01:06
    ## 18 net_single_zero_pseudo.rds          file       11.13M 2026-06-25 20:51:27
    ## 19 net_single_zero_random.rds          file       16.82M 2026-06-25 20:56:23

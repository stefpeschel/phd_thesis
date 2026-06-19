Example figures for the methods chapter
================
Compiled at 2026-06-20 11:25:02 UTC

    ## [conflicted] Removing existing preference.
    ## [conflicted] Will prefer dplyr::filter over any other package.
    ## [conflicted] Removing existing preference.
    ## [conflicted] Will prefer dplyr::mutate over any other package.
    ## [conflicted] Removing existing preference.
    ## [conflicted] Will prefer dplyr::select over any other package.

## Introduction

This script collects small, self-contained figures used to illustrate
concepts in the NetCoMi chapter. The examples are meant to be visually
simple rather than data-driven: each figure isolates one methodological
step so that it can be used as explanatory material in the thesis text
or during a presentation.

## Association transformations

The following plot compares signed and unsigned transformations from
sparse associations to dissimilarities and the corresponding
similarities. The signed transformation treats negative associations as
large dissimilarities and small similarities, whereas the unsigned
transformation uses only association strength.

![](figures/example_figures/netcomi_asso_diss_transformation-1.png)<!-- -->

## Centrality measures

The following example uses a modular core-periphery network to
illustrate how different centrality measures highlight different
structural roles. The network contains two subnetworks with different
internal densities, peripheral leaf-like nodes, and one low-degree
bridge node connecting the subnetworks. This structure is kept separate
from the larger graphlet examples below so that the highlighted
centrality roles remain visible.

![](figures/example_figures/netcomi_centrality_measures_network-1.png)<!-- -->

Degree highlights taxa with many direct neighbors, here mainly module
hubs to which several peripheral nodes are attached. Betweenness
emphasizes the low-degree bridge node that lies on shortest paths
between the two subnetworks, even though this node is not highly
connected itself. Closeness favors nodes that are globally well
positioned with respect to the whole network, often near the bridge
between subnetworks. Eigenvector centrality highlights nodes embedded in
central and well-connected neighborhoods, rather than nodes that are
merely bridges, and is therefore higher in the denser subnetwork.

## Standard networks and graphlet correlation matrices

The following examples compare three standard network models with the
same number of nodes as the filtered genus-level data set used in the
application chapter: an Erdos-Renyi graph, a scale-free Barabasi-Albert
graph, and a stochastic block model. The Erdos-Renyi graph is generated
with the same edge count as the stochastic block model. For each graph,
the corresponding graphlet correlation matrix is computed from the
binary adjacency matrix.

### Erdos-Renyi network

The Erdos-Renyi network is used as a random baseline. Edges are placed
without an explicit preference for hubs or modules, so any local
structure arises from chance rather than from an imposed ecological
organization.

![](figures/example_figures/netcomi_network_gcms_ER-1.png)<!-- -->

The GCM shows broadly positive correlations among most graphlet orbits.
This is expected for a random graph of this size and density: nodes with
higher degree also tend to participate more often in many other small
graphlet positions, whereas clear opposing orbit roles are largely
absent.

### Barabasi-Albert network

The Barabasi-Albert network represents a scale-free hub structure. New
nodes preferentially attach to already well-connected nodes, producing a
few hubs and many nodes with low to moderate degree.

![](figures/example_figures/netcomi_network_gcms_BA-1.png)<!-- -->

The GCM has more visible block structure than the random baseline.
Orbits associated with hub participation are highly correlated with each
other. Since the network is generated with two edges for each newly
added node, it contains few or no terminal nodes; the terminal-orbit
group is therefore less pronounced than in ecological networks with many
endpoints.

### Barabasi-Albert network with peripheral leaves

This exploratory variant keeps a scale-free Barabasi-Albert core but
adds degree-one peripheral taxa attached preferentially to hubs. It
therefore combines hub-dominated structure with endpoints, a feature
that is often more plausible for ecological or microbiome networks than
a pure Barabasi-Albert model with `m = 2`.

![](figures/example_figures/netcomi_network_gcms_BA_peripheral-1.png)<!-- -->

Compared with the pure Barabasi-Albert graph, this network should
strengthen the contrast between hub-related orbits and terminal-node
roles. Hubs remain important for orbits associated with degree and
internal graphlet positions, while the added leaves increase counts for
terminal orbits and can make their relationship to the hub-dominated
part of the network easier to see.

![](figures/example_figures/netcomi_network_gcms_BA_peripheral_thesis-1.png)<!-- -->

### Stochastic block model

The stochastic block model represents a modular ecological network.
Edges are more likely within modules than between modules, mimicking
groups of taxa that share similar niches or co-occurrence patterns.

![](figures/example_figures/netcomi_network_gcms_SB-1.png)<!-- -->

The GCM reflects the modular structure through correlated groups of
orbits. Dense within-module neighborhoods increase the dependence among
graphlet roles that occur in locally clustered regions, while
between-module links contribute less strongly. The result is more
structured than the Erdos-Renyi baseline but less hub-dominated than the
Barabasi-Albert network.

### Core-periphery ecological network

The core-periphery ecological network combines dense module cores with
connector taxa and many peripheral taxa. This creates a contrast between
taxa embedded in locally dense communities and taxa attached as leaves
or sparse connectors.

![](figures/example_figures/netcomi_network_gcms_Eco-1.png)<!-- -->

The GCM shows the clearest contrast between graphlet roles. Orbits 0, 2,
5, and 7 describe degree and internal or branching positions in open
structures, while orbits 8, 10, and 11 describe participation in cycle-
or triangle-related structures. In this example, these roles are
concentrated in the module cores and connector taxa. Their negative
correlations with orbits 6 and 9 indicate that nodes frequently
participating in core, branching, or cyclic graphlets are not usually
the same nodes that occupy terminal graphlet positions. Conversely,
nodes with high counts for terminal roles tend to be peripheral taxa
attached to the network boundary and therefore have low counts for the
denser core-related orbits.

### Combined overview

The combined figure places the three standard network models and their
GCMs next to each other to make the structural differences easier to
compare. This is the version intended for the thesis appendix.

![](figures/example_figures/netcomi_network_gcms-1.png)<!-- -->

Across the three standard models, the GCMs become more structured as the
networks move away from a homogeneous random baseline. The random
network mainly shows degree-driven positive orbit correlations, the
Barabasi-Albert network highlights hub-related dependencies, and the
stochastic block model emphasizes module-related dependencies.

## Files written

These files have been written to the target directory,
`data/example_figures`:

    ## # A tibble: 0 × 4
    ## # ℹ 4 variables: path <fs::path>, type <fct>, size <fs::bytes>, modification_time <dttm>

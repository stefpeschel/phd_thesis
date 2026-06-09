compare_methods
================
Compiled at 2026-06-10 10:34:05 UTC

``` r
here::i_am(paste0(params$name, ".Rmd"), uuid = "4892c382-867a-4ad7-8c98-22c28d1dae81")
```

# Overview

This script explores and compares several threshold selection methods
for generalized Pareto distribution (GPD) tail modeling in the context
of permutation-based inference. The main goal is to understand how
different threshold rules behave, both on a concrete permutation example
and under simulated bulk-tail mixture models where the true threshold is
known.

The analysis proceeds in three stages. First, the script defines the
candidate threshold grid and computes method-specific diagnostics based
on goodness-of-fit testing and stability criteria. Second, the methods
are illustrated on a two-sample permutation $t$-test example, where no
true threshold is available but the empirical behavior of the
diagnostics can be inspected visually. Third, the script turns to
simulated settings generated from known mixture distributions, allowing
the selected thresholds to be compared against the true threshold. This
includes both single illustrative draws and a larger simulation study
with repeated samples.

## Threshold methods

This section defines the set of threshold selection methods considered
throughout the script, together with display labels and a consistent
color palette for the figures. The methods include existing approaches
as well as new proposed methods.

``` r
threshold_methods <- c(
  "ftr",
  "fwd_stop",
  "rob_ftr",
  "gof_cp",
  "rpc",
  "shape_var"
)

method_labels <- c(
  ftr = "FTR",
  fwd_stop = "FwdStop",
  rob_ftr = "robFTR",
  gof_cp = "GoF-CP",
  rpc = "RPC",
  shape_var = "Shape-Var"
)

okabe_ito <- c(
  ftr = "#56B4E9",
  fwd_stop = "#009E73",
  rob_ftr = "#0072B2",
  gof_cp = "#CC79A7",
  rpc = "#E69F00",
  shape_var = "#D55E00"
)
```

## Parameter settings

The following global parameters are used throughout the analysis. They
specify the significance level for the goodness-of-fit assessment, the
window width used in the shape-variation diagnostic, the GPD fitting
method, the selected goodness-of-fit test, and a global random seed for
reproducibility. These settings are held fixed unless explicitly varied
later in the script.

``` r
gof_alpha <- 0.05
shape_var_window <- 7L
fit_method <- "lme"
gof_test <- "ad"
seed_global <- 123456
set.seed(seed_global) # Set seed here already to produce the same plots when knitting
```

## Data-generating functions

To study threshold selection under controlled conditions, the script
generates samples from several bulk–tail mixture distributions. In each
setting, observations below the threshold arise from a bulk
distribution, whereas exceedances follow a GPD tail. By varying the bulk
family and the relationship between bulk and tail at the threshold, the
simulations cover both smooth transitions and mismatch scenarios with
upward or downward jumps in tail behavior. Since the true threshold is
known in these settings, they provide a useful basis for evaluating
threshold estimators.

``` r
simulate_perm_stats <- function(
    n,
    scenario,
    bulk = NULL,
    xi = NULL, # GPD shape
    sigma = NA_real_, # GPD scale
    epsilon = NULL, # for the transition interval
    wshape = NULL,
    wscale = NULL,
    nmean = NULL,
    nsd = NULL,
    gshape = NULL,
    gscale = NULL,
    lnmean = NULL,
    lnsd = NULL
) {
  if (scenario == "smooth_weibull_gpd") {
    u <- qweibull(bulk, shape = wshape, scale = wscale)
    
    if (is.na(sigma)) {
      sigma <- (1 - pweibull(u, shape = wshape, scale = wscale)) /
      dweibull(u, shape = wshape, scale = wscale)
    }
    
    x <- evmix::rweibullgpd(
      n = n,
      wshape = wshape,
      wscale = wscale,
      u = u,
      sigmau = sigma,
      xi = xi
    )

    return(list(
      x = x,
      true_u = u,
      scenario = scenario,
      pars = list(
        bulk = bulk,
        wshape = wshape,
        wscale = wscale,
        xi = xi,
        sigma = sigma
      )
    ))
  }

  if (scenario == "transition_weibull_gpd") {
    u <- qweibull(bulk, shape = wshape, scale = wscale)
    
    if (is.na(sigma)) {
      sigma <- (1 - pweibull(u, shape = wshape, scale = wscale)) /
      dweibull(u, shape = wshape, scale = wscale)
    }

    x <- evmix::ritmweibullgpd(
      n = n,
      wshape = wshape,
      wscale = wscale,
      u = u,
      epsilon = epsilon,
      sigmau = sigma,
      xi = xi
    )

    return(list(
      x = x,
      true_u = u,
      scenario = scenario,
      pars = list(
        bulk = bulk,
        wshape = wshape,
        wscale = wscale,
        xi = xi,
        epsilon = epsilon,
        sigma = sigma
      )
    ))
  }
  
  if (scenario == "normal_gpd") {
    u <- qnorm(bulk, mean = nmean, sd = nsd)
    
    if (is.na(sigma)) {
      sigma <- (1 - pnorm(u, mean = nmean, sd = nsd)) /
        dnorm(u, mean = nmean, sd = nsd)
    }
    
    x <- evmix::rnormgpd(
      n = n,
      nmean = nmean,
      nsd = nsd,
      u = u,
      sigmau = sigma,
      xi = xi
    )

    return(list(
      x = x,
      true_u = u,
      scenario = scenario,
      pars = list(
        bulk = bulk,
        nmean = nmean,
        nsd = nsd,
        xi = xi,
        sigma = sigma
      )
    ))
  }
  
  if (scenario == "gamma_gpd") {
    u <- qgamma(bulk, shape = gshape, scale = gscale)
    
    if (is.na(sigma)) {
      sigma <- (1 - pgamma(u, shape = gshape, scale = gscale)) /
        dgamma(u, shape = gshape, scale = gscale)
    }
    
    x <- evmix::rgammagpd(
      n = n,
      gshape = gshape,
      gscale = gscale,
      u = u,
      sigmau = sigma,
      xi = xi
    )
    
    return(list(
      x = x,
      true_u = u,
      scenario = scenario,
      pars = list(
        bulk = bulk,
        gshape = gshape,
        gscale = gscale,
        xi = xi,
        sigma = sigma
      )
    ))
  }
  
  if (scenario == "lognormal_gpd") {
    u <- qlognormgpd(bulk, lnmean = lnmean, lnsd = lnsd)
    
    if (is.na(sigma)) {
      sigma <- (1 - plognormgpd(u, lnmean = lnmean, lnsd = lnsd)) /
        dlognormgpd(u, lnmean = lnmean, lnsd = lnsd)
    }
    
    x <- evmix::rlognormgpd(
      n = n,
      lnmean = lnmean,
      lnsd = lnsd,
      u = u,
      sigmau = sigma,
      xi = xi
    )
    
    return(list(
      x = x,
      true_u = u,
      scenario = scenario,
      pars = list(
        bulk = bulk,
        lnmean = lnmean,
        lnsd = lnsd,
        xi = xi,
        sigma = sigma
      )
    ))
  }
  stop("Unknown scenario.")
}
```

## Candidate thresholds and diagnostics

Threshold selection is performed over a grid of candidate values derived
from the observed sample. The grid is restricted by upper and lower
exceedance constraints to exclude thresholds that are clearly too low or
too high for reliable tail fitting. For each candidate threshold, a GPD
is fitted to the exceedances and a collection of diagnostics is
computed, including parameter estimates, goodness-of-fit $p$-values, and
method-specific summary quantities.

Based on these diagnostics, each threshold selection rule returns one
selected threshold, if available. This modular structure makes it
possible to compare the methods on a common set of candidate thresholds
and fitted models, rather than conflating methodological differences
with differences in the underlying grid.

``` r
build_threshold_grid <- function(perm_stats, obs_stat = Inf, exceed0, exceed_min, thresh_step = 1) {
  n_perm <- length(perm_stats)
  t_sort <- sort(perm_stats, decreasing = FALSE)
  thresh_init <- c(0, t_sort[t_sort > 0])

  exceed0 <- if (is.finite(exceed0) && exceed0 <= 1) {
    max(1L, floor(n_perm * exceed0))
  } else {
    as.integer(exceed0)
  }

  exceed_min <- if (is.finite(exceed_min) && exceed_min < 1) {
    max(1L, floor(n_perm * exceed_min))
  } else {
    as.integer(exceed_min)
  }

  thresh_exceed0 <- sort(thresh_init, decreasing = TRUE)[exceed0 + 1]
  thresh_ex_min <- sort(thresh_init, decreasing = TRUE)[exceed_min + 1]
  thresh_incl_obs <- max(thresh_init[thresh_init < obs_stat])

  thresh_low <- min(thresh_exceed0, thresh_incl_obs)
  thresh_upp <- min(thresh_ex_min, thresh_incl_obs)

  thresh_poss <- thresh_init[thresh_init >= thresh_low & thresh_init <= thresh_upp]
  thresh_poss <- thresh_poss[c(TRUE, rep(FALSE, thresh_step - 1))]
  unique(thresh_poss)
}

compute_threshold_diagnostics <- function(
    perm_stats,
    obs_stat = Inf,
    exceed0 = 250,
    exceed_min = 50,
    thresh_step = 10,
    gof_alpha = 0.05,
    gof_test = "ad",
    fit_method = "lme",
    tol = 1e-7,
    shape_var_window = 7L,
    seed = NULL
) {
  if (!is.null(seed)) set.seed(seed)

  thresh_poss <- build_threshold_grid(
    perm_stats = perm_stats,
    obs_stat = obs_stat,
    exceed0 = exceed0,
    exceed_min = exceed_min,
    thresh_step = thresh_step
  )

  t_sort <- sort(perm_stats, decreasing = FALSE)

  diag_df <- purrr::map_dfr(seq_along(thresh_poss), function(i) {
    thresh <- thresh_poss[i]
    fit <- permApprox::fit_gpd(
      data = t_sort,
      thresh = thresh,
      fit_method = fit_method,
      tol = tol,
      constraint = "unconstrained",
      gof_test = gof_test
    )

    tibble(
      idx = i,
      thresh = thresh,
      n_exceed = sum(t_sort > thresh),
      shape = fit$shape,
      scale = fit$scale,
      gof_p_value = fit$p_value
    )
  })

  acc <- which(diag_df$gof_p_value > gof_alpha)
  rej <- which(diag_df$gof_p_value <= gof_alpha)
  
  # Initialize index vector
  idx_methods <- numeric(length(threshold_methods))
  names(idx_methods) <- threshold_methods

  # FTR
  idx_ftr <- if (length(acc) == 0) NA_integer_ else acc[1]
  idx_methods["ftr"] <- idx_ftr

  # robFTR: x consecutive acceptances
  min_acc <- 5
  idx_rob_ftr <- NA_integer_
  if (nrow(diag_df) >= 3) {
    for (i in 1:(nrow(diag_df) - (min_acc - 1))) {
      if (all(diag_df$gof_p_value[i:(i + (min_acc - 1))] > gof_alpha)) {
        idx_rob_ftr <- i
        break
      }
    }
  }
  idx_methods["rob_ftr"] <- idx_rob_ftr

  # ForwardStop
  y <- -log(1 - diag_df$gof_p_value)
  ybar <- purrr::map_dbl(seq_along(y), ~ mean(y[1:.x]))
  idx_fwd_stop <- if (all(ybar <= gof_alpha)) {
    length(ybar)
  } else if (all(ybar > gof_alpha)) {
    1L
  } else {
    which(ybar > gof_alpha)[1]
  }
  idx_methods["fwd_stop"] <- idx_fwd_stop

  # GoF change point
  gof_p_tmp <- c(runif(100, min = 0, max = 0.01), diag_df$gof_p_value)
  cp <- changepoint::cpt.meanvar(gof_p_tmp)
  idx_sel <- cp@cpts[1] - 100
  idx_gof_cp <- if (length(acc[acc >= idx_sel]) == 0) NA_integer_ else acc[acc >= idx_sel][1]
  idx_methods["gof_cp"] <- idx_gof_cp
  
  # Shape stability: rolling variance over all candidate thresholds,
  # final selection only among GoF-accepted thresholds
  w <- as.integer(shape_var_window)
  if (w < 2L) stop("shape_var_window must be at least 2.")
  half <- floor((w - 1L) / 2L)

  shape_roll_var <- rep(NA_real_, nrow(diag_df))

  for (i in seq_len(nrow(diag_df))) {
    lo <- max(1L, i - half)
    hi <- min(nrow(diag_df), i + half)
    sh <- diag_df$shape[lo:hi]
    shape_roll_var[i] <- if (sum(!is.na(sh)) >= 2) stats::var(sh, na.rm = TRUE) else NA_real_
  }

  cand_shape <- which(diag_df$gof_p_value > gof_alpha & !is.na(shape_roll_var))

  idx_shape_var <- NA_integer_
  if (length(cand_shape) == 1) {
    idx_shape_var <- cand_shape[1]
  } else if (length(cand_shape) > 1) {
    best <- cand_shape[shape_roll_var[cand_shape] ==
                         min(shape_roll_var[cand_shape], na.rm = TRUE)]
    idx_shape_var <- best[which.max(diag_df$thresh[best])]
  }
  idx_methods["shape_var"] <- idx_shape_var
  
  # RPC
  prop_reject <- purrr::map_dbl(seq_len(nrow(diag_df)), function(i) {
    mean(diag_df$gof_p_value[i:nrow(diag_df)] <= gof_alpha)
  })
  prop_reject2 <- prop_reject
  prop_reject2[rej] <- 1
  idx_rpc <- which(prop_reject2 <= gof_alpha)[1]
  if (is.na(idx_rpc)) idx_rpc <- which.min(prop_reject2)
  idx_methods["rpc"] <- idx_rpc
  
  # Combine results
  method_tbl <- tibble(
    method = threshold_methods,
    idx = idx_methods[threshold_methods]
  ) %>%
    mutate(
      thresh = ifelse(is.na(idx), NA_real_, diag_df$thresh[idx]),
      n_exceed = ifelse(is.na(idx), NA_integer_, diag_df$n_exceed[idx])
    )

  cp_thresh <- if (!is.na(idx_sel) && idx_sel >= 1 && idx_sel <= nrow(diag_df)) {
    diag_df$thresh[idx_sel]
  } else {
    NA_real_
  }

  diag_df <- diag_df %>%
    mutate(
      ybar_forwardstop = ybar,
      prop_reject = prop_reject,
      shape_roll_var = shape_roll_var
    )

  cp_df <- tibble(
    idx_aug = seq_along(gof_p_tmp),
    gof_p_value_aug = gof_p_tmp,
    idx_original = seq_along(gof_p_tmp) - 100L,
    is_artificial = seq_along(gof_p_tmp) <= 100L,
    thresh = NA_real_
  )

  idx_valid <- cp_df$idx_original >= 1 & cp_df$idx_original <= nrow(diag_df)
  cp_df$thresh[idx_valid] <- diag_df$thresh[cp_df$idx_original[idx_valid]]

  list(
    diagnostics = diag_df,
    selected = method_tbl,
    cp_diagnostics = cp_df,
    cp_idx = idx_sel,
    cp_thresh = cp_thresh
  )
}
```

## Plot functions

### AD p-value plot

### Diagnostic plot

Several plotting functions are defined to visualize the threshold
diagnostics in a consistent way.

### Combined plot AD p-values and diagnostic for a single method

### AD p-value plot with all methods

### Histrogram

## Two-sample t-test

Before turning to fully controlled simulations, the methods are first
illustrated on a simple two-sample permutation $t$-test example. This
setting mimics the intended use case more directly: the permutation
statistics are finite in number, no true threshold is known, and
threshold choice must be guided purely by diagnostics. The example is
therefore useful for understanding how the methods behave in practice,
even though it does not permit a formal accuracy assessment.

``` r
get_perm_t_example <- function(
    n = 500,
    mu1 = 1,
    mu2 = 0,
    sd = 1,
    B = 1000,
    seed = NULL
) {
  if (!is.null(seed)) set.seed(seed)

  x1 <- rnorm(n, mean = mu1, sd = sd)
  x2 <- rnorm(n, mean = mu2, sd = sd)

  # Observed t-statistic (manual)
  t_obs <- (mean(x1) - mean(x2)) /
    sqrt((var(x1) + var(x2)) / n)
  
  # Permutation setup
  x_comb <- c(x1, x2)
  n_comb <- length(x_comb)
  
  # Generate permutation indices
  perm_idx_mat <- matrix(nrow = 0, ncol = n)
  while (nrow(perm_idx_mat) < B) {
    new_rows <- replicate(B, sample(n_comb, n), simplify = "matrix")
    perm_idx_mat <- unique(rbind(perm_idx_mat, t(new_rows)))
  }
  perm_idx_mat <- perm_idx_mat[1:B, , drop = FALSE]
  
  # Permutation t-statistics (manual)
  t_perm <- apply(perm_idx_mat, 1, function(idx) {
    x1_perm <- x_comb[idx]
    x2_perm <- x_comb[-idx]
    (mean(x1_perm) - mean(x2_perm)) /
      sqrt((var(x1_perm) + var(x2_perm)) / n)
  })

  list(
    x1 = x1,
    x2 = x2,
    t_obs = t_obs,
    t_perm = t_perm
  )
}
```

### Histogram

The histogram of the permuted absolute $t$-statistics gives a first
impression of the empirical null distribution.

![](figures/01_compare_methods/thresh_ttest_hist-1.png)<!-- -->

### AD p-values all methods

This plot overlays the thresholds selected by all methods on the same
Anderson–Darling goodness-of-fit profile. It provides a compact overview
of where the methods place the tail threshold relative to the apparent
region of acceptable GPD fit.

![](figures/01_compare_methods/thresh_ttest_ADp_all-1.png)<!-- -->

### FTR

The first-threshold rule selects the smallest candidate threshold whose
goodness-of-fit test is accepted. As the most liberal rule considered
here, it tends to enter the acceptance region as early as possible and
serves as a useful baseline for comparison.

![](figures/01_compare_methods/thresh_ttest_ftr_ADp-1.png)<!-- -->

### Robust FTR

The robust first-threshold rule modifies the simple first-acceptance
idea by requiring several consecutive accepted thresholds. This makes
the method less sensitive to isolated large $p$-values and typically
shifts the selected threshold upward.

![](figures/01_compare_methods/thresh_ttest_rob_ftr_ADp-1.png)<!-- -->

### ForwardStop

ForwardStop aggregates the sequence of goodness-of-fit $p$-values into a
running summary statistic motivated by sequential multiple testing.
Rather than reacting to a single accepted threshold, it aims to identify
a stable entry point into a region of acceptable fit.

![](figures/01_compare_methods/thresh_ttest_fwd_stop_ADp-1.png)<!-- -->

![](figures/01_compare_methods/thresh_ttest_fwd_stop_diag-1.png)<!-- -->

![](figures/01_compare_methods/thresh_ttest_fwd_stop_ADp_diag-1.png)<!-- -->

### Combined plot (hist + FTR + FwdStop)

This combined figure juxtaposes the empirical distribution of the
permutation statistics with the threshold choices of FTR and
ForwardStop. It illustrates how two conceptually different rules may
respond to the same diagnostic pattern.

![](figures/01_compare_methods/thresh_ttest_ftr_fwd_stop_ADp_diag-1.png)<!-- -->

### GoF-changepoint

The changepoint-based approach searches for a structural shift in the
sequence of goodness-of-fit $p$-values after augmenting the series with
artificial small values. The aim is to detect the transition from clear
model misspecification to a region where GPD fitting becomes plausible.

![](figures/01_compare_methods/thresh_ttest_gof_cp_diag-1.png)<!-- -->

### Rejection proportion control

The rejection proportion control rule summarizes how often
goodness-of-fit tests are rejected among larger candidate thresholds.
This yields a more global criterion that favors thresholds beyond which
model fit appears acceptably stable in aggregate.

![](figures/01_compare_methods/thresh_ttest_rpc_ADp-1.png)<!-- -->

![](figures/01_compare_methods/thresh_ttest_rpc_diag-1.png)<!-- -->

![](figures/01_compare_methods/thresh_ttest_rpc_ADp_diag-1.png)<!-- -->

### Shape variation

The shape-variation rule is based on the heuristic that, above a
suitable threshold, the estimated GPD shape parameter should stabilize.
The diagnostic therefore evaluates the local variability of the shape
estimate across neighboring thresholds and selects a threshold with
small variation among those that also pass the goodness-of-fit filter.

![](figures/01_compare_methods/thresh_ttest_shape_var_ADp-1.png)<!-- -->

![](figures/01_compare_methods/thresh_ttest_shape_var_diag-1.png)<!-- -->

![](figures/01_compare_methods/thresh_ttest_shape_var_ADp_diag-1.png)<!-- -->

## Exploratory simulation study

The next part of the script considers single simulated samples from
several bulk–tail mixture models. These examples are intended for visual
exploration rather than formal performance evaluation. Because the true
threshold is known, they make it possible to assess qualitatively
whether the selected thresholds align with the actual onset of the GPD
tail and how the methods react to smooth transitions or bulk–tail
mismatches.

### Weibull-GPD with smooth transition

This setting represents the most favorable case for threshold selection:
the Weibull bulk connects smoothly to the GPD tail at the true
threshold. In principle, one would expect threshold methods to perform
relatively well here, although finite-sample variability and the
discreteness of the candidate grid may still lead to noticeable
deviations.

![](figures/01_compare_methods/thresh_sim_single_weib_gpd_smooth_hist_ADp_all-1.png)<!-- -->

Since in this smooth setting, none of the methods is able to detect the
true threshold, we consider mixtures with a jump at the threshold in the
following.

### Weibull-GPD with upward jump

![](figures/01_compare_methods/thresh_sim_single_weib_gpd_up_jump_hist_ADp_all-1.png)<!-- -->

### Weibull-GPD with downward jump

![](figures/01_compare_methods/thresh_sim_single_weib_gpd_down_jump_hist_ADp_all-1.png)<!-- -->

![](figures/01_compare_methods/thresh_sim_single_weib_gpd_down_jump_hist_ADp_all_seed2-1.png)<!-- -->

### Log-Normal-GPD

As alternative to the Weibull distribution, we consider also a
log-normal distribution for the bulk, which might also be a good
representation of permutation distributions.

![](figures/01_compare_methods/thresh_sim_single_log_normal_gpd_hist_ADp_all-1.png)<!-- -->

### Gamma-GPD

As third model, we consider the Gamma distribution for the bulk, which
might also be a good representation of permutation distributions.

![](figures/01_compare_methods/thresh_sim_single_gamma_gpd_hist_ADp_all-1.png)<!-- -->

### Gamma-GPD - 250 exceedances

In reality, one would not fit the GPD to the whole distribution, but
only to the tail, which is represented here.

![](figures/01_compare_methods/thresh_sim_single_gamma_gpd_250_hist_ADp_all-1.png)<!-- -->

### Combined plot (four panels)

![](figures/01_compare_methods/thresh_sim_single_combined_four_panels-1.png)<!-- -->

## Simulation study

While the previous section focused on single illustrative samples, the
following simulation study provides a more systematic assessment. For
each scenario and each choice of starting exceedances, 100 independent
data sets are generated. The threshold methods are then applied
repeatedly, and the selected thresholds are compared with the known true
threshold. This repeated-sampling perspective allows systematic bias and
variability to be distinguished from one-off behavior in individual
examples.

### Simulation settings

The simulation design crosses five distributional settings with two
choices of the starting number of exceedances, resulting in ten scenario
configurations. The selected settings were chosen to represent both
favorable and challenging threshold problems while keeping the
simulation study manageable.

    ## # A tibble: 12 × 15
    ##    setting_id   scenario  bulk    xi sigma wshape wscale gshape gscale lnmean  lnsd exceed0 stepsize exceed0_label stepsize_label
    ##    <chr>        <chr>    <dbl> <dbl> <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl> <dbl>   <int>    <dbl> <fct>         <fct>         
    ##  1 gamma_down   gamma_g…   0.8  -0.2   1.3   NA       NA    1.2    0.6     NA  NA       250        1 exceed0 = 250 stepsize = 1  
    ##  2 gamma_down   gamma_g…   0.8  -0.2   1.3   NA       NA    1.2    0.6     NA  NA       250       10 exceed0 = 250 stepsize = 10 
    ##  3 gamma_down   gamma_g…   0.8  -0.2   1.3   NA       NA    1.2    0.6     NA  NA      1000        1 exceed0 = 10… stepsize = 1  
    ##  4 gamma_down   gamma_g…   0.8  -0.2   1.3   NA       NA    1.2    0.6     NA  NA      1000       10 exceed0 = 10… stepsize = 10 
    ##  5 lognormal_d… lognorm…   0.8  -0.2   2.5   NA       NA   NA     NA        0   0.8     250        1 exceed0 = 250 stepsize = 1  
    ##  6 lognormal_d… lognorm…   0.8  -0.2   2.5   NA       NA   NA     NA        0   0.8     250       10 exceed0 = 250 stepsize = 10 
    ##  7 lognormal_d… lognorm…   0.8  -0.2   2.5   NA       NA   NA     NA        0   0.8    1000        1 exceed0 = 10… stepsize = 1  
    ##  8 lognormal_d… lognorm…   0.8  -0.2   2.5   NA       NA   NA     NA        0   0.8    1000       10 exceed0 = 10… stepsize = 10 
    ##  9 weibull_down smooth_…   0.8  -0.2   1.8    1.2      1   NA     NA       NA  NA       250        1 exceed0 = 250 stepsize = 1  
    ## 10 weibull_down smooth_…   0.8  -0.2   1.8    1.2      1   NA     NA       NA  NA       250       10 exceed0 = 250 stepsize = 10 
    ## 11 weibull_down smooth_…   0.8  -0.2   1.8    1.2      1   NA     NA       NA  NA      1000        1 exceed0 = 10… stepsize = 1  
    ## 12 weibull_down smooth_…   0.8  -0.2   1.8    1.2      1   NA     NA       NA  NA      1000       10 exceed0 = 10… stepsize = 10

### Helper functions

The helper functions in this section execute a single simulation
replicate and aggregate multiple replicates for a fixed setting. For
each repetition, the script stores the selected threshold, the
corresponding number of exceedances, the true threshold, and summary
measures of estimation error. These quantities form the basis of the
later numerical and graphical comparisons.

``` r
run_one_threshold_rep <- function(
    rep_id,
    setting_row,
    n = 1000L,
    exceed_min = 10L,
    gof_alpha = 0.05,
    gof_test = "ad",
    fit_method = "lme",
    shape_var_window = 7L,
    seed_global = 123456
) {
  seed_rep <- seed_global + 
    10000L * match(setting_row$setting_id, unique(sim_grid$setting_id)) +
    1000L * as.integer(setting_row$exceed0) + rep_id
  set.seed(seed_rep)
  
  sim_obj <- simulate_perm_stats(
    n = n,
    scenario = setting_row$scenario,
    bulk = setting_row$bulk,
    xi = setting_row$xi,
    sigma = setting_row$sigma,
    epsilon = NA,
    wshape = setting_row$wshape,
    wscale = setting_row$wscale,
    nmean = NA,
    nsd = NA,
    gshape = setting_row$gshape,
    gscale = setting_row$gscale,
    lnmean = setting_row$lnmean,
    lnsd = setting_row$lnsd
  )

  res <- compute_threshold_diagnostics(
    perm_stats = sim_obj$x,
    exceed0 = setting_row$exceed0,
    exceed_min = exceed_min,
    thresh_step = setting_row$stepsize,
    gof_alpha = gof_alpha,
    gof_test = gof_test,
    fit_method = fit_method,
    shape_var_window = shape_var_window,
    seed = seed_rep
  )
  
  res$selected %>%
    transmute(
      rep = rep_id,
      method,
      est_thresh = thresh,
      est_n_exceed = n_exceed,
      true_u = sim_obj$true_u,
      diff_est_minus_true = est_thresh - true_u,
      abs_diff = abs(diff_est_minus_true)
    )
}

run_one_setting <- function(
    setting_row,
    n_reps = 100L,
    n = 1000L,
    exceed_min = 10L,
    gof_alpha = 0.05,
    gof_test = "ad",
    fit_method = "lme",
    shape_var_window = 7L,
    seed_global = 123456
) {
  purrr::map_dfr(
    seq_len(n_reps),
    run_one_threshold_rep,
    setting_row = setting_row,
    n = n,
    exceed_min = exceed_min,
    gof_alpha = gof_alpha,
    gof_test = gof_test,
    fit_method = fit_method,
    shape_var_window = shape_var_window,
    seed_global = seed_global
  )
}
```

### Run simulation study

``` r
handlers("txtprogressbar")
plan(multisession, workers = cores)

with_progress({
  p <- progressor(steps = nrow(sim_grid))

  furrr::future_walk(
    split(sim_grid, seq_len(nrow(sim_grid))),
    function(row) {
      
      row <- as_tibble(row)

      f_out <- path(
        path_sim,
        paste0(row$setting_id, "_exceed0_", row$exceed0, "_step", row$stepsize, ".rds")
      )

      if (!file_exists(f_out)) {
        res_setting <- run_one_setting(
          setting_row = row,
          n_reps = n_sim_reps,
          n = 1000L,
          exceed_min = 10L,
          gof_alpha = gof_alpha,
          gof_test = gof_test,
          fit_method = fit_method,
          shape_var_window = shape_var_window,
          seed_global = seed_global
        )
        saveRDS(res_setting, f_out)
      }

      p()
    },
    .options = furrr::furrr_options(seed = TRUE)
  )
})

plan(sequential)
```

    ## # A tibble: 6 × 24
    ##   setting_id scenario   bulk    xi sigma wshape wscale gshape gscale lnmean  lnsd exceed0 stepsize exceed0_label stepsize_label
    ##   <chr>      <chr>     <dbl> <dbl> <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl> <dbl>   <int>    <dbl> <fct>         <fct>         
    ## 1 gamma_down gamma_gpd   0.8  -0.2   1.3     NA     NA    1.2    0.6     NA    NA     250        1 exceed0 = 250 stepsize = 1  
    ## 2 gamma_down gamma_gpd   0.8  -0.2   1.3     NA     NA    1.2    0.6     NA    NA     250        1 exceed0 = 250 stepsize = 1  
    ## 3 gamma_down gamma_gpd   0.8  -0.2   1.3     NA     NA    1.2    0.6     NA    NA     250        1 exceed0 = 250 stepsize = 1  
    ## 4 gamma_down gamma_gpd   0.8  -0.2   1.3     NA     NA    1.2    0.6     NA    NA     250        1 exceed0 = 250 stepsize = 1  
    ## 5 gamma_down gamma_gpd   0.8  -0.2   1.3     NA     NA    1.2    0.6     NA    NA     250        1 exceed0 = 250 stepsize = 1  
    ## 6 gamma_down gamma_gpd   0.8  -0.2   1.3     NA     NA    1.2    0.6     NA    NA     250        1 exceed0 = 250 stepsize = 1  
    ## # ℹ 9 more variables: rep <int>, method <fct>, est_thresh <dbl>, est_n_exceed <int>, true_u <dbl>, diff_est_minus_true <dbl>,
    ## #   abs_diff <dbl>, method_label <fct>, setting_label <fct>

### Quick numerical summary

As a first overview, the simulation results are summarized numerically
by setting, starting exceedance level, and method. The reported
quantities include the number of successful threshold selections, the
median and mean signed threshold error, and the median absolute error.

    ## # A tibble: 72 × 8
    ##    setting_label exceed0_label  stepsize_label method_label  n_ok median_diff mean_diff median_abs_diff
    ##    <fct>         <fct>          <fct>          <fct>        <int>       <dbl>     <dbl>           <dbl>
    ##  1 Weibull-GPD   exceed0 = 1000 stepsize = 1   FTR           1000     -0.0797   -0.243           0.0803
    ##  2 Weibull-GPD   exceed0 = 1000 stepsize = 1   FwdStop       1000      0.386     0.754           0.427 
    ##  3 Weibull-GPD   exceed0 = 1000 stepsize = 1   robFTR        1000     -0.0661   -0.205           0.0676
    ##  4 Weibull-GPD   exceed0 = 1000 stepsize = 1   GoF-CP        1000     -0.0797   -0.243           0.0803
    ##  5 Weibull-GPD   exceed0 = 1000 stepsize = 1   RPC           1000     -0.0497    0.119           0.0670
    ##  6 Weibull-GPD   exceed0 = 1000 stepsize = 1   Shape-Var     1000      0.141     0.0815          0.262 
    ##  7 Weibull-GPD   exceed0 = 1000 stepsize = 10  FTR           1000     -0.0596   -0.203           0.0613
    ##  8 Weibull-GPD   exceed0 = 1000 stepsize = 10  FwdStop       1000      0.406     0.787           0.448 
    ##  9 Weibull-GPD   exceed0 = 1000 stepsize = 10  robFTR         999     -0.0525   -0.117           0.0603
    ## 10 Weibull-GPD   exceed0 = 1000 stepsize = 10  GoF-CP        1000     -0.0596   -0.203           0.0613
    ## # ℹ 62 more rows

### Boxplots of estimated minus true threshold

The main graphical summary of the simulation study is based on the
signed error $\hat{u} - u_{\mathrm{true}}$. Positive values indicate
that the selected threshold is too high, whereas negative values
correspond to underestimation. The boxplots and jittered points
therefore show both systematic bias and the variability of each method
across repetitions.

![](figures/01_compare_methods/thresh_sim_rep_jitter_box_weib_down-1.png)<!-- -->

![](figures/01_compare_methods/thresh_sim_rep_jitter_box_lnorm_down-1.png)<!-- -->

![](figures/01_compare_methods/thresh_sim_rep_jitter_box_gamma_down-1.png)<!-- -->

### Boxplots for selected settings

Since the smooth Weibull-GPD and upward-jump Weibull-GPD settings show
uniformly weak performance for `exceed0 = 1000`, the final comparison
focuses on the remaining three settings, where the methods exhibit
better performance in estimating the true threshold.

#### exceed0 = 1000, step size = 1

The following figure compares the three retained settings when the
candidate threshold grid starts at 1000 exceedances. This corresponds to
the broadest threshold search range considered in the simulation study.

The step size is 1 here, which means that in the candidate range all
thresholds are considered.

![](figures/01_compare_methods/thresh_sim_rep_jitter_box_all_exc1000_step1-1.png)<!-- -->

#### exceed0 = 1000, step size = 10

The following figure compares the three retained settings when the
candidate threshold grid starts at 1000 exceedances. This corresponds to
the broadest threshold search range considered in the simulation study.

The step size is 10 here, which means that in the candidate range only
every 10th threshold is considered.

![](figures/01_compare_methods/thresh_sim_rep_jitter_box_all_exc1000_step10-1.png)<!-- -->

#### exceed0 = 250, step size = 1

The next figure shows the same comparison when the candidate threshold
grid starts at 250 exceedances, which is more realistic.

The step size is 1 here, which means that in the candidate range all
thresholds are considered.

![](figures/01_compare_methods/thresh_sim_rep_jitter_box_all_exc250_step1-1.png)<!-- -->

#### exceed0 = 250, step size = 10

The next figure shows the same comparison when the candidate threshold
grid starts at 250 exceedances, which is more realistic.

The step size is 10 here, which means that in the candidate range only
every 10th threshold is considered.

![](figures/01_compare_methods/thresh_sim_rep_jitter_box_all_exc250_step10-1.png)<!-- -->

## Files written

These files have been written to the target directory,
`data/01_compare_methods`:

    ## # A tibble: 19 × 4
    ##    path                                   type             size modification_time  
    ##    <fs::path>                             <fct>     <fs::bytes> <dttm>             
    ##  1 gamma_gpd_down_jump_res_ex.rds         file           74.69K 2026-03-21 18:51:27
    ##  2 gamma_gpd_down_jump_res_ex_250.rds     file           14.85K 2026-03-21 18:53:01
    ##  3 gamma_gpd_down_jump_res_ex_500.rds     file           34.09K 2026-03-16 09:16:27
    ##  4 gamma_gpd_down_jump_sim_ex.rds         file            7.68K 2026-03-21 18:51:27
    ##  5 gamma_gpd_down_jump_sim_ex_250.rds     file            7.68K 2026-03-21 18:53:01
    ##  6 gamma_gpd_down_jump_sim_ex_500.rds     file            7.68K 2026-03-16 09:16:27
    ##  7 log_normal_gpd_down_jump_res_ex.rds    file           74.89K 2026-03-21 18:40:14
    ##  8 log_normal_gpd_down_jump_sim_ex.rds    file            7.71K 2026-03-21 18:40:14
    ##  9 simulation_thresholds                  directory           0 2026-03-22 14:43:37
    ## 10 ttest_perm_ex.rds                      file           11.43K 2026-03-21 18:33:26
    ## 11 ttest_res_perm.rds                     file           74.23K 2026-03-21 18:33:26
    ## 12 weibull_gpd_down_jump_res_ex.rds       file           74.81K 2026-03-21 18:38:03
    ## 13 weibull_gpd_down_jump_res_ex_seed2.rds file           74.88K 2026-03-21 18:39:30
    ## 14 weibull_gpd_down_jump_sim_ex.rds       file            7.71K 2026-03-21 18:38:03
    ## 15 weibull_gpd_down_jump_sim_ex_seed2.rds file            7.71K 2026-03-21 18:39:30
    ## 16 weibull_gpd_smooth_res_ex.rds          file           73.59K 2026-03-21 18:36:16
    ## 17 weibull_gpd_smooth_sim_ex.rds          file             7.7K 2026-03-21 18:36:16
    ## 18 weibull_gpd_up_jump_res_ex.rds         file           75.15K 2026-03-21 18:37:11
    ## 19 weibull_gpd_up_jump_sim_ex.rds         file            7.75K 2026-03-21 18:37:11

# Chapter 6: Approximation of permutation p-values with permApprox

This folder contains code, rendered reports, generated figures, and saved simulation outputs for the thesis chapter on approximating permutation p-values. The analyses focus on generalized Pareto distribution (GPD) tail approximation, threshold selection, and comparisons with empirical, gamma-based, and classical test-based p-value calculations.

The folder is part of the larger thesis repository and uses the project-level R environment defined by `renv.lock` in the repository root.

## Folder Structure

```text
.
├── README.md                     → Chapter overview (this file)
│
├── explorations/                 → Exploratory analyses and single-rep trials
│   ├── gpd_fit/                    → Exploratory analyses on GPD data
│   │   ├── 01_tol_calibration        → Find tolerance values for optimization
│   │   ├── 02_runtime                → Runtime comparison of GPD fitting methods
│   │   ├── data/                     → Saved exploratory results
│   │   └── figures/                  → Generated exploratory figures
│   │
│   ├── perm_ttest/                 → Exploratory t-test permutation analyses
│   │   ├── 01_exact_vs_ttest         → Exact permutation test vs. t-test
│   │   ├── 02_eps_trials             → Preliminary epsilon (ε) trials
│   │   ├── 03_find_eps_rule          → Search for data-driven ε rule
│   │   ├── 04_single_tests           → Apply ε rule to single-test settings
│   │   ├── 05_exceedances            → Evaluate numbers of exceedances
│   │   ├── 06_p_approx_methods.Rmd   → Comparison of p-value approximation methods
│   │   ├── data/                     → Saved exploratory results
│   │   └── figures/                  → Generated exploratory figures
│   │
│   ├── perm_wilcox/                → Exploratory Wilcoxon permutation analyses
│   │   ├── 01_test_eps_rule          → Test ε rule in Wilcoxon context
│   │   ├── 02_single_tests           → Single-test validation for Wilcoxon
│   │   ├── 03_exceedances            → Evaluate numbers of exceedances
│   │   ├── 04_p_approx_methods       → Comparison against competing approaches
│   │   ├── data/                     → Saved exploratory results
│   │   └── figures/                  → Generated exploratory figures
│   │
│   └── threshold_selection/        → Exploratory threshold method analyses
│       ├── 01_test_eps_rule          → Compare methods using t-test and simulations
│       ├── data/                     → Saved threshold-selection results
│       └── figures/                  → Generated threshold-selection figures
│
├── functions/                    → Local helper code used by the chapter analyses
│   ├── permApprox_eps_fct/         → permApprox version (accepts eps functions)
│   └── waddR                       → Own waddR implementation
│
├── overview_figures/             → Overview figures to summarize some approaches
│
└── simulations/                  → Full simulation studies evaluating method performance
    ├── gpd_fit/                    → GPD parameter estimation and robustness
    │   ├── 01_data_gen               → Data generation for GPD studies
    │   ├── 02_unconstrained          → Unconstrained GPD estimation
    │   ├── 03_asymptotic             → Asymptotic behavior of estimators
    │   ├── 04_misspecification       → Robustness to boundary misspecification
    │   ├── 05_eval_point             → Effect of evaluation point (ε shift)
    │   ├── data/                     → Saved simulation data and results
    │   └── figures/                  → Generated simulation figures
    │
    ├── perm_ttest/                 → Permutation-based t-test simulation studies
    │   ├── 01_data_gen               → Data generation for t-test simulations
    │   ├── 02_constr_vs_unconstr     → Constrained vs. unconstrained GPD fits
    │   ├── 03_nexceed                → Find optimal number of exceedances
    │   ├── 04_thresh_methods         → Evaluation of threshold detection methods
    │   ├── 05_p_approx_methods       → Comparison against competing approaches
    │   ├── data/                     → Saved simulation data and results
    │   └── figures/                  → Generated simulation figures
    │
    └── perm_wilcox/                → Permutation-based Wilcoxon simulation studies
        ├── 01_gen_data               → Data generation for Wilcoxon simulations
        ├── 02_p_approx_methods       → Comparison against competing approaches
        ├── data/                     → Saved simulation data and results
        └── figures/                  → Generated simulation figures
```

## Rendering

The analyses are written as R Markdown files. Individual reports can be rendered from the repository root, for example:

```r
rmarkdown::render("ch06_permapprox/simulations/perm_ttest/05_p_approx_methods.Rmd")
rmarkdown::render("ch06_permapprox/explorations/threshold_selection/01_compare_methods.Rmd")
```

Many analyses write outputs to matching `data/` and `figures/` subfolders. The rendered `.html` and `.md` reports are kept alongside the corresponding `.Rmd` files.

## Notes

- The simulation folders contain many saved `.rds` or `.RDS` objects and generated figure files.
- Some simulations are computationally intensive and may take substantial time to rerun.
- Exact numerical values may differ slightly across systems because of floating-point arithmetic, package versions, or parallel execution.
- The `functions/` folder contains local helper code used for the thesis analyses; it is not intended to replace the user-facing `permApprox` R package.


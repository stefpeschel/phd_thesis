library(projthis)
library(rmarkdown)
library(rprojroot)

# -------------------------------------------------------------------------
# Create projthis workflow and files
# -------------------------------------------------------------------------

# Create new workflow folder structure
#proj_use_workflow("workflow")

# Create new Rmd file
#proj_workflow_use_rmd("file_name", path_proj = "ch07_application")

# ------------------------------------------------------------------------------
# Helper for rendering single Rmd files
# ------------------------------------------------------------------------------

proj_path <- rprojroot::find_root(rprojroot::has_file("phd_thesis.Rproj"))

render_rmd <- function(path, output_format = "all", quiet = FALSE) {
  file_path <- file.path(proj_path, path)

  if (!grepl("\\.Rmd$", file_path, ignore.case = TRUE)) {
    file_path <- paste0(file_path, ".Rmd")
  }

  file_path <- normalizePath(file_path, winslash = "/", mustWork = FALSE)

  if (!file.exists(file_path)) {
    stop("File not found: ", file_path, call. = FALSE)
  }

  old_wd <- getwd()
  on.exit(setwd(old_wd), add = TRUE)

  setwd(dirname(file_path))

  message("\n--- Rendering: ", file_path, " ---\n")

  rmarkdown::render(
    input = basename(file_path),
    output_format = output_format,
    quiet = quiet,
    envir = new.env(parent = globalenv())
  )
}

################################################################################
### Chapter 2: Microbiome data as statistical objects ##########################
################################################################################

render_rmd("ch02_microbiome_data/clr_mini_example.Rmd")
render_rmd("ch02_microbiome_data/overview_figure_example.Rmd")

################################################################################
### Chapter 5: NetCoMi #########################################################
################################################################################

render_rmd("ch05_netcomi/example_figures.Rmd")

################################################################################
### Chapter 6: permApprox ######################################################
################################################################################

# ------------------------------------------------------------------------------
# Chapter 6: permApprox - explorations / GPD fit
# ------------------------------------------------------------------------------

render_rmd("ch06_permapprox/explorations/gpd_fit/01_tol_calibration.Rmd")
render_rmd("ch06_permapprox/explorations/gpd_fit/02_runtime.Rmd")

# ------------------------------------------------------------------------------
# Chapter 6: permApprox - explorations / permutation t-test
# ------------------------------------------------------------------------------

render_rmd("ch06_permapprox/explorations/perm_ttest/01_exact_vs_ttest.Rmd")
render_rmd("ch06_permapprox/explorations/perm_ttest/02_eps_trials.Rmd")
render_rmd("ch06_permapprox/explorations/perm_ttest/03_find_eps_rule.Rmd")
render_rmd("ch06_permapprox/explorations/perm_ttest/04_single_tests.Rmd")
render_rmd("ch06_permapprox/explorations/perm_ttest/05_exceedances.Rmd")
render_rmd("ch06_permapprox/explorations/perm_ttest/06_p_approx_methods.Rmd")

# ------------------------------------------------------------------------------
# Chapter 6: permApprox - explorations / permutation Wilcoxon test
# ------------------------------------------------------------------------------

render_rmd("ch06_permapprox/explorations/perm_wilcox/01_test_eps_rule.Rmd")
render_rmd("ch06_permapprox/explorations/perm_wilcox/02_single_tests.Rmd")
render_rmd("ch06_permapprox/explorations/perm_wilcox/03_exceedances.Rmd")
render_rmd("ch06_permapprox/explorations/perm_wilcox/04_p_approx_methods.Rmd")

# ------------------------------------------------------------------------------
# Chapter 6: permApprox - explorations / threshold selection
# ------------------------------------------------------------------------------

render_rmd("ch06_permapprox/explorations/threshold_selection/01_compare_methods.Rmd")

# ------------------------------------------------------------------------------
# Chapter 6: permApprox - simulations / GPD fit
# ------------------------------------------------------------------------------

render_rmd("ch06_permapprox/simulations/gpd_fit/01_data_gen.Rmd")
render_rmd("ch06_permapprox/simulations/gpd_fit/02_unconstrained.Rmd")
render_rmd("ch06_permapprox/simulations/gpd_fit/03_asymptotic.Rmd")
render_rmd("ch06_permapprox/simulations/gpd_fit/04_misspecification.Rmd")
render_rmd("ch06_permapprox/simulations/gpd_fit/05_eval_point.Rmd")

# ------------------------------------------------------------------------------
# Chapter 6: permApprox - simulations / permutation t-test
# ------------------------------------------------------------------------------

render_rmd("ch06_permapprox/simulations/perm_ttest/01_data_gen.Rmd")
render_rmd("ch06_permapprox/simulations/perm_ttest/02_constr_vs_unconstr.Rmd")
render_rmd("ch06_permapprox/simulations/perm_ttest/03_nexceed.Rmd")
render_rmd("ch06_permapprox/simulations/perm_ttest/04_thresh_methods.Rmd")
render_rmd("ch06_permapprox/simulations/perm_ttest/05_p_approx_methods.Rmd")

# ------------------------------------------------------------------------------
# Chapter 6: permApprox - simulations / permutation Wilcoxon test
# ------------------------------------------------------------------------------

render_rmd("ch06_permapprox/simulations/perm_wilcox/01_data_gen.Rmd")
render_rmd("ch06_permapprox/simulations/perm_wilcox/02_p_approx_methods.Rmd")

# ------------------------------------------------------------------------------
# Chapter 6: permApprox - helper-code vignettes
# ------------------------------------------------------------------------------

render_rmd("ch06_permapprox/functions/waddR/vignettes/waddR.Rmd")
render_rmd("ch06_permapprox/functions/waddR/vignettes/wasserstein_metric.Rmd")
render_rmd("ch06_permapprox/functions/waddR/vignettes/wasserstein_singlecell.Rmd")
render_rmd("ch06_permapprox/functions/waddR/vignettes/wasserstein_test.Rmd")

################################################################################
### Chapter 7: Analysis of the PASTURE data ####################################
################################################################################

render_rmd("ch07_application/00_build_dataset.Rmd")
render_rmd("ch07_application/01_overview.Rmd")
render_rmd("ch07_application/02_filtering.Rmd")
render_rmd("ch07_application/03_alpha_diversity.Rmd")
render_rmd("ch07_application/04_beta_diversity.Rmd")
render_rmd("ch07_application/05_regression.Rmd")
render_rmd("ch07_application/06_comp_equivalence.Rmd")
render_rmd("ch07_application/07_exploration.Rmd")
render_rmd("ch07_application/08_diff_abundance.Rmd")
render_rmd("ch07_application/09_diff_distribution.Rmd")

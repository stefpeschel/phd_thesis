get_sample_by_taxa <- function(phylo) {
  mat <- as(otu_table(phylo), "matrix")

  if (taxa_are_rows(phylo)) {
    mat <- t(mat)
  }

  mat <- as.matrix(mat)
  storage.mode(mat) <- "numeric"

  mat
}

counts_to_rel_abund <- function(count_mat) {
  lib_size <- rowSums(count_mat)

  if (any(lib_size == 0)) {
    stop("At least one sample has library size zero.")
  }

  sweep(count_mat, 1, lib_size, "/")
}

compute_multrepl_clr <- function(rel_abund_mat, frac = 0.65) {
  positive_values <- rel_abund_mat[rel_abund_mat > 0]

  if (length(positive_values) == 0) {
    stop("No positive relative abundances found.")
  }

  detection_limit <- min(positive_values, na.rm = TRUE)
  detection_limit_mat <- matrix(
    detection_limit,
    nrow = nrow(rel_abund_mat),
    ncol = ncol(rel_abund_mat),
    dimnames = dimnames(rel_abund_mat)
  )

  rel_abund_repl <- zCompositions::multRepl(
    rel_abund_mat,
    label = 0,
    dl = detection_limit_mat,
    frac = frac,
    z.warning = 0.9,
    z.delete = FALSE
  )

  rel_abund_repl <- as.matrix(rel_abund_repl)
  rownames(rel_abund_repl) <- rownames(rel_abund_mat)
  colnames(rel_abund_repl) <- colnames(rel_abund_mat)

  log_repl <- log(rel_abund_repl)
  z <- sweep(log_repl, 1, rowMeans(log_repl), "-")

  list(
    z = z,
    rel_abund_repl = rel_abund_repl,
    detection_limit = detection_limit,
    replacement_value = frac * detection_limit,
    frac = frac
  )
}

empirical_pvalue <- function(obs_stat, perm_stats) {
  (1 + sum(perm_stats >= obs_stat, na.rm = TRUE)) / (1 + length(perm_stats))
}

sig_stars <- function(p) {
  dplyr::case_when(
    p < 0.001 ~ "***",
    p < 0.01  ~ "**",
    p < 0.05  ~ "*",
    p < 0.1   ~ ".",
    TRUE      ~ ""
  )
}

fmt_p_latex <- function(p_num) {
  p_str <- formatC(p_num, format = "e", digits = 2)
  stars <- sig_stars(p_num)

  ifelse(stars != "", paste0(p_str, "$^{", stars, "}$"), p_str)
}

fmt_p_table <- function(p_num) {
  formatC(p_num, format = "e", digits = 2)
}

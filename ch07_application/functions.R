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

# General zero replacement + CLR function supporting all methods used in the
# network analysis. Mirrors the interface of compute_multrepl_clr but dispatches
# on `method`. All methods operate on a samples-by-taxa relative abundance matrix
# and return a named list with at minimum:
#   $method          – the method used
#   $rel_abund_repl  – zero-replaced relative abundance matrix (same dims as input)
#   $z               – CLR-transformed version of rel_abund_repl
#
# Method-specific extra fields mirror the parameters used:
#   multRepl   : $detection_limit, $replacement_value, $frac
#   pseudo     : $pseudocount, $zerosOnly, $random
#   alrEM      : $detection_limit, $max.iter
#   bayesMult  : (none)
#
# Parameters shared across methods:
#   z.warning  – zero fraction per taxon above which a warning is raised
#   z.delete   – if TRUE, taxa exceeding z.warning are removed (FALSE recommended
#                when data are pre-filtered)
compute_zero_repl_clr <- function(
  rel_abund_mat,
  method      = c("multRepl", "pseudo", "alrEM", "bayesMult"),
  frac        = 0.65,    # multRepl: fraction of detection limit used as replacement
  pseudocount = 2e-5,    # pseudo: value added to zeros (or all entries)
  zerosOnly   = FALSE,   # pseudo: if FALSE adds pseudocount to ALL values
  random      = FALSE,   # pseudo: if TRUE and zerosOnly, uses Uniform(eps, pseudocount)
  max.iter    = 20,      # alrEM: maximum EM iterations
  z.warning   = 0.9,
  z.delete    = FALSE
) {
  method <- match.arg(method)
  
  positive_values <- rel_abund_mat[rel_abund_mat > 0]
  if (length(positive_values) == 0) {
    stop("No positive relative abundances found.")
  }
  
  if (method == "multRepl") {
    detection_limit <- min(positive_values, na.rm = TRUE)
    dl_mat <- matrix(detection_limit,
                     nrow = nrow(rel_abund_mat), ncol = ncol(rel_abund_mat),
                     dimnames = dimnames(rel_abund_mat))
    
    rel_abund_repl <- as.matrix(zCompositions::multRepl(
      rel_abund_mat,
      label     = 0,
      dl        = dl_mat,
      frac      = frac,
      z.warning = z.warning,
      z.delete  = z.delete
    ))
    dimnames(rel_abund_repl) <- dimnames(rel_abund_mat)
    
    extra <- list(detection_limit    = detection_limit,
                  replacement_value  = frac * detection_limit,
                  frac               = frac)
    
  } else if (method == "pseudo") {
    rel_abund_repl <- rel_abund_mat
    if (zerosOnly) {
      n_zeros <- sum(rel_abund_repl == 0)
      if (random) {
        rel_abund_repl[rel_abund_repl == 0] <- stats::runif(
          n_zeros, min = .Machine$double.eps, max = pseudocount
        )
      } else {
        rel_abund_repl[rel_abund_repl == 0] <- pseudocount
      }
    } else {
      rel_abund_repl <- rel_abund_repl + pseudocount
    }
    extra <- list(pseudocount = pseudocount, zerosOnly = zerosOnly, random = random)
    
  } else if (method == "alrEM") {
    detection_limit <- min(positive_values, na.rm = TRUE)
    dl_vec <- rep(detection_limit, ncol(rel_abund_mat))
    
    # When every sample has at least one zero, lrEM has no zero-free reference row
    # and cannot initialise its covariance. Workaround (following NetCoMi): augment
    # the matrix with a synthetic row derived from the sample with fewest zeros,
    # then drop it after imputation.
    nzeros_per_sample <- rowSums(rel_abund_mat == 0)
    if (all(nzeros_per_sample > 0)) {
      ref_row <- rel_abund_mat[which.min(nzeros_per_sample)[1], ]
      nz      <- sum(ref_row == 0)
      ref_row <- (1 - nz * detection_limit) * ref_row
      ref_row[ref_row == 0] <- detection_limit
      mat_aug <- rbind(rel_abund_mat, ref_row)
      
      result <- as.matrix(zCompositions::lrEM(
        mat_aug,
        label          = 0,
        dl             = dl_vec,
        ini.cov        = "multRepl",
        max.iter       = max.iter,
        z.warning      = z.warning,
        z.delete       = z.delete,
        suppress.print = TRUE
      ))
      rel_abund_repl <- result[-nrow(result), , drop = FALSE]
    } else {
      rel_abund_repl <- as.matrix(zCompositions::lrEM(
        rel_abund_mat,
        label          = 0,
        dl             = dl_vec,
        ini.cov        = "multRepl",
        max.iter       = max.iter,
        z.warning      = z.warning,
        z.delete       = z.delete,
        suppress.print = TRUE
      ))
    }
    dimnames(rel_abund_repl) <- dimnames(rel_abund_mat)
    extra <- list(detection_limit = detection_limit, max.iter = max.iter)
    
  } else if (method == "bayesMult") {
    rel_abund_repl <- tryCatch(
      as.matrix(zCompositions::cmultRepl(
        rel_abund_mat,
        label          = 0,
        method         = "GBM",
        output         = "prop",
        z.warning      = z.warning,
        z.delete       = z.delete,
        suppress.print = TRUE
      )),
      error = function(e) stop("cmultRepl (GBM) failed: ", conditionMessage(e))
    )
    dimnames(rel_abund_repl) <- dimnames(rel_abund_mat)
    extra <- list()
  }
  
  log_repl <- log(rel_abund_repl)
  z        <- sweep(log_repl, 1, rowMeans(log_repl), "-")
  
  c(list(method = method, rel_abund_repl = rel_abund_repl, z = z), extra)
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

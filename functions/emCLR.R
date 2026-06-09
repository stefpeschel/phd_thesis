### Geometric mean extension ###################################################

# The following function is published in the gitHub repository belonging to the 
# de la Cruz paper:

# Geometric mean
geoMean <- function (x) {
  return(exp(mean(log(x))))
}

geomMeanExtension <- function(dataset, epsilon = 1e-5){
  #geomMeanExtension.R Modification of the geometric mean expression to
  #include datasets with zero values.
  #
  #The formula is:
  #exp(mean(log(dataset+delta)))-delta (Eq. I)
  #where delta is the maximum value such that:
  #   abs([exp(mean(log(dataset_nozeros+delta)))-delta]-geomean(dataset_nozeros))<epsilon*geomean(dataset_nozeros) (Eq. II)
  #where:
  #   dataset_nozeros is obtained removing the zero values of the dataset
  #   geomean: the usual geometric mean
  #
  #input_values
  #   dataset
  #   epsilon: (default value=1e-5)
  #output_values
  #   gmeanE: value of the expression (Eq. I)
  #   delta: value calculated in (Eq. II)
  #
  #Roberto de la Cruz, 06/05/2020
  ########################################################################
  #library("EnvStats")
  
  dataset_nozeros <- dataset[dataset>0]
  geomeanNozeros <- geoMean(dataset_nozeros)
  epsilon <- epsilon*geomeanNozeros
  
  #Simple bisection  method to calculate delta: ( (Eq. I) is increasing as
  #consequence of the Superaddivity of the Geometric Mean)
  deltamin <- 0
  deltamax <- (geomeanNozeros+epsilon)
  while (exp(mean(log(dataset_nozeros+deltamax)))-deltamax < epsilon){#Just for data set with very small standard desviation
    deltamin <- deltamax
    deltamax <- deltamax*2
  }
  delta <- (deltamin+deltamax)/2
  auxExp <- exp(mean(log(dataset_nozeros+delta)))-delta #Define auxExp to not repeat operations
  while ((auxExp-geomeanNozeros)>epsilon){
    if ((auxExp<geomeanNozeros)){
      deltamin <- delta
    } else {
      deltamax <- delta
    }
    delta <- (deltamin+deltamax)/2
    auxExp <- exp(mean(log(dataset_nozeros+delta)))-delta
  }
  gmeanE <- exp(mean(log(dataset+delta)))-delta
  
  #print(paste("Modified geometric mean", gmeanE))
  #print(paste("Delta value", delta))
  return(c(geoMean = gmeanE, delta = delta))
}

# We adapt the function to our needs and write a function that performs the clr 
# transformation using the geometric mean extension. 

# ---- helper: geometric-mean extension delta for a numeric vector -------------
.gme_delta <- function(x, epsilon = 1e-5) {
  x_pos <- x[x > 0]
  if (length(x_pos) == 0L) return(NA_real_)   # row of all zeros → no delta from this row
  
  # usual geometric mean of positive entries
  gmean_pos <- exp(mean(log(x_pos)))
  tol <- epsilon * gmean_pos
  
  # bisection to solve: |exp(mean(log(x_pos + δ))) - δ - gmean_pos| < tol
  deltamin <- 0
  deltamax <- gmean_pos + tol
  # grow deltamax if needed (very low variance case)
  while (exp(mean(log(x_pos + deltamax))) - deltamax < tol) {
    deltamin <- deltamax
    deltamax <- deltamax * 2
  }
  
  delta <- (deltamin + deltamax) / 2
  auxExp <- exp(mean(log(x_pos + delta))) - delta
  # original code uses one-sided stopping (auxExp - gmean_pos > tol)
  while ((auxExp - gmean_pos) > tol) {
    if (auxExp < gmean_pos) {
      deltamin <- delta
    } else {
      deltamax <- delta
    }
    delta  <- (deltamin + deltamax) / 2
    auxExp <- exp(mean(log(x_pos + delta))) - delta
  }
  delta
}

### CLR with geometric-mean extension, using min-delta across rows
# X: matrix / data.frame of nonnegative values (rows = samples, cols = features)
emCLR <- function(X, epsilon = 1e-4) {
  X <- as.matrix(X)
  if (any(!is.finite(X)) || any(X < 0, na.rm = TRUE)) {
    stop("X must be a nonnegative, finite numeric matrix/data.frame.")
  }
  
  # delta per row (NA for all-zero rows)
  delta_row <- apply(X, 1, .gme_delta, epsilon = epsilon)
  
  if (all(is.na(delta_row))) {
    # completely zero matrix -> any delta>0 yields identical rows; CLR = 0
    delta_min <- 1
    L <- log(X + delta_min)
    clr <- L - rowMeans(L)
    return(list(clr = clr, delta_min = delta_min, delta_row = delta_row))
  }
  
  delta_min <- min(delta_row[is.finite(delta_row)], na.rm = TRUE)
  
  # CLR with a single global delta (minimum across rows)
  L <- log(X + delta_min)
  clr <- L - rowMeans(L)
  
  # return
  list(
    clr       = clr,
    delta_min = delta_min,
    delta_row = delta_row
  )
}
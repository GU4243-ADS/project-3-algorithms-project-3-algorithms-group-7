# Expectation Function
expectation <- function(mu, gamma, matrix_k, c) {
  theta <- NULL
  N <- nrow(matrix_k)
  for (i in 1:c) {
    gamma_c <- gamma[((i - 1) * 6 + 1):(6 * i),]
    gamma_c <- as.vector(t(gamma_c))
    gamma_c <- matrix(rep(gamma_c, each = N), nrow = N)
    Di <- matrix_k * gamma_c
    theta_i <- apply(Di, 1, function(x) {
      return(prod(x[x > 0]))
    })
    names(theta_i) <- NULL
    theta <- rbind(theta, theta_i)
  }
  mu_repeat <- matrix(rep(mu, each = N), nrow = N)
  upper <- t(mu_repeat) * theta
  sum <- colSums(upper, na.rm = TRUE)
  lower <- matrix(rep(sum, each = c), nrow = c)
  pi <- upper / lower
  pi[is.na(pi)] <- 10 ^ (-100)
  return(pi)
}

# Maximization Function
maximization <- function(pi, matrix_k, c) {
  N <- ncol(matrix_k)
  
  # Estimate mu
  mu <- rowSums(pi, na.rm = TRUE) / ncol(pi)
  
  # Estimate gamma
  summation <- rowSums(pi, na.rm = TRUE)
  lower <- matrix(rep(summation, each = N), nrow = N)
  gamma_temp <- NULL
  for (k in 1:6) {
    data <- as.matrix(matrix_k)
    data[data != k] <- 0
    data[data == k] <- 1
    upper <- pi %*% data
    gamma_k <- upper / t(lower)
    gamma_k <- as.vector(t(gamma_k))
    gamma_temp <- rbind(gamma_temp, gamma_k)
  }
  # End of gamma calculation for each k
  
  gamma <- NULL
  for (i in 1:c) {
    temp <- gamma_temp[, ((i - 1) * N + 1):(i * N)]
    gamma <- rbind(gamma, temp)
  }
  mu[is.na(mu)] <- 10 ^ (-100)
  gamma[is.na(gamma)] <- 10 ^ (-100)
  re <- list(mu, gamma)
  return(re)
}


# Expectation Maximization Algorithm
EM <-
  function(data, matrix_k, mu_inits, gamma_inits, c, maxit = 100, tolerance = 1e-5)
  {
    # Initial estimation of parameters
    flag <- FALSE
    mu_cur <- mu_inits
    gamma_cur <- gamma_inits
    
    # Iterate between expectation and maximization steps.
    for (i in 1:maxit) {
      cur <- c(mu_cur, gamma_cur)
      new <-
        maximization(expectation(mu_cur, gamma_cur, data, c), matrix_k, c)
      mu_new <- new[[1]]
      gamma_new <- new[[2]]
      new_step <- c(mu_new, gamma_new)
      
      # Stop iteration if the difference between current and new estimates
      # is less than a tolerance level.
      if (all(abs(cur - new_step) < tolerance)) {
        flag <- TRUE
        break
        }
      
      # Otherwise, continue iteration.
      mu_cur <- mu_new
      gamma_cur <- gamma_new
    }
    
    # Note algorithm failure if convergence isn't achieved.
    if (!flag)
      warning("Didn't converge\n")
    
    # Return final `mu` and `gamma` values.
    em <- list(mu_cur, gamma_cur)
    return(em)
  }
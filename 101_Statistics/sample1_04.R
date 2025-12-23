nPr <- function(n, r) {
  factorial(n) / factorial(n - r)
}

nCr <- function(n, r) {
  factorial(n) / (factorial(r) * factorial(n - r))
}

main <- function() {
  print(paste("5!  : ", factorial(5)))
  print(paste("nPr : ", factorial(5)/factorial(5-3)))
  print(paste("nCr : ", choose(5, 3)))

  print(paste("nPr : ", nPr(5, 3)))
  print(paste("nCr : ", nCr(5, 3)))

  PA <- c(1, 2, 3, 4)
  PB <- c(2, 3, 4, 5, 6)
  cat("A u B :", union(PA, PB), "\n")
  cat("A n B :", intersect(PA, PB), "\n")
  cat("A - B :", setdiff(PA, PB), "\n")
  cat("B - A :", setdiff(PB, PA), "\n")

  P_A_given_B <- length(intersect(PA, PB)) / length(PB)
  cat("P_A_given_B :", P_A_given_B, "\n")

}

main()

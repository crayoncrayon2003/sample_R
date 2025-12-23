
main <- function() {
  cat("########################", "\n")
  cat("二項分布", "\n")
  n <- 10
  p <- 0.3

  E <- n * p
  V <- n * p * (1 - p)

  cat("期待値 :", E, "\n")
  cat("分散   :", V, "\n")


  n <- 10
  p <- 0.3

  x <- 0:n
  px <- dbinom(x, size = n, prob = p)

  E <- sum(x * px)
  V <- sum((x - E)^2 * px)

  cat("期待値 :", E, "\n")
  cat("分散   :", V, "\n")


  cat("########################", "\n")
  cat("ポアソン分布", "\n")
  lambda <- 3

  E <- lambda
  V <- lambda

  cat("期待値 :", E, "\n")
  cat("分散   :", V, "\n")

  lambda <- 3
  x <- 0:20   # 十分大きく取る
  px <- dpois(x, lambda)

  E <- sum(x * px)
  V <- sum((x - E)^2 * px)

  cat("期待値 :", E, "\n")
  cat("分散   :", V, "\n")

  cat("########################", "\n")
  cat("幾何分布", "\n")
  p <- 0.4

  E <- (1 - p) / p
  V <- (1 - p) / p^2

  cat("期待値 :", E, "\n")
  cat("分散   :", V, "\n")

  p <- 0.4
  x <- 0:50
  px <- dgeom(x, prob = p)

  E <- sum(x * px)
  V <- sum((x - E)^2 * px)

  cat("期待値 :", E, "\n")
  cat("分散   :", V, "\n")


  cat("########################", "\n")
  cat("正規分布", "\n")
  mu <- 50
  sigma <- 10

  E <- mu
  V <- sigma^2

  cat("期待値 :", E, "\n")
  cat("分散   :", V, "\n")


  mu <- 50
  sigma <- 10

  E <- integrate(
    function(x) x * dnorm(x, mean = mu, sd = sigma),
    -Inf, Inf
  )$value

  V <- integrate(
    function(x) (x - mu)^2 * dnorm(x, mean = mu, sd = sigma),
    -Inf, Inf
  )$value

  cat("期待値 :", E, "\n")
  cat("分散   :", V, "\n")


  cat("########################", "\n")
  cat("指数分布", "\n")
  lambda <- 2

  E <- 1 / lambda
  V <- 1 / lambda^2

  cat("期待値 :", E, "\n")
  cat("分散   :", V, "\n")


  lambda <- 2

  E <- integrate(
    function(x) x * dexp(x, rate = lambda),
    0, Inf
  )$value

  V <- integrate(
    function(x) (x - E)^2 * dexp(x, rate = lambda),
    0, Inf
  )$value

  cat("期待値 :", E, "\n")
  cat("分散   :", V, "\n")


  cat("########################", "\n")
  cat("離散一様分布", "\n")

  a <- 1
  b <- 6

  E <- (a + b) / 2
  V <- ((b - a + 1)^2 - 1) / 12

  cat("期待値 :", E, "\n")
  cat("分散   :", V, "\n")


  set.seed(1)
  x <- sample(1:6, size = 100000, replace = TRUE)

  E <- mean(x)
  V <- var(x)

  cat("期待値 :", E, "\n")
  cat("分散   :", V, "\n")


  cat("########################", "\n")
  cat("連続一様分布", "\n")
  a <- 0
  b <- 10

  E <- (a + b) / 2
  V <- (b - a)^2 / 12

  cat("期待値 :", E, "\n")
  cat("分散   :", V, "\n")

  a <- 0
  b <- 10

  E <- integrate(
    function(x) x * dunif(x, a, b),
    a, b
  )$value

  V <- integrate(
    function(x) (x - E)^2 * dunif(x, a, b),
    a, b
  )$value

  cat("期待値 :", E, "\n")
  cat("分散   :", V, "\n")

  cat("########################", "\n")
  cat("カイ二乗分布", "\n")
  k <- 5

  E <- k
  V <- 2 * k

  cat("期待値 :", E, "\n")
  cat("分散   :", V, "\n")


  k <- 5

  E <- integrate(
    function(x) x * dchisq(x, df = k),
    0, Inf
  )$value

  V <- integrate(
    function(x) (x - E)^2 * dchisq(x, df = k),
    0, Inf
  )$value

  cat("期待値 :", E, "\n")
  cat("分散   :", V, "\n")

  cat("########################", "\n")
  cat("t分布", "\n")
  nu <- 10

  E <- if (nu > 1) 0 else NA
  V <- if (nu > 2) nu / (nu - 2) else NA

  cat("期待値 :", E, "\n")
  cat("分散   :", V, "\n")

  E <- integrate(
    function(x) x * dt(x, df = nu),
    -Inf, Inf
  )$value

  V <- integrate(
    function(x) (x - E)^2 * dt(x, df = nu),
    -Inf, Inf
  )$value

  cat("期待値 :", E, "\n")
  cat("分散   :", V, "\n")

}


main()

main <- function() {
  cat("########################################################################\n")
  cat("連続一様分布\n")
  cat("区間 [a, b] の中で、すべての値が同じ確率密度をもつ連続分布\n")

  a <- 0
  b <- 10

  # --- 理論値 ---
  E <- (a + b) / 2
  V <- (b - a)^2 / 12

  cat("期待値（理論） :", E, "\n")
  cat("分散（理論）   :", V, "\n")


  # --- dunif：確率密度関数による確認 ---
  E2 <- integrate(
    function(x) x * dunif(x, min = a, max = b),
    a, b
  )$value

  V2 <- integrate(
    function(x) (x - E)^2 * dunif(x, min = a, max = b),
    a, b
  )$value

  cat("期待値（dunif） :", E2, "\n")
  cat("分散（dunif）   :", V2, "\n")


  # --- punif：累積分布関数 ---
  k <- 4
  pk <- punif(k, min = a, max = b)
  cat("P(X ≤", k, ") =", pk, "\n")


  # --- qunif：分位点 ---
  alpha <- 0.95
  q <- qunif(alpha, min = a, max = b)
  cat(alpha * 100, "% 分位点 =", q, "\n")


  # --- runif：乱数生成 ---
  set.seed(123)
  samples <- runif(1000, min = a, max = b)
  cat("シミュレーション結果（X を1000回観測）\n")


  # --- 可視化：ヒストグラム + 理論密度 ---
  hist(
    samples,
    probability = TRUE,
    col = "lightgray",
    border = "white",
    xlab = "値",
    ylab = "密度",
    main = "連続一様分布：理論分布 vs シミュレーション"
  )

  curve(
    dunif(x, min = a, max = b),
    from = a,
    to = b,
    col = "red",
    lwd = 2,
    add = TRUE
  )
}

main()

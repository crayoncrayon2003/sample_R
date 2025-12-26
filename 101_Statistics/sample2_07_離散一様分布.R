main <- function() {
  cat("########################################################################\n")
  cat("離散一様分布\n")
  cat("整数 a から b までの値が、すべて同じ確率で出現する分布\n")

  a <- 1
  b <- 6
  x <- a:b

  # --- 理論値 ---
  E <- (a + b) / 2
  V <- ((b - a + 1)^2 - 1) / 12

  cat("期待値（理論） :", E, "\n")
  cat("分散（理論）   :", V, "\n")


  # --- 確率質量関数（手動定義） ---
  px <- rep(1 / length(x), length(x))

  E <- sum(x * px)
  V <- sum((x - E)^2 * px)

  cat("期待値（d*） :", E, "\n")
  cat("分散（d*）   :", V, "\n")


  # --- 累積分布関数 ---
  cdf <- cumsum(px)
  k <- 4
  pk <- cdf[x == k]
  cat("P(X ≤", k, ") =", pk, "\n")


  # --- 分位点 ---
  alpha <- 0.95
  q <- x[min(which(cdf >= alpha))]
  cat(alpha * 100, "% 分位点 =", q, "\n")


  # --- 乱数生成 ---
  set.seed(1)
  samples <- sample(x, size = 1000, replace = TRUE)
  cat("シミュレーション結果（X を1000回観測）\n")


  # --- シミュレーション分布 ---
  freq <- table(samples) / length(samples)
  cat("シミュレーション分布（相対度数） :", freq, "\n")


  # --- 可視化：棒グラフ + 理論分布 ---
  bp <- barplot(
    freq,
    ylim = c(0, max(px, freq)),
    col = "lightgray",
    xlab = "値",
    ylab = "確率",
    main = "離散一様分布：理論分布 vs シミュレーション"
  )

  # 理論確率を重ねる
  points(bp, px, col = "red", pch = 16)
  lines(bp, px, col = "red", lwd = 2)
}

main()

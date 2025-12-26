
main <- function() {
  cat("########################################################################\n")
  cat("二項分布\n")
  cat("成功／失敗の2通りの結果を持つ試行を、成功確率 p で、同一条件のもとに n 回試行したときの成功回数の分布\n")

  n <- 10     # 硬貨を10回投げる
  p <- 0.5    # 表が出る確率

  # --- 理論値 ---
  E <- n * p
  V <- n * p * (1 - p)

  cat("期待値（理論） :", E, "\n")
  cat("分散（理論）   :", V, "\n")

  # --- dbinom：確率質量関数 ---
  # 成功回数 x = 0,1,2,...,n に対する確率
  x <- 0:n
  px <- dbinom(x, size = n, prob = p)
  cat("理論分布 :", px, "\n")

  E <- sum(x * px)
  V <- sum((x - E)^2 * px)

  cat("期待値（dbinom） :", E, "\n")
  cat("分散（dbinom）   :", V, "\n")


  # --- pbinom：累積分布関数 ---
  # 硬貨を10回投げて、コインの表が出る回数が3回以下の確率
  k <- 3
  pk <- pbinom(k, size = n, prob = p)
  cat("P(X ≤", k, ") =", pk, "\n")


  # --- qbinom：分位点 ---
  alpha <- 0.95
  q <- qbinom(alpha, size = n, prob = p)
  cat(alpha * 100, "% 分位点 =", q, "\n")


  # --- rbinom：乱数生成 ---
  # 成功確率 p の n回試行を、5回繰り返す
  set.seed(123)
  samples <- rbinom(5, size = n, prob = p)
  cat("シミュレーション結果（X を5回観測） :", samples, "\n")
  # 乱数（rbinom） : 2 4 3 5 5
  #　1回目の10回の試行は、成功が2回
  #　2回目の10回の試行は、成功が4回
  #　...
  #　5回目の10回の試行は、成功が5回

  # 5回繰り返した試行を1回分にまとめて、頻度分布を計算する
  freq <- table(samples) / length(samples)
  cat("シミュレーション分布（1回分相対度数） :", freq, "\n")

  barplot(
    freq,
    ylim = c(0, max(px, freq)),
    col = "lightgray",
    xlab = "成功回数",
    ylab = "確率",
    main = "理論分布 vs シミュレーション"
  )

  points(1:length(px), px, col = "red", pch = 16)
  lines(1:length(px), px, col = "red", lwd = 2)

}


main()

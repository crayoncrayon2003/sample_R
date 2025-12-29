
main <- function() {
  cat("########################################################################\n")
  cat("ベルヌーイ分布\n")
  cat("成功／失敗の2通りの結果を持つ試行を、成功確率 p で、同一条件のもとに 1 回試行したときの成功回数の分布\n")

  # 例１：表が出る確率 0.5 の硬貨を 1 回投げたときの、表の出た回数の分布
  # 例２：不良率 0.5 の製品を 1 回検査したときの、不良品の個数の分布

  n <- 1
  p <- 0.5

  # --- 理論値 ---
  E <- p
  V <- p * (1 - p)

  cat("期待値（理論） :", E, "\n")
  cat("分散（理論）   :", V, "\n")

  # --- dbinom：確率質量関数 ---
  # 成功回数 x = 0,1 に対する確率
  x <- 0:n
  px <- dbinom(x, size = n, prob = p)
  cat("理論分布 :", px, "\n")

  E <- sum(x * px)
  V <- sum((x - E)^2 * px)

  cat("期待値（dbinom） :", E, "\n")
  cat("分散（dbinom）   :", V, "\n")


  # --- pbinom：累積分布関数 ---
  # 硬貨を1回投げて、コインの表が出る回数が1回以下の確率
  k <- 1
  pk <- pbinom(k, size = n, prob = p)
  cat("P(X ≤", k, ") =", pk, "\n")


  # --- qbinom：分位点 ---
  alpha <- 0.95
  q <- qbinom(alpha, size = n, prob = p)
  cat(alpha * 100, "% 分位点 =", q, "\n")


  # --- rbinom：乱数生成 ---
  # 成功確率 p の 1回試行を、5回繰り返す
  set.seed(123)
  samples <- rbinom(5, size = n, prob = p)
  cat("シミュレーション結果（X を5回観測） :", samples, "\n")
  # 乱数（rbinom） : 0 1 0 1 1
  #　1回目の1回の試行は、成功が0回
  #　2回目の1回の試行は、成功が1回
  #　...
  #　5回目の1回の試行は、成功が1回

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

  points(c(1, 2), px, col = "red", pch = 16)
  lines(c(1, 2), px, col = "red", lwd = 2)

}


main()

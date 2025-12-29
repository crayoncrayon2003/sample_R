
main <- function() {
  cat("########################################################################\n")
  cat("ポアソン分布\n")
  cat("単位時間や単位区間あたりに、平均発生回数 λ で発生する事象に対して、実際の発生回数の分布\n")

  # 例１：1分間に非常に多くのコイン投げをしたときの表の個数が、平均発生回数 λ = 3（1分あたり平均3個の表）
  # 例２：1時間あたりに発生する不良品の個数が、平均発生回数λ = 3（1時間に平均3個の不良）

  lambda <- 3

  # --- 理論値 ---
  E <- lambda
  V <- lambda

  cat("期待値（理論） :", E, "\n")
  cat("分散（理論）   :", V, "\n")

  # --- dpois：確率質量関数 ---
  x <- 0:20   # 十分大きく取る
  px <- dpois(x, lambda)
  cat("理論分布 :", px, "\n")

  E <- sum(x * px)
  V <- sum((x - E)^2 * px)

  cat("期待値（dpois） :", E, "\n")
  cat("分散（dpois）   :", V, "\n")

  # --- ppois：累積分布関数 ---
  k <- 3
  pk <- ppois(k, lambda)
  cat("P(X ≤", k, ") =", pk, "\n")


  # --- qpois：分位点 ---
  alpha <- 0.95
  q <- qpois(alpha, lambda)
  cat(alpha * 100, "% 分位点 =", q, "\n")

  # --- rpois：乱数生成 ---
  set.seed(123)
  samples <- rpois(1000, lambda)
  cat("乱数（rpois） :", samples, "\n")
  cat("シミュレーション結果（X を1000回観測） :", samples, "\n")
  # 乱数（rpois） : 2 4 2 5 6
  #　1回目の1回の試行は、2回発生
  #　2回目の1回の試行は、4回発生
  #　...
  #　5回目の1回の試行は、6回発生

  freq <- table(samples) / length(samples)
  cat("シミュレーション分布（1回分相対度数） :", freq, "\n")

  bp <- barplot(
    freq,
    ylim = c(0, max(px, freq)),
    col = "lightgray",
    xlab = "発生回数",
    ylab = "確率",
    main = "理論分布 vs シミュレーション"
  )

  # freq の名前（= 発生回数）に対応する理論確率を取得
  k_obs <- as.numeric(names(freq))
  px_obs <- dpois(k_obs, lambda)

  points(bp, px_obs, col = "red", pch = 16)
  lines(bp, px_obs, col = "red", lwd = 2)

}


main()


main <- function() {
  cat("########################################################################\n")
  cat("幾何分布\n")
  cat("成功確率 p の試行を繰り返したとき、最初に成功するまでの失敗回数の分布\n")

  # 例１：表が出る確率 p = 0.4 の硬貨を投げ続けたとき、最初に表が出るまでに裏が何回続くかの分布
  # 例２：不良率 p = 0.4 の製品を1つずつ検査したとき、最初に不良品が見つかるまでに、良品が何個続くかの分布

  p <- 0.4

  # --- 理論値 ---
  E <- (1 - p) / p
  V <- (1 - p) / p^2

  cat("期待値（理論） :", E, "\n")
  cat("分散（理論）   :", V, "\n")


  # --- dgeom：確率質量関数 ---
  x <- 0:50   # 失敗回数（0,1,2,..50）
  px <- dgeom(x, prob = p)

  E <- sum(x * px)
  V <- sum((x - E)^2 * px)

  cat("期待値（dgeom） :", E, "\n")
  cat("分散（dgeom）   :", V, "\n")


  # --- pgeom：累積分布関数 ---
  k <- 3
  pk <- pgeom(k, prob = p)
  cat("P(X ≤", k, ") =", pk, "\n")


  # --- qgeom：分位点 ---
  alpha <- 0.95
  q <- qgeom(alpha, prob = p)
  cat(alpha * 100, "% 分位点 =", q, "\n")


  # --- rgeom：乱数生成 ---
  set.seed(123)
  samples <- rgeom(5, prob = p)
  cat("シミュレーション結果（X を5回観測） :", samples, "\n")
  # 乱数（rgeom） : 2 4 0 0 0
  # 1回目の試行：成功までに失敗が2回
  # 2回目の試行：成功までに失敗が4回
  # ...
  # 5回目の試行：成功までに失敗が0回

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

  # 失敗回数に対応する理論確率
  k_obs <- as.numeric(names(freq))
  px_obs <- dgeom(k_obs, prob = p)
  points(bp, px_obs, col = "red", pch = 16)
  lines(bp, px_obs, col = "red", lwd = 2)

}


main()

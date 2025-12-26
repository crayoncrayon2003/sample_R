main <- function() {
  cat("########################################################################\n")
  cat("F分布\n")
  cat("2つの独立なカイ二乗分布の比から定義される、分散の比を表す連続分布\n")

  d1 <- 5   # 分子の自由度
  d2 <- 10  # 分母の自由度

  # --- 理論値（存在条件つき） ---
  E_theory <- if (d2 > 2) d2 / (d2 - 2) else NA
  V_theory <- if (d2 > 4) {
    2 * d2^2 * (d1 + d2 - 2) / (d1 * (d2 - 2)^2 * (d2 - 4))
  } else NA

  cat("期待値（理論） :", E_theory, "\n")
  cat("分散（理論）   :", V_theory, "\n")


  # --- df：確率密度関数による確認 ---
  # 数値積分は上限を有限値にする（F分布は裾が重い）
  E_df <- integrate(
    function(x) x * df(x, df1 = d1, df2 = d2),
    0, 100
  )$value

  V_df <- integrate(
    function(x) (x - E_df)^2 * df(x, df1 = d1, df2 = d2),
    0, 100
  )$value

  cat("期待値（df） :", E_df, "\n")
  cat("分散（df）   :", V_df, "\n")


  # --- pf：累積分布関数 ---
  x0 <- 2
  pk <- pf(x0, df1 = d1, df2 = d2)
  cat("P(X ≤", x0, ") =", pk, "\n")


  # --- qf：分位点 ---
  alpha <- 0.95
  q <- qf(alpha, df1 = d1, df2 = d2)
  cat(alpha * 100, "% 分位点 =", q, "\n")


  # --- rf：乱数生成 ---
  set.seed(123)
  samples <- rf(1000, df1 = d1, df2 = d2)
  cat("シミュレーション結果（X を1000回観測）\n")


  # --- 可視化：ヒストグラム + 理論密度 ---
  hist(
    samples,
    probability = TRUE,
    col = "lightgray",
    border = "white",
    xlim = c(0, 5),
    xlab = "値",
    ylab = "密度",
    main = paste("F分布（df1 =", d1, ", df2 =", d2, "）")
  )

  curve(
    df(x, df1 = d1, df2 = d2),
    from = 0,
    to = 5,
    col = "red",
    lwd = 2,
    add = TRUE
  )
}

main()

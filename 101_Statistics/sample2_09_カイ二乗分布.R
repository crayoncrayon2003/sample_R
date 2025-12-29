main <- function() {
  cat("########################################################################\n")
  cat("カイ二乗分布\n")
  cat("自由度 k をもつ、正規分布に従う変数の平方和として定義される連続分布\n")

  # 例1：あるテストは、平均 50 点 標準偏差 10 点の正規分布に従うと想定されている。
  # 学生 5 人の（「各点数‐平均点」／標準偏差）は、自由度5のカイ2乗分布に従う
  # ->「データがどれだけズレているか」を数値化した結果の分布

  k <- 5

  # --- 理論値 ---
  E <- k
  V <- 2 * k

  cat("期待値（理論） :", E, "\n")
  cat("分散（理論）   :", V, "\n")


  # --- dchisq：確率密度関数による確認 ---
  E2 <- integrate(
    function(x) x * dchisq(x, df = k),
    0, Inf
  )$value

  V2 <- integrate(
    function(x) (x - E2)^2 * dchisq(x, df = k),
    0, Inf
  )$value

  cat("期待値（dchisq） :", E2, "\n")
  cat("分散（dchisq）   :", V2, "\n")


  # --- pchisq：累積分布関数 ---
  x0 <- 7
  pk <- pchisq(x0, df = k)
  cat("P(X ≤", x0, ") =", pk, "\n")


  # --- qchisq：分位点 ---
  alpha <- 0.95
  q <- qchisq(alpha, df = k)
  cat(alpha * 100, "% 分位点 =", q, "\n")


  # --- rchisq：乱数生成 ---
  set.seed(123)
  samples <- rchisq(1000, df = k)
  cat("シミュレーション結果（X を1000回観測）\n")


  # --- 可視化：ヒストグラム + 理論密度 ---
  hist(
    samples,
    probability = TRUE,
    col = "lightgray",
    border = "white",
    xlab = "値",
    ylab = "密度",
    main = paste("カイ二乗分布（自由度", k, "）")
  )

  curve(
    dchisq(x, df = k),
    from = 0,
    to = max(samples),
    col = "red",
    lwd = 2,
    add = TRUE
  )
}

main()

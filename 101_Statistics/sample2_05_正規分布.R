
main <- function() {
  cat("########################################################################\n")
  cat("正規分布\n")
  cat("平均 μ、分散 σ^2 をもつ連続的な確率分布\n")

  # 例１：平均点が 50 点、標準偏差が 10 点の試験で、学生1人あたりのテスト得点の分布
  # 例２：平均 50 g、標準偏差 10 g の製品重量の分布
  #
  # コイン・不具合は「離散・二値」のため、そのままでは正規分布で表現できない。
  # ただし試行回数が十分に大きい場合は、中心極限定理により正規分布で近似できる。
  # 例３：表が出る確率 p = 0.5 のコインを 1000 回投げたときの 「表の個数」の二項分布は、中心極限定理により平均 500、分散 250 の正規分布に近づく。
  # 例４：不良率 p = 0.5 の製品を 10,000 個検査したときの「不良品個数」の二項分布は、中心極限定理により平均 5,000、分散 2,500 の正規分布に近づく。

  mu <- 50
  sigma <- 10

  # --- 理論値 ---
  E <- mu
  V <- sigma^2

  cat("期待値（理論） :", E, "\n")
  cat("分散（理論）   :", V, "\n")


  # --- dnorm：確率密度関数による期待値・分散 ---
  E <- integrate(
    function(x) x * dnorm(x, mean = mu, sd = sigma),
    -Inf, Inf
  )$value

  V <- integrate(
    function(x) (x - mu)^2 * dnorm(x, mean = mu, sd = sigma),
    -Inf, Inf
  )$value

  cat("期待値（dnorm） :", E, "\n")
  cat("分散（dnorm）   :", V, "\n")


  # --- pnorm：累積分布関数 ---
  k <- 60
  pk <- pnorm(k, mean = mu, sd = sigma)
  cat("P(X ≤", k, ") =", pk, "\n")


  # --- qnorm：分位点 ---
  alpha <- 0.95
  q <- qnorm(alpha, mean = mu, sd = sigma)
  cat(alpha * 100, "% 分位点 =", q, "\n")


  # --- rnorm：乱数生成 ---
  set.seed(123)
  samples <- rnorm(1000, mean = mu, sd = sigma)
  cat("シミュレーション結果（X を1000回観測）\n")


  # --- 可視化：ヒストグラム＋理論密度 ---
  hist(
    samples,
    probability = TRUE,
    col = "lightgray",
    border = "white",
    xlab = "値",
    ylab = "密度",
    main = "正規分布：理論密度 vs シミュレーション"
  )

  curve(
    dnorm(x, mean = mu, sd = sigma),
    col = "red",
    lwd = 2,
    add = TRUE
  )
}


main()

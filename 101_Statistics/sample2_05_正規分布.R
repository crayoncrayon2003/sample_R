
main <- function() {
  cat("########################################################################\n")
  cat("正規分布\n")
  cat("平均 μ、分散 σ^2 をもつ連続的な確率分布\n")

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

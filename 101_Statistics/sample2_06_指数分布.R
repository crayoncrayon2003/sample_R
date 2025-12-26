main <- function() {
  cat("########################################################################\n")
  cat("指数分布\n")
  cat("一定の割合 λ で事象が発生するとき、次に発生するまでの待ち時間の分布\n")

  lambda <- 2

  # --- 理論値 ---
  E <- 1 / lambda
  V <- 1 / lambda^2

  cat("期待値（理論） :", E, "\n")
  cat("分散（理論）   :", V, "\n")


  # --- dexp：確率密度関数による期待値・分散 ---
  E <- integrate(
    function(x) x * dexp(x, rate = lambda),
    0, Inf
  )$value

  V <- integrate(
    function(x) (x - E)^2 * dexp(x, rate = lambda),
    0, Inf
  )$value

  cat("期待値（dexp） :", E, "\n")
  cat("分散（dexp）   :", V, "\n")


  # --- pexp：累積分布関数 ---
  t <- 1
  pt <- pexp(t, rate = lambda)
  cat("P(X ≤", t, ") =", pt, "\n")


  # --- qexp：分位点 ---
  alpha <- 0.95
  q <- qexp(alpha, rate = lambda)
  cat(alpha * 100, "% 分位点 =", q, "\n")


  # --- rexp：乱数生成 ---
  set.seed(123)
  samples <- rexp(1000, rate = lambda)
  cat("シミュレーション結果（X を1000回観測）\n")


  # --- 可視化：ヒストグラム + 理論密度 ---
  hist(
    samples,
    probability = TRUE,
    col = "lightgray",
    border = "white",
    xlab = "待ち時間",
    ylab = "密度",
    main = "指数分布：理論分布 vs シミュレーション"
  )

  curve(
    dexp(x, rate = lambda),
    from = 0,
    to = max(samples),
    col = "red",
    lwd = 2,
    add = TRUE
  )
}

main()

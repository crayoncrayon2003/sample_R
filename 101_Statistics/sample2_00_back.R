
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
    main = "二項分布：理論分布 vs シミュレーション"
  )

  points(1:length(px), px, col = "red", pch = 16)
  lines(1:length(px), px, col = "red", lwd = 2)

  cat("########################################################################\n")
  cat("ベルヌーイ分布\n")
  cat("成功／失敗の2通りの結果を持つ試行を、成功確率 p で、同一条件のもとに 1 回試行したときの成功回数の分布\n")

  p <- 0.3

  # --- 理論値 ---
  E <- p
  V <- p * (1 - p)

  cat("期待値（理論） :", E, "\n")
  cat("分散（理論）   :", V, "\n")


  # --- dbinom：確率質量関数（n = 1） ---
  x <- 0:1
  px <- dbinom(x, size = 1, prob = p)

  E <- sum(x * px)
  V <- sum((x - E)^2 * px)

  cat("期待値（dbinom） :", E, "\n")
  cat("分散（dbinom）   :", V, "\n")


  # --- pbinom：累積分布関数 ---
  k <- 1
  pk <- pbinom(k, size = 1, prob = p)
  cat("P(X ≤", k, ") =", pk, "\n")


  # --- qbinom：分位点 ---
  alpha <- 0.95
  q <- qbinom(alpha, size = 1, prob = p)
  cat(alpha * 100, "% 分位点 =", q, "\n")


  # --- rbinom：乱数生成 ---
  set.seed(123)
  samples <- rbinom(5, size = 1, prob = p)
  cat("乱数（rbinom） :", samples, "\n")


  cat("########################################################################\n")
  cat("ポアソン分布\n")
  cat("単位時間や単位区間あたりに、平均発生回数 λ で発生する事象に対して、実際の発生回数の分布\n")

  lambda <- 3

  # --- 理論値 ---
  E <- lambda
  V <- lambda

  cat("期待値（理論） :", E, "\n")
  cat("分散（理論）   :", V, "\n")

  # --- dpois：確率質量関数 ---
  x <- 0:20   # 十分大きく取る
  px <- dpois(x, lambda)

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
  samples <- rpois(5, lambda)
  cat("乱数（rpois） :", samples, "\n")

  cat("########################################################################\n")
  cat("幾何分布\n")
  cat("成功確率 p の試行を繰り返したとき、最初に成功するまでの失敗回数の分布\n")

  p <- 0.4

  # --- 理論値 ---
  E <- (1 - p) / p
  V <- (1 - p) / p^2

  cat("期待値（理論） :", E, "\n")
  cat("分散（理論）   :", V, "\n")


  # --- dgeom：確率質量関数 ---
  x <- 0:50   # 失敗回数（0,1,2,...）
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
  cat("乱数（rgeom） :", samples, "\n")

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


  # --- dnorm：確率密度関数 ---
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
  samples <- rnorm(5, mean = mu, sd = sigma)
  cat("乱数（rnorm） :", samples, "\n")


  cat("########################################################################\n")
  cat("指数分布\n")
  cat("一定の割合 λ で事象が発生するとき、次に発生するまでの待ち時間の分布\n")

  lambda <- 2

  # --- 理論値 ---
  E <- 1 / lambda
  V <- 1 / lambda^2

  cat("期待値（理論） :", E, "\n")
  cat("分散（理論）   :", V, "\n")


  # --- dexp：確率密度関数 ---
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
  samples <- rexp(5, rate = lambda)
  cat("乱数（rexp） :", samples, "\n")

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


  # --- d*：確率質量関数（手動定義） ---
  px <- rep(1 / length(x), length(x))

  E <- sum(x * px)
  V <- sum((x - E)^2 * px)

  cat("期待値（d*） :", E, "\n")
  cat("分散（d*）   :", V, "\n")


  # --- p*：累積分布関数 ---
  cdf <- cumsum(px)
  k <- 4
  pk <- cdf[x == k]
  cat("P(X ≤", k, ") =", pk, "\n")


  # --- q*：分位点 ---
  alpha <- 0.95
  q <- x[min(which(cdf >= alpha))]
  cat(alpha * 100, "% 分位点 =", q, "\n")


  # --- r*：乱数生成 ---
  set.seed(1)
  samples <- sample(x, size = 5, replace = TRUE)
  cat("乱数（sample） :", samples, "\n")


  cat("########################################################################\n")
  cat("連続一様分布\n")
  cat("区間 [a, b] の中で、すべての値が同じ確率密度をもつ連続分布\n")

  a <- 0
  b <- 10

  # --- 理論値 ---
  E <- (a + b) / 2
  V <- (b - a)^2 / 12

  cat("期待値（理論） :", E, "\n")
  cat("分散（理論）   :", V, "\n")


  # --- dunif：確率密度関数 ---
  E <- integrate(
    function(x) x * dunif(x, min = a, max = b),
    a, b
  )$value

  V <- integrate(
    function(x) (x - E)^2 * dunif(x, min = a, max = b),
    a, b
  )$value

  cat("期待値（dunif） :", E, "\n")
  cat("分散（dunif）   :", V, "\n")


  # --- punif：累積分布関数 ---
  k <- 4
  pk <- punif(k, min = a, max = b)
  cat("P(X ≤", k, ") =", pk, "\n")


  # --- qunif：分位点 ---
  alpha <- 0.95
  q <- qunif(alpha, min = a, max = b)
  cat(alpha * 100, "% 分位点 =", q, "\n")


  # --- runif：乱数生成 ---
  set.seed(123)
  samples <- runif(5, min = a, max = b)
  cat("乱数（runif） :", samples, "\n")

  cat("########################################################################\n")
  cat("カイ二乗分布\n")
  cat("自由度 k をもつ、正規分布に従う変数の平方和として定義される連続分布\n")

  k <- 5

  # --- 理論値 ---
  E <- k
  V <- 2 * k

  cat("期待値（理論） :", E, "\n")
  cat("分散（理論）   :", V, "\n")


  # --- dchisq：確率密度関数 ---
  E <- integrate(
    function(x) x * dchisq(x, df = k),
    0, Inf
  )$value

  V <- integrate(
    function(x) (x - E)^2 * dchisq(x, df = k),
    0, Inf
  )$value

  cat("期待値（dchisq） :", E, "\n")
  cat("分散（dchisq）   :", V, "\n")


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
  samples <- rchisq(5, df = k)
  cat("乱数（rchisq） :", samples, "\n")

  cat("########################################################################\n")
  cat("t分布\n")
  cat("自由度 ν をもつ、正規分布に比べて裾の重い連続確率分布\n")

  nu <- 10

  # --- 理論値（存在条件つき） ---
  E <- if (nu > 1) 0 else NA
  V <- if (nu > 2) nu / (nu - 2) else NA

  cat("期待値（理論） :", E, "\n")
  cat("分散（理論）   :", V, "\n")


  # --- dt：確率密度関数 ---
  E <- integrate(
    function(x) x * dt(x, df = nu),
    -Inf, Inf
  )$value

  V <- integrate(
    function(x) (x - E)^2 * dt(x, df = nu),
    -Inf, Inf
  )$value

  cat("期待値（dt） :", E, "\n")
  cat("分散（dt）   :", V, "\n")


  # --- pt：累積分布関数 ---
  x0 <- 1.5
  pk <- pt(x0, df = nu)
  cat("P(X ≤", x0, ") =", pk, "\n")


  # --- qt：分位点 ---
  alpha <- 0.95
  q <- qt(alpha, df = nu)
  cat(alpha * 100, "% 分位点 =", q, "\n")


  # --- rt：乱数生成 ---
  set.seed(123)
  samples <- rt(5, df = nu)
  cat("乱数（rt） :", samples, "\n")

  cat("########################################################################\n")
  cat("F分布\n")
  cat("2つの独立なカイ二乗分布の比から定義される、分散の比を表す連続分布\n")

  d1 <- 5   # 分子の自由度
  d2 <- 10  # 分母の自由度

  # --- 理論値（存在条件つき） ---
  E <- if (d2 > 2) d2 / (d2 - 2) else NA
  V <- if (d2 > 4) {
    2 * d2^2 * (d1 + d2 - 2) / (d1 * (d2 - 2)^2 * (d2 - 4))
  } else NA

  cat("期待値（理論） :", E, "\n")
  cat("分散（理論）   :", V, "\n")


  # --- df：確率密度関数 ---
  E <- integrate(
    function(x) x * df(x, df1 = d1, df2 = d2),
    0, Inf
  )$value

  V <- integrate(
    function(x) (x - E)^2 * df(x, df1 = d1, df2 = d2),
    0, Inf
  )$value

  cat("期待値（df） :", E, "\n")
  cat("分散（df）   :", V, "\n")


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
  samples <- rf(5, df1 = d1, df2 = d2)
  cat("乱数（rf） :", samples, "\n")
}


main()

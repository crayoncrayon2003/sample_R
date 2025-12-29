main <- function() {
  cat("########################################################################\n")
  cat("t分布\n")
  cat("自由度 ν をもつ、正規分布に比べて裾の重い連続確率分布\n")

  # 母集団の平均 μ および分散 σ² は未知であることが多く、それらを直接求めることは困難である。
  # 母集団が正規分布に従うと仮定し、大きさ n の標本から標本平均X̄と標本分散 S² を求めると、
  # 統計量T = (X̄ − μ) / (S / √n)は、自由度n-1のｔ分布に従う。
  # 統計量Ｔを使って、母集団の平均μを推定・検定する。

  # 例１：あるテストの点数は正規分布に従うと考えられているが、母平均・母分散は未知である。
  # 　　　学生 11 人の点数を測定し、標本平均 X̄ と標本標準偏差 S を用いて
  # 　　　T = (X̄ − μ) / (S / √n) と定義した統計量 T は、自由度 10 の t分布に従う。

  # 例２：ある製品の重量は正規分布に従うと仮定されているが、母平均・母分散は未知である。
  # 　　　生産初期のためデータは 11 個しかない。
  # 　　　11 個の製品重量から求めた標本平均 X̄ と標本標準偏差 S を用いて
  # 　　　T = (X̄ − μ) / (S / √n) と定義した統計量 T は、自由度 10 の t分布に従う。

  nu <- 10

  # --- 理論値（存在条件つき） ---
  E_theory <- if (nu > 1) 0 else NA
  V_theory <- if (nu > 2) nu / (nu - 2) else NA

  cat("期待値（理論） :", E_theory, "\n")
  cat("分散（理論）   :", V_theory, "\n")


  # --- dt：確率密度関数による確認 ---
  E_dt <- integrate(
    function(x) x * dt(x, df = nu),
    -Inf, Inf
  )$value

  V_dt <- integrate(
    function(x) (x - E_dt)^2 * dt(x, df = nu),
    -Inf, Inf
  )$value

  cat("期待値（dt） :", E_dt, "\n")
  cat("分散（dt）   :", V_dt, "\n")


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
  samples <- rt(1000, df = nu)
  cat("シミュレーション結果（X を1000回観測）\n")


  # --- 可視化：ヒストグラム + 理論密度 ---
  hist(
    samples,
    probability = TRUE,
    col = "lightgray",
    border = "white",
    xlab = "値",
    ylab = "密度",
    main = paste("t分布（自由度", nu, "）")
  )

  curve(
    dt(x, df = nu),
    from = min(samples),
    to = max(samples),
    col = "red",
    lwd = 2,
    add = TRUE
  )
}

main()

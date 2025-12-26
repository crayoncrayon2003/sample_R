
main <- function() {
  # データの入力
  data <- c(495, 502, 510, 512, 505)

  ##############################
  # ケース１
  n <- length(data)              # サンプルサイズ (5)
  x_bar <- mean(data)            # 平均 (504.8)
  s <- sd(data)                  # 不偏標準偏差 (約6.91)
  se <- s / sqrt(n)              # 標準誤差 (約3.09)

  # t分布表から値を取得 (自由度 n-1 = 4, 両側5%)
  # qt関数はt分布のパーセント点を返します
  t_value <- qt(0.975, df = n - 1) # 約2.776

  # 信頼区間の計算
  upper <- x_bar + t_value * se  # 上限
  lower <- x_bar - t_value * se  # 下限

  # 結果の表示
  cat("平均:", x_bar, "\n")
  cat("t値 (自由度4, 95%):", t_value, "\n")
  cat("95%信頼区間: [", lower, ",", upper, "]\n")

  ##############################
  # ケース２
  # t検定関数を実行して信頼区間を表示
  result <- t.test(data, conf.level = 0.95)

  # 結果の表示
  print(result$conf.int)


}


main()

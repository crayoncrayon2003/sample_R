main <- function() {
  # CSVファイルパスの読込み
  df <- data.frame(
    range = c("0-20", "20-40", "40-60", "60-80", "80-100"),
    score = c(     2,       4,      13,      11,        6)
  )
  print(df)
  print(typeof(df))

  # range, score
  # 0-20, 2
  # 20-40, 4
  # 40-60, 13
  # 60-80, 11
  # 80-100, 6

  # ---- 階級値の算出 ----
  df$class_value <- sapply(df$range, function(x) {
    bounds <- as.numeric(strsplit(x, "-")[[1]])
    mean(bounds)
  })

  # 結果表示
  print(df)

  # ---- 相対度数の算出 ----
  total_freq <- sum(df$score)
  df$relative_freq <- df$score / total_freq

  # 結果表示
  print(df)

  # ---- 累積相対度数の算出 ----
  df$cum_relative_freq <- cumsum(df$relative_freq)

  # 結果表示
  print(df)

  # ---- 平均値の算出 ----
  mean_score <- sum(df$class_value * df$score) / sum(df$score)
  print(paste("平均値：", mean_score))

  # ---- 最頻値の算出 ----
  max_freq <- max(df$relative_freq)
  print(paste("最頻値：", max_freq))

  # ---- 期待値の算出 ----
  expected_value <- sum(df$class_value * df$relative_freq)
  print(paste("期待値：", expected_value))

}

main()

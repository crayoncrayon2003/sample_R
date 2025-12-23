# ディレクトリの取得
get_script_dir <- function() {
  if (!is.null(sys.frames()[[1]]$ofile)) {
    return(dirname(normalizePath(sys.frames()[[1]]$ofile)))
  }

  args <- commandArgs(trailingOnly = FALSE)
  file_arg <- grep("--file=", args, value = TRUE)
  if (length(file_arg) > 0) {
    return(dirname(normalizePath(sub("--file=", "", file_arg))))
  }

  normalizePath(".")
}

# 最頻値（自作関数）
mode_value <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

main <- function() {
  df <- data.frame(
    stem = c(
      rep(4, 9),
      rep(5, 15),
      rep(6, 14),
      rep(7, 9),
      rep(8, 1)
    ),
    leaf = c(
      c(1, 2, 4, 4, 5, 5, 7, 8, 8),
      c(1, 1, 2, 2, 3, 4, 4, 4, 4, 6, 7, 8, 8, 9, 9),
      c(0, 0, 1, 1, 1, 2, 2, 2, 3, 4, 4, 4, 4, 6),
      c(1, 2, 3, 4, 5, 6, 7, 8, 9),
      c(0)
    )
  )

  print("=== 幹葉図データ ===")
  print(df)

  # 幹葉図 → 数値データに復元
  values <- df$stem * 10 + df$leaf

  print("=== 復元された数値データ ===")
  print(values)

  # 平均
  mean_value <- mean(values)

  # 中央値
  median_value <- median(values)

  # 最頻値（自作関数）
  mode_result <- mode_value(values)

  # 四分位数・四分位範囲
  quartiles <- quantile(values)
  iqr_value <- IQR(values)

  # 分散
  var_value <- var(values)    # 不変分散
  un_var_value <- var(values) * (length(values) - 1) / length(values) # 分散

  # 標準偏差
  sd_value <- sd(values)          # 不偏標準偏差
  un_sd_value <- sqrt(un_var_value)  # 母標準偏差

  # 変動係数
  cv_value <- un_sd_value / mean_value
  cv_percent <- cv_value * 100

  ############################################
  # 4. 結果表示
  ############################################
  print("=== 統計量 ===")
  print(paste("平均:", mean_value))
  print(paste("分散:", un_var_value))
  print(paste("不変分散:", var_value))
  print(paste("標準偏差（不偏）:", sd_value))
  print(paste("標準偏差（母）:", un_sd_value))
  print(paste("変動係数:", cv_value))
  print(paste("変動係数（%）:", cv_percent))

  print(paste("中央値:", median_value))
  print(paste("最頻値:", mode_result))
  print(paste("第1四分位数:", quartiles[2]))
  print(paste("第3四分位数:", quartiles[4]))
  print(paste("四分位範囲:", iqr_value))

  ############################################
  # 5. 箱ひげ図（任意）
  ############################################
  x11()
  boxplot(
    values,
    main = "Score Boxplot (from Stem-and-Leaf)",
    ylab = "Score"
  )



}

main()

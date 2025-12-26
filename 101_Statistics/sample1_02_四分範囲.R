main <- function() {
  df <- data.frame(
    score = c(41, 43, 46, 47, 48, 56, 58, 71, 72, 78, 79, 81, 86, 88, 89)
  )
  print(df)
  print(typeof(df))

  # 四分位数の計算
  quartiles <- quantile(df$score, probs = c(0.25, 0.5, 0.75))
  print(quartiles)

  print(paste("第1四分位数:", quartiles[1]))
  print(paste("第2四分位数:", quartiles[2]))
  print(paste("第3四分位数:", quartiles[3]))
  print(paste("四分範囲:", quartiles[3] - quartiles[1]))
  print(paste("四分範囲:", IQR(df$score)))

  x11()
  boxplot(
    df$score,
    horizontal = TRUE,
    main = "Score Boxplot (Horizontal)",
    xlab = "Score"
  )

}

main()

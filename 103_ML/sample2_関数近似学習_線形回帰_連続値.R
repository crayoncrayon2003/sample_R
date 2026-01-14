# =========================================================
# シーン
#   あなたは ECサイトのデータ分析担当者 である。
#   サイトには多数の顧客が訪問しており、以下の情報が取得できている。
#
# 観測データ
#    * 顧客の年齢 age（ 年 ）
#    * 顧客の性別 gender（ 0 = 女性, 1 = 男性 ）
#    * 顧客の訪問回数／月 visit_count（ 回、直近1か月 ）
#    * 顧客の滞在時間／訪問 avg_stay_time（ 分、直近1か月平均 ）
#    * マーケティング施策クーポン配布有無 coupon( 0 = 訪問前に未配布 1 = 訪問前に配布済 )
#
# 目的変数
#    * リンゴ購入金額 purchase_amount（ 円、0以上の連続値 ）
#
# 課題
# 　 各顧客について、次回サイト訪問時のリンゴ購入金額を予測せよ。
# =========================================================



# ===============================
# ディレクトリの取得
# ===============================
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


# ===============================
# 保存関数
# ===============================
save_data <- function(df, base_dir) {
  if (!dir.exists(base_dir)) {
    dir.create(base_dir, recursive = TRUE)
  }
  write.csv(df, file.path(base_dir, "data.csv"), row.names = FALSE)
}


# ===============================
# 読込関数
# ===============================
load_data <- function(base_dir) {
  file_path <- file.path(base_dir, "data.csv")
  if (file.exists(file_path)) {
    return(read.csv(file_path))
  } else {
    warning("file not found -> data.csv")
    return(data.frame())
  }
}


# ===============================
# 削除関数
# ===============================
delete_data <- function(base_dir) {
  file_path <- file.path(base_dir, "data.csv")
  if (file.exists(file_path)) {
    file.remove(file_path)
    message("removed file -> data.csv")
  }
}


# ===============================
# データ生成関数
# ===============================
generate_data <- function(n = 1000, seed = 123) {

  set.seed(seed)

  age <- rnorm(n, mean = 40, sd = 10)
  gender <- rbinom(n, 1, 0.5)
  visit_count <- rpois(n, lambda = 5)
  avg_stay_time <- rnorm(n, mean = 5, sd = 2)
  coupon <- rbinom(n, 1, 0.4)

  # --- 購入有無（潜在変数） ---
  logit_p <- -3 +
    0.03 * age +
    0.5  * gender +
    0.4  * visit_count +
    0.6  * avg_stay_time +
    1.0  * coupon

  p <- 1 / (1 + exp(-logit_p))
  purchase_flag <- rbinom(n, 1, p)

  # --- 購入金額（回帰の目的変数） ---
  # 購入した場合のみ金額が発生
  purchase_amount <- purchase_flag * (
    200 +
      5  * age +
      20 * visit_count +
      30 * avg_stay_time +
      100 * coupon +
      rnorm(n, mean = 0, sd = 50)
  )

  purchase_amount[purchase_amount < 0] <- 0

  data.frame(
    age,
    gender,
    visit_count,
    avg_stay_time,
    coupon,
    purchase_amount
  )
}


# ===============================
# 学習関数
# ===============================
train_model <- function(train_data) {
  # 線形回帰モデル
  # 顧客がリンゴを購入する金額を推定するために、
  # 目的変数が連続値のデータとして線形回帰を利用
  model <- lm(
    purchase_amount ~ age + gender + visit_count + avg_stay_time + coupon,
    data = train_data
  )

  return(model)
}


# ===============================
# 推論関数
# ===============================
predict_model <- function(model, new_data) {

  pred <- predict(model, new_data)

  data.frame(
    pred_amount = pred
  )
}


# ===============================
# 評価関数
# ===============================
evaluate_model <- function(pred_data, test_data) {

  rmse <- sqrt(
    mean((pred_data$pred_amount - test_data$purchase_amount)^2)
  )

  paste("RMSE:", round(rmse, 2))
}


# ===============================
# main関数
# ===============================
main <- function(seed = 123) {

  set.seed(seed)

  data <- generate_data(n = 1000, seed = seed)

  idx <- sample(seq_len(nrow(data)), size = 0.7 * nrow(data))
  train_data <- data[idx, ]
  test_data  <- data[-idx, ]

  model <- train_model(train_data)

  result <- predict_model(model, test_data)

  score <- evaluate_model(result, test_data)

  print(score)
}


main()

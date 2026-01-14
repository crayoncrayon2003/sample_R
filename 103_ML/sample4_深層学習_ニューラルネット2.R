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
#    * リンゴ購入 purchase_next（ 1 = リンゴを購入した, 0 = 購入しなかった ）
#
# 課題
# 　 各顧客について、次回サイト訪問時にリンゴを購入するか否かを予測せよ。
# =========================================================

library(neuralnet)

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

  logit_p <- -3 +
    0.03 * age +
    0.5  * gender +
    0.4  * visit_count +
    0.6  * avg_stay_time +
    1.0  * coupon

  p <- 1 / (1 + exp(-logit_p))
  purchase_next <- rbinom(n, 1, p)

  data.frame(
    age,
    gender,
    visit_count,
    avg_stay_time,
    coupon,
    purchase_next
  )
}


# ===============================
# 学習関数
# ===============================
train_model <- function(train_data) {
  x_scaled <- as.data.frame(scale(train_data[, c(
    "age", "gender", "visit_count", "avg_stay_time", "coupon"
  )]))

  train_nn <- cbind(
    x_scaled,
    purchase_next = train_data$purchase_next
  )

  formula <- purchase_next ~
    age + gender + visit_count + avg_stay_time + coupon

  # 入力層 （5）： 入力変数の数（"age", "gender", "visit_count", "avg_stay_time", "coupon"）
  # 隠れ層1（8）： 入力層と出力層の間の隠れ層1。ノード数8
  # 隠れ層2（4）： 入力層と出力層の間の隠れ層2。ノード数4
  # 隠れ層3（4）： 入力層と出力層の間の隠れ層3。ノード数4
  # 出力層 （1）： 出力変数の数（purchase_nextの確率）
  model <- neuralnet(
    formula,
    data = train_nn,
    hidden = c(8, 4, 4),    # 隠れ層
    act.fct = "logistic",   # 隠れ層の活性化関数
    linear.output = FALSE   # 分類なのでFALSE
  )

  list(
    model = model,
    center = attr(x_scaled, "scaled:center"),
    scale  = attr(x_scaled, "scaled:scale")
  )
}


# ===============================
# 推論関数
# ===============================
train_model <- function(train_data) {

  x <- train_data[, c("age","gender","visit_count","avg_stay_time","coupon")]

  x_scaled <- scale(x)

  train_nn <- cbind(
    as.data.frame(x_scaled),
    purchase_next = train_data$purchase_next
  )

  model <- neuralnet(
    purchase_next ~ age + gender + visit_count + avg_stay_time + coupon,
    data = train_nn,
    hidden = c(8, 4, 4),
    act.fct = "logistic",
    linear.output = FALSE
  )

  list(
    model  = model,
    center = as.numeric(attr(x_scaled, "scaled:center")),
    scale  = as.numeric(attr(x_scaled, "scaled:scale"))
  )
}



# ===============================
# 評価関数
# ===============================
evaluate_model <- function(pred_data, test_data) {

  accuracy <- mean(pred_data$pred == test_data$purchase_next)
  paste("Accuracy:", round(accuracy, 3))
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

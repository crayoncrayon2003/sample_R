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
# 課題
#   顧客を行動・属性の類似性にもとづいてクラスタリングせよ。
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

  data.frame(
    age           = rnorm(n, mean = 40, sd = 10),
    gender        = rbinom(n, 1, 0.5),
    visit_count   = rpois(n, lambda = 5),
    avg_stay_time = rnorm(n, mean = 5, sd = 2),
    coupon        = rbinom(n, 1, 0.4)
  )
}


# ===============================
# 学習関数
# ===============================
train_model <- function(train_data, k = 3) {

  x_raw <- train_data
  x_scaled <- scale(x_raw)

  # k個にクラスタリング
  model <- kmeans(
    x_scaled,
    centers = k,
    nstart = 20
  )

  list(
    model  = model,
    center = attr(x_scaled, "scaled:center"),
    scale  = attr(x_scaled, "scaled:scale")
  )
}

# ===============================
# 推論関数
# ===============================
predict_model <- function(model_obj, new_data) {

  x <- scale(
    new_data,
    center = model_obj$center,
    scale  = model_obj$scale
  )

  cluster <- apply(x, 1, function(row) {
    which.min(colSums((t(model_obj$model$centers) - row)^2))
  })

  data.frame(cluster = cluster)
}

# ===============================
# 評価関数
# ===============================
evaluate_model <- function(pred_data, test_data) {

  # クラスタごとの平均的な特徴量を見る
  summary <- aggregate(
    test_data,
    by = list(cluster = pred_data$cluster),
    FUN = mean
  )

  summary
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

  model <- train_model(train_data, k = 3)

  result <- predict_model(model, test_data)

  summary <- evaluate_model(result, test_data)

  print(summary)
}


main()

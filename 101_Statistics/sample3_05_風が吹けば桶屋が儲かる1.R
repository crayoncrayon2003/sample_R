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
# Step0 : ダミー観測データ生成
# ===============================
preprocess <- function(n, base_dir) {
  set.seed(123)

  # SCM: すべて Bernoulli
  wind <- rbinom(n, 1, 0.5)

  dust <- rbinom(n, 1, ifelse(wind == 1, 0.7, 0.1))
  blind <- rbinom(n, 1, ifelse(dust == 1, 0.6, 0.05))
  shamisen <- rbinom(n, 1, ifelse(blind == 1, 0.8, 0.1))
  cats <- rbinom(n, 1, ifelse(shamisen == 1, 0.7, 0.2))
  mice <- rbinom(n, 1, ifelse(cats == 1, 0.2, 0.8))
  bucket_damage <- rbinom(n, 1, ifelse(mice == 1, 0.7, 0.1))
  bucket_sales <- rbinom(n, 1, ifelse(bucket_damage == 1, 0.8, 0.2))

  df <- data.frame(
    wind, dust, blind, shamisen,
    cats, mice, bucket_damage, bucket_sales
  )

  write.csv(df, file.path(base_dir, "kazefukeba_okeya.csv"), row.names = FALSE)
}



# ===============================
# 観測1
# ===============================
process_seeing_1 <- function(data) {
  # 「桶の売上は、桶の被害量だけで説明できる」
  #  という因果仮説のもとで、観測データがその仮説と矛盾していないかを評価するパターン
  #     bucket_damage  →  bucket_sales
  #

  damage <- data$bucket_damage
  sales  <- data$bucket_sales

  predicted_sales <- ifelse(
    damage == 1,
    mean(sales[damage == 1]),
    mean(sales[damage == 0])
  )

  score <- -mean((sales - predicted_sales)^2)

  list(
    model_name = "seeing_1_minimal_chain",
    predicted_sales = predicted_sales,
    fit = NULL,
    score = score
  )
}

# ===============================
# 観測2
# ===============================
process_seeing_2 <- function(data) {
  # 「桶の売上は桶の被害量によって決まるが、その背後にネズミという共通原因（交絡）が存在する」
  # という因果仮説のもとで、観測データがその仮説と矛盾していないかを評価するパターン
  #     mice           ┐
  #      ↓             ├->  bucket_sales
  #     bucket_damage  ┘
  #
  # つまり、
  # ・bucket_damage は bucket_sales に影響を与える
  # ・miceは、bucket_damageとbucket_salesに影響を与える
  #
  # この仮説が正しいならば、
  # bucket_sales は bucket_damage だけでなく mice も含めて
  # 説明した方が観測データとの整合性が高くなるはず、という考え方
  #

  sales <- data$bucket_sales

  key <- paste(data$bucket_damage, data$mice)

  mu <- tapply(sales, key, mean)

  predicted_sales <- mu[key]

  score <- -mean((sales - predicted_sales)^2)

  list(
    model_name = "seeing_2_with_mice",
    predicted_sales = predicted_sales,
    fit = NULL,
    score = score
  )
}

# ===============================
# 観測3
# ===============================
process_seeing_3 <- function(data) {
  # 「桶の被害量と桶の売上には相関が見えるが、それはネズミという共通原因によるもので、桶の被害量そのものは売上の原因ではない」
  # という因果仮説のもとで、観測データがその仮説と矛盾していないかを評価するパターン
  #
  # 因果構造の仮定：
  #       ┌──→ bucket_damage
  #     mice
  #       └──→ bucket_sales
  # つまり、
  # ・bucket_damage は、bucket_sales に影響を与えない
  # ・mice が、bucket_damage と bucket_sales の共通原因である
  #
  # この仮説が正しければ、
  # bucket_sales は mice だけで説明でき、bucket_damage を入れても当てはまりは改善しないはず
  #

  mice  <- data$mice
  sales <- data$bucket_sales

  predicted_sales <- ifelse(
    mice == 1,
    mean(sales[mice == 1]),
    mean(sales[mice == 0])
  )

  score <- -mean((sales - predicted_sales)^2)

  list(
    model_name = "seeing_3_spurious_correlation",
    predicted_sales = predicted_sales,
    fit = NULL,
    score = score
  )
}

# ===============================
# 観測4（フルモデル）
# ===============================
process_seeing_4 <- function(data) {
  # 「桶屋が儲かるまでの一連の因果連鎖を、途中の変数をすべて含めて説明するのが最も素直である」
  # という因果仮説のもとで、観測データがその仮説と矛盾していないかを評価するパターン
  #
  #   wind → dust → blind → shamisen → cats → mice → bucket_damage → bucket_sales
  #
  # つまり、
  # ・風から桶の売上までの因果連鎖はすべて実在する
  # ・どの段階の変数も、 bucket_sales に直接または間接的に影響を与える
  #
  # この仮説が正しければ、
  # bucket_sales は最終段階の変数だけでなく、上流の変数も含めて説明した方が観測データとの整合性が高くなるはず
  #

  sales <- data$bucket_sales

  key <- paste(
    data$wind,
    data$dust,
    data$blind,
    data$shamisen,
    data$cats,
    data$mice,
    data$bucket_damage
  )

  mu <- tapply(sales, key, mean)

  predicted_sales <- mu[key]

  score <- -mean((sales - predicted_sales)^2)

  list(
    model_name = "seeing_4_full_chain",
    predicted_sales = predicted_sales,
    fit = NULL,
    score = score
  )
}

# ===============================
# モデルの選択
# ===============================
select_best_model <- function(seeing_results) {

  results_df <- data.frame(
    model = sapply(seeing_results, function(x) x$model_name),
    score = sapply(seeing_results, function(x) x$score)
  )

  print(results_df)

  scores <- sapply(seeing_results, function(x) x$score)
  best   <- seeing_results[[which.max(scores)]]

  cat("Selected model:", best$model_name, "\n")

  return(best)

}

# ===============================
# 介入1（do(wind=0)）
# ===============================
process_doing_1 <- function(data, model) {
  n <- nrow(data)

  wind <- rep(0, n)

  dust <- rbinom(n, 1, ifelse(wind == 1, 0.7, 0.1))
  blind <- rbinom(n, 1, ifelse(dust == 1, 0.6, 0.05))
  shamisen <- rbinom(n, 1, ifelse(blind == 1, 0.8, 0.1))
  cats <- rbinom(n, 1, ifelse(shamisen == 1, 0.7, 0.2))
  mice <- rbinom(n, 1, ifelse(cats == 1, 0.2, 0.8))
  damage <- rbinom(n, 1, ifelse(mice == 1, 0.7, 0.1))
  sales <- rbinom(n, 1, ifelse(damage == 1, 0.8, 0.2))

  cat("doing_1 (do wind=0): mean outcome =", mean(sales), "\n")
  sales
}

# ===============================
# 介入2（do(wind=1)）
# ===============================
process_doing_2 <- function(data, model) {
  n <- nrow(data)

  wind <- rep(1, n)

  dust <- rbinom(n, 1, ifelse(wind == 1, 0.7, 0.1))
  blind <- rbinom(n, 1, ifelse(dust == 1, 0.6, 0.05))
  shamisen <- rbinom(n, 1, ifelse(blind == 1, 0.8, 0.1))
  cats <- rbinom(n, 1, ifelse(shamisen == 1, 0.7, 0.2))
  mice <- rbinom(n, 1, ifelse(cats == 1, 0.2, 0.8))
  damage <- rbinom(n, 1, ifelse(mice == 1, 0.7, 0.1))
  sales <- rbinom(n, 1, ifelse(damage == 1, 0.8, 0.2))

  cat("doing_2 (do wind=1): mean outcome =", mean(sales), "\n")
  sales
}

# ===============================
# seeing_4 用の介入関数（do(wind=指定値)）
# ===============================
process_doing_seeing_4 <- function(data, wind_do) {
  n <- nrow(data)

  wind <- rep(wind_do, n)

  dust <- rbinom(n, 1, ifelse(wind == 1, 0.7, 0.1))
  blind <- rbinom(n, 1, ifelse(dust == 1, 0.6, 0.05))
  shamisen <- rbinom(n, 1, ifelse(blind == 1, 0.8, 0.1))
  cats <- rbinom(n, 1, ifelse(shamisen == 1, 0.7, 0.2))
  mice <- rbinom(n, 1, ifelse(cats == 1, 0.2, 0.8))
  damage <- rbinom(n, 1, ifelse(mice == 1, 0.7, 0.1))
  sales <- rbinom(n, 1, ifelse(damage == 1, 0.8, 0.2))

  cat("do(wind =", wind_do, "): mean(bucket_sales) =", mean(sales), "\n")
  sales
}

# ===============================
# ファイル削除
# ===============================
postprocess <- function(base_dir) {
  file_path <- file.path(base_dir, "kazefukeba_okeya.csv")

  if (file.exists(file_path)) {
    file.remove(file_path)
    cat("postprocess: removed file -> kazefukeba_okeya.csv\n")
  } else {
    cat("postprocess: file not found -> kazefukeba_okeya.csv\n")
  }
}

# ===============================
# main
# ===============================
main <- function() {
  n <- 3000

  base_dir <- get_script_dir()
  preprocess(n, base_dir)

  data <- read.csv(file.path(base_dir, "kazefukeba_okeya.csv"))

  # データの準備
  seeing_results <- list(
    process_seeing_1(data),
    process_seeing_2(data),
    process_seeing_3(data),
    process_seeing_4(data)
  )

  # ベストモデルの選択
  best_model <- select_best_model(seeing_results)

  # ベストモデルを使って介入効果の推定
  process_doing_1(data, best_model)
  process_doing_2(data, best_model)

  cat("観測１・観測２・観測３・観測４は、何らかの基準（例えばscore）を使えば、モデルの評価が可能になる。\n")
  cat("ただし、観測１・観測２・観測３・観測４は、仮設している構造方程式が異なる= もそも仮説した前提が異なる\n")
  cat("このため、観測１・観測２・観測３・観測４を評価したからといって因果関係の良し悪しを評価している訳ではない\n")
  cat("各観測結果から、研究者が何らかの基準（例えばscore）を使うことで最も当てはまりの良い構造法手式が選択できると判断した仮定のもとで選択したモデルを使い介入する\n")


  postprocess(base_dir)
}

main()

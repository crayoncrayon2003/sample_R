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

  wind <- rnorm(n, 3, 1)

  U1 <- rnorm(n, 0, 0.5)
  U2 <- rnorm(n, 0, 0.5)
  U3 <- rnorm(n, 0, 0.5)
  U4 <- rnorm(n, 0, 5)
  U5 <- rnorm(n, 0, 5)
  U6 <- rnorm(n, 0, 5)
  U7 <- rnorm(n, 0, 10)

  dust <- 0.8 * wind + U1
  blind <- 0.6 * dust + U2
  shamisen <- 0.7 * blind + U3
  cats <- 200 - 0.5 * shamisen + U4
  mice <- 0.8 * (200 - cats) + U5
  bucket_damage <- 0.9 * mice + U6
  bucket_sales <- 1.2 * bucket_damage + U7

  df <- data.frame(
    wind,
    dust,
    blind,
    shamisen,
    cats,
    mice,
    bucket_damage,
    bucket_sales
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

  # seeing: 条件付き平均
  model <- lm(sales ~ damage, data = data)
  predicted_sales <- predict(model, newdata = data)

  # 観測とのズレでスコア化（小さい方が良い）
  score <- -mean((sales - predicted_sales)^2)

  list(
    model_name = "seeing_1_minimal_chain",
    predicted_sales = predicted_sales,
    fit = model,
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

  mice   <- data$mice
  damage <- data$bucket_damage
  sales  <- data$bucket_sales

  # 連続値に対応する線形回帰モデル
  # SCM: bucket_sales ~ bucket_damage + mice
  model <- lm(sales ~ damage + mice, data = data)
  predicted_sales <- predict(model, newdata = data)

  # 観測とのズレでスコア化（小さい方が良い）
  score <- -mean((sales - predicted_sales)^2)

  list(
    model_name = "seeing_2_with_mice",
    predicted_sales = predicted_sales,
    fit = model,
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

  mice   <- data$mice
  sales  <- data$bucket_sales

  # SCM: bucket_sales ~ mice
  model <- lm(sales ~ mice, data = data)
  predicted_sales <- predict(model, newdata = data)

  # 観測とのズレでスコア化
  score <- -mean((sales - predicted_sales)^2)

  list(
    model_name = "seeing_3_spurious_correlation",
    predicted_sales = predicted_sales,
    fit = model,
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

  n <- nrow(data)

  # 1. wind
  wind <- data$wind

  # 2. dust ~ wind
  dust_model <- lm(dust ~ wind, data = data)
  dust <- predict(dust_model, newdata = data)

  # 3. blind ~ dust
  blind_model <- lm(blind ~ dust, data = data.frame(dust=dust, blind=data$blind))
  blind <- predict(blind_model, newdata = data.frame(dust=dust))

  # 4. shamisen ~ blind
  shamisen_model <- lm(shamisen ~ blind, data = data.frame(blind=blind, shamisen=data$shamisen))
  shamisen <- predict(shamisen_model, newdata = data.frame(blind=blind))

  # 5. cats ~ shamisen
  cats_model <- lm(cats ~ shamisen, data = data.frame(shamisen=shamisen, cats=data$cats))
  cats <- predict(cats_model, newdata = data.frame(shamisen=shamisen))

  # 6. mice ~ cats
  mice_model <- lm(mice ~ cats, data = data.frame(cats=cats, mice=data$mice))
  mice <- predict(mice_model, newdata = data.frame(cats=cats))

  # 7. bucket_damage ~ mice
  damage_model <- lm(bucket_damage ~ mice, data = data.frame(mice=mice, bucket_damage=data$bucket_damage))
  bucket_damage <- predict(damage_model, newdata = data.frame(mice=mice))

  # 8. bucket_sales ~ bucket_damage
  sales_model <- lm(bucket_sales ~ bucket_damage, data = data.frame(bucket_damage=bucket_damage, bucket_sales=data$bucket_sales))
  bucket_sales <- predict(sales_model, newdata = data.frame(bucket_damage=bucket_damage))

  # スコア計算
  score <- -mean((data$bucket_sales - bucket_sales)^2)

  list(
    model_name = "seeing_4_full_chain",
    predicted_sales = bucket_sales,
    fit = bucket_sales,
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
# 介入1（do(wind=1)）
# ===============================
process_doing_1 <- function(data, model) {
  n <- nrow(data)
  wind_q1 <- quantile(data$wind, 0.25)
  fit <- model$fit

  newdata <- data
  newdata$wind <- wind_q1  # wind を第1四分位で固定

  pred <- predict(fit, newdata = newdata)

  cat("doing_1 (wind Q1): mean outcome =", mean(pred), "\n")
  return(pred)
}

# ===============================
# 介入2（do(wind=5)）
# ===============================
process_doing_2 <- function(data, model) {
  n <- nrow(data)
  wind_q3 <- quantile(data$wind, 0.75)
  fit <- model$fit

  newdata <- data
  newdata$wind <- wind_q3  # wind を第3四分位で固定

  pred <- predict(fit, newdata = newdata)

  cat("doing_2 (wind Q3): mean outcome =", mean(pred), "\n")
  return(pred)
}

# ===============================
# seeing_4 用の介入関数（do(wind=指定値)）
# ===============================
process_doing_seeing_4 <- function(data, wind_do) {

  # 1. wind を介入値で固定
  wind <- rep(wind_do, nrow(data))

  # 2. dust ~ wind
  dust_model <- lm(dust ~ wind, data = data)
  dust <- predict(dust_model, newdata = data.frame(wind=wind))

  # 3. blind ~ dust
  blind_model <- lm(blind ~ dust, data = data.frame(dust=data$dust, blind=data$blind))
  blind <- predict(blind_model, newdata = data.frame(dust=dust))

  # 4. shamisen ~ blind
  shamisen_model <- lm(shamisen ~ blind, data = data.frame(blind=data$shamisen, shamisen=data$shamisen))
  shamisen <- predict(shamisen_model, newdata = data.frame(blind=blind))

  # 5. cats ~ shamisen
  cats_model <- lm(cats ~ shamisen, data = data.frame(shamisen=data$shamisen, cats=data$cats))
  cats <- predict(cats_model, newdata = data.frame(shamisen=shamisen))

  # 6. mice ~ cats
  mice_model <- lm(mice ~ cats, data = data.frame(cats=data$cats, mice=data$mice))
  mice <- predict(mice_model, newdata = data.frame(cats=cats))

  # 7. bucket_damage ~ mice
  damage_model <- lm(bucket_damage ~ mice, data = data.frame(mice=data$mice, bucket_damage=data$bucket_damage))
  bucket_damage <- predict(damage_model, newdata = data.frame(mice=mice))

  # 8. bucket_sales ~ bucket_damage
  sales_model <- lm(bucket_sales ~ bucket_damage, data = data.frame(bucket_damage=data$bucket_damage, bucket_sales=data$bucket_sales))
  bucket_sales <- predict(sales_model, newdata = data.frame(bucket_damage=bucket_damage))

  cat("do(wind =", wind_do, "): mean(bucket_sales) =", mean(bucket_sales), "\n")
  return(bucket_sales)
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
    process_seeing_3(data)
  )

  cat("観測１・観測２・観測３は、変数 → 変数 の構造になっている。\n")
  cat("このため何らかの基準（例えばscore）を使えば、モデルの評価が可能になる。\n")
  cat("ただし、観測１・観測２・観測３は、変数 → 変数 の構造が一致しているだけで、そもそも仮説した前提が異なる\n")
  cat("このため、観測１・観測２・観測３を評価したからといって因果関係の良し悪しを評価している訳ではない\n")

  # ベストモデルの選択
  best_model <- select_best_model(seeing_results)

  # ベストモデルを使って介入効果の推定
  process_doing_1(data, best_model)
  process_doing_2(data, best_model)

  cat("観測４に介入する。\n")
  pred1 <- process_doing_seeing_4(data, wind_do = 1)
  pred2 <- process_doing_seeing_4(data, wind_do = 5)


  postprocess(base_dir)
}

main()

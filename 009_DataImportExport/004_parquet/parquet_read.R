print("############################################################")
print("# PARQUET READER: input.parquetを読み込みます")
print("############################################################")

if (!requireNamespace("arrow", quietly = TRUE)) install.packages("arrow")
library(arrow)

# スクリプトの場所を動的に取得
get_script_dir <- function() {
  if (!is.null(sys.frames()[[1]]$ofile)) {
    return(dirname(normalizePath(sys.frames()[[1]]$ofile)))
  }
  args <- commandArgs(trailingOnly = FALSE)
  file_arg <- grep("--file=", args, value = TRUE)
  if (length(file_arg) > 0) {
    return(dirname(normalizePath(sub("--file=", "", file_arg))))
  }
  return(normalizePath("."))
}

script_dir <- get_script_dir()
input_path <- file.path(script_dir, "output.parquet")

# ファイルが存在するか確認
if (file.exists(input_path)) {
  # Parquetの読み込み
  df_input <- read_parquet(input_path)

  print("Parquetデータの読み込みに成功しました:")
  print(head(df_input)) # 最初の数行を表示
  print(summary(df_input))
} else {
  print(paste("エラー: 読み込み用ファイルが見つかりません:", input_path))
  print("テストを行うには、この場所に 'input.parquet' を用意してください。")
}
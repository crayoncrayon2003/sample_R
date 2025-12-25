print("############################################################")
print("# JSON READER: input.jsonを読み込みます")
print("############################################################")

if (!requireNamespace("jsonlite", quietly = TRUE)) install.packages("jsonlite")
library(jsonlite)

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
input_path <- file.path(script_dir, "output.json")

# ファイルが存在するか確認
if (file.exists(input_path)) {
  # simplifyVector = TRUE でJSON配列をデータフレームに自動変換
  df_input <- read_json(input_path, simplifyVector = TRUE)

  print("JSONデータの読み込みに成功しました:")
  print(df_input)
} else {
  # テスト用にファイルがない場合の説明
  print(paste("エラー: 読み込み用ファイルが見つかりません:", input_path))
  print("テストを行うには、この場所に 'input.json' を用意してください。")
}
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

main <- function() {
  # ディレクトリの取得
  script_dir <- get_script_dir()
  print(paste("Script directory:", script_dir))

  # CSVファイルパスの作成
  csv_file <- file.path(script_dir, "data0_01.csv")

  # CSVファイルパスの読込み
  df <- read.csv(csv_file, stringsAsFactors = FALSE)
  print("Data read from CSV:")
  print(df)
  print(typeof(df))

  # カラム単位の表示
  print(df$name)
  print(df$score)

  # 行単位の表示
  print(df[1, ])

  # 列単位の表示
  print(df[, "score"])

  # Summary
  print(summary(df))
}

main()

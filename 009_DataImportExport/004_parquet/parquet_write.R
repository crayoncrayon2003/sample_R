print("############################################################")
print("# PARQUET WRITER: output.parquetを作成します")
print("############################################################")

# arrowパッケージの確認（インストールには少し時間がかかる場合があります）
if (!requireNamespace("arrow", quietly = TRUE)) {
  install.packages("arrow")
}
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
output_path <- file.path(script_dir, "output.parquet")

# 書き出し用の大きなデータフレームを作成（Parquetは大量データで威力を発揮します）
df_to_save <- data.frame(
  id = 1:1000,
  category = sample(c("A", "B", "C"), 1000, replace = TRUE),
  value = rnorm(1000),
  timestamp = Sys.time()
)

# Parquet書き出し
# 圧縮形式（snappy等）は自動で最適化されます
write_parquet(df_to_save, sink = output_path)

print(paste("Parquetファイルを書き出しました:", output_path))
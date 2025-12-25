print("############################################################")
print("# JSON WRITER: output.jsonを作成します")
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
output_path <- file.path(script_dir, "output.json")

# 保存するデータの作成
data_to_save <- list(
  timestamp = Sys.time(),
  settings = list(
    mode = "Simulation",
    trials = 10000
  ),
  results = data.frame(
    id = 4:6,
    name = c("David", "Eve", "Frank"),
    score = c(88, 92, 79)
  )
)

# JSON書き出し（pretty=TRUEでインデントを付けて見やすく保存）
write_json(data_to_save, path = output_path, pretty = TRUE)

print(paste("JSONファイルを書き出しました:", output_path))
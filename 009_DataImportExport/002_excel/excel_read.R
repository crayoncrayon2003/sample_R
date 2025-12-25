print("############################################################")
print("# 1. Load required package")
print("############################################################")

# 読み込み専用パッケージ readxl の確認と読み込み
if (!requireNamespace("readxl", quietly = TRUE)) {
  install.packages("readxl")
}
library(readxl)

print("############################################################")
print("# 2. Determine script directory dynamically")
print("############################################################")

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
print(paste("Script directory:", script_dir))

print("############################################################")
print("# 3. Reading Excel files")
print("############################################################")

excel_file <- file.path(script_dir, "output.xlsx")

if (file.exists(excel_file)) {
  df <- read_excel(excel_file, sheet = 1)

  print("Data read from Excel:")
  print(head(df)) # 最初の数行を表示
} else {
  print(paste("Error: File not found at", excel_file))
}

print("############################################################")
print("# 4. Accessing data")
print("############################################################")

if (exists("df")) {
  # 列へのアクセス（CSVと同様）
  # df$列名 または df[["列名"]]
  print("Column Names:")
  print(colnames(df))

  # 要約統計の表示
  print("Data Summary:")
  print(summary(df))
}
print("############################################################")
print("# 1. Load required package")
print("############################################################")

# 書き出し用パッケージ writexl の確認と読み込み
if (!requireNamespace("writexl", quietly = TRUE)) {
  install.packages("writexl")
}
library(writexl)

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
print("# 3. Writing Excel files")
print("############################################################")

# Excelファイルのパス
excel_file <- file.path(script_dir, "output.xlsx")

# 書き出し用のサンプルデータ作成
df <- data.frame(
  id = 4:6,
  name = c("David", "Eve", "Frank"),
  score = c(88, 92, 79)
)

# Excelへの書き出し
# col_names = TRUE でヘッダーを含める（デフォルト）
write_xlsx(df, path = excel_file)

print(paste("Data written to Excel:", excel_file))

print("############################################################")
print("# 4. Verification: Reading back the Excel")
print("############################################################")

# 確認のために読み込み（readxlパッケージが必要）
if (!requireNamespace("readxl", quietly = TRUE)) {
  install.packages("readxl")
}
library(readxl)

df_read <- read_excel(excel_file)
print("Content of the written Excel file:")
print(df_read)
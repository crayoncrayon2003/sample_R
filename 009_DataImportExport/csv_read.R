print("############################################################")
print("# 1. Determine script directory dynamically")
print("############################################################")

# Function to get script directory (VSCode, source(), Rscript compatible)
get_script_dir <- function() {
  # source() 実行時
  if (!is.null(sys.frames()[[1]]$ofile)) {
    return(dirname(normalizePath(sys.frames()[[1]]$ofile)))
  }
  # Rscript 実行時
  args <- commandArgs(trailingOnly = FALSE)
  file_arg <- grep("--file=", args, value = TRUE)
  if (length(file_arg) > 0) {
    return(dirname(normalizePath(sub("--file=", "", file_arg))))
  }
  # fallback: カレントディレクトリ
  return(normalizePath("."))
}

script_dir <- get_script_dir()
print(paste("Script directory:", script_dir))


print("############################################################")
print("# 2. Reading CSV files")
print("############################################################")

# CSV file path relative to script
csv_file <- file.path(script_dir, "sample.csv")

# Create example CSV for demonstration (if not exist)
if (!file.exists(csv_file)) {
  df_example <- data.frame(
    id = 1:3,
    name = c("Alice", "Bob", "Charlie"),
    score = c(80, 90, 85)
  )
  write.csv(df_example, csv_file, row.names = FALSE)
}

# Read CSV
df <- read.csv(csv_file, stringsAsFactors = FALSE)
print("Data read from CSV:")
print(df)


print("############################################################")
print("# 3. Accessing data")
print("############################################################")

# Access columns
print(df$name)
print(df$score)

# Access rows
print(df[1, ])
print(df[, "score"])

# Summary
print(summary(df))

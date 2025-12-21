print("############################################################")
print("# Boxplot sample (Statistical Test Level 2)")
print("############################################################")

# 1. Determine script directory dynamically
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
print("# 1. Create CSV file if it does not exist")
print("############################################################")

csv_file <- file.path(script_dir, "data.csv")

if (!file.exists(csv_file)) {
  df_create <- data.frame(
    Group = rep(c("A","B","C"), each=6),
    Score = c(85,88,90,92,95,87, 78,80,82,85,79,81, 65,68,70,72,66,69)
  )
  write.csv(df_create, csv_file, row.names = FALSE)
  print(paste("CSV file created:", csv_file))
} else {
  print(paste("CSV file already exists, not overwritten:", csv_file))
}


print("############################################################")
print("# 2. Read CSV file")
print("############################################################")

# CSVファイルを必ず読み込む
df <- read.csv(csv_file, stringsAsFactors = FALSE)
print("CSV content:")
print(df)


print("############################################################")
print("# 3. Create boxplot")
print("############################################################")

# Basic boxplot with base R
boxplot(Score ~ Group, data = df,
        main = "Boxplot of Scores by Group",
        xlab = "Group",
        ylab = "Score",
        col = c("lightblue", "lightgreen", "lightpink"))

# Optional: add grid
grid()

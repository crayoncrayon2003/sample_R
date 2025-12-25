print("############################################################")
print("# 1. Determine script directory dynamically")
print("############################################################")

# Function to get script directory (VSCode, source(), Rscript compatible)
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
print("# 2. Writing CSV files")
print("############################################################")

# CSV file path relative to script
csv_file <- file.path(script_dir, "output.csv")

# Create example data frame
df <- data.frame(
  id = 4:6,
  name = c("David", "Eve", "Frank"),
  score = c(88, 92, 79)
)

# Write to CSV
write.csv(df, csv_file, row.names = FALSE)
print(paste("Data written to:", csv_file))


print("############################################################")
print("# 3. Reading back the CSV")
print("############################################################")

df_read <- read.csv(csv_file, stringsAsFactors = FALSE)
print(df_read)

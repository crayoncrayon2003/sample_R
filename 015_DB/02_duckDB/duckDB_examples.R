if (!requireNamespace("DBI", quietly = TRUE)) install.packages("DBI")
if (!requireNamespace("duckdb", quietly = TRUE)) install.packages("duckdb")

library(DBI)
library(duckdb)

# ---- 1. パス取得 ----
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

file_src <- file.path(script_dir, "sample.csv")
file_dst <- file.path(script_dir, "summary.parquet")

# ---- 2. DuckDB 接続 ----
# :memory: をファイルパスに変えれば永続化も可能
con <- dbConnect(duckdb(), dbdir = ":memory:")

# ---- 3. 入力データ読み込み（CSV）----
dbExecute(con, sprintf("
    CREATE TABLE sales AS
    SELECT *
    FROM read_csv_auto('%s')
    ", file_src))

# ---- 4. 前処理・集計（SQLに全部任せる）----
dbExecute(con, "
  CREATE TABLE sales_summary AS
  SELECT
    category,
    COUNT(*)            AS cnt,
    SUM(amount)         AS total_amount,
    AVG(amount)         AS avg_amount
  FROM sales
  GROUP BY category
")

# ---- 5. Parquet に書き出し（中間成果物）----
dbExecute(con, sprintf("
  COPY sales_summary
  TO '%s'
  (FORMAT 'parquet')
    ", file_dst))


# ---- 6. R に結果を取り込む（分析用）----
summary_df <- dbGetQuery(con, "
  SELECT *
  FROM sales_summary
  ORDER BY total_amount DESC
")

print(summary_df)

# ---- 7. R 側で分析・可視化など ----
# （例：カテゴリ別売上比率）
summary_df$ratio <- summary_df$total_amount / sum(summary_df$total_amount)
print(summary_df)

# ---- 8. 後始末（重要）----
dbDisconnect(con, shutdown = TRUE)

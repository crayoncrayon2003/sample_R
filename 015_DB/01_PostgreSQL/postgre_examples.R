print("############################################################")
print("# 1. Load required packages")
print("############################################################")

if (!requireNamespace("DBI", quietly = TRUE)) install.packages("DBI")
if (!requireNamespace("RPostgres", quietly = TRUE)) install.packages("RPostgres")
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("dbplyr", quietly = TRUE)) install.packages("dbplyr")

library(DBI)
library(RPostgres)
library(dplyr)

print("############################################################")
print("# 2. Connect to PostgreSQL (Docker)")
print("############################################################")

# Docker Composeの設定に合わせて接続
# デフォルトのデータベース名はユーザー名と同じ "user" になることが多いです
con <- dbConnect(
  RPostgres::Postgres(),
  host     = "127.0.0.1",
  port     = 5432,
  dbname   = "user",  # POSTGRES_USERで指定した値
  user     = "user",
  password = "user"
)

print("Connected to PostgreSQL.")

print("############################################################")
print("# 3. Write and Read Data")
print("############################################################")

# テストデータの作成
df_pg <- data.frame(
  id = 101:103,
  item = c("Laptop", "Mouse", "Keyboard"),
  price = c(120000, 5000, 12000)
)

# 書き込み
dbWriteTable(con, "products", df_pg, overwrite = TRUE, row.names = FALSE)

# dplyrを使った読み込み
products_db <- tbl(con, "products")

df_res <- products_db %>%
  filter(price > 10000) %>%
  collect()

print("Products with price > 10000:")
print(df_res)

# 接続終了
dbDisconnect(con)
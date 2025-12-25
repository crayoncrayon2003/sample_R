print("############################################################")
print("# 1. Load required packages")
print("############################################################")

# 必要なパッケージのインストール
if (!requireNamespace("DBI", quietly = TRUE)) install.packages("DBI")
if (!requireNamespace("RMariaDB", quietly = TRUE)) install.packages("RMariaDB")
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")

library(DBI)
library(RMariaDB)
library(dplyr)

print("############################################################")
print("# 2. Connect to MySQL (Docker)")
print("############################################################")

# Docker Composeの設定に合わせて接続
con <- dbConnect(
  RMariaDB::MariaDB(),
  host     = "127.0.0.1",
  port     = 3306,
  dbname   = "sample_db",
  user     = "user",
  password = "user"
)

# 接続確認
print("Connected to MySQL:")
print(dbGetInfo(con))

print("############################################################")
print("# 3. Write data to MySQL")
print("############################################################")

# 書き込むデータの作成
df_to_write <- data.frame(
  id = 1:5,
  name = c("Alice", "Bob", "Charlie", "David", "Eve"),
  score = c(80, 95, 85, 88, 92),
  created_at = Sys.time()
)

# テーブルの書き込み (すでにある場合は上書き: overwrite = TRUE)
dbWriteTable(con, "users", df_to_write, overwrite = TRUE, row.names = FALSE)
print("Data written to 'users' table.")

print("############################################################")
print("# 4. Read data from MySQL")
print("############################################################")

# 方法 A: SQLクエリで直接読み込む
res <- dbGetQuery(con, "SELECT * FROM users WHERE score >= 90")
print("Query result (Score >= 90):")
print(res)

# 方法 B: dplyr を使って読み込む (SQLを書かずに操作可能)
# データベース上のテーブルを R のオブジェクトのように扱う
users_db <- tbl(con, "users")

df_read <- users_db %>%
  filter(score < 90) %>%
  select(name, score) %>%
  collect() # 実際にデータを R にロードする

print("Dplyr result (Score < 90):")
print(df_read)

print("############################################################")
print("# 5. Disconnect")
print("############################################################")

# 接続を閉じる
dbDisconnect(con)
print("Disconnected.")
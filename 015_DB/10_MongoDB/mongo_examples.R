print("############################################################")
print("# 1. Load required package")
print("############################################################")

if (!requireNamespace("mongolite", quietly = TRUE)) {
  install.packages("mongolite")
}
library(mongolite)

print("############################################################")
print("# 2. Connect to MongoDB (Docker)")
print("############################################################")

# MongoDBへの接続設定
# 形式: mongodb://ユーザー:パスワード@ホスト:ポート/データベース名
# 今回のDocker設定では認証なしなのでシンプルです
url <- "mongodb://localhost:27017"

# 「sample_db」データベースの「users」コレクションに接続
con <- mongo(
  collection = "users",
  db = "sample_db",
  url = url
)

print("Connected to MongoDB.")

print("############################################################")
print("# 3. Write (Insert) Data")
print("############################################################")

# 書き込むデータの作成
# MongoDBはリスト形式やデータフレームをそのまま受け入れます
df_mongo <- data.frame(
  id = 1:3,
  name = c("Alice", "Bob", "Charlie"),
  hobbies = c("Reading", "Gaming", "Hiking"),
  age = c(25, 30, 22)
)

# データの挿入
con$insert(df_mongo)

print("Data inserted into MongoDB.")

print("############################################################")
print("# 4. Read (Find) Data")
print("############################################################")

# 全データの読み込み
all_data <- con$find('{}') # {} は「すべて」を意味するクエリ
print("All data in collection:")
print(all_data)

# 条件を指定して読み込み (JSON形式のクエリを使用)
# 例: age が 25 以上の人を抽出
rich_query <- con$find('{"age": {"$gte": 25}}')
print("Filtered data (Age >= 25):")
print(rich_query)

print("############################################################")
print("# 5. Cleanup")
print("############################################################")

# 今回のテスト用にコレクションを空にする場合（必要に応じて）
# con$drop()

# mongoliteは接続を明示的に閉じなくてもRの終了時にクリーンアップされます
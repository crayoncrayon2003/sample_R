print("############################################################")
print("# 1. Load dplyr package")
print("############################################################")

# Install dplyr if not installed
if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr")
}

library(dplyr)

print("############################################################")
print("# 2. Create example data frame")
print("############################################################")

df <- data.frame(
  id = 1:5,
  name = c("Alice", "Bob", "Charlie", "David", "Eve"),
  score = c(80, 90, 85, 88, 92),
  class = c("A", "A", "B", "B", "A")
)
print(df)

print("############################################################")
print("# 3. Select columns")
print("############################################################")

df_select <- df %>% select(name, score)
print(df_select)

print("############################################################")
print("# 4. Filter rows")
print("############################################################")

df_filter <- df %>% filter(class == "A", score > 85)
print(df_filter)

print("############################################################")
print("# 5. Arrange rows")
print("############################################################")

df_arrange <- df %>% arrange(desc(score))
print(df_arrange)

print("############################################################")
print("# 6. Mutate (add new column)")
print("############################################################")

df_mutate <- df %>% mutate(pass = score >= 85)
print(df_mutate)

print("############################################################")
print("# 7. Summarize and group_by")
print("############################################################")

df_summary <- df %>%
  group_by(class) %>%
  summarize(
    mean_score = mean(score),
    max_score = max(score),
    min_score = min(score)
  )
print(df_summary)

# ... (1〜7まではご提示のコードと同じ)

print("############################################################")
print("# 8. Join (Combine with another data frame)")
print("############################################################")

# 結合用の補足データ（出席日数）を作成
extra_info <- data.frame(
  id = 1:5,
  attendance = c(100, 95, 80, 90, 98)
)

# idをキーにして左結合
df_joined <- df %>% left_join(extra_info, by = "id")
print(df_joined)

print("############################################################")
print("# 9. Rename and Relocate (Change column name/position)")
print("############################################################")

df_reorder <- df_joined %>%
  rename(student_name = name) %>%        # nameをstudent_nameに変更
  relocate(class, .before = id)          # classをidの前に移動
print(df_reorder)

print("############################################################")
print("# 10. Advanced Mutate (case_when & across)")
print("############################################################")

df_advanced <- df_joined %>%
  # 条件に応じたラベル付け
  mutate(grade = case_when(
    score >= 90 ~ "S",
    score >= 85 ~ "A",
    TRUE        ~ "B"
  )) %>%
  # 複数の列(score, attendance)に対して一括で処理(0.1倍する)
  mutate(across(c(score, attendance), ~ .x * 0.1, .names = "scaled_{.col}"))

print(df_advanced)

print("############################################################")
print("# 11. Distinct and Slice (Handle duplicates and specific rows)")
print("############################################################")

# 重複行を含むデータの作成
df_dup <- bind_rows(df, df %>% filter(id == 1))

df_unique_top <- df_dup %>%
  distinct() %>%                         # 重複行を除去
  arrange(desc(score)) %>%
  slice(1:3)                             # 上位3行のみ抽出

print(df_unique_top)

print("############################################################")
print("# 12. Count (Quick frequency table)")
print("############################################################")

# クラスごとの人数をカウント
df_count <- df %>% count(class)
print(df_count)
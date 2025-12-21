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

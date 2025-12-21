print("############################################################")
print("# 2. Plotting with ggplot2")
print("############################################################")

# Check if ggplot2 is installed
if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}
library(ggplot2)

# Sample data frame
df <- data.frame(
  category = c("A", "B", "C", "D"),
  value = c(3, 7, 9, 5)
)

# Bar plot
p1 <- ggplot(df, aes(x = category, y = value, fill = category)) +
  geom_bar(stat = "identity") +
  ggtitle("Bar Plot with ggplot2")
print(p1)

# Scatter plot with line
df2 <- data.frame(x = 1:5, y = c(2, 4, 6, 8, 10))
p2 <- ggplot(df2, aes(x = x, y = y)) +
  geom_point(color = "blue", size = 3) +
  geom_line(color = "red", linetype = "dashed") +
  ggtitle("Scatter + Line Plot with ggplot2")
print(p2)

# Histogram
values <- c(1,2,2,3,3,3,4,4,4,4)
df_hist <- data.frame(values = values)
p3 <- ggplot(df_hist, aes(x = values)) +
  geom_histogram(binwidth = 1, fill = "orange", color = "black") +
  ggtitle("Histogram with ggplot2")
print(p3)

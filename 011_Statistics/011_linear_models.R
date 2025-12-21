print("############################################################")
print("# 1. Simple linear regression")
print("############################################################")

# Example data
set.seed(123)
x <- 1:20
y <- 2 + 3 * x + rnorm(20, mean = 0, sd = 5)  # y = 2 + 3x + noise

# Fit linear model
lm_model <- lm(y ~ x)
print(summary(lm_model))

# Open new window for first graph
dev.new()
plot(x, y, main = "Simple Linear Regression", xlab = "x", ylab = "y",
     pch = 19, col = "blue")
abline(lm_model, col = "red", lwd = 2)


print("############################################################")
print("# 2. Multiple linear regression")
print("############################################################")

# Example data
set.seed(456)
df <- data.frame(
  x1 = rnorm(30, 10, 2),
  x2 = rnorm(30, 5, 1),
  y = rnorm(30)
)
# Construct dependent variable
df$y <- 1 + 2*df$x1 + 3*df$x2 + rnorm(30, 0, 2)

# Fit multiple linear regression
lm_multi <- lm(y ~ x1 + x2, data = df)
print(summary(lm_multi))


print("############################################################")
print("# 3. ANOVA (one-way) - example of experimental design")
print("############################################################")

# Example: 3 groups with different means
group <- factor(rep(c("A", "B", "C"), each = 5))
response <- c(5,6,4,5,6, 7,8,6,7,7, 4,5,3,4,4)
anova_model <- aov(response ~ group)
print(summary(anova_model))

# Open another new window for second graph
dev.new()
boxplot(response ~ group, main = "One-way ANOVA", col = c("red", "green", "blue"))

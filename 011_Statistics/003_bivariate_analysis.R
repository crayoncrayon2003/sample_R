print("############################################################")
print("# 1. Bivariate data analysis")
print("############################################################")

# Sample data: students' math and English scores
math_scores <- c(85, 88, 90, 92, 95, 87, 78, 80, 82, 85)
english_scores <- c(80, 82, 85, 90, 88, 84, 75, 78, 80, 82)

# Combine into a data frame
df <- data.frame(math = math_scores, english = english_scores)
print("Data frame:")
print(df)

print("############################################################")
print("# 2. Scatter plot and correlation")
print("############################################################")

# Scatter plot
plot(df$math, df$english,
     main = "Scatter: Math vs English",
     xlab = "Math",
     ylab = "English",
     pch = 19, col = "blue")
grid()

# Open a new graphics device for next plot
dev.new()

# Correlation
cor_val <- cor(df$math, df$english)
print(paste("Correlation coefficient:", cor_val))

# Correlation test
cor_test <- cor.test(df$math, df$english)
print("Correlation test result:")
print(cor_test)

print("############################################################")
print("# 3. Simple linear regression")
print("############################################################")

# Fit a linear model: English ~ Math
lm_model <- lm(english ~ math, data = df)
print("Linear model summary:")
print(summary(lm_model))

# Predict English score for new Math scores
new_math <- data.frame(math = c(90, 95))
predictions <- predict(lm_model, new_math)
print("Predicted English scores for Math = 90, 95:")
print(predictions)

# Plot regression line
plot(df$math, df$english,
     main = "Regression: English ~ Math",
     xlab = "Math",
     ylab = "English",
     pch = 19, col = "blue")
abline(lm_model, col = "red", lwd = 2)
grid()

# Open new device for categorical data
dev.new()

print("############################################################")
print("# 4. Categorical data analysis")
print("############################################################")

# Sample categorical data: Study method vs Pass/Fail
study_method <- c("A", "A", "B", "B", "C", "C", "A", "B", "C", "A")
pass_fail <- c("Pass", "Pass", "Pass", "Fail", "Pass", "Fail", "Fail", "Pass", "Pass", "Fail")

df_cat <- data.frame(study_method = study_method, result = pass_fail)
print("Categorical data frame:")
print(df_cat)

# Contingency table
tbl <- table(df_cat$study_method, df_cat$result)
print("Contingency table:")
print(tbl)

# Mosaic plot
mosaicplot(tbl, main = "Study Method vs Pass/Fail", color = TRUE)

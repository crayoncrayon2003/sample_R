print("############################################################")
print("# 1. Basic plotting with base R")
print("############################################################")

# Sample data
x <- 1:5
y <- c(2, 4, 6, 8, 10)

# Scatter plot
plot(x, y, main = "Scatter Plot", xlab = "X axis", ylab = "Y axis", col = "blue", pch = 19)

# Line plot
plot(x, y, type = "l", main = "Line Plot", xlab = "X axis", ylab = "Y axis", col = "red", lwd = 2)

# Bar plot
barplot(y, names.arg = x, main = "Bar Plot", col = "lightgreen")

# Histogram
values <- c(1,2,2,3,3,3,4,4,4,4)
hist(values, main = "Histogram", xlab = "Values", col = "orange", breaks = 4)

# Boxplot
boxplot(values, main = "Boxplot", col = "purple")

print("############################################################")
print("# 1. Univariate data analysis")
print("############################################################")

# Sample data: test scores of students
scores <- c(85, 88, 90, 92, 95, 87, 78, 80, 82, 85, 79, 81, 65, 68, 70, 72, 66, 69)
print("Scores data:")
print(scores)

print("############################################################")
print("# 2. Measures of central tendency")
print("############################################################")

# Mean
mean_val <- mean(scores)
print(paste("Mean:", mean_val))

# Median
median_val <- median(scores)
print(paste("Median:", median_val))

# Mode (not built-in, define function)
get_mode <- function(x) {
  uniq_x <- unique(x)
  uniq_x[which.max(tabulate(match(x, uniq_x)))]
}
mode_val <- get_mode(scores)
print(paste("Mode:", mode_val))

print("############################################################")
print("# 3. Measures of dispersion")
print("############################################################")

# Range
range_val <- range(scores)
print(paste("Range:", paste(range_val, collapse = " - ")))

# Variance
variance_val <- var(scores)
print(paste("Variance:", variance_val))

# Standard deviation
sd_val <- sd(scores)
print(paste("Standard deviation:", sd_val))

# Interquartile range
iqr_val <- IQR(scores)
print(paste("IQR:", iqr_val))

print("############################################################")
print("# 4. Using central tendency and dispersion")
print("############################################################")

# Example: Z-scores
z_scores <- (scores - mean_val) / sd_val
print("Z-scores:")
print(z_scores)

print("############################################################")
print("# 5. Time series data example")
print("############################################################")

# Create a time series object
ts_data <- ts(scores, start = 1, frequency = 1)
print("Time series data:")
print(ts_data)

# Plot time series
plot(ts_data, type = "o", col = "blue",
     main = "Time Series of Scores",
     xlab = "Observation",
     ylab = "Score")
grid()

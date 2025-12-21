print("############################################################")
print("# Basic statistics in R")
print("############################################################")

# Sample numeric data
scores <- c(85, 88, 90, 92, 95, 87, 78, 80, 82, 85, 79, 81, 65, 68, 70, 72, 66, 69)
print("Data:")
print(scores)

print("############################################################")
print("# 1. Measures of central tendency")
print("############################################################")

# Mean
mean_val <- mean(scores)
print(paste("Mean:", mean_val))

# Median
median_val <- median(scores)
print(paste("Median:", median_val))

print("############################################################")
print("# 2. Measures of dispersion")
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

print("############################################################")
print("# 3. Summary")
print("############################################################")

summary_val <- summary(scores)
print(summary_val)

print("############################################################")
print("# 4. Additional statistics")
print("############################################################")

# Minimum
print(paste("Minimum:", min(scores)))

# Maximum
print(paste("Maximum:", max(scores)))

# Quantiles
quantiles <- quantile(scores)
print("Quantiles:")
print(quantiles)

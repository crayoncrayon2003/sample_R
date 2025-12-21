print("############################################################")
print("# 1. Sample mean and its properties")
print("############################################################")

set.seed(123)
population <- rnorm(10000, mean = 50, sd = 10)

# Draw a sample
sample_n <- 30
sample_data <- sample(population, sample_n)

# Sample mean and variance
sample_mean <- mean(sample_data)
sample_var <- var(sample_data)

print(paste("Sample mean:", round(sample_mean, 2)))
print(paste("Sample variance:", round(sample_var, 2)))

# Check unbiasedness: mean of many sample means
sample_means <- replicate(1000, mean(sample(population, sample_n)))
print(paste("Mean of 1000 sample means:", round(mean(sample_means), 2)))

print("############################################################")
print("# 2. Confidence interval for mean (known SD)")
print("############################################################")

# Known population SD (sigma)
sigma <- 10
alpha <- 0.05
z <- qnorm(1 - alpha/2)
ci_lower <- sample_mean - z * sigma / sqrt(sample_n)
ci_upper <- sample_mean + z * sigma / sqrt(sample_n)
print(paste("95% CI for mean (known SD):", round(ci_lower, 2), "-", round(ci_upper, 2)))

print("############################################################")
print("# 3. Confidence interval for mean (unknown SD)")
print("############################################################")

# Use t-distribution
t_val <- qt(1 - alpha/2, df = sample_n - 1)
ci_lower_t <- sample_mean - t_val * sd(sample_data) / sqrt(sample_n)
ci_upper_t <- sample_mean + t_val * sd(sample_data) / sqrt(sample_n)
print(paste("95% CI for mean (unknown SD):", round(ci_lower_t, 2), "-", round(ci_upper_t, 2)))

print("############################################################")
print("# 4. Confidence interval for proportion")
print("############################################################")

# Sample data: success/failure
successes <- sum(sample_data > 50)  # Example: "success" if value > 50
sample_prop <- successes / sample_n

# 95% CI using normal approximation
ci_prop_lower <- sample_prop - z * sqrt(sample_prop*(1-sample_prop)/sample_n)
ci_prop_upper <- sample_prop + z * sqrt(sample_prop*(1-sample_prop)/sample_n)
print(paste("95% CI for proportion:", round(ci_prop_lower, 2), "-", round(ci_prop_upper, 2)))

print("############################################################")
print("# 5. Confidence interval for variance")
print("############################################################")

# Chi-square CI for variance
chi_lower <- qchisq(alpha/2, df = sample_n - 1)
chi_upper <- qchisq(1 - alpha/2, df = sample_n - 1)
ci_var_lower <- (sample_n - 1) * sample_var / chi_upper
ci_var_upper <- (sample_n - 1) * sample_var / chi_lower
print(paste("95% CI for variance:", round(ci_var_lower, 2), "-", round(ci_var_upper, 2)))

print("############################################################")
print("# 1. One-sample t-test (mean)")
print("############################################################")

set.seed(123)
sample_data <- rnorm(30, mean = 52, sd = 10)

# H0: mu = 50, H1: mu != 50
t_test_result <- t.test(sample_data, mu = 50)
print(t_test_result)

print("############################################################")
print("# 2. Two-sample t-test (mean)")
print("############################################################")

group1 <- rnorm(20, mean = 50, sd = 8)
group2 <- rnorm(20, mean = 55, sd = 8)

# H0: mu1 = mu2, H1: mu1 != mu2
t_test_2_result <- t.test(group1, group2)
print(t_test_2_result)

print("############################################################")
print("# 3. One-sample proportion test")
print("############################################################")

# Sample: 30 successes out of 50 trials
x <- 30
n <- 50
p0 <- 0.5

prop_test_result <- prop.test(x, n, p = p0)
print(prop_test_result)

print("############################################################")
print("# 4. Chi-square test for variance")
print("############################################################")

# Sample variance test: H0: sigma^2 = 100
s2 <- var(sample_data)
n <- length(sample_data)
chi_sq_lower <- (n - 1) * s2 / qchisq(0.975, df = n - 1)
chi_sq_upper <- (n - 1) * s2 / qchisq(0.025, df = n - 1)
print(paste("95% CI for variance:", round(chi_sq_lower,2), "-", round(chi_sq_upper,2)))

print("############################################################")
print("# 5. Type I and Type II errors")
print("############################################################")

# Type I error: rejecting H0 when it is true
# Type II error: failing to reject H0 when H1 is true
alpha <- 0.05
print(paste("Significance level (Type I error probability):", alpha))
beta <- 0.2  # Example
print(paste("Type II error probability (example):", beta))

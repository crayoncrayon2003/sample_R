print("############################################################")
print("# 1. Sampling distribution of the sample mean")
print("############################################################")

# Population: heights
set.seed(123)
population <- rnorm(10000, mean = 170, sd = 10)

# Take repeated samples of size n=30
n <- 30
sample_means <- replicate(1000, mean(sample(population, n)))

# Histogram of sample means
hist(sample_means, breaks = 30,
     main = "Sampling distribution of the sample mean",
     xlab = "Sample mean",
     col = "lightblue", border = "black")
grid()

print(paste("Mean of sample means:", mean(sample_means)))
print(paste("SD of sample means:", sd(sample_means)))

print("############################################################")
print("# 2. Normal approximation of Binomial")
print("############################################################")

n_bin <- 50
p_bin <- 0.3
# Mean and SD
mu <- n_bin * p_bin
sigma <- sqrt(n_bin * p_bin * (1 - p_bin))

# Probability of 10 <= X <= 20
prob_norm_approx <- pnorm(20 + 0.5, mean = mu, sd = sigma) - pnorm(10 - 0.5, mean = mu, sd = sigma)
print(paste("Normal approximation P(10 <= X <= 20):", round(prob_norm_approx, 4)))

print("############################################################")
print("# 3. t, Chi-square, and F distributions")
print("############################################################")

# t-distribution
df_t <- 10
x_t <- 1.5
print(paste("t-density at x=1.5 with df=10:", dt(x_t, df = df_t)))

# Chi-square distribution
df_chi <- 5
x_chi <- 7
print(paste("Chi-square density at x=7 with df=5:", dchisq(x_chi, df = df_chi)))

# F distribution
df1 <- 5
df2 <- 10
x_f <- 2
print(paste("F density at x=2 with df1=5, df2=10:", df(x_f, df1 = df1, df2 = df2)))

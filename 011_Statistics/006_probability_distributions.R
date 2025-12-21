print("############################################################")
print("# 1. Binomial distribution")
print("############################################################")

# Number of trials = 10, probability of success = 0.5
n <- 10
p <- 0.5

# Probability of exactly 5 successes
prob_5 <- dbinom(5, size = n, prob = p)
print(paste("P(X = 5) in Binomial(10, 0.5):", prob_5))

# Mean and variance
mean_binom <- n * p
var_binom <- n * p * (1 - p)
print(paste("Mean:", mean_binom, "Variance:", var_binom))

print("############################################################")
print("# 2. Normal distribution")
print("############################################################")

# Standard normal: mean = 0, sd = 1
x <- 0
prob_x <- dnorm(x, mean = 0, sd = 1)
print(paste("Density at x=0:", prob_x))

# Mean and variance
mean_norm <- 0
var_norm <- 1
print(paste("Mean:", mean_norm, "Variance:", var_norm))

print("############################################################")
print("# 3. t distribution")
print("############################################################")

df <- 10  # degrees of freedom
prob_t <- dt(0, df = df)
print(paste("t-density at 0 with df=10:", prob_t))

print("############################################################")
print("# 4. Chi-square distribution")
print("############################################################")

df_chi <- 5
prob_chi <- dchisq(3, df = df_chi)
print(paste("Chi-square density at 3 with df=5:", prob_chi))

print("############################################################")
print("# 5. F distribution")
print("############################################################")

df1 <- 5
df2 <- 10
prob_f <- df(2, df1 = df1, df2 = df2)
print(paste("F density at 2 with df1=5, df2=10:", prob_f))

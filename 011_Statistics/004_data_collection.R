print("############################################################")
print("# 1. Data collection for statistical inference")
print("############################################################")

# Example 1: Observational study
# Simulate data from a population without intervention
set.seed(123)
population_height <- rnorm(1000, mean = 170, sd = 10)
sample_obs <- sample(population_height, 50)
print("Sample from observational study:")
print(sample_obs)

print("############################################################")
print("# 2. Experimental study")
print("############################################################")

# Example 2: Randomized experiment
# Two groups with different treatments
set.seed(123)
group_A <- rnorm(25, mean = 50, sd = 5)
group_B <- rnorm(25, mean = 55, sd = 5)

df_exp <- data.frame(
  group = rep(c("A", "B"), each = 25),
  value = c(group_A, group_B)
)
print("Experimental study data:")
print(df_exp)

# Compare means
mean_A <- mean(group_A)
mean_B <- mean(group_B)
print(paste("Mean of group A:", mean_A))
print(paste("Mean of group B:", mean_B))

print("############################################################")
print("# 3. Sampling methods")
print("############################################################")

# Simple random sampling
sample_srs <- sample(population_height, 30)
print("Simple random sample:")
print(sample_srs)

# Systematic sampling (every 10th individual)
systematic_index <- seq(1, length(population_height), by = 10)
sample_sys <- population_height[systematic_index]
print("Systematic sample:")
print(sample_sys)

# Stratified sampling
# Suppose population is divided by gender
set.seed(123)
gender <- sample(c("Male", "Female"), 1000, replace = TRUE)
population_df <- data.frame(height = population_height, gender = gender)
# Sample 10 males and 10 females
sample_strat <- rbind(
  population_df[sample(which(population_df$gender == "Male"), 10), ],
  population_df[sample(which(population_df$gender == "Female"), 10), ]
)
print("Stratified sample:")
print(sample_strat)

print("############################################################")
print("# 4. Fisher's 3 principles demonstration")
print("############################################################")

# Randomization
set.seed(123)
treatment <- sample(c("Drug", "Placebo"), 50, replace = TRUE)

# Replication
response <- rnorm(50, mean = ifelse(treatment == "Drug", 5, 3), sd = 1)

# Blocking (using age group as block)
age_group <- sample(c("Young", "Old"), 50, replace = TRUE)
df_fisher <- data.frame(treatment, response, age_group)
print("Data demonstrating Fisher's principles:")
print(df_fisher)

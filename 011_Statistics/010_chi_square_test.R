print("############################################################")
print("# 1. Chi-square goodness-of-fit test")
print("############################################################")

# Observed frequencies
observed <- c(30, 10, 10, 50)
# Expected proportions
expected <- c(0.25, 0.25, 0.25, 0.25)

# Perform goodness-of-fit test
gof_test <- chisq.test(observed, p = expected)
print(gof_test)

print("############################################################")
print("# 2. Chi-square test of independence")
print("############################################################")

# Example data: cross table
# Suppose we have 2 categorical variables: Gender x Preference
data <- matrix(c(20, 15, 30, 35), nrow = 2,
               dimnames = list(Gender = c("Male", "Female"),
                               Preference = c("A", "B")))
print("Contingency table:")
print(data)

# Perform chi-square test of independence
indep_test <- chisq.test(data)
print(indep_test)

# Expected counts
print("Expected counts under independence:")
print(indep_test$expected)

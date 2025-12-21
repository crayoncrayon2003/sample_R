print("############################################################")
print("# 1. Defining a function")
print("############################################################")

# Define a simple function
add_two_numbers <- function(a, b) {
  a + b
}

# Call the function
result <- add_two_numbers(3, 5)
print(result)


print("############################################################")
print("# 2. The last expression is returned (simple case)")
print("############################################################")

# Only one expression
f1 <- function() {
  10   # ← this value is returned
}

print(f1())


print("############################################################")
print("# 3. The last expression is returned (multiple expressions)")
print("############################################################")

# Multiple expressions: only the last one is returned
f <- function() {
  1
  2
  3   # ← this value is returned
}

print(f())


print("############################################################")
print("# 4. Using return() explicitly")
print("############################################################")

# return() is useful for early exit
check_positive <- function(x) {
  if (x < 0) {
    return("negative value detected")
  }
  "value is non-negative"
}

print(check_positive(10))
print(check_positive(-5))


print("############################################################")
print("# 5. Returning multiple values using list")
print("############################################################")

# Functions often return lists in R
summary_stats <- function(x) {
  list(
    min = min(x),
    max = max(x),
    mean = mean(x)
  )
}

stats <- summary_stats(c(1, 2, 3, 4, 5))
print(stats)


print("############################################################")
print("# 6. Functions are objects")
print("############################################################")

# Functions themselves are objects
print(typeof(add_two_numbers))

# Assign function to another variable
f_copy <- add_two_numbers
print(f_copy(2, 3))


print("############################################################")
print("# 7. Summary")
print("############################################################")

print("Functions return the last evaluated expression")
print("return() is used for early exit")
print("Use list to return multiple values")

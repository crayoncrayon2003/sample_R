print("############################################################")
print("# 1. Creating a numeric vector")
print("############################################################")

x <- c(1, 2, 3, 4, 5)
print(x)
print(typeof(x))


print("############################################################")
print("# 2. sum()")
print("############################################################")

# Sum of all elements
print(sum(x))


print("############################################################")
print("# 3. min() and max()")
print("############################################################")

print(min(x))
print(max(x))


print("############################################################")
print("# 4. mean()")
print("############################################################")

print(mean(x))


print("############################################################")
print("# 5. round()")
print("############################################################")

y <- c(1.234, 5.678)
print(y)

# Round to nearest integer
print(round(y))

# Round to 1 decimal place
print(round(y, 1))


print("############################################################")
print("# 6. abs()")
print("############################################################")

z <- c(-10, -5, 0, 5, 10)
print(z)

print(abs(z))


print("############################################################")
print("# 7. Handling NA values")
print("############################################################")

x_na <- c(1, 2, NA, 4)
print(x_na)

# NA propagates by default
print(sum(x_na))
print(mean(x_na))

# Use na.rm = TRUE to remove NA
print(sum(x_na, na.rm = TRUE))
print(mean(x_na, na.rm = TRUE))


print("############################################################")
print("# 8. Summary")
print("############################################################")

print("Numeric built-in functions work on vectors")
print("Most functions accept na.rm = TRUE")
print("Vectorized operations are the default in R")

print("############################################################")
print("# 1. Assigning values to variables")
print("############################################################")

# Assign a value to a variable using <- (recommended)
x <- 10
y <- 20

# Use variables in calculations
z <- x + y

print(z)

print("############################################################")
print("# 2. Using = for assignment (allowed, but not recommended)")
print("############################################################")
# = also works for assignment
a = 1
b = 2

# At this stage, you can think <- and = as almost the same
c = a + b

print(c)


print("############################################################")
print("3. Everything in R is an object")
print("############################################################")

# Numbers are objects
print(typeof(x))

# Vectors are objects
v <- c(1, 2, 3)
print(typeof(v))

# Functions are also objects
f <- function(n) {
  n * 2
}

print(typeof(f))

# Call the function
print(f(5))


print("############################################################")
print("4. Constants in R (there are no true constants)")
print("############################################################")

# Built-in constant
base::pi
print(base::pi)

# Even built-in constants can be reassigned
# (This is NOT recommended)
pi <- 3
pi
print(pi)

# A common convention for constants:
# - use uppercase variable names
MAX_COUNT <- 100
MAX_COUNT
print(MAX_COUNT)

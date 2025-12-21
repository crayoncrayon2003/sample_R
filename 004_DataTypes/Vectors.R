print("############################################################")
print("# 1. Atomic vectors")
print("############################################################")

# Numeric vector
v_num <- c(1, 2, 3)
print(v_num)
print(typeof(v_num))

# Character vector
v_char <- c("a", "b", "c")
print(v_char)
print(typeof(v_char))

# Logical vector
v_logical <- c(TRUE, FALSE, TRUE)
print(v_logical)
print(typeof(v_logical))

print("############################################################")
print("# 2 Additional vector types")
print("############################################################")

# Empty vector
v_empty <- c()
print("Empty vector:")
print(v_empty)
print(typeof(v_empty))

# Unit vector (all 1s)
v_unit <- rep(1, 5)
print("Unit vector:")
print(v_unit)

# Column vector vs row vector (1D in R is always 1D, but can be treated as matrix)
v_col <- matrix(1:3, nrow = 3, ncol = 1)
print("Column vector (matrix form):")
print(v_col)

v_row <- matrix(1:3, nrow = 1, ncol = 3)
print("Row vector (matrix form):")
print(v_row)

# Sequence vector
v_seq1 <- 1:5
print("Sequence vector:")
print(v_seq1)

v_seq2 <- seq(6,10)
print("Sequence vector:")
print(v_seq2)


# Repeated sequence
v_rep <- rep(1:3, times = 2)
print("Repeated sequence vector:")
print(v_rep)


print("############################################################")
print("# 3. Vector coercion")
print("############################################################")

# Mixing types causes coercion
v_mix <- c(1, "a", TRUE)
print(v_mix)
print(typeof(v_mix))

# coercion (forced type conversion)
# Vector is a mathematical vector, not an array.
# Vector cannot mix types.
# logical -> numeric -> character (priority order)
# Because "a" is character, all elements become character.

print("############################################################")
print("# 1 Special matrices")
print("############################################################")

zero_matrix <- matrix(0, nrow = 3, ncol = 3)
print("Zero matrix:")
print(zero_matrix)

identity_matrix <- diag(3)
print("Identity matrix:")
print(identity_matrix)

scalar_matrix <- diag(rep(5, 3))
print("Scalar matrix:")
print(scalar_matrix)

diag_matrix <- diag(c(1, 2, 3))
print("Diagonal matrix:")
print(diag_matrix)

upper_tri <- matrix(1:9, nrow = 3)
upper_tri[lower.tri(upper_tri)] <- 0
print("Upper triangular matrix:")
print(upper_tri)

lower_tri <- matrix(1:9, nrow = 3)
lower_tri[upper.tri(lower_tri)] <- 0
print("Lower triangular matrix:")
print(lower_tri)

print("Transpose of original matrix m:")
print(t(m))

print("############################################################")
print("# 2. Matrix")
print("############################################################")

# Matrix is a 2-dimensional atomic vector
# All elements must be the same type

m <- matrix(
  1:6,
  nrow = 2,
  ncol = 3
)

print(m)
print(typeof(m))


print("############################################################")
print("# 3. Column-major order")
print("############################################################")

# R fills matrices by columns (column-major order)
m_col <- matrix(1:6, nrow = 2, byrow = FALSE)
print(m_col)

# Fill by row
m_row <- matrix(1:6, nrow = 2, byrow = TRUE)
print(m_row)


print("############################################################")
print("# 4. Dimensions and access")
print("############################################################")

print(dim(m))
print(nrow(m))
print(ncol(m))

print(m[1, 1])
print(m[1, ])
print(m[, 1])


print("############################################################")
print("# 5. Matrix arithmetic")
print("############################################################")

A <- matrix(1:4, nrow = 2)
B <- matrix(5:8, nrow = 2)

print(A + B)    # element-wise
print(A * B)    # element-wise
print(A %*% B)  # matrix multiplication


print("############################################################")
print("# 6. Utilities")
print("############################################################")

print(t(A))      # transpose

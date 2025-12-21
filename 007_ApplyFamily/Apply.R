print("############################################################")
print("# 1. apply()")
print("############################################################")

# Example matrix
mat <- matrix(1:9, nrow = 3)
print("Original matrix:")
print(mat)

# Apply sum over rows (MARGIN = 1)
row_sums <- apply(mat, 1, sum)
print("Sum of each row:")
cat(row_sums, sep = "\n")

# Apply sum over columns (MARGIN = 2)
col_sums <- apply(mat, 2, sum)
print("Sum of each column:")
cat(col_sums,"\n")


print("############################################################")
print("# 2. lapply()")
print("############################################################")

# Example list
lst <- list(a = 1:3, b = 4:6, c = 7:9)
print("Original list:")
print(lst)

# Apply function to each element
lst_squared <- lapply(lst, function(x) x^2)
print("Each element squared:")
print(lst_squared)


print("############################################################")
print("# 3. sapply()")
print("############################################################")

# sapply returns simplified result if possible
squared_vec <- sapply(lst, function(x) x^2)
print("Each element squared (sapply):")
print(squared_vec)


print("############################################################")
print("# 4. vapply()")
print("############################################################")

# vapply is like sapply but safer: you specify the type of result
v_squared <- vapply(lst, function(x) sum(x^2), numeric(1))
print("Sum of squares of each element (vapply):")
print(v_squared)


print("############################################################")
print("# 5. tapply()")
print("############################################################")

# Example vector and factor
values <- c(10, 20, 30, 40, 50, 60)
groups <- factor(c("A","A","B","B","C","C"))

# Apply function by group
group_sum <- tapply(values, groups, sum)
print("Sum of values by group:")
print(group_sum)


print("############################################################")
print("# 6. mapply()")
print("############################################################")

# Apply function to multiple arguments
m1 <- 1:5
m2 <- 6:10
sum_vec <- mapply(sum, m1, m2)
print("Element-wise sum of two vectors using mapply:")
print(sum_vec)

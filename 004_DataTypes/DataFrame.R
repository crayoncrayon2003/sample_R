print("############################################################")
print("# 1. Data frame")
print("############################################################")

# Data frame is a special type of list
df <- data.frame(
  id = c(1, 2, 3),
  name = c("Alice", "Bob", "Charlie"),
  score = c(80, 90, 85)
)

print(df)
print(typeof(df))

print("############################################################")
print("# 2. Accessing data frame elements")
print("############################################################")

print(df$name)
print(df[1, ])

print("############################################################")
print("# 3. Summary")
print("############################################################")

print("Vector: 1D, same type (mathematical vector)")
print("Matrix: 2D, same type (mathematical matrix)")
print("List: different type elements")
print("Data frame: table-like list (columns have types)")

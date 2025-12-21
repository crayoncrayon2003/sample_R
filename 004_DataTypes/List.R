print("############################################################")
print("# 1. List")
print("############################################################")

# List can contain different types
lst <- list(
  number = 1,
  text = "hello",
  vector = c(1, 2, 3)
)

print(lst)
print(typeof(lst))

# List is NOT a mathematical vector.
# List is more like an array or container.
# Each element keeps its own type

print("############################################################")
print("# 2. Accessing list elements")
print("############################################################")

print(lst$number)
print(lst[[1]])

print("############################################################")
print("# 1. length()")
print("############################################################")

# length() returns the number of elements
v <- c(10, 20, 30, 40)
print(v)
print(length(v))


print("############################################################")
print("# 2. class()")
print("############################################################")

# class() returns the class of an object
print(class(v))
print(class("Hello"))
print(class(Sys.Date()))


print("############################################################")
print("# 3. typeof()")
print("############################################################")

# typeof() returns the internal storage type
print(typeof(v))
print(typeof(1))
print(typeof(1L))
print(typeof(TRUE))


print("############################################################")
print("# 4. str()")
print("############################################################")

# str() shows the structure of an object
df <- data.frame(
  id = c(1, 2, 3),
  name = c("Alice", "Bob", "Charlie"),
  score = c(80, 90, 85)
)

str(df)


print("############################################################")
print("# 5. summary()")
print("############################################################")

# summary() provides a quick statistical summary
print(summary(df))


print("############################################################")
print("# 6. head() / tail()")
print("############################################################")

# head() shows first elements
print(head(v))

# tail() shows last elements
print(tail(v))


print("############################################################")
print("# 7. is.*() functions")
print("############################################################")

# Type checking functions
print(is.numeric(v))
print(is.character(v))
print(is.data.frame(df))


print("############################################################")
print("# 8. help() / ?")
print("############################################################")

# Show help documentation
# help(length)
# ?length


print("############################################################")
print("# 9. ls() / rm()")
print("############################################################")

# List objects in the current environment
print(ls())

# Remove an object (be careful)
# rm(v)

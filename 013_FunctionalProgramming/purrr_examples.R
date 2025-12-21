print("############################################################")
print("# 1. Load purrr package")
print("############################################################")

# Install purrr if not installed
if (!requireNamespace("purrr", quietly = TRUE)) {
  install.packages("purrr")
}

library(purrr)

print("############################################################")
print("# 2. Example list")
print("############################################################")

my_list <- list(
  a = 1:5,
  b = 6:10,
  c = 11:15
)

print(my_list)

print("############################################################")
print("# 3. Using map() - apply a function to each element")
print("############################################################")

# Double each element
doubled <- map(my_list, ~ .x * 2)
print(doubled)

print("############################################################")
print("# 4. Using map_dbl() - return numeric vector")
print("############################################################")

# Calculate sum of each element
sums <- map_dbl(my_list, sum)
print(sums)

print("############################################################")
print("# 5. Using map_chr() - return character vector")
print("############################################################")

# Convert each element to a string
as_text <- map_chr(my_list, ~ paste(.x, collapse = ","))
print(as_text)

print("############################################################")
print("# 6. Using walk() - side effects, return nothing")
print("############################################################")

# Print each element (side effect)
walk(my_list, ~ print(.x))

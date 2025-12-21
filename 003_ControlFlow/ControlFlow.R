
print("############################################################")
print("# 1. if / else")
print("############################################################")

x <- 10

# if is an expression in R (it returns a value)
result_if <- if (x > 5) {
  "x is greater than 5"
} else {
  "x is 5 or less"
}

print(result_if)


print("############################################################")
print("# 2. for loop")
print("############################################################")

# for loops are mainly used for side effects
for (i in 1:3) {
  print(i)
}

# for itself does not return a meaningful value
result_for <- for (i in 1:3) {
  i
}

print(result_for)


print("############################################################")
print("# 3. while loop")
print("############################################################")

count <- 1

while (count <= 3) {
  print(count)
  count <- count + 1
}

# while is also used for side effects
result_while <- while (FALSE) {
  1
}

print(result_while)


print("############################################################")
print("# 4. Summary")
print("############################################################")

# Key points:
# - if / else returns a value
# - for and while are mainly for side effects
# - explicit print() is needed when using source()
print("End of Control Flow")

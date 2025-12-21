print("############################################################")
print("# 1. Creating a logical vector")
print("############################################################")

flags <- c(TRUE, FALSE, TRUE, FALSE)
print(flags)
print(typeof(flags))


print("############################################################")
print("# 2. any()")
print("############################################################")

# anyは、ベクトルが１つでもTRUEを含むと、全体がTRUEになる -> 論理和
print(any(c(FALSE, FALSE)))
print(any(c(FALSE, TRUE)))

# any() returns TRUE if at least one element is TRUE
print(any(flags))


print("############################################################")
print("# 3. all()")
print("############################################################")

# all()は、ベクトルが全てTRUEを含むと、全体がTRUE -> 論理積
print(all(c(TRUE, TRUE)))
print(all(c(TRUE, FALSE)))

# all() returns TRUE only if all elements are TRUE
print(all(flags))



print("############################################################")
print("# 4. is.na()")
print("############################################################")

x <- c(1, NA, 3, NA)
print(x)

# Check which elements are NA
print(is.na(x))


print("############################################################")
print("# 5. which()")
print("############################################################")

# which() returns indices of TRUE values
print(which(is.na(x)))

# Combine logical condition and which()
print(which(x > 2))


print("############################################################")
print("# 6. Combining logical functions")
print("############################################################")

# Check if any NA exists
print(any(is.na(x)))

# Check if all values are non-NA
print(all(!is.na(x)))


print("############################################################")
print("# 7. Summary")
print("############################################################")

print("Logical functions work on logical vectors")
print("any(): at least one TRUE")
print("all(): all TRUE")
print("is.na(): detect missing values")
print("which(): get indices from logical results")

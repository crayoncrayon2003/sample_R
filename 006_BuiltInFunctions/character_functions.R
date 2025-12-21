print("############################################################")
print("# 1. nchar()")
print("############################################################")

# nchar() returns the number of characters
text <- "Hello World"
print(nchar(text))


print("############################################################")
print("# 2. paste() / paste0()")
print("############################################################")

# paste() concatenates strings with a separator
first <- "Hello"
second <- "World"
print(paste(first, second))
print(paste(first, second, sep = ", "))
print(paste(first, second, sep = ": "))

# paste0() concatenates strings without a separator
print(paste0(first, second))


print("############################################################")
print("# 3. toupper() / tolower()")
print("############################################################")

# Convert to upper case
print(toupper("hello"))

# Convert to lower case
print(tolower("HELLO"))


print("############################################################")
print("# 4. substr()")
print("############################################################")

# Extract part of a string
text <- "DataScience"
print(substr(text, 1, 4))   # "DataScience" -> "Data"
print(substr(text, 5, 11))  # "DataScience" -> "Science"


print("############################################################")
print("# 5. strsplit()")
print("############################################################")

# Split a string into parts
sentence <- "R is very powerful"
words <- strsplit(sentence, " ")
print(words)


print("############################################################")
print("# 6. grepl()")
print("############################################################")

# grepl() returns TRUE/FALSE if a pattern is found
print(grepl("R", "R is fun"))
print(grepl("Python", "R is fun"))


print("############################################################")
print("# 7. gsub()")
print("############################################################")

# gsub() replaces matched patterns
text <- "I like apples"
print(gsub("apples", "oranges", text))


print("############################################################")
print("# 8. sprintf()")
print("############################################################")

# sprintf() formats strings
name <- "Alice"
age <- 30
print(sprintf("My name is %s and I am %d years old.", name, age))

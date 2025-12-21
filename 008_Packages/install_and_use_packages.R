print("############################################################")
print("# 1. Installing packages")
print("############################################################")

if (!requireNamespace("ggplot2", quietly = TRUE)) {
    install.packages("ggplot2")
}
library(ggplot2)

if (!requireNamespace("dplyr", quietly = TRUE)) {
    install.packages("dplyr")
}
library(dplyr)

print("Packages can be installed using install.packages('package_name')")


print("############################################################")
print("# 2. Loading packages")
print("############################################################")

# Load a package
library(ggplot2)
library(dplyr)

print("Packages are loaded with library('package_name')")


print("############################################################")
print("# 3. Checking installed packages")
print("############################################################")

installed <- installed.packages()
print("First 5 installed packages:")
print(installed[1:5, "Package"])


print("############################################################")
print("# 4. Using functions from packages")
print("############################################################")

# Using ggplot2 for a quick plot
df <- data.frame(x = 1:5, y = c(3, 5, 2, 8, 7))

p <- ggplot(df, aes(x = x, y = y)) +
  geom_point() +
  geom_line()

print(p)

# Using dplyr to manipulate data
df2 <- df %>%
  mutate(z = x + y)

print("Data frame after dplyr mutate:")
print(df2)


print("############################################################")
print("# 5. Using package without loading")
print("############################################################")

# You can also use :: to call a function without library()
df3 <- dplyr::mutate(df, w = x * y)
print("Using dplyr::mutate without loading package:")
print(df3)

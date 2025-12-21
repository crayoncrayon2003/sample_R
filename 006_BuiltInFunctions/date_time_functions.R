print("############################################################")
print("# 1. Sys.Date()")
print("############################################################")

# Sys.Date() returns today's date
today <- Sys.Date()
print(today)
print(typeof(today))


print("############################################################")
print("# 2. Sys.time()")
print("############################################################")

# Sys.time() returns current date and time
now <- Sys.time()
print(now)
print(typeof(now))


print("############################################################")
print("# 3. as.Date()")
print("############################################################")

# Convert character to Date
date_str <- "2025-01-01"
d <- as.Date(date_str)
print(d)
print(typeof(d))


print("############################################################")
print("# 4. Date calculation")
print("############################################################")

# Date arithmetic
print(today + 1)    # tomorrow
print(today - 1)    # yesterday

# Difference between dates
d1 <- as.Date("2025-01-10")
d2 <- as.Date("2025-01-01")
print(d1 - d2)


print("############################################################")
print("# 5. difftime()")
print("############################################################")

# Calculate time difference
t1 <- as.POSIXct("2025-01-01 12:00:00")
t2 <- as.POSIXct("2025-01-01 10:30:00")
diff <- difftime(t1, t2, units = "mins")
print(diff)


print("############################################################")
print("# 6. format()")
print("############################################################")

# Format date and time
print(format(today, "%Y/%m/%d"))
print(format(now, "%Y-%m-%d %H:%M:%S"))


print("############################################################")
print("# 7. weekdays(), months()")
print("############################################################")

# Extract weekday and month
print(weekdays(today))
print(months(today))


print("############################################################")
print("# 8. lubridate (preview)")
print("############################################################")

# lubridate is NOT a built-in package, but very common
# Uncomment after installing lubridate
# install.packages("lubridate")
# library(lubridate)
# print(ymd("2025-01-01"))

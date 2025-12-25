print("############################################################")
print("# 1. Load httr package")
print("############################################################")

# Install httr if not installed
if (!requireNamespace("httr", quietly = TRUE)) {
  install.packages("httr")
}

library(httr)

print("############################################################")
print("# 2. Make a GET request")
print("############################################################")


url <- "http://127.0.0.1:5000/test-get"

response <- GET(url)

# Check status
print(paste("Status code:", status_code(response)))

print("############################################################")
print("# 3. Parse content as text or JSON")
print("############################################################")

# Content as text
content_text <- content(response, as = "text", encoding = "UTF-8")
print(substr(content_text, 1, 200))  # first 200 characters

# Content as parsed JSON
if (!requireNamespace("jsonlite", quietly = TRUE)) {
  install.packages("jsonlite")
}
library(jsonlite)

content_json <- content(response, as = "parsed")
print(content_json$full_name)
print(content_json$description)

print("############################################################")
print("# 4. POST request example (dummy)")
print("############################################################")

# POST example (httpbin.org echo endpoint)
post_response <- POST("http://127.0.0.1:5000/test-post", body = list(name = "Alice", score = 100), encode = "json")
print(content(post_response, as = "parsed"))

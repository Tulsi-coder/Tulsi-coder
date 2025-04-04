# Simple data frame

data <- data.frame(
  Name = c("Dipa", "Puja", "Ranju", "Dipak", "Eliza"),
  Age = c(26, 27, 29, 30, 25)
)
# Access a column
data$Name

# Access a specific row
data[1, ]  # First row

# Add a new column (length must match number of rows)
data$Grade <- c("A", "B", "A", "C", "B")

# Filter data (e.g., where Age > 25)
subset(data, Age > 25)

# Rename a column 
names(data)[2] <- "AgeYears"

# Remove a column
data$OldColumn <- NULL 

# Remove a row 
data <- data[-3, ]

# final data
print(data)

setwd('C:/CZ4032/Tanzania')

# Define train_values_url
train_values_url <- "train_values.csv"

# Import train_values
train_values <- read.csv(train_values_url)

# Define train_labels_url
train_labels_url <- "train_labels.csv"

# Import train_labels
train_labels <- read.csv(train_labels_url)

# Define test_values_url
test_values_url <- "test_values.csv"

# Import test_values
test_values <- read.csv(test_values_url)

# Merge data frames to create the data frame train
train <- read.csv("train1.csv")
test <- read.csv("test1.csv")

# Load the ggplot package and examine train
library(ggplot2)
# Now subsetting when construction_year is larger than 0
ggplot(subset(train, construction_year > 0), aes(x = construction_year)) +
  geom_histogram(bins = 20) + 
  facet_grid( ~ status_group)

# Load the randomForest library
library(randomForest)

# Set seed and create a random forest classifier
set.seed(42)
model_forest <- randomForest(as.factor(status_group) ~ longitude + latitude + quantity + waterpoint_type + construction_year + extraction_type_class + management + payment + water_quality + source,
                             data = train, importance = TRUE, ntree = 5, nodesize = 2)

# Use random forest to predict the values in train
pred_forest_train <- predict(model_forest, test)

library(caret)
confusionMatrix(pred_forest_train, test$status_group)

varImpPlot(model_forest)
importance(model_forest)


# Setting working Directory to folder with data set (needs to be changed to where your file is located)
setwd("/Users/kirat/Desktop/Data Analysis/DATASETS")

# Installing required packages
install.packages("tidyverse", type = "source")

# Loading above and also existing packages (i.e. already installed)
library(tidyverse)
library(broom)
library(janitor)
library(ggplot2)
library(dplyr)
library(class)
library(corrplot)
library(caret)

# Loading diabetes data
diabetes_df <- read.csv("diabetes.csv", header = TRUE) 

###################################################### Data Cleaning  #######################################################

# Obvious place to start is retrieving the first 5 entries to see values and table structure
head(diabetes_df, 5)

# We can also view a statistical summary of the data set
summary(diabetes_df)

# To explore this more closely, we can begin by looking at the column names to see if adjustments are needed
colnames(diabetes_df) 
    # By doing further research into origins of data set, I discovered that the data represents women, provided they are at least 21 years old,
    # of Pima Indian Heritage. More specifically however, it was clear that some columns defined specific data features not clear in name:
    # 'Pregnancies' - Number of pregnancies 
    # 'Glucose' - Concentration in oral test
    # 'Outcome' - A binary variable for diabetes status, where 1 means the woman has diabetes, and 0 means they do not
    # To add this specificity to the data, we can change the column names
colnames(diabetes_df)[1] <- ("num_pregnancies") 
colnames(diabetes_df)[2] <- ("glucose_conc")
colnames(diabetes_df)[9] <- ("diabetes_status")
    # Now we have the issue where some column names are lowercase and others with capital letters. Since general format for table headers is
    # lowercase with no spaces, we should make all column names consistent
diabetes_df <- diabetes_df %>%
  clean_names()
    # Now we check to see if everything worked
head(diabetes_df, 5)

# Now we must examine the data types to see if all data is consistent with expectations
str(diabetes_df)
    # Everything seems ok, however it should be noted that if diabetes_status wasn't already binary but instead categorical, we would need to 
    # convert it. To showcase this, I'll first convert it back to categorical and then back again to a binary variable

    # Changing to categorical
diabetes_df <- diabetes_df %>% mutate(diabetes_status = ifelse(diabetes_status == 0, "Healthy", "Diabetic"))

    # Back to 1 and 0
diabetes_df$diabetes_status <- ifelse(diabetes_df$diabetes_status == "Diabetic", 1, 0)
diabetes_df$diabetes_status <- as.integer(diabetes_df$diabetes_status)

# No we check for missing values
sum(is.na(diabetes_df))
    # All clear. If any missing, simply used na.omit on the data frame and make a new one.

# Now we check for duplicate entries in data
get_dupes(diabetes_df)
# No duplicate values, if there were: diabetes_df <- diabetes_df %>% distinct()

# Examining the data we can also observe that multiple rows have entries inconsistent with real life. For example, a BMI of 0 or blood
# pressure of 0 is not possible. These rows suggest errors in input and need to be dealt with. We could either remove entirely, 
# which would be to the detriment of data size and bias, or impute using means. However, we must keep in
# mind that Insulin, which also has 0 values, is a possibility, and thus should be left alone.

cleaned_df <- diabetes_df

# replacing bmi nulls with mean
bmi_null = as.numeric(cleaned_df$bmi)
bmi_null[bmi_null == 0] = NA
avg_bmi = round(mean(na.omit(bmi_null)), 1)

cleaned_df_replaced <- cleaned_df %>%
  mutate(bmi_cleaned = ifelse(is.na(bmi_null), avg_bmi, bmi_null))

# replacing skin thickness nulls with mean
skin_thickness_null = as.numeric(cleaned_df$skin_thickness)
skin_thickness_null[skin_thickness_null == 0] = NA
avg_skin_thickness = round(mean(na.omit(skin_thickness_null)), 1)

cleaned_df_replaced_2 <- cleaned_df_replaced %>%
  mutate(skin_thickness_cleaned = ifelse(is.na(skin_thickness_null), avg_skin_thickness, skin_thickness_null))

# replacing blood pressure nulls with mean
blood_pressure_null = as.numeric(cleaned_df$blood_pressure)
blood_pressure_null[blood_pressure_null == 0] = NA
avg_blood_pressure = round(mean(na.omit(blood_pressure_null)), 1)

cleaned_df_replaced_3 <- cleaned_df_replaced_2 %>%
  mutate(blood_pressure_cleaned = ifelse(is.na(blood_pressure_null), avg_blood_pressure, blood_pressure_null))

# Replacing old columns in data set with cleaned ones.
cleaned_df['bmi'] <- cleaned_df_replaced['bmi_cleaned']
cleaned_df['skin_thickness'] <- cleaned_df_replaced_2['skin_thickness_cleaned']
cleaned_df['blood_pressure'] <- cleaned_df_replaced_3['blood_pressure_cleaned']

# Note: we could have also just omitted the rows with 0's using the following code
# diabetes_df <- filter(diabetes_df, skin_thickness > 0), skin thickness used as it had the most 0 values. 

############################################# DATA EXPLORATION AND VISUALISATION ######################################

# Share of women that have diabetes
share_diabetes <- mean(cleaned_df$diabetes_status)
cat("Share of women who have tested positive for Diabetes: ", round(share_diabetes * 100, 2), "%\n")
    # Close to a third of women in data set have some form of diabetes    

cleaned_df <- cleaned_df %>% mutate(diabetes_status = ifelse(diabetes_status == 0, "Healthy", "Diabetic"))
ggplot(cleaned_df, aes(x = factor(diabetes_status))) + 
  geom_bar(color = "white", fill = "lightblue") + theme_grey() +
  labs(x = "Diabetic Status", y = "Frequency", 
       title = "Distribution of women that tested positive for Diabetes")

# When exploring data, it is good practice to examine the distributions of the data so observe skew, modality, etc. To make it clear which
# histogram belongs to diabetics vs non diabetics, we will also change the values in diabetes_status to categorical. Let's do age:

ggplot(data = cleaned_df, mapping = aes(x = age)) + 
  geom_histogram(bins = 20, color = "white", fill = "lightblue") + 
  facet_wrap(~ diabetes_status) + theme_grey() + 
  labs(title = "Distribution of Age", 
       x = "Age",
       y = "Number of women")
    # Clear positively skewed distributions regardless of diabetes status, with majority of women being between 20 and 40. Note the outliers.
    # We can also view the distribution via box plots

ggplot(data = cleaned_df, aes(x = diabetes_status, y = age)) + 
  geom_boxplot(fill = "lightblue") + theme_grey() + 
  labs(title = "Distribution of Age", 
       x = " ",
       y = "Age")
    # Clearly the non diabetic women have much more outliers (older women), yet remain by all central measures under the distribution of
    # diabetic women.
    
# We will examine two more variables, blood pressure and the number of pregnancies

# Blood Pressure
ggplot(data = cleaned_df, mapping = aes(x = blood_pressure)) + 
  geom_histogram(bins = 20, color = "white", fill = "lightblue") + 
  facet_wrap(~ diabetes_status) + theme_grey() +
  labs(title = "Distribution of Blood Pressure (mmHg)",
       y = "Number of women")
    # Outliers of 0 indicative of incorrect data input or system error. General distribution is symmetric, which is useful.

ggplot(data = cleaned_df, aes(x = diabetes_status, y = blood_pressure)) + 
  geom_boxplot(fill = "lightblue") + theme_grey() +
  labs(title = "Distribution of Blood Pressure (mmHg)",
       x = " ",
       y = "Blood Pressure (mmHg)")
    # Symmetry is even more obvious

#Pregnancies
# create bar chart of pregnancies distribution
ggplot(data = cleaned_df, aes(x = num_pregnancies)) +
  geom_bar(color = "white", fill = "lightblue") + theme_grey() + facet_wrap(~ diabetes_status) +
  labs(title = "Distribution of Pregnancies",
       x = "Pregnancies",
       y = "Number of women")
    # Positively skewed, as expected, with similar trend between both categories of women

# We can also form some scatter plots 
ggplot(data = cleaned_df, aes(x = age, y = skin_thickness)) + 
  geom_point(aes(color = diabetes_status)) + theme_light() + 
  labs(title = "Skin Thickness vs Age",
       x = "Age",
       y = "Skin Thickness",
       caption = "Clear positive trend for both categories of women") + 
  geom_smooth(method = "lm", col = "black", se = FALSE)
    # Slight positive trend for Healthy women, and slight negative for diabetic, but nothing significant

ggplot(data = cleaned_df, aes(x = age, y = blood_pressure)) + 
  geom_point(aes(color = diabetes_status)) + theme_light() + 
  labs(title = "Blood Pressure vs Age", 
       x = "Age",
       y = "Blood Pressure",
       caption = "Clear Positive trend for both categories of women") + 
  geom_smooth(method = "lm", col = "black", se = FALSE)
    # Clear positive trend

# This can all be summed up by plotting the overall correlation between variables.

cleaned_df$diabetes_status <- ifelse(cleaned_df$diabetes_status == "Diabetic", 1, 0)
cleaned_df$diabetes_status <- as.integer(cleaned_df$diabetes_status)

correlation_df <- cor(cleaned_df)
corrplot(correlation_df, method = "shade", type = "upper",
         addCoef.col = "black", title = "Correlation Matrix for Independent variables", mar = c(0, 0, 2, 0), number.cex = 0.8, tl.cex = 0.5)
# age and num_pregnancies seem moderately correlated with a coefficient > 0.5, with insulin and skin_thickness slightly weaker at 0.44
# skin_thickness and age are the most negatively correlated at -0.11, which makes sense.
# Note: without mar inside corrplot, title is half hidden due to margin constraints

# Initial bivariate exploration into which variables might be related to diabetes. P value under significance (0.05) indicative of good indicator.
# More formally, the null hypothesis is that the two variables have independence (chi squared test). 
# We will use Chi squared tests because our target variable to predict is diabetes_status (the binary variable).

# Age (p-value < 0.05 so important)
chi_diabetes_age <- chisq.test(cleaned_df$diabetes_status, cleaned_df$age)
print(chi_diabetes_age)
# BMI (p-value = 0.04282 so not clear)
chi_diabetes_bmi <- chisq.test(cleaned_df$diabetes_status, cleaned_df$bmi)
print(chi_diabetes_bmi)
# Number of pregnancies (p-value < 0.05 surprisingly, so important. Further research lead me to gestational diabetes - up to 10% of women)
chi_diabetes_pregnancies <- chisq.test(cleaned_df$diabetes_status, cleaned_df$num_pregnancies)
print(chi_diabetes_pregnancies)

############################################################ MODELLING ########################################################

###### GOAL 1 - See which parameters most influence diabetes diagnosis

# Making the model (GLM so normalization is not needed and to increase model flexibility, plus continuous data).

diabetes_glm_model <- glm(diabetes_status ~ . , data = cleaned_df, family = "binomial")
summary(diabetes_glm_model)

# Tidy up the coefficient table (broom package)
tidy_model <- tidy(diabetes_glm_model)

# Calculating 95% CI and save as lower CI and upper CI
tidy_model$lower_CI <- exp(tidy_model$estimate - 1.96 * tidy_model$std.error)
tidy_model$upper_CI <- exp(tidy_model$estimate + 1.96 * tidy_model$std.error)

# Displaying the updated coefficient table
tidy_model
    # By observing p values, only glucose concentration, bmi, diabetes pedigree function and the number of pregnancies are significant
    # This aligns with correlation and general understanding of diabetes

##### GOAL 2 - predicting future possible cases of diabetes - GLM & K-Nearest Neighbours 

# The data must first be normalised 

cleaned_df <- cleaned_df %>% mutate(diabetes_status = ifelse(diabetes_status == 0, "Healthy", "Diabetic"))

normalise <- function(x){
  (x - min(x)) / (max(x) - min(x))
}
normalised_df <- as.data.frame(lapply(cleaned_df[1:8], normalise))
normalised_df[9] <- cleaned_df[9]


# Splitting up data into training and testing (80:20)
training_df <- normalised_df[1:614, ]
testing_df <- normalised_df[615:768, ]

# Making labels to observe prediction accuracy
training_df_labels <- cleaned_df[1:614, 9]
testing_df_labels <- cleaned_df[615:768, 9]

# Training GLM model
prediction_model <- glm(factor(diabetes_status) ~ . , family = "binomial", data = training_df)

# Assessing baseline proportions of Healthy vs Diabetic
prop.table(table(training_df$diabetes_status))
    # just a bit over 65% are Healthy in training set

# Predictions on the training set
trained_prediction = predict(prediction_model, data = training_df, type = "response")

# Confusion matrix on training data
table(training_df$diabetes_status, trained_prediction >= 0.5)
# Accuracy 
(124 + 360)/nrow(training_df) #Accuracy - 79%

#Predictions on the testing set
tested_prediction = predict(prediction_model, newdata = testing_df, type = "response")

# Confusion matrix on test set
table(testing_df$diabetes_status, tested_prediction >= 0.5)
# Accuracy
(30 + 87)/nrow(testing_df) #Accuracy - 76%

# Both ahead of baseline accuracy which is good

# Training the KNN model
prediction_model <- knn(train = training_df[-9], test = testing_df[-9], cl = training_df_labels, k = sqrt(768))

# Assessing Accuracy
Accuracy <- 100 * sum(testing_df_labels == prediction_model) / NROW(testing_df_labels)
Accuracy # 78%

# Both models extremely similar for prediction, and above baseline. If instead of imputing missing values we 
# removed them entirely:

################################################ REMOVING MISSING VALUES #############################################

diabetes_df <- filter(diabetes_df, skin_thickness > 0)

diabetes_df <- diabetes_df %>% mutate(diabetes_status = ifelse(diabetes_status == 0, "Healthy", "Diabetic"))

normalise <- function(x){
  (x - min(x)) / (max(x) - min(x))
}
normalised_df <- as.data.frame(lapply(diabetes_df[1:8], normalise))
normalised_df[9] <- diabetes_df[9]


# Splitting up data into training and testing (80:20)
training_df <- normalised_df[1:432, ]
testing_df <- normalised_df[433:541, ]

# Making labels to observe prediction accuracy
training_df_labels <- diabetes_df[1:432, 9]
testing_df_labels <- diabetes_df[433:541, 9]

# Training GLM model
prediction_model <- glm(factor(diabetes_status) ~ . , family = "binomial", data = training_df)

# Assessing baseline proportions of Healthy vs Diabetic
prop.table(table(training_df$diabetes_status))
# just a bit over 67% are Healthy in training set

# Predictions on the training set
trained_prediction = predict(prediction_model, data = training_df, type = "response")

# Confusion matrix on training data
table(training_df$diabetes_status, trained_prediction >= 0.5)
# Accuracy 
(82 + 260)/nrow(training_df) #Accuracy - 79%

#Predictions on the testing set
tested_prediction = predict(prediction_model, newdata = testing_df, type = "response")

# Confusion matrix on test set
table(testing_df$diabetes_status, tested_prediction >= 0.5)
# Accuracy
(66 + 25)/nrow(testing_df) #Accuracy - 83%

# Slight improvement on GLM model, but fairly close




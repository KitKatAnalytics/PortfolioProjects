# Packages ----------------------------------------------------------------
library(tidyverse)
library(ggforce)
library(ggcorrplot)
library(MASS)

# Load in data ------------------------------------------------------------
housing.df <- read.delim("dataset_processed.txt", header = TRUE, sep = ",")

# Clean data --------------------------------------------------------------
housing.df.cleaned <- housing.df %>%
  as_tibble() %>%
  
  # Make values NA
  mutate(Household.value = na_if(Household.value, 9999999),
         Monthly.rent = na_if(Monthly.rent, 99999)) %>% # Replace 100+ with 100-199 in number of units mutate(Number.of.units = replace(
  Number.of.units,
Number.of.units ==  100+ units ,
 100-199 units )) %>%
  
  # Replace negative income with 0
  mutate(Householder.income = replace(
    Householder.income,
    Householder.income < 0,
    0
  )) %>%
  
  # Get median number of units in each apartment mutate(Median.number.of.units = factor(
  Number.of.units,
c( 1 unit ,  2 units ,  3-5 units ,  6-9 units ,  10-19 units ,
    20-49 units ,  50-99 units ,  100-199 units ,  200+ units ),
c(1, 2, 4, 7.5, 14.5, 34.5, 74.5, 149.5, 249.5)
) %>% as.character() %>% as.numeric()) %>% # Create column for median number of stories mutate(Median.number.of.stories = factor(
  Number.of.stories,
c("1 story", "1-2 stories", "2 stories", "3-5 stories", "6-10 stories",
  "11-20 stories", "21+ stories"),
c(1, 1.5, 2, 4, 8, 15.5, 25.5)
) %>% as.character() %>% as.numeric()) %>% # Create column for median length of lease mutate(Median.length.of.lease = factor(
  Length.of.lease,
c("Less than 1 year", "1 year", "Between 1 and 2 years",
  "2 years", "More than 2 years", "No lease", "Owner-occupied"),
c(0.5, 1, 1.5, 2, 3.5, 0, NA)
) %>% as.character() %>% as.numeric()) %>% # Replace "8" with NA in some of the columns mutate(across(
  c(Householder.sex, Householder.hispanic.origin, Plumbing.facilities,
    Kitchen.facilities),
~ na_if(.x,  8 )
)) %>%
  
  # Replace blank cell with "Unknown" in race column
  
mutate(Householder.race = replace(
  Householder.race, Householder.race ==   ,  Unknown )) %>%
  
  # Change some columns to factors
  mutate(across(
    c(Householder.sex, Householder.hispanic.origin, Householder.race,
      Number.of.units:Number.of.stories, Plumbing.facilities:Length.of.lease,
      Resident.rating, Borough, Status:General.building.condition),
    ~ as.factor(.))) %>%
  
  # Re-order some of the factor levels
  mutate(
    Number.of.units = factor(
      Number.of.units,
      levels = c("1 unit", "2 units", "3-5 units", "6-9 units", "10-19 units",
                 "20-49 units", "50-99 units", "100-199 units", "200+ units")
    ),
    Number.of.stories = factor(
      Number.of.stories,
      levels = c("1 story", "1-2 stories", "2 stories", "3-5 stories",
                 "6-10 stories", "11-20 stories", "21+ stories")
    ),
    Length.of.lease = factor(
      Length.of.lease,
      levels = c("No lease", "Less than 1 year", "1 year", "Between 1 and 2 years",
                 "2 years", "More than 2 years", "Owner-occupied")
    ),
    Resident.rating = factor(
      Resident.rating,
      levels = c("Poor", "Fair", "Good", "Excellent")
    ),
    Severity.walls = factor(
      Severity.walls,
      levels = c("0", "1", "2")
    ),
    Severity.windows = factor(
      Severity.windows,
      levels = c("0", "1", "2", "3")
    ),
    Severity.stairways = factor(
      Severity.stairways,
      levels = c("0", "1", "2")
    ),
    Severity.floors = factor(
      Severity.floors,
      levels = c("0", "1", "2")
    ),
    General.building.condition = factor(
      General.building.condition,
      levels = c("0", "1", "2")
    )
  ) %>%
  
  # Change binary factor variables to integers mutate(
  Householder.female = factor(
    Householder.sex,
    c( Female ,  Male ),
    c(1, 0)
  ) %>% as.character() %>% as.integer(),


Householder.hispanic.origin = factor(
  Householder.hispanic.origin,
  c("Hispanic", "Not hispanic"),
  c(1, 0)
) %>% as.character() %>% as.integer(),
Owner.in.building = factor(
  Owner.in.building,
  c("Yes", "No"),
  c(1, 0)
) %>% as.character() %>% as.integer(),
Plumbing.facilities = factor(
  Plumbing.facilities,
  c("Yes", "No"),
  c(1, 0)
) %>% as.character() %>% as.integer(),
Kitchen.facilities = factor(
  Kitchen.facilities,
  c("Yes", "No"),
  c(1, 0)
) %>% as.character() %>% as.integer(),
Status.Owner = factor(
  Status,
  c("Owner", "Renter"),
  c(1, 0)
) %>% as.character() %>% as.integer()
) %>%
  dplyr::select(-Householder.sex, -Status) %>%
  # Change some columns to double
  mutate(across(c(Household.value, Householder.age, Duration.of.stay.as.of.2017,
                  Monthly.rent, Householder.income),
                ~ as.double(.))) %>%
  # Change Number.of.people column to integer
  mutate(Number.of.people = as.integer(Number.of.people)) # View cleaned data frame
housing.df.cleaned %>% glimpse()
# View unique values for each variable
housing.df.cleaned %>%
  dplyr::select(!where(is.double)) %>%
  sapply(unique)
housing.df.cleaned %>%
  summary()
housing.df.cleaned %>%
  is.na() %>%
  colSums()

# Get data frames for renters and owners ----------------------------------
housing.df.cleaned.renters <-
  housing.df.cleaned %>%
  filter(Status.Owner == 0) %>%
  dplyr::select(-Status.Owner, -Household.value)
housing.df.cleaned.owners <-
  

housing.df.cleaned %>%
  filter(Status.Owner == 1) %>%
  dplyr::select(-Status.Owner, -Monthly.rent, -Median.length.of.lease,
                -Length.of.lease, -Owner.in.building) # -Household.value
housing.df.cleaned.owners.and.rents <-
  housing.df.cleaned %>%
  dplyr::select(-Monthly.rent, -Median.length.of.lease, -Household.value)

# Converting into Base R once cleaned ------------------------------------
housing <- data.frame(housing.df.cleaned)
housing.owners <- data.frame(housing.df.cleaned.owners)
housing.renters <- data.frame(housing.df.cleaned.renters)
Plots

# Correlation Matrices ------------------------------------------------
housing.df.cleaned.renters %>%
  dplyr::select(where(is.numeric)) %>%
  cor(use =  complete.obs ) %>%
  ggcorrplot(type =  lower , hc.order = TRUE,
             outline.color =  white ,
             colors = c("#6D9EC1", "white", "#E46726"),
             p.mat = cor_pmat(dplyr::select(housing.df.cleaned.renters,
                                            where(is.numeric))),
             ggtheme = ggplot2::theme_gray) +
  labs(title =  Correlation matrix for renters ) +
  theme(plot.title = element_text(hjust = 0.5))
housing.df.cleaned.owners %>%
  dplyr::select(where(is.numeric)) %>%
  cor(use =  complete.obs ) %>%
  ggcorrplot(type =  lower ,
             hc.order = TRUE,
             outline.color =  white ,
             colors = c("#6D9EC1", "white", "#E46726"),
             p.mat = cor_pmat(dplyr::select(housing.df.cleaned.owners,
                                            where(is.numeric))),
             ggtheme = ggplot2::theme_gray) +
  labs(title =  Correlation matrix for owners ) +
  theme(plot.title = element_text(hjust = 0.5))
housing.df.cleaned.owners.and.rents %>%
  dplyr::select(where(is.numeric)) %>%
  cor(use =  complete.obs ) %>%
  ggcorrplot(type =  lower , hc.order = TRUE,
             outline.color =  white ,
             colors = c("#6D9EC1", "white", "#E46726"),
             p.mat = cor_pmat(dplyr::select(housing.df.cleaned.owners.and.rents,
                                            where(is.numeric))),
             ggtheme = ggplot2::theme_gray) +
  labs(title =  Correlation matrix for owners and renters ) +
  theme(plot.title = element_text(hjust = 0.5))

# Factor Plots ---------------------------------------------------------
par(mfrow=c(2,3))
plot.design(housing.owners$Borough~housing.owners$Household.value,
            
            
            xlab = "Borough", ylab = "House Price")
plot.design(housing.owners$Resident.rating~housing.owners$Household.value,
            xlab = "Resident Rating", ylab = "House Price")
plot.design(housing.owners$General.building.condition~housing.owners$Household.value,
            xlab = "Building Condition", ylab = "House Price")
plot.design(housing.renters$Borough~housing.renters$Monthly.rent,
            xlab = "Borough", ylab = "Monthly Rent")
plot.design(housing.renters$Resident.rating~housing.renters$Monthly.rent,
            xlab = "Resident Rating", ylab = "Monthly Rent")
plot.design(housing.renters$General.building.condition~housing.renters$Monthly.rent,
            xlab = "Building Condition", ylab = "Monthly Rent")

# Price-Year Plots -----------------------------------------------------
plot(housing.owners$Year, housing.owners$Household.value, xlab = "Year",
     ylab = "House Price")
lines(loess.smooth(housing.owners$Year, housing.owners$Household.value), col = "red")
plot(housing.owners$Year, log(housing.owners$Household.value), xlab = "Year",
     ylab = "log(House Price)")
lines(loess.smooth(housing.owners$Year, log(housing.owners$Household.value)), col = "red")
plot(housing.renters$Year, housing.renters$Monthly.rent, xlab = "Year",
     ylab = "Monthly Rent")
lines(loess.smooth(housing.renters$Year, housing.renters$Monthly.rent), col = "red")
plot(housing.renters$Year, log(housing.renters$Monthly.rent), xlab = "Year",
     ylab = "Monthly Rent")
lines(loess.smooth(housing.renters$Year, log(housing.renters$Monthly.rent)), col = "red") Model Choice and Selection

# Linear Models and Stepwise Selection
own.full.lm <- lm(log(Household.value) ~ .,
                  data = housing.owners)
summary(own.full.lm)
anova(own.full.lm)
own.intercept.lm <- lm(log(Household.value) ~ 1, data = housing.owners)
summary(own.intercept.lm)
rent.full.lm <- lm(log(Monthly.rent) ~ .,
                   data = housing.renters)
summary(rent.full.lm)
rent.intercept.lm <- lm(log(Monthly.rent) ~ 1, data = housing.renters)
summary(rent.intercept.lm)
forward.AIC.own <- stepAIC(own.intercept.lm,
                           scope = list(lower = own.intercept.lm,
                                        upper = own.full.lm),
                           direction =  forward )


backward.AIC.own <- stepAIC(own.full.lm, direction =  backward )
forward.AIC.own$call
backward.AIC.own$call
own.selected.lm <-
  lm(formula = log(Household.value) ~ Year + Median.number.of.units +
       Borough + Number.of.rooms + Resident.rating + Median.number.of.stories +
       Mice.and.rats + Broken.plaster + General.building.condition +
       Heating.breakdowns + Kitchen.functioning + Holes.in.floors,
     data = housing.owners)
summary(own.selected.lm)
anova(own.selected.lm)
par(mfrow = c(2, 2))
plot(own.selected.lm)
par(mfrow = c(1, 1))
rent.selected.lm <-
  lm(formula = log(Monthly.rent) ~ Year + Resident.rating + Borough +
       Number.of.rooms + Mice.and.rats + General.building.condition +
       Median.number.of.units + Broken.plaster + Median.number.of.stories +
       Severity.windows + Toilets.breakdowns + Severity.stairways +
       Kitchen.functioning + Water.leakage + Severity.floors + Plumbing.facilities +
       Kitchen.facilities, data = housing.renters)
summary(rent.selected.lm)
anova(rent.selected.lm)
par(mfrow = c(2, 2))
plot(rent.selected.lm)
par(mfrow = c(1, 1))

# Getting AdjR2 for models using regsubsets  ------------------------------
# Regsubsets for owners models to get best adjusted r-squared
own_best_subsets <- regsubsets(log(Household.value) ~ .,
                               data = housing.owners, nvmax = 100)
own_best_subsets_summary <- summary(own_best_subsets)
which.max(own_best_subsets_summary$adjr2)
# Model with best adjusted r??2
Number.of.parameters.owners <- which.max(own_best_subsets_summary$adjr2)
Adj.R2.owners <- own_best_subsets_summary$adjr2[Number.of.parameters.owners]
Parameters.included.owners <- own_best_subsets$xnames[
  own_best_subsets_summary$which[Number.of.parameters.owners, ]
]
Parameters.included.owners <- paste(Parameters.included.owners[-1], collapse =  ,  )
best.adj.r2.owners <- data.frame(
  Number.of.parameters = Number.of.parameters.owners,
  Adj.R2 = Adj.R2.owners
)


best.adj.r2.owners
names(Parameters.included.owners) <-
   Paramaters included in house owners model with best adjusted R-squared 
# Compare with selected model
summary(own.selected.lm)$adj.r.squared
Adj.R2.owners.comparison <- data.frame(
   Adj.R2 from best regsubsets  = Adj.R2.owners,
   Adj.R2 from selected model  = summary(own.selected.lm)$adj.r.squared
)
Adj.R2.owners.comparison

# Regsubsets for renters models to get best adjusted r-squared
rent_best_subsets <- regsubsets(log(Monthly.rent) ~ .,
                                data = housing.renters, nvmax = 100)
rent_best_subsets_summary <- summary(rent_best_subsets)
which.max(rent_best_subsets_summary$adjr2)

# Model with best adjusted r??2
Number.of.parameters.renters <- which.max(rent_best_subsets_summary$adjr2)
Adj.R2.renters <- rent_best_subsets_summary$adjr2[Number.of.parameters.renters]
Parameters.included.renters <- rent_best_subsets$xnames[
  rent_best_subsets_summary$which[Number.of.parameters.renters, ]
]
Parameters.included.renters <- paste(Parameters.included.renters[-1], collapse =  ,  )
best.adj.r2.renters <- data.frame(
  Number.of.parameters = Number.of.parameters.renters,
  Adj.R2 = Adj.R2.renters
)
best.adj.r2.renters
names(Parameters.included.renters) <-
   Paramaters included in house renters model with best adjusted R-square 
Parameters.included.renters
# Compare with selected model
summary(rent.selected.lm)$adj.r.squared
Adj.R2.renters.comparison <- data.frame(
   Adj.R2 from best regsubsets  = Adj.R2.renters,
   Adj.R2 from selected model  = summary(rent.selected.lm)$adj.r.squared
)
Adj.R2.renters.comparison
# The adjusted R-squared is very slightly smaller in both of the selected
# models. However, it is so close that it actually supports our choices.
Prediction and Evaluation

# Predicting -------------------------------------------------------------- # Predicting rental prices for owned property data
owned.new.data <- housing.owners


owned.new.data$Predicted.monthly.rent <-
  exp(predict(rent.selected.lm,
              newdata =dplyr::select(owned.new.data, -Household.value)))
owned.new.data.2017 = owned.new.data[owned.new.data$Year == 2017,]
owned.new.data.1991 = owned.new.data[owned.new.data$Year == 1991,]
# Finding relationship between rent prices and house prices in 1991 and 2017.
summary(lm(Household.value~Predicted.monthly.rent, data = owned.new.data.2017))
summary(lm(Household.value~Predicted.monthly.rent, data = owned.new.data.1991))
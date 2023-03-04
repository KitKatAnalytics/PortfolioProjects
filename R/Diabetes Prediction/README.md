Above is a machine learning project that aimed to predict Diabetes in women, a condition that effects far too many women. It begins with an intial 
data cleaning process to fix issues in the data, and then a thorough exploration into aspects of the data. It culminated in an examination of 
important parameters for diabetes diagnosis prediction, as well as the formulation of two models, one a generalised linear model, and the other
implementing K-Nearest neighbours, to predict diabetes frequency ina training set. The highest accuracy achieved was 83%, a great level considering the
baseline accuracy of 68%

Interesting Insights:

    - The number of pregnancies is fairly significantly correlated to diabetes in what is known as Gestational Diabetes (had no idea this existed).
    
    - Around a third of women in data set had tested positive for Diabetes at the time of data collection.
    
    - Significant indicators of Diabetes include glucose concentration, BMI, diabetes pedigree function, and number of pregnancies.
    
    - BMI is much less correalted to Diabetes that I had thought, with a Pearson coefficient of 0.043 (close proximity to significance level).
    
    - Insulin negatively correlated to both number of pregnancies and blood pressure.

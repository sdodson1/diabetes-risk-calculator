# File: /diabetes-risk-calculator/diabetes-risk-calculator/R/plot_functions.R

library(ggplot2)

# Function to plot the relationship between BMI change and diabetes risk
plot_bmi_change_risk <- function(data, risk_column) {
  ggplot(data, aes(x = bmi_change_pct_centered, y = !!sym(risk_column))) +
    geom_point(alpha = 0.6) +
    geom_smooth(method = "loess", color = "blue") +
    labs(title = "Relationship Between BMI Change and Diabetes Risk",
         x = "BMI Change (%)",
         y = "Diabetes Risk (%)") +
    theme_minimal()
}

# Function to plot the distribution of diabetes risk by gender
plot_risk_by_gender <- function(data, risk_column) {
  ggplot(data, aes(x = !!sym(risk_column), fill = gender)) +
    geom_density(alpha = 0.5) +
    labs(title = "Distribution of Diabetes Risk by Gender",
         x = "Diabetes Risk (%)",
         y = "Density") +
    theme_minimal()
}

# Function to create a bar plot of average diabetes risk by age group
plot_risk_by_age_group <- function(data, risk_column) {
  data %>%
    group_by(age_group) %>%
    summarize(avg_risk = mean(!!sym(risk_column), na.rm = TRUE)) %>%
    ggplot(aes(x = age_group, y = avg_risk, fill = age_group)) +
    geom_bar(stat = "identity") +
    labs(title = "Average Diabetes Risk by Age Group",
         x = "Age Group",
         y = "Average Diabetes Risk (%)") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
}
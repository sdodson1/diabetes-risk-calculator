library(shiny)
library(dplyr)
library(readr)

# Load model coefficients for diabetes risk calculation
setwd("C:/Lourdes/prediabetes/diabetes-risk-calculator")
model_coefficients <- readRDS("data/model_coefficients.rds")

# Function to calculate diabetes risk based on user inputs
calculate_diabetes_risk <- function(bmi_change_pct_centered, age_continuous, gender, baseline_a1c, baseline_bmi, ckd, cvd, smoking, hypertension, hyperlipidemia, comorbidity_count) {
  # Create a data frame for input values
  input_data <- data.frame(
    bmi_change_pct_centered = bmi_change_pct_centered,
    age_continuous = age_continuous,
    gender = as.numeric(gender),  # Assuming gender is coded as 0 and 1
    baseline_a1c = baseline_a1c,
    baseline_bmi = baseline_bmi,
    ckd = as.numeric(ckd),
    cvd = as.numeric(cvd),
    smoking = as.numeric(smoking),
    hypertension = as.numeric(hypertension),
    hyperlipidemia = as.numeric(hyperlipidemia),
    comorbidity_count = comorbidity_count
  )
  
  # Calculate the linear predictor using the model coefficients
  linear_predictor <- as.numeric(input_data %*% model_coefficients)
  
  # Convert linear predictor to probability using the logistic function
  risk_percentage <- 1 / (1 + exp(-linear_predictor)) * 100
  
  return(risk_percentage)
}
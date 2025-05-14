library(shiny)
library(dplyr)

# Load model coefficients
model_coefficients <- readRDS("data/model_coefficients.rds")

# Function to calculate diabetes risk
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
  
  # Calculate the linear predictor
  linear_predictor <- as.numeric(input_data %*% model_coefficients)
  
  # Convert linear predictor to probability using the logistic function
  risk_percentage <- 1 / (1 + exp(-linear_predictor)) * 100
  
  return(risk_percentage)
}

# Define server logic
shinyServer(function(input, output) {
  
  # Reactive expression to calculate risk based on user inputs
  risk <- reactive({
    req(input$bmi_change_pct_centered, input$age_continuous, input$gender, 
        input$baseline_a1c, input$baseline_bmi, input$ckd, input$cvd, 
        input$smoking, input$hypertension, input$hyperlipidemia, input$comorbidity_count)
    
    calculate_diabetes_risk(
      bmi_change_pct_centered = input$bmi_change_pct_centered,
      age_continuous = input$age_continuous,
      gender = input$gender,
      baseline_a1c = input$baseline_a1c,
      baseline_bmi = input$baseline_bmi,
      ckd = input$ckd,
      cvd = input$cvd,
      smoking = input$smoking,
      hypertension = input$hypertension,
      hyperlipidemia = input$hyperlipidemia,
      comorbidity_count = input$comorbidity_count
    )
  })
  
  # Output the risk percentage
  output$risk_percentage <- renderText({
    paste("Estimated risk of developing diabetes:", round(risk(), 2), "%")
  })
})